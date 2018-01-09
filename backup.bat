echo off

REM --- Edit the lines below to create your own backup strategy
REM --- Use robocopy /mir option to mirror files (deleted files in src will be deleted in dst!)
REM --- Add more lines for each new folder requiring backup
rem --- The results of the backup can be found in txt log file

for /f %%D in ('wmic volume get DriveLetter^, Label ^| find "Backup"') do set ext_drive_backup_letter=%%D
for /f %%D in ('wmic volume get DriveLetter^, Label ^| find "Laptop-Extern"') do set ext_drive_chris_letter=%%D
for /f %%D in ('wmic volume get DriveLetter^, Label ^| find "Fotobox"') do set ext_drive_photo_letter=%%D

IF DEFINED ext_drive_backup_letter IF DEFINED ext_drive_chris_letter (
	robocopy "%ext_drive_chris_letter%\Eigene Dateien" "%ext_drive_backup_letter%\RoboBackup\Eigene Dateien" /e /np /tee /mt:4 /r:1 /log:my_backup_log.txt
) ELSE (
	echo ext_drive_backup_letter is not found!
)

IF DEFINED ext_drive_backup_letter IF DEFINED ext_drive_photo_letter (
	robocopy "%ext_drive_photo_letter%\_Fotos" "%ext_drive_backup_letter%\RoboBackup\_Fotos" /e /np /tee /mt:4 /r:1 /log:my_backup_log.txt
) ELSE (
	echo ext_drive_backup_letter is not found!
)
	
pause