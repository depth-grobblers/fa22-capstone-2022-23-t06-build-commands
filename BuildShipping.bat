cd C:\Projects\fa22-capstone-2022-23-t06-p01

git config --global --add safe.directory C:/Projects/fa22-capstone-2022-23-t06-p01

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
powershell Compress-Archive windows\ %WORKSPACE%\Data\Builds.zip
EXIT /B %ERRORLEVEL%

EXIT /B 0