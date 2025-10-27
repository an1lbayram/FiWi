@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: Varsayılan renk ayarı
set "CURRENT_COLOR=0A"

:MAIN_MENU
cls
color %CURRENT_COLOR%
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                          - FiWi -                            ║
echo ║                        by an1lbayram                         ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo 1- Kayıtlı WiFi Ağları (Sadece Ağ İsimleri)
echo 2- Kayıtlı WiFi Ağları Şifreleri
echo 3- CLI Menü Renkleri
echo 4- Çıkış
echo.
set /p choice=Lütfen seçiminizi yapın (1-4): 

if "%choice%"=="1" goto SHOW_NETWORKS
if "%choice%"=="2" goto SHOW_PASSWORDS
if "%choice%"=="3" goto COLOR_MENU
if "%choice%"=="4" goto EXIT
echo Hatalı seçim! Lütfen 1-4 arasında bir sayı girin.
pause
goto MAIN_MENU

:SHOW_NETWORKS
cls
color %CURRENT_COLOR%
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                     Kayıtlı WiFi Ağları                      ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

:: WiFi profillerini al
set counter=0
for /f "tokens=2 delims=:" %%i in ('netsh wlan show profiles ^| findstr "All User Profile"') do (
    set "profile=%%i"
    set "profile=!profile:~1!"
    set /a counter+=1
    echo !counter!- !profile!
)

if %counter%==0 (
    echo Kayıtlı WiFi ağı bulunamadı!
) else (
    echo.
    echo Toplam %counter% adet kayıtlı WiFi ağı bulundu.
)

echo Başka bir işlem yapmak ister misiniz? (Ana Menüye Dönmek İçin "M")
echo E/H/M
echo.
set /p continue=Seçiminizi yapın (E/H/M): 

if /i "%continue%"=="E" goto MAIN_MENU
if /i "%continue%"=="H" goto EXIT
if /i "%continue%"=="M" goto MAIN_MENU
echo Geçersiz seçim! Ana menüye yönlendiriliyorsunuz...
timeout /t 2 >nul
goto MAIN_MENU

:SHOW_PASSWORDS
cls
color %CURRENT_COLOR%
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                 WiFi Şifrelerini Görüntüleme                 ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

:: Profil listesini temizle
set counter=0
set profiles[0]=

:: WiFi profillerini al ve diziye kaydet
for /f "tokens=2 delims=:" %%i in ('netsh wlan show profiles ^| findstr "All User Profile"') do (
    set "profile=%%i"
    set "profile=!profile:~1!"
    set /a counter+=1
    set "profiles[!counter!]=!profile!"
    echo !counter!- !profile!
)

if %counter%==0 (
    echo Kayıtlı WiFi ağı bulunamadı!
    echo.
    pause
    goto MAIN_MENU
)

echo.
set /p selection=Şifresini görmek istediğiniz WiFi ağının numarasını girin: 

:: Seçimi kontrol et
if "%selection%"=="" (
    echo Lütfen geçerli bir numara girin!
    pause
    goto SHOW_PASSWORDS
)

:: Sayı kontrolü
echo %selection%| findstr /r "^[0-9][0-9]*$" >nul
if errorlevel 1 (
    echo Lütfen sadece sayı girin!
    pause
    goto SHOW_PASSWORDS
)

:: Aralık kontrolü
if %selection% LSS 1 (
    echo Lütfen 1-%counter% arasında bir sayı girin!
    pause
    goto SHOW_PASSWORDS
)

if %selection% GTR %counter% (
    echo Lütfen 1-%counter% arasında bir sayı girin!
    pause
    goto SHOW_PASSWORDS
)

:: Seçilen profili al
set "selected_profile=!profiles[%selection%]!"

echo.
echo Seçilen WiFi Ağı: %selected_profile%
echo Şifre aranıyor...
echo.

:: Şifreyi al
for /f "tokens=2 delims=:" %%i in ('netsh wlan show profile name^="%selected_profile%" key^=clear ^| findstr "Key Content"') do (
    set "password=%%i"
    set "password=!password:~1!"
)

if "!password!"=="" (
    echo Bu WiFi ağının şifresi bulunamadı veya şifre korunmuyor.
) else (
    echo ╔══════════════════════════════════════════════════════════╗
    echo ║                     - WiFi Şifresi -                     ║
    echo ╚══════════════════════════════════════════════════════════╝
    echo.
    echo Wi-Fi Adı: %selected_profile%
    echo Şifre: !password!
    echo.
)

echo.
echo Başka bir işlem yapmak ister misiniz? (Ana Menüye Dönmek İçin "M")
echo E/H/M
echo.
set /p continue=Seçiminizi yapın (E/H/M): 

if /i "%continue%"=="E" goto SHOW_PASSWORDS
if /i "%continue%"=="H" goto EXIT
if /i "%continue%"=="M" goto MAIN_MENU
echo Geçersiz seçim! Ana menüye yönlendiriliyorsunuz...
timeout /t 2 >nul
goto MAIN_MENU

:COLOR_MENU
cls
color %CURRENT_COLOR%
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                      CLI Menü Renkleri                       ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo  1- Varsayılan Renkler (Yeşil)
echo  2- Mavi Tema
echo  3- Sarı Tema
echo  4- Kırmızı Tema
echo  5- Mor Tema
echo  6- Geri Dön
echo.
set /p color_choice=Renk temasını seçin (1-6): 

if "%color_choice%"=="1" goto DEFAULT_COLORS
if "%color_choice%"=="2" goto BLUE_THEME
if "%color_choice%"=="3" goto YELLOW_THEME
if "%color_choice%"=="4" goto RED_THEME
if "%color_choice%"=="5" goto PURPLE_THEME
if "%color_choice%"=="6" goto MAIN_MENU
echo Hatalı seçim! Lütfen 1-6 arasında bir sayı girin.
pause
goto COLOR_MENU

:DEFAULT_COLORS
set "CURRENT_COLOR=0A"
color %CURRENT_COLOR%
echo Varsayılan renkler uygulandı!
goto COLOR_CONTINUE

:BLUE_THEME
set "CURRENT_COLOR=0B"
color %CURRENT_COLOR%
echo Mavi tema uygulandı!
goto COLOR_CONTINUE

:YELLOW_THEME
set "CURRENT_COLOR=0E"
color %CURRENT_COLOR%
echo Sarı tema uygulandı!
goto COLOR_CONTINUE

:RED_THEME
set "CURRENT_COLOR=0C"
color %CURRENT_COLOR%
echo Kırmızı tema uygulandı!
goto COLOR_CONTINUE

:PURPLE_THEME
set "CURRENT_COLOR=0D"
color %CURRENT_COLOR%
echo Mor tema uygulandı!
goto COLOR_CONTINUE

:COLOR_CONTINUE
echo.
echo Başka bir işlem yapmak ister misiniz? (Ana Menüye Dönmek İçin "M")
echo E/H/M
echo.
set /p continue=Seçiminizi yapın (E/H/M): 

if /i "%continue%"=="E" goto COLOR_MENU
if /i "%continue%"=="H" goto EXIT
if /i "%continue%"=="M" goto MAIN_MENU
echo Geçersiz seçim! Ana menüye yönlendiriliyorsunuz...
timeout /t 2 >nul
goto MAIN_MENU

:EXIT
cls
color %CURRENT_COLOR%
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                          - FiWi -                            ║
echo ║                        by an1lbayram                         ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo Script kapatılıyor...
echo Teşekkürler!
echo.
timeout /t 5 /nobreak >nul

exit
