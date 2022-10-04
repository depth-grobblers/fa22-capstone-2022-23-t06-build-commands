SET PROJECT_FOLDER=fa22-capstone-2022-23-t06
SET PROJECT_NAME=Dead_Pedal_2

%PROJECT_FOLDER%
%PROJECT_NAME%

cd C:\Projects\%PROJECT_FOLDER%

git config --global --add safe.directory C:/Projects/%PROJECT_FOLDER%

git pull origin main

if NOT "%ERRORLEVEL%"=="0" EXIT /B %ERRORLEVEL%

cd %WORKSPACE%

cd fa22-capstone-2022-23-t06-build-commands

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
powershell Compress-Archive windows\ %WORKSPACE%\buildv%BUILD_NUMBER%.zip
EXIT /B %ERRORLEVEL%

cd %WORKSPACE%

Rem check file size
FOR /F "usebackq" %%A IN ('"Builds.zip"') DO set size=%%~zA
if %size% LSS 1000 (
    EXIT /B 1
)

EXIT /B 0
