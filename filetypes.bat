@echo off
REM Lists all file extensions inside 'target' folder
set target=F:\_Fotos

if "%target%"=="" set target=%cd%
echo Searching for filetypes in "%target%"
echo ...This could take a while...

setlocal EnableDelayedExpansion

set LF=^


rem Previous two lines deliberately left blank for LF to work.

echo Found types:

for /f "tokens=*" %%i in ('dir /b /s /a:-d "%target%" /L') do (
    set ext=%%~xi
    if "!ext!"=="" set ext=FileWithNoExtension
    echo !extlist! | find "!ext!:" > nul
    if not !ERRORLEVEL! == 0 (
		ECHO !ext!
		set extlist=!extlist!!ext!:
	)
)
ECHO  -- Finished -- 

endlocal

pause