echo off
setlocal enabledelayedexpansion 

REM --- Edit the lines below to create your own backup strategy
REM --- Use robocopy /mir option to mirror files (deleted files in src will be deleted in dst!)
REM --- Add more lines for each new folder requiring backup
rem --- The results of the backup can be found in txt log file

REM Read in parameters
REM -----------------
SET ext_src_drivelabel[0]=Fotobox
SET ext_src_path[0]=_Fotos
SET ext_src_drivelabel[1]=Laptop-Extern
SET ext_src_path[1]=Eigene Dateien

SET ext_dst_drivelabel=Backup
SET ext_dst_path=RoboBackup


REM Get drive letters for labels
REM ----------------------------
for /l %%n in (0,1,1) do (
	for /f %%D in ('wmic volume get DriveLetter^, Label ^| find "!ext_src_drivelabel[%%n]!"') do (
		SET ext_src_drive[%%n]=%%D
	)
)

for /f %%D in ('wmic volume get DriveLetter^, Label ^| find "%ext_dst_drivelabel%"') DO (
	SET ext_dst_drive=%%D
)


SET exclude_files=*.MOV *.MP4 *.AVI *.db *.3GP *.MPG

REM Execute robocopy
REM ----------------
IF DEFINED ext_dst_drive (
	for /l %%n in (0,1,2) do (
		IF DEFINED ext_src_drive[%%n] (
			echo Running backup for "!ext_src_drive[%%n]!\!ext_src_path[%%n]!"!
			robocopy "!ext_src_drive[%%n]!\!ext_src_path[%%n]!" "%ext_dst_drive%\%ext_dst_path%\!ext_src_path[%%n]!" /e /xf %exclude_files% /np /tee /mt:4 /r:1 /log:my_backup_!ext_src_drive[%%n]!_log.txt
		) ELSE (
			echo source !ext_src_drive[%%n]!\!ext_src_path[%%n]! is not found!
		)
	)
) ELSE (
	echo external drive called "%ext_dst_drivelabel%" is not found!
)

pause