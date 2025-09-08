@echo off
REM Batch Build Script for Windows
REM Usage: build.bat <command>

if "%1"=="" (
    goto :help
)

set BUILD_CMD=.\build_and_run_app.bat

if "%1"=="update_app_icon" goto :update_app_icon
if "%1"=="update_splash" goto :update_splash
if "%1"=="remove_splash" goto :remove_splash
if "%1"=="l10n" goto :l10n
if "%1"=="clean" goto :clean
if "%1"=="pub_get" goto :pub_get
if "%1"=="sync" goto :sync
if "%1"=="gen_env" goto :gen_env
if "%1"=="build_runner_all" goto :build_runner_all
if "%1"=="build_runner_app" goto :build_runner_app
if "%1"=="build_runner_domain" goto :build_runner_domain
if "%1"=="build_runner_network" goto :build_runner_network
if "%1"=="build_runner_shared" goto :build_runner_shared
if "%1"=="build_staging_apk" goto :build_staging_apk
if "%1"=="build_prod_apk" goto :build_prod_apk
if "%1"=="build_staging_bundle" goto :build_staging_bundle
if "%1"=="build_prod_bundle" goto :build_prod_bundle
if "%1"=="build_staging_ipa" goto :build_staging_ipa
if "%1"=="build_prod_ipa" goto :build_prod_ipa
if "%1"=="pub_get_app" goto :pub_get_app
if "%1"=="pub_get_domain" goto :pub_get_domain
if "%1"=="pub_get_network" goto :pub_get_network
if "%1"=="pub_get_shared" goto :pub_get_shared

echo Unknown command: %1
goto :help

:update_app_icon
cd app
dart run flutter_launcher_icons
cd ..
goto :eof

:update_splash
cd app
dart run flutter_native_splash:create --path=splash/splash.yaml
cd ..
goto :eof

:remove_splash
cd app
dart run flutter_native_splash:remove --path=splash/splash.yaml
cd ..
goto :eof

:l10n
melos run l10n
goto :eof

:clean
melos clean
goto :eof

:pub_get
melos bootstrap
goto :eof

:sync
melos bootstrap
melos run l10n
melos run build_runner_all
goto :eof

:gen_env
dart pub get --directory=tools
dart run tools/lib/main.dart
goto :eof

:build_runner_all
melos run build_runner_all
goto :eof

:build_runner_app
melos run build_runner_app
goto :eof

:build_runner_domain
melos run build_runner_domain
goto :eof

:build_runner_network
melos run build_runner_network
goto :eof

:build_runner_shared
melos run build_runner_shared
goto :eof

:build_staging_apk
cd tools
call %BUILD_CMD% staging build apk
cd ..
goto :eof

:build_prod_apk
cd tools
call %BUILD_CMD% prod build apk
cd ..
goto :eof

:build_staging_bundle
cd tools
call %BUILD_CMD% staging build appbundle
cd ..
goto :eof

:build_prod_bundle
cd tools
call %BUILD_CMD% prod build appbundle
cd ..
goto :eof

:build_staging_ipa
cd tools
call %BUILD_CMD% staging build ipa --export-options-plist=ios/exportOptions.plist
cd ..
goto :eof

:build_prod_ipa
cd tools
call %BUILD_CMD% prod build ipa --export-options-plist=ios/exportOptions.plist
cd ..
goto :eof

:pub_get_app
melos run pub_get_app
goto :eof

:pub_get_domain
melos run pub_get_domain
goto :eof

:pub_get_network
melos run pub_get_network
goto :eof

:pub_get_shared
melos run pub_get_shared
goto :eof

:help
echo Available commands:
echo   update_app_icon, update_splash, remove_splash
echo   l10n, clean, pub_get, sync, gen_env
echo   build_runner_all, build_runner_app, build_runner_domain
echo   build_runner_network, build_runner_shared
echo   build_staging_apk, build_prod_apk
echo   build_staging_bundle, build_prod_bundle
echo   build_staging_ipa, build_prod_ipa
echo   pub_get_app, pub_get_domain, pub_get_network, pub_get_shared
echo.
echo Usage: build.bat ^<command^>
goto :eof