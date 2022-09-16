cd:\Project\fa22-capstone-2022-23-t06-p01

git pull origin main

if NOT "%ERRORLEVEL%"=="0" EXIT /B %ERRORLEVEL%

cd %WORKSPACE%

cd fa22-capstone-2022-23-t06-build-repo

Call Generate.bat
if NOT "%ERRORLEVEL%"=="0" EXIT /B %ERRORLEVEL%

cmd /c call CompileEditor.bat
if NOT "%ERRORLEVEL%"=="0" EXIT /B %ERRORLEVEL%

cmd /c call CompileGame.bat
if NOT "%ERRORLEVEL%"=="0" EXIT /B %ERRORLEVEL%

Rem Call Build.bat
cmd /c call Build.bat
if NOT "%ERRORLEVEL%"=="0" EXIT /B %ERRORLEVEL%

cd C:\Build

Rem Archive
powershell Compress-Archive Data\Builds\ Data\Builds.zip
EXIT /B %ERRORLEVEL%

Rem check file size
FOR /F "usebackq" %%A IN ('"Data\Builds.zip"') DO set size=%%~zA
if %size% LSS 1000 (
    EXIT /B 1
)

EXIT /B 0