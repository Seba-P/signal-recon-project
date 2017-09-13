@echo off
cls
 
echo Please wait... 
 
del hps_0.h 2>NUL

rem
rem Take a look at the end of the script "sopc-create-header-files" for the commands
rem
%QUARTUS_ROOTDIR%\sopc_builder\bin\sopcinfo2swinfo --input=soc_system.sopcinfo
%QUARTUS_ROOTDIR%\sopc_builder\bin\swinfo2header --swinfo soc_system.swinfo --single hps_def.h --module hps_0

del soc_system.swinfo
