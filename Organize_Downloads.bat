@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ================================================================
:: Organize_Downloads.bat
:: Creates category folders and moves files in your Downloads folder
:: into matching folders such as Audio, Video, Excel, ZIP, etc.
::
:: Usage:
::   1) Double-click this file to organize: %USERPROFILE%\Downloads
::   2) Or run from Command Prompt with a custom folder:
::        Organize_Downloads.bat "D:\Path\To\Folder"
::
:: Notes:
::   - Only files directly inside the chosen folder are moved.
::   - Existing folders/subfolders are not moved.
::   - If a file with the same name already exists, a number is added.
:: ================================================================

if "%~1"=="" (
    set "TARGET=%USERPROFILE%\Downloads"
) else (
    set "TARGET=%~1"
)

if not exist "%TARGET%\" (
    echo ERROR: Folder not found: "%TARGET%"
    echo.
    pause
    exit /b 1
)

cls
echo ================================================================
echo  Downloads Folder Organizer
echo ================================================================
echo.
echo Target folder:
echo "%TARGET%"
echo.
echo This will move files into category folders inside the target folder.
echo Existing folders will not be moved.
echo.
choice /C YN /M "Continue"
if errorlevel 2 (
    echo.
    echo Cancelled. No files were moved.
    pause
    exit /b 0
)

:: Create category folders
for %%D in (
    "Audio"
    "Video"
    "Images"
    "Documents"
    "PDF"
    "Word"
    "Excel"
    "PowerPoint"
    "ZIP_Archives"
    "Installers"
    "Code"
    "Text"
    "Ebooks"
    "Fonts"
    "Shortcuts"
    "Torrents"
    "Disk_Images"
    "Others"
) do if not exist "%TARGET%\%%~D\" mkdir "%TARGET%\%%~D" >nul 2>&1

set /a MOVED=0
set /a SKIPPED=0

echo.
echo Organizing files...
echo.

for %%F in ("%TARGET%\*") do (
    if not exist "%%~fF\" (
        if /I not "%%~fF"=="%~f0" (
            call :CategorizeAndMove "%%~fF"
        )
    )
)

echo.
echo ================================================================
echo  Done!
echo  Files moved:   %MOVED%
echo  Files skipped: %SKIPPED%
echo ================================================================
echo.
pause
exit /b 0

:CategorizeAndMove
set "FILE=%~1"
set "EXT=%~x1"
set "CATEGORY=Others"

:: Audio
if /I "%EXT%"==".mp3"  set "CATEGORY=Audio"
if /I "%EXT%"==".wav"  set "CATEGORY=Audio"
if /I "%EXT%"==".flac" set "CATEGORY=Audio"
if /I "%EXT%"==".aac"  set "CATEGORY=Audio"
if /I "%EXT%"==".ogg"  set "CATEGORY=Audio"
if /I "%EXT%"==".m4a"  set "CATEGORY=Audio"
if /I "%EXT%"==".wma"  set "CATEGORY=Audio"
if /I "%EXT%"==".opus" set "CATEGORY=Audio"

:: Video
if /I "%EXT%"==".mp4"  set "CATEGORY=Video"
if /I "%EXT%"==".mkv"  set "CATEGORY=Video"
if /I "%EXT%"==".avi"  set "CATEGORY=Video"
if /I "%EXT%"==".mov"  set "CATEGORY=Video"
if /I "%EXT%"==".wmv"  set "CATEGORY=Video"
if /I "%EXT%"==".flv"  set "CATEGORY=Video"
if /I "%EXT%"==".webm" set "CATEGORY=Video"
if /I "%EXT%"==".m4v"  set "CATEGORY=Video"
if /I "%EXT%"==".3gp"  set "CATEGORY=Video"

:: Images
if /I "%EXT%"==".jpg"  set "CATEGORY=Images"
if /I "%EXT%"==".jpeg" set "CATEGORY=Images"
if /I "%EXT%"==".png"  set "CATEGORY=Images"
if /I "%EXT%"==".gif"  set "CATEGORY=Images"
if /I "%EXT%"==".bmp"  set "CATEGORY=Images"
if /I "%EXT%"==".tif"  set "CATEGORY=Images"
if /I "%EXT%"==".tiff" set "CATEGORY=Images"
if /I "%EXT%"==".webp" set "CATEGORY=Images"
if /I "%EXT%"==".svg"  set "CATEGORY=Images"
if /I "%EXT%"==".heic" set "CATEGORY=Images"
if /I "%EXT%"==".ico"  set "CATEGORY=Images"

:: Documents
if /I "%EXT%"==".pdf"  set "CATEGORY=PDF"
if /I "%EXT%"==".doc"  set "CATEGORY=Word"
if /I "%EXT%"==".docx" set "CATEGORY=Word"
if /I "%EXT%"==".rtf"  set "CATEGORY=Documents"
if /I "%EXT%"==".odt"  set "CATEGORY=Documents"

:: Excel
if /I "%EXT%"==".xls"  set "CATEGORY=Excel"
if /I "%EXT%"==".xlsx" set "CATEGORY=Excel"
if /I "%EXT%"==".xlsm" set "CATEGORY=Excel"
if /I "%EXT%"==".csv"  set "CATEGORY=Excel"
if /I "%EXT%"==".ods"  set "CATEGORY=Excel"

