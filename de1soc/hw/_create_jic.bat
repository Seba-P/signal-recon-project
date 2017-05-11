@echo off
cls
 
del .\release\*.jic 2>NUL
del .\release\*.map 2>NUL
del .\release\*.sof 2>NUL
del .\release\*.cdf 2>NUL
copy .\cfg\de1soc_prog.cdf .\release\de1soc_prog.cdf
cls

echo Please wait...
copy .\output_files\*.sof .\release >NUL
%QUARTUS_ROOTDIR%\bin64\quartus_cpf -c .\cfg\de1soc_conv.cof

pause

