set QSYS_SIMDIR "./../../soc_system/simulation"
source $QSYS_SIMDIR/mentor/msim_setup.tcl

set TOP_LEVEL_NAME fir_subsystem_top_tb
# set USER_DEFINED_ELAB_OPTIONS <elaboration options>
elab
do wave.do
run -a
