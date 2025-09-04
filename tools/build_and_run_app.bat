@echo off
REM Usage: build_and_run_app.bat dev build apk

REM Lấy các tham số
REM %1 = flavor (dev/staging/prod)
REM %2 = build/run
REM %3 = apk/appbundle/ios/ipa (optional)
REM %4 = export options (optional, iOS only)

set FLAVOR=%1
set ACTION=%2
set TARGET=%3
set EXTRA=%4

REM Chuyển vào thư mục app
cd ..\app

REM Tạo lệnh flutter
set CMD=flutter %ACTION% %TARGET% %EXTRA% --flavor %FLAVOR% --dart-define FLAVOR=%FLAVOR%

echo %CMD%
%CMD%
