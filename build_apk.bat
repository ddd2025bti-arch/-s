@echo off
title SMRISS GGSSS Bathinda - Build Android APK
echo ========================================================
echo  SMRISS GGSSS Bathinda Smart School Portal - APK Builder
echo ========================================================
echo.

where flutter >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Flutter SDK was not found in your system PATH.
    echo.
    echo To build the APK locally on this computer:
    echo  1. Download Flutter SDK from https://docs.flutter.dev/get-started/install/windows
    echo  2. Extract it (e.g. to C:\src\flutter) and add its bin folder to PATH.
    echo  3. Ensure Android Studio is installed with Android SDK command-line tools.
    echo  4. Run this script again!
    echo.
    echo Alternatively:
    echo  - Push this project to GitHub and use our included GitHub Actions
    echo    workflow (.github/workflows/build_apk.yml) to automatically compile
    echo    and download the APK from the cloud in 2 minutes!
    echo.
    pause
    exit /b 1
)

echo [1/3] Fetching Flutter dependencies...
call flutter pub get
if %errorlevel% neq 0 (
    echo [ERROR] Failed to get packages.
    pause
    exit /b 1
)

echo.
echo [2/3] Building Release APK for Android (com.school.myapp)...
call flutter build apk --release
if %errorlevel% neq 0 (
    echo [ERROR] Build failed. Please check Android SDK and licenses.
    pause
    exit /b 1
)

echo.
echo [3/3] Build Successful!
echo APK Location: build\app\outputs\flutter-apk\app-release.apk
explorer build\app\outputs\flutter-apk
echo.
echo You can now transfer app-release.apk to your phone and install it.
pause
