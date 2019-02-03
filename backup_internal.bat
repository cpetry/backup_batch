echo off
setlocal enabledelayedexpansion 

REM --- Edit the lines below to create your own backup strategy
REM --- Use robocopy /mir option to mirror files (deleted files in src will be deleted in dst!)
REM --- Add more lines for each new folder requiring backup
rem --- The results of the backup can be found in txt log file

REM Read in parameters
REM -----------------

for /f %%D in ('wmic volume get DriveLetter^, Label ^| find "%1"') do (
    SET ext_src_drive=%%D
)
for /f %%D in ('wmic volume get DriveLetter^, Label ^| find "%3"') DO (
	SET ext_dst_drive=%%D
)

SET exclude_files=*.MOV *.MP4 *.AVI *.db *.3GP *.MPG

REM Execute robocopy
REM ----------------
IF DEFINED ext_dst_drive (
    IF DEFINED ext_src_drive (
        echo Running backup for "%ext_src_drive%/%2"!
        robocopy "%ext_src_drive%/%2" "%ext_dst_drive%/%4/%2" /e /xf %exclude_files% /np /tee /mt:4 /r:1 /log:my_backup_log.txt
    ) ELSE (
        echo source "%ext_src_drive%/%2" is not found!
    )
) ELSE (
	echo external destination called "%ext_src_drive%/%2" is not found!
)
