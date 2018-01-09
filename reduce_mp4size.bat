ECHO OFF

REM This script encodes *.mov and *.mp4 to mp4 with preset fast 1080p30.
REM Should be a good solution to reduce size of movies created by digital cameras
REM You need HandBrakeCLI for that.

FOR /F "tokens=*" %%G IN ('DIR /B /S *.MOV *.MP4 ^|FINDSTR /V /I "_min.mp4"') DO (
	IF NOT EXIST "%%G"_min.mp4 (
		ECHO %%G encoding...
	 	"HandBrakeCLI" -i "%%G" -o "%%G"_min.mp4 --preset="Fast 1080p30" >nul 2>&1
	 	ECHO|set /p="Done!"
	) ELSE (
	 	ECHO %%G was already encoded! Skipping...
	)
)

PAUSE