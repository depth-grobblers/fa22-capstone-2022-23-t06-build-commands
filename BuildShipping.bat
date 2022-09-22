SET PROJECT_FOLDER=Capstone_Test_Repo
SET PROJECT_NAME=VR_Template
%PROJECT_NAME%
cd:\Project\%PROJECT_FOLDER%

git pull origin main

if NOT "%ERRORLEVEL%"=="0" EXIT /B %ERRORLEVEL%

cd %WORKSPACE%

cd %PROJECT_FOLDER%

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

cmd /c call Build.bat
if NOT "%ERRORLEVEL%"=="0" EXIT /B %ERRORLEVEL%

Rem do you need this? yes
move Data\Builds.zip %WORKSPACE%

EXIT /B 0