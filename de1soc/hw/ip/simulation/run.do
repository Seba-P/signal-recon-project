# set USER_DEFINED_ELAB_OPTIONS <elaboration options>
# source msim_setup.do
quit -sim

elab
do wave.do
run -a

WaveRestoreZoom {0 ns} [eval simtime]
