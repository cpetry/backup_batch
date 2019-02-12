echo off

REM Here set the name for external backup location
SET ext_dst_drivelabel=Some Drive
SET ext_dst_path=Backup

REM Here set name for the source
REM Either specify drive name or "" if local
SET ext_src_drivelabel=
SET ext_src_path=

call backup_internal.bat !ext_src_drivelabel! !ext_src_path! !ext_dst_drivelabel! !ext_dst_path!