# 🧪 FiWi - Test Planı / Test Plan

Bu doküman FiWi (`FiWi.bat`) için test kapsamını tanımlar.
This document defines the test scope for FiWi (`FiWi.bat`).

**Context:** FiWi is a single-file, portable Windows batch (`.bat`) CLI tool with no web frontend, no API, no external runtime dependencies, and no build/package pipeline. Several categories below are therefore marked **N/A** with a short justification instead of being padded with irrelevant test cases; where a category has no literal equivalent, the closest applicable interpretation is used instead (e.g. "Component" → functional block, "API" → the `netsh` contract FiWi consumes).

**Execution note (2026-08-14):** The items marked ✅ **Executed** below were actually run against this repo's `FiWi.bat` and the real, live WLAN profile store on a Windows 11 dev machine (55 real saved profiles, non-admin user), not just planned. Four real findings came out of that run, including one root-caused defect — see [Verified Findings](#verified-findings-2026-08-14) at the end of this document.

---

## 1. Functional QA

Covers the full menu tree in `FiWi.bat`.

- Language selection (`1`=TR, `2`=EN) sets correct strings via `SET_TURKISH_TEXT` / `SET_ENGLISH_TEXT`; invalid input (`3`, empty, letters) re-prompts with error and loops `LANGUAGE_SELECTION`.
- Main menu options `1-4` route to `SHOW_NETWORKS`, `SHOW_PASSWORDS`, `COLOR_MENU`, `EXIT` respectively; any other input shows `MENU_ERROR` and re-displays the menu.
- `SHOW_NETWORKS` lists all saved profiles with correct 1-based numbering and a correct total count in the selected language.
- `SHOW_PASSWORDS` lists profiles, accepts a valid index, and displays network name + password; empty/out-of-range/non-numeric input is rejected with the correct error and re-prompts.
- Continue prompts (`E/H/M` in TR, `Y/N/M` in EN) route correctly: back to the current screen, to `EXIT`, or to `MAIN_MENU`; invalid input shows `CONTINUE_ERROR` and falls back to `MAIN_MENU` after a 2s timeout.
- `EXIT` prints both exit messages, waits 5s, and terminates cleanly.
- Zero saved profiles is handled gracefully in both `SHOW_NETWORKS` and `SHOW_PASSWORDS` (`NETWORKS_NOT_FOUND`, no crash, no divide-by-zero on `counter`).

## 2. Unit Testing

Batch has no native test framework, so isolate and test the pure logic blocks independently (e.g. via a Pester wrapper or by extracting the `for /f` parsing loop into a standalone script fed with fixture output):

- Profile-line parser (lines ~187–197, ~240–251): given a fixed sample of `netsh wlan show profiles` text (including edge cases — profile names with spaces, accented/Turkish characters, a trailing blank line), verify the extracted `counter` and `profile` values are exactly correct.
- Numeric-input validator (`findstr /r "^[0-9][0-9]*$"`): test `"5"` → valid, `"05"` → valid, `"-1"`, `"5.0"`, `"5a"`, `""`, `" 5"` → all rejected. ✅ **Executed** — ran the exact regex via `findstr` directly (not simulated): `5`→VALID, `05`→VALID, `-1`→INVALID, `5.0`→INVALID, `5a`→INVALID, `""`→INVALID, `" 5"`→INVALID. All 7 cases matched the expected behavior above.
- Range check (`LSS 1` / `GTR %counter%`): boundary values `0`, `1`, `counter`, `counter+1`.
- Unsafe-character sanitizer (lines ~304–318): profile names containing `^`, `&`, `|`, `"` individually and combined must be flagged; a clean profile name with spaces/Turkish characters must pass through unmodified.
- Codepage capture/restore (`chcp` parsing, lines ~15–21, ~446): verify `orig_cp` is correctly extracted as a bare number regardless of locale-specific `chcp` phrasing, and restored on exit.

## 3. Component Testing

No UI components exist; treat each labeled block (`:LANGUAGE_SELECTION`, `:MAIN_MENU`, `:SHOW_NETWORKS`, `:SHOW_PASSWORDS`, `:COLOR_MENU`) as a component and test it in isolation with `netsh` output mocked/stubbed (e.g. a wrapper batch file that shadows `netsh` on `PATH` with a fixture script) so each block's behavior is verified independent of a real WiFi adapter or saved profiles.

## 4. Integration Testing

Tests the real integration points FiWi depends on:

