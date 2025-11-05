@echo off
:: =============================================
:: FiWi1.1 - Windows WiFi Password Viewer
:: Author: an1lbayram
:: License: MIT
:: =============================================
title FiWi1.1 - by an1lbayram
chcp 65001 >nul
setlocal enabledelayedexpansion

:: Varsayılan renk ayarı
set "CURRENT_COLOR=0A"

:: Dil seçimi
:LANGUAGE_SELECTION
cls
color %CURRENT_COLOR%
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                         - FiWi 1.1 -                         ║
echo ║                         by an1lbayram                        ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo   [1] Türkçe / Turkish
echo   [2] English / İngilizce
echo.
set /p lang_choice=Lütfen dil seçiminizi yapın / Please select your language (1-2): 

if "%lang_choice%"=="1" (
    set "LANG=TR"
    call :SET_TURKISH_TEXT
) else if "%lang_choice%"=="2" (
    set "LANG=EN"
    call :SET_ENGLISH_TEXT
) else (
    echo Hatalı seçim! / Invalid selection! Lütfen 1 veya 2 girin / Please enter 1 or 2.
    pause
    goto LANGUAGE_SELECTION
)

goto MAIN_MENU

:SET_TURKISH_TEXT
set "MENU_TITLE=- FiWi1.1 -"
set "MENU_OPTION1=1- Kayıtlı WiFi Ağları (Sadece Ağ İsimleri)"
set "MENU_OPTION2=2- Kayıtlı WiFi Ağları Şifreleri"
set "MENU_OPTION3=3- CLI Menü Renkleri"
set "MENU_OPTION4=4- Çıkış"
set "MENU_PROMPT=Lütfen seçiminizi yapın (1-4): "
set "MENU_ERROR=Hatalı seçim! Lütfen 1-4 arasında bir sayı girin."
set "NETWORKS_TITLE=Kayıtlı WiFi Ağları"
set "NETWORKS_NOT_FOUND=Kayıtlı WiFi ağı bulunamadı!"
set "NETWORKS_FOUND_TR=Toplam"
set "NETWORKS_FOUND_EN=Total"
set "NETWORKS_FOUND_END_TR=adet kayıtlı WiFi ağı bulundu."
set "NETWORKS_FOUND_END_EN=saved WiFi networks found."
set "CONTINUE_PROMPT=Başka bir işlem yapmak ister misiniz? (Ana Menüye Dönmek İçin \"M\")"
set "CONTINUE_OPTIONS=E/H/M"
set "CONTINUE_INPUT=Seçiminizi yapın (E/H/M): "
set "CONTINUE_ERROR=Geçersiz seçim! Ana menüye yönlendiriliyorsunuz..."
set "PASSWORDS_TITLE=WiFi Şifrelerini Görüntüleme"
set "PASSWORD_SELECT_PROMPT=Şifresini görmek istediğiniz WiFi ağının numarasını girin: "
set "PASSWORD_ERROR1=Lütfen geçerli bir numara girin!"
set "PASSWORD_ERROR2=Lütfen sadece sayı girin!"
set "PASSWORD_SELECTED=Seçilen WiFi Ağı:"
set "PASSWORD_SEARCHING=Şifre aranıyor..."
set "PASSWORD_NOT_FOUND=Bu WiFi ağının şifresi bulunamadı veya şifre korunmuyor."
set "PASSWORD_DISPLAY_TITLE=- WiFi Şifresi -"
set "PASSWORD_NETWORK_NAME=Wi-Fi Adı:"
set "PASSWORD_LABEL=Şifre:"
set "COLOR_TITLE=CLI Menü Renkleri"
set "COLOR_OPTION1=1- Varsayılan Renkler (Yeşil)"
set "COLOR_OPTION2=2- Mavi Tema"
set "COLOR_OPTION3=3- Sarı Tema"
set "COLOR_OPTION4=4- Kırmızı Tema"
set "COLOR_OPTION5=5- Mor Tema"
set "COLOR_OPTION6=6- Geri Dön"
set "COLOR_PROMPT=Renk temasını seçin (1-6): "
set "COLOR_ERROR=Hatalı seçim! Lütfen 1-6 arasında bir sayı girin."
set "COLOR_APPLIED1=Varsayılan renkler uygulandı!"
set "COLOR_APPLIED2=Mavi tema uygulandı!"
set "COLOR_APPLIED3=Sarı tema uygulandı!"
set "COLOR_APPLIED4=Kırmızı tema uygulandı!"
set "COLOR_APPLIED5=Mor tema uygulandı!"
set "EXIT_MESSAGE1=Script kapatılıyor..."
set "EXIT_MESSAGE2=Teşekkürler!"
exit /b

