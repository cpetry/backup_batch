ECHO OFF

REM This script encodes *.mov and *.mp4 to mp4 with preset fast 1080p30.
REM Should be a good solution to reduce size of movies created by digital cameras
REM You need HandBrakeCLI for that.

SETLOCAL EnableDelayedExpansion

set src=F:\_Fotos
set dst=G:\RoboBackup\_Fotos

set ext=*.MOV *.MP4 *.AVI *.3GP *.MPG

ECHO Encoding videos %src% to %dst% with "_min.mp4" extension

FOR /R %src% %%G IN (%ext%) DO (
	SET dstPath=%%~dG%%~pG
	SET dstPath=!dstPath:%src%=%dst%!
	IF NOT EXIST "!dstPath!%%~nG_min.mp4" (
		REM create folder path if it doesnt exist
		if not exist "!dstPath!" mkdir !dstPath!

		ECHO Encoding %%G
		HandBrakeCLI -i "%%G" -o "!dstPath!%%~nG_min.mp4" --preset="Fast 1080p30" >nul 2>&1
	) ELSE (
	 	ECHO %%G was already encoded! Skipping...
	)
)

endlocal

PAUSE