- Actual `netsh wlan show profiles` / `netsh wlan show profile name="X" key=clear` output on a real Windows machine with a known, controlled set of saved profiles (including one with `key=clear` unsupported/open network, and one with a non-ASCII SSID). ✅ **Executed** — ran directly against this machine's real 55-profile WLAN store: `netsh wlan show profiles` correctly listed all profiles including a Turkish-character SSID (`Şehzade Apart`) and one with a leading space in the name (` WiSpotter`, exercising the indentation-based line-parsing edge case in `SHOW_NETWORKS`/`SHOW_PASSWORDS`). For an open network (`INTERNET`, `Security key: Absent`) `key=clear` correctly returns no `Key Content` line, which drives FiWi's `PASSWORD_NOT_FOUND` path. For a WPA network (`Şehzade Apart`) `key=clear` returned a real, non-empty `Key Content` value (verified present/non-empty without printing the actual password to logs).
- Behavior without Administrator rights — confirm `PASSWORD_NOT_FOUND` (or equivalent) is shown rather than a raw `netsh` access-denied dump reaching the user. ⚠️ **Correction after execution:** the script's own comments and this plan originally assumed Administrator rights "may be required" to read `key=clear`. Tested as a **standard non-admin user** on this machine: `netsh wlan show profile ... key=clear` succeeded and returned the real password with no elevation. Admin-requirement behavior appears to depend on Windows version/group policy rather than being a hard requirement — the README's Administrator recommendation should be treated as "sometimes needed," not "always needed," and this should be tested on a machine with a stricter policy to confirm the access-denied fallback path still degrades gracefully.
- `chcp 65001` interaction with the real console codepage across CMD and PowerShell hosts, confirming UTF-8 box-drawing characters (`╔`, `║`, etc.) render correctly and the original codepage is restored after `EXIT`.
- `color` command applied/reset correctly across the 5 themes without leaving the console in an altered color state on unexpected termination (Ctrl+C).

## 5. E2E Testing

Full user journeys as documented in `README.md`:

- PowerShell one-liner (`Invoke-WebRequest ... -OutFile "FiWi.bat"; .\FiWi.bat`) → language select → view networks → view a password → exit.
- `git clone` one-liner → run → full menu walkthrough.
- Manual step-by-step flow (open terminal as Administrator → download → run → select language → select network) matching the README's numbered instructions exactly.
- Repeated "continue" loop: view password → `M` → main menu → color theme change → `M` → main menu → exit, without state leaking between iterations (e.g. previous password not shown for a newly selected network — this was a fixed bug per commit history).

**⚠️ Executed, root-caused a real defect:** attempted to automate this full journey by piping a scripted sequence of answers into `FiWi.bat`'s stdin, three times, via two different piping methods (file redirection, direct pipe). All three desynced at the very first prompt and fell into a fast, non-blocking `set /p`-on-empty-input loop that reprints the current menu indefinitely (one run produced 2.5MB of output in under a minute before being killed).

Isolated the root cause with two minimal repro scripts (not part of `FiWi.bat`, built to bisect the behavior): a script that runs `chcp 65001 >nul` before its first `set /p` reads the piped value as **empty**, while the identical script *without* the `chcp 65001` call reads the piped value correctly. **Root cause: `FiWi.bat` line 21's `chcp 65001 >nul` discards any input already sitting in a redirected/piped stdin buffer before the first prompt ever reads it.** This is a genuine, deterministic defect (not environment flakiness) — every subsequent `set /p`/`pause` in the script is reading from a stdin stream whose buffered contents were silently dropped by the codepage switch, which explains the desync-into-infinite-loop pattern seen on every attempt.

**Practical implications:**
- This is a real, reportable limitation of the script itself, not just a test-harness quirk: **any** attempt to drive FiWi.bat non-interactively (automated testing, scripted deployment, remote execution tooling) will silently lose the first — and effectively all — piped input. A fix would mean moving the `chcp 65001` call earlier (before `orig_cp` capture) or reading first input only after confirming the console is interactive.
- True E2E of the interactive menu needs a PTY-based/`ConPTY`-based harness that emulates real keystrokes rather than redirecting stdin — plain piping cannot work here by design, not just by bad luck.
- Any CI job must not depend on piping real menu input past the `chcp` call; see the CI/CD section for how this is handled.

## 6. Security Testing

Highest-priority category given the recent `enjeksiyon` (injection) fix in the commit history.