:: PowerPoint
if /I "%EXT%"==".ppt"  set "CATEGORY=PowerPoint"
if /I "%EXT%"==".pptx" set "CATEGORY=PowerPoint"
if /I "%EXT%"==".pptm" set "CATEGORY=PowerPoint"
if /I "%EXT%"==".odp"  set "CATEGORY=PowerPoint"

:: Archives / ZIP
if /I "%EXT%"==".zip" set "CATEGORY=ZIP_Archives"
if /I "%EXT%"==".rar" set "CATEGORY=ZIP_Archives"
if /I "%EXT%"==".7z"  set "CATEGORY=ZIP_Archives"
if /I "%EXT%"==".tar" set "CATEGORY=ZIP_Archives"
if /I "%EXT%"==".gz"  set "CATEGORY=ZIP_Archives"
if /I "%EXT%"==".bz2" set "CATEGORY=ZIP_Archives"
if /I "%EXT%"==".xz"  set "CATEGORY=ZIP_Archives"

:: Installers / Apps
if /I "%EXT%"==".exe"  set "CATEGORY=Installers"
if /I "%EXT%"==".msi"  set "CATEGORY=Installers"
if /I "%EXT%"==".msix" set "CATEGORY=Installers"
if /I "%EXT%"==".apk"  set "CATEGORY=Installers"
if /I "%EXT%"==".appx" set "CATEGORY=Installers"

:: Code
if /I "%EXT%"==".html" set "CATEGORY=Code"
if /I "%EXT%"==".htm"  set "CATEGORY=Code"
if /I "%EXT%"==".css"  set "CATEGORY=Code"
if /I "%EXT%"==".js"   set "CATEGORY=Code"
if /I "%EXT%"==".ts"   set "CATEGORY=Code"
if /I "%EXT%"==".json" set "CATEGORY=Code"
if /I "%EXT%"==".xml"  set "CATEGORY=Code"
if /I "%EXT%"==".py"   set "CATEGORY=Code"
if /I "%EXT%"==".java" set "CATEGORY=Code"
if /I "%EXT%"==".cpp"  set "CATEGORY=Code"
if /I "%EXT%"==".c"    set "CATEGORY=Code"
if /I "%EXT%"==".cs"   set "CATEGORY=Code"
if /I "%EXT%"==".php"  set "CATEGORY=Code"
if /I "%EXT%"==".sh"   set "CATEGORY=Code"
if /I "%EXT%"==".bat"  set "CATEGORY=Code"
if /I "%EXT%"==".cmd"  set "CATEGORY=Code"
if /I "%EXT%"==".ps1"  set "CATEGORY=Code"

:: Text / Notes
if /I "%EXT%"==".txt" set "CATEGORY=Text"
if /I "%EXT%"==".md"  set "CATEGORY=Text"
if /I "%EXT%"==".log" set "CATEGORY=Text"

:: Ebooks
if /I "%EXT%"==".epub" set "CATEGORY=Ebooks"
if /I "%EXT%"==".mobi" set "CATEGORY=Ebooks"
if /I "%EXT%"==".azw"  set "CATEGORY=Ebooks"
if /I "%EXT%"==".azw3" set "CATEGORY=Ebooks"

:: Fonts
if /I "%EXT%"==".ttf"   set "CATEGORY=Fonts"
if /I "%EXT%"==".otf"   set "CATEGORY=Fonts"
if /I "%EXT%"==".woff"  set "CATEGORY=Fonts"
if /I "%EXT%"==".woff2" set "CATEGORY=Fonts"

:: Shortcuts / Torrents / Disk Images
if /I "%EXT%"==".lnk"     set "CATEGORY=Shortcuts"
if /I "%EXT%"==".url"     set "CATEGORY=Shortcuts"
if /I "%EXT%"==".torrent" set "CATEGORY=Torrents"
if /I "%EXT%"==".iso"     set "CATEGORY=Disk_Images"
if /I "%EXT%"==".img"     set "CATEGORY=Disk_Images"
if /I "%EXT%"==".vhd"     set "CATEGORY=Disk_Images"
if /I "%EXT%"==".vhdx"    set "CATEGORY=Disk_Images"

call :MoveFileSafely "%FILE%" "%TARGET%\%CATEGORY%"
exit /b 0

:MoveFileSafely
set "SRC=%~1"
set "DESTDIR=%~2"
set "NAME=%~n1"
set "EXTN=%~x1"
set "DEST=%DESTDIR%\%~nx1"
set /a N=1

if not exist "%DESTDIR%\" mkdir "%DESTDIR%" >nul 2>&1

:FindFreeName
if exist "%DEST%" (
    set "DEST=%DESTDIR%\%NAME% (!N!)%EXTN%"
    set /a N+=1
    goto :FindFreeName
)

move /Y "%SRC%" "%DEST%" >nul
if errorlevel 1 (
    echo [SKIPPED] "%SRC%"
    set /a SKIPPED+=1
) else (
    echo [MOVED] "%~nx1" --^> "%~nx2"
    set /a MOVED+=1
)
exit /b 0
