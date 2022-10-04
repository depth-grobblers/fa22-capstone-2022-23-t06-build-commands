SET PROJECT_FOLDER=fa22-capstone-2022-23-t06
SET PROJECT_NAME=Dead_Pedal_2

%PROJECT_FOLDER%
%PROJECT_NAME%

cd C:\Projects\%PROJECT_FOLDER%

call :StartTimer

git config --global --add safe.directory C:/Projects/%PROJECT_FOLDER%

git pull origin main

if NOT "%ERRORLEVEL%"=="0" EXIT /B %ERRORLEVEL%

call :StopTimer
call :DisplayTimerResult

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

Rem Copy
powershell Copy-Item %WORKSPACE%\buildv%BUILD_NUMBER%.zip %WORKSPACE%\build-latest.zip
EXIT /B %ERRORLEVEL%

cd %WORKSPACE%

Rem check file size
FOR /F "usebackq" %%A IN ('"buildv%BUILD_NUMBER%.zip"') DO set size=%%~zA
if %size% LSS 1000 (
    EXIT /B 1
)

EXIT /B 0

:StartTimer
:: Store start time
set StartTIME=%TIME%
for /f "usebackq tokens=1-4 delims=:., " %%f in (`echo %StartTIME: =0%`) do set /a Start100S=1%%f*360000+1%%g*6000+1%%h*100+1%%i-36610100
goto :EOF

:StopTimer
:: Get the end time
set StopTIME=%TIME%
for /f "usebackq tokens=1-4 delims=:., " %%f in (`echo %StopTIME: =0%`) do set /a Stop100S=1%%f*360000+1%%g*6000+1%%h*100+1%%i-36610100
:: Test midnight rollover. If so, add 1 day=8640000 1/100ths secs
if %Stop100S% LSS %Start100S% set /a Stop100S+=8640000
set /a TookTime=%Stop100S%-%Start100S%
set TookTimePadded=0%TookTime%
goto :EOF

:DisplayTimerResult
:: Show timer start/stop/delta
echo Started: %StartTime%
echo Stopped: %StopTime%
echo Elapsed: %TookTime:~0,-2%.%TookTimePadded:~-2% seconds
goto :EOF