:SET_ENGLISH_TEXT
set "MENU_TITLE=- FiWi1.1 -"
set "MENU_OPTION1=1- Saved WiFi Networks (Network Names Only)"
set "MENU_OPTION2=2- Saved WiFi Network Passwords"
set "MENU_OPTION3=3- CLI Menu Colors"
set "MENU_OPTION4=4- Exit"
set "MENU_PROMPT=Please make your selection (1-4): "
set "MENU_ERROR=Invalid selection! Please enter a number between 1-4."
set "NETWORKS_TITLE=Saved WiFi Networks"
set "NETWORKS_NOT_FOUND=No saved WiFi networks found!"
set "NETWORKS_FOUND_TR=Toplam"
set "NETWORKS_FOUND_EN=Total"
set "NETWORKS_FOUND_END_TR=adet kayıtlı WiFi ağı bulundu."
set "NETWORKS_FOUND_END_EN=saved WiFi networks found."
set "CONTINUE_PROMPT=Would you like to perform another operation? (Press \"M\" to Return to Main Menu)"
set "CONTINUE_OPTIONS=Y/N/M"
set "CONTINUE_INPUT=Make your selection (Y/N/M): "
set "CONTINUE_ERROR=Invalid selection! Redirecting to main menu..."
set "PASSWORDS_TITLE=View WiFi Passwords"
set "PASSWORD_SELECT_PROMPT=Enter the number of the WiFi network whose password you want to see: "
set "PASSWORD_ERROR1=Please enter a valid number!"
set "PASSWORD_ERROR2=Please enter numbers only!"
set "PASSWORD_SELECTED=Selected WiFi Network:"
set "PASSWORD_SEARCHING=Searching for password..."
set "PASSWORD_NOT_FOUND=Password for this WiFi network not found or not protected."
set "PASSWORD_DISPLAY_TITLE=- WiFi Password -"
set "PASSWORD_NETWORK_NAME=Wi-Fi Name:"
set "PASSWORD_LABEL=Password:"
set "COLOR_TITLE=CLI Menu Colors"
set "COLOR_OPTION1=1- Default Colors (Green)"
set "COLOR_OPTION2=2- Blue Theme"
set "COLOR_OPTION3=3- Yellow Theme"
set "COLOR_OPTION4=4- Red Theme"
set "COLOR_OPTION5=5- Purple Theme"
set "COLOR_OPTION6=6- Go Back"
set "COLOR_PROMPT=Select color theme (1-6): "
set "COLOR_ERROR=Invalid selection! Please enter a number between 1-6."
set "COLOR_APPLIED1=Default colors applied!"
set "COLOR_APPLIED2=Blue theme applied!"
set "COLOR_APPLIED3=Yellow theme applied!"
set "COLOR_APPLIED4=Red theme applied!"
set "COLOR_APPLIED5=Purple theme applied!"
set "EXIT_MESSAGE1=Closing script..."
set "EXIT_MESSAGE2=Thank you!"
exit /b

:MAIN_MENU
cls
color %CURRENT_COLOR%
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                         - FiWi 1.1 -                         ║
echo ║                         by an1lbayram                        ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo %MENU_OPTION1%
echo %MENU_OPTION2%
echo %MENU_OPTION3%
echo %MENU_OPTION4%
echo.
set /p choice=%MENU_PROMPT%

if "%choice%"=="1" goto SHOW_NETWORKS
if "%choice%"=="2" goto SHOW_PASSWORDS
if "%choice%"=="3" goto COLOR_MENU
if "%choice%"=="4" goto EXIT
echo %MENU_ERROR%
pause
goto MAIN_MENU

:SHOW_NETWORKS
cls
color %CURRENT_COLOR%
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo                        %NETWORKS_TITLE%                      
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
    echo %NETWORKS_NOT_FOUND%
) else (
    echo.
    if "%LANG%"=="TR" (
        echo %NETWORKS_FOUND_TR% %counter% %NETWORKS_FOUND_END_TR%
    ) else (
        echo %NETWORKS_FOUND_EN% %counter% %NETWORKS_FOUND_END_EN%
    )
)

echo %CONTINUE_PROMPT%
echo %CONTINUE_OPTIONS%
echo.
set /p continue=%CONTINUE_INPUT%

if /i "%continue%"=="E" goto MAIN_MENU
if /i "%continue%"=="Y" goto MAIN_MENU
if /i "%continue%"=="H" goto EXIT
if /i "%continue%"=="N" goto EXIT
if /i "%continue%"=="M" goto MAIN_MENU
echo %CONTINUE_ERROR%
timeout /t 2 >nul
goto MAIN_MENU

:SHOW_PASSWORDS
cls
color %CURRENT_COLOR%
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo                       %PASSWORDS_TITLE%                     
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
    echo %NETWORKS_NOT_FOUND%
    echo.
    pause
    goto MAIN_MENU
)

echo.
set /p selection=%PASSWORD_SELECT_PROMPT%

:: Seçimi kontrol et
if "%selection%"=="" (
    echo %PASSWORD_ERROR1%
    pause
    goto SHOW_PASSWORDS
)