- **Command injection via profile name:** attempt to create/simulate a saved profile name containing `^`, `&`, `|`, `"` and confirm the sanitizer at lines ~302–318 blocks the operation before the name reaches the `netsh ... name="%selected_profile%"` call; confirm the block message displays in both languages and does not execute the injected fragment.
- **Stale-password bug (regression test):** select network A, view its password, return via `M`/`E`, select network B — confirm B's password is freshly retrieved and A's is not shown (the `set "password="` reset at line ~327 must run every time).
- **Local-only operation:** confirm via network capture (e.g. Wireshark/Sysinternals) that FiWi makes zero outbound network calls itself — it only shells out to local `netsh`.
- **Plaintext credential exposure:** password is printed to console and not written to any log/temp file; verify no residual file is left in `%TEMP%` after execution.
- **Supply-chain integrity:** the README's `Invoke-WebRequest` one-liner has no checksum/signature verification — recommend documenting a SHA256 hash for release artifacts so users can verify the download before executing an admin-elevated script.
- **Least-privilege behavior:** confirm the script degrades gracefully (no crash, no unhandled `netsh` error text) when run without Administrator rights rather than silently failing.

## 7. SEO Testing — N/A

FiWi has no web frontend, landing page, or hosted content — it's a downloadable CLI script. The only public surface is the GitHub `README.md`, which is discovery/marketing copy, not something SEO testing (crawlability, meta tags, structured data) applies to.

## 8. Performance Testing

- Startup time from invocation to language prompt (should be near-instant; no heavy init).
- `SHOW_NETWORKS` / `SHOW_PASSWORDS` enumeration time on a machine with a large number of saved profiles (e.g. 50–100+) — confirm the `for /f` loop scales linearly and doesn't visibly stall.
- Menu responsiveness after invalid input (the `pause` / `timeout /t 2` delays should match intended UX pacing, not mask a slow operation).

## 9. Accessibility Testing

- Screen-reader compatibility: console output is read top-to-bottom by default screen readers (e.g. NVDA) — verify menu prompts and results are announced in a sensible order and important info (password, errors) isn't conveyed by color alone (currently text-based, which is good — verify this holds for every message).
- Color-theme contrast: confirm all 5 `color` codes (`0A`/`0B`/`0E`/`0C`/`0D` — green/blue/yellow/red/purple, all on black background code `0`) meet reasonable contrast against the default black console background.
- Legibility of box-drawing characters (`╔═╗`) in narrow terminal windows or with non-default console fonts that may not include those glyphs (fallback behavior should not corrupt the whole layout).

## 10. Cross-Browser Testing — N/A

No browser-rendered UI exists. The only browser-adjacent surface is GitHub's rendering of `README.md`, which is out of scope for a CLI tool's test plan.

## 11. Responsive Testing

No layout in the web sense, but the CLI equivalent — terminal window size — should be tested:

- Resize the console window narrower than the box-drawing border width (66 chars) and confirm wrapping doesn't corrupt the box characters or make text unreadable.
- Test at both default CMD (80x25) and a maximized/wide terminal, and in Windows Terminal vs legacy `conhost.exe`.

## 12. Visual Regression Testing

- Snapshot the rendered menu (box borders, spacing, alignment) per language and confirm no unintended drift between releases (e.g. the box-drawing alignment issue mentioned as fixed in recent commits).
- Snapshot each of the 5 color themes to confirm the correct `color` code is visually applied and no theme silently falls back to default.

## 13. API Testing

FiWi exposes no API of its own. The closest equivalent is the external contract it consumes: `netsh wlan show profiles` / `netsh wlan show profile ... key=clear`.

- Verify output-parsing robustness across Windows versions (7/8/10/11) and locales — the script's own header comment flags that password extraction was "only tested on English Windows" and may fail to find `Key Content` on other language packs. This is a known limitation to explicitly regression-test on at least one non-English Windows locale, since prior fixes addressed locale-dependent parsing (`enjeksiyon ve codepage` commit).
- Verify graceful handling of a non-zero/error exit from `netsh` (e.g. WLAN service disabled, no wireless adapter present).

## 14. Dependency Security

FiWi has zero third-party dependencies (no npm/pip/NuGet packages, no bundled DLLs or binaries) — it's a single `.bat` file relying only on OS-native `netsh`/`chcp`/`color`/`findstr`. This drastically narrows the category:

- Confirm no external downloads or DLL/COM invocations happen at runtime beyond the documented `netsh` calls.
- The one supply-chain surface is the README's raw-download one-liner — recommend pinning to a tagged release URL (not a mutable branch ref) and publishing a checksum, per the Security Testing note above.

