del *.bak /S
del .\release\*.* /Q
rmdir "db" /S /Q
rmdir "incremental_db" /S /Q 
rmdir "output_files" /S /Q
REM rmdir "hps_isw_handoff" /S /Q
del PLLJ_PLLSPE_INFO.txt
del c5_pin_model_dump.txt
del hps_sdram_p0_all_pins.txt
del hps_sdram_p0_summary.csv
del hps_0.h