:: Sayı kontrolü
echo %selection%| findstr /r "^[0-9][0-9]*$" >nul
if errorlevel 1 (
    echo %PASSWORD_ERROR2%
    pause
    goto SHOW_PASSWORDS
)

:: Aralık kontrolü
if %selection% LSS 1 (
    if "%LANG%"=="TR" (
        echo Lütfen 1-%counter% arasında bir sayı girin!
    ) else (
        echo Please enter a number between 1-%counter%!
    )
    pause
    goto SHOW_PASSWORDS
)

if %selection% GTR %counter% (
    if "%LANG%"=="TR" (
        echo Lütfen 1-%counter% arasında bir sayı girin!
    ) else (
        echo Please enter a number between 1-%counter%!
    )
    pause
    goto SHOW_PASSWORDS
)

:: Seçilen profili al
set "selected_profile=!profiles[%selection%]!"

echo.
echo %PASSWORD_SELECTED% %selected_profile%
echo %PASSWORD_SEARCHING%
echo.

:: Şifreyi al
for /f "tokens=2 delims=:" %%i in ('netsh wlan show profile name^="%selected_profile%" key^=clear ^| findstr "Key Content"') do (
    set "password=%%i"
    set "password=!password:~1!"
)

if "!password!"=="" (
    echo %PASSWORD_NOT_FOUND%
) else (
    echo ╔══════════════════════════════════════════════════════════╗
    echo                      %PASSWORD_DISPLAY_TITLE%                 
    echo ╚══════════════════════════════════════════════════════════╝
    echo.
    echo %PASSWORD_NETWORK_NAME% %selected_profile%
    echo %PASSWORD_LABEL% !password!
    echo.
)

echo.
echo %CONTINUE_PROMPT%
echo %CONTINUE_OPTIONS%
echo.
set /p continue=%CONTINUE_INPUT%

if /i "%continue%"=="E" goto SHOW_PASSWORDS
if /i "%continue%"=="Y" goto SHOW_PASSWORDS
if /i "%continue%"=="H" goto EXIT
if /i "%continue%"=="N" goto EXIT
if /i "%continue%"=="M" goto MAIN_MENU
echo %CONTINUE_ERROR%
timeout /t 2 >nul
goto MAIN_MENU

:COLOR_MENU
cls
color %CURRENT_COLOR%
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo                          %COLOR_TITLE%                      
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo  %COLOR_OPTION1%
echo  %COLOR_OPTION2%
echo  %COLOR_OPTION3%
echo  %COLOR_OPTION4%
echo  %COLOR_OPTION5%
echo  %COLOR_OPTION6%
echo.
set /p color_choice=%COLOR_PROMPT%

if "%color_choice%"=="1" goto DEFAULT_COLORS
if "%color_choice%"=="2" goto BLUE_THEME
if "%color_choice%"=="3" goto YELLOW_THEME
if "%color_choice%"=="4" goto RED_THEME
if "%color_choice%"=="5" goto PURPLE_THEME
if "%color_choice%"=="6" goto MAIN_MENU
echo %COLOR_ERROR%
pause
goto COLOR_MENU

:DEFAULT_COLORS
set "CURRENT_COLOR=0A"
color %CURRENT_COLOR%
echo %COLOR_APPLIED1%
goto COLOR_CONTINUE

:BLUE_THEME
set "CURRENT_COLOR=0B"
color %CURRENT_COLOR%
echo %COLOR_APPLIED2%
goto COLOR_CONTINUE

:YELLOW_THEME
set "CURRENT_COLOR=0E"
color %CURRENT_COLOR%
echo %COLOR_APPLIED3%
goto COLOR_CONTINUE

:RED_THEME
set "CURRENT_COLOR=0C"
color %CURRENT_COLOR%
echo %COLOR_APPLIED4%
goto COLOR_CONTINUE

:PURPLE_THEME
set "CURRENT_COLOR=0D"
color %CURRENT_COLOR%
echo %COLOR_APPLIED5%
goto COLOR_CONTINUE

:COLOR_CONTINUE
echo.
echo %CONTINUE_PROMPT%
echo %CONTINUE_OPTIONS%
echo.
set /p continue=%CONTINUE_INPUT%

if /i "%continue%"=="E" goto COLOR_MENU
if /i "%continue%"=="Y" goto COLOR_MENU
if /i "%continue%"=="H" goto EXIT
if /i "%continue%"=="N" goto EXIT
if /i "%continue%"=="M" goto MAIN_MENU
echo %CONTINUE_ERROR%
timeout /t 2 >nul
goto MAIN_MENU

:EXIT
cls
color %CURRENT_COLOR%
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                         - FiWi 1.1 -                         ║
echo ║                         by an1lbayram                        ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo %EXIT_MESSAGE1%
echo %EXIT_MESSAGE2%
echo.
timeout /t 5 /nobreak >nul
exit