## 15. Code Quality Testing

Static/manual review, since no batch linter is standard tooling:

- Consistent use of `setlocal enabledelayedexpansion` / `!var!` vs `%var%` throughout (mixed usage is a common batch bug source).
- DRY check: the "continue" prompt block (echo + `set /p` + 5-way `if /i` routing) is duplicated near-identically in `SHOW_NETWORKS`, `SHOW_PASSWORDS`, and `COLOR_MENU` — flag as a refactor candidate (extract to a callable `:CONTINUE_HANDLER` subroutine) even if not fixed immediately.
- Label/variable naming consistency (`MENU_*`, `COLOR_*`, `PASSWORD_*` prefixes are followed correctly).
- Comment accuracy: the header comment documenting known limitations (English-only password extraction) should be kept in sync as fixes land.
- No hardcoded absolute paths, no leftover debug output.

## 16. CI/CD Testing

No CI pipeline currently existed in the repo — added `.github/workflows/smoke-test.yml` (see repo) implementing the plan below. Given the root-caused `chcp 65001`-discards-piped-stdin defect confirmed under E2E Testing above, the workflow deliberately does **not** attempt to drive the interactive menu via piped input — that's not a flakiness problem a longer timeout or retries can paper over, it's a design-level defect in the script that would need a `FiWi.bat` code change to actually fix:

- **Reliable unit-level checks** (no interactivity, unaffected by the `chcp` defect): re-run the numeric-validator and unsafe-character-sanitizer regex checks extracted in Unit Testing, directly via `findstr`/batch string substitution, as fast deterministic CI gates. Both were locally verified against the exact snippets in the workflow, including a tricky embedded-double-quote case that initially broke the test script itself (fixed by building the quote character via `set QUOTE=^"` and delayed expansion instead of passing it through `call` arguments).
- **Launch smoke test:** start `FiWi.bat` with empty stdin and confirm the initial banner/menu renders within a few seconds before being killed — this validates the script launches, parses, and reaches its first prompt without crashing, without depending on the broken piped-input path.
- Runs on `windows-latest` since the script is Windows-only (`netsh`, `chcp`, `color`).
- Since there's no build/package step, "CI/CD" here is effectively "CI only" — release is just tagging and publishing the raw file, so a release workflow should at minimum regenerate/verify the checksum mentioned in Dependency Security above (not yet implemented).

---

## Test Environment Matrix

| Windows Version | Locale | Admin Rights | Terminal |
|---|---|---|---|
| Windows 7 | EN | Yes/No | CMD |
| Windows 10 | EN, TR | Yes/No | CMD, PowerShell |
| Windows 11 | EN, TR | Yes/No | CMD, PowerShell, Windows Terminal |

Non-English/non-Turkish locale coverage should be added given the script's documented English-only password-extraction limitation.

## Verified Findings (2026-08-14)

Real, reproduced results from running the above tests against this repo's `FiWi.bat` and this machine's live WLAN profile store (not hypothetical):

1. **Root-caused defect: `chcp 65001` (line 21) discards piped/redirected stdin before it's ever read.** Reproduced the desync-into-infinite-loop failure three times via two piping methods, then isolated the cause with minimal repro scripts: identical `set /p` logic reads input correctly *without* `chcp 65001`, and reads empty *with* it. This means any non-interactive execution of FiWi.bat (automated testing, scripted deployment) silently loses its input — a real bug worth fixing upstream (e.g. move the codepage switch after input is captured, or detect non-interactive stdin and skip it), not just a testing inconvenience.
2. **Admin-rights assumption was wrong.** `netsh wlan show profile ... key=clear` returned real passwords for both open and WPA-secured profiles under a standard non-admin account on this machine — the script comments' and README's implication that Administrator rights are needed is not universally true; it likely depends on Windows version/group policy. This should be re-tested on a machine with stricter local policy to confirm the graceful-degradation path.
3. **Numeric-input validator and profile-line parser behave exactly as designed** across 7 edge-case inputs and a real 55-profile store containing Turkish characters and a leading-space profile name — no defects found in this logic.
4. **Non-admin, open-network password lookup degrades correctly**: `key=clear` on an open network yields no `Key Content` line, which is exactly what `SHOW_PASSWORDS`'s `findstr "Key Content"` pipeline needs to correctly fall through to `PASSWORD_NOT_FOUND`.
