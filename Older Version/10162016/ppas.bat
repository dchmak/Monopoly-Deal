@echo off
SET THEFILE=u:\ictsba\olderv~1\10162016\a1020.exe
echo Linking %THEFILE%
c:\dev-pas\bin\ldw.exe  -s   -b base.$$$ -o u:\ictsba\olderv~1\10162016\a1020.exe link.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occured while assembling %THEFILE%
goto end
:linkend
echo An error occured while linking %THEFILE%
:end
