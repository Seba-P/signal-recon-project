
MODELSIM_INSTALL_DIR  ?= C:/intelfpga/17.1/modelsim_ase
QUARTUS_INSTALL_DIR   ?= C:/intelfpga/17.1/quartus
QSYS_SIMDIR           ?= ../../../soc_system/simulation
RTL_DIR               ?= ../../source
TB_DIR                ?= .
UVM_HOME              = ../uvm_1.1d
DPI_SRC               = $(UVM_HOME)/src/dpi/uvm_dpi.cc

G++                   = $(MODELSIM_INSTALL_DIR)/gcc-4.2.1-mingw32vc12/bin/g++.exe
GCC                   = $(MODELSIM_INSTALL_DIR)/gcc-4.2.1-mingw32vc12/bin/gcc.exe

ifeq ($(UVM_TESTNAME),)
	UVM_TESTNAME_OPT = +UVM_TESTNAME=base_test
else
	UVM_TESTNAME_OPT = +UVM_TESTNAME=$(UVM_TESTNAME)
endif

ifeq ($(UVM_VERBOSITY),)
	UVM_VERBOSITY_OPT = +UVM_VERBOSITY=UVM_LOW
else
	UVM_VERBOSITY_OPT = +UVM_VERBOSITY=$(UVM_VERBOSITY)
endif

ifeq ($(GUI),)
	GUI_OPT = -c
else
	GUI_OPT = -gui
endif

DO_CMD = "do ./wave.do; run -a;"

all default: libs rtl uvm tb sim

uvm:
	vlog +incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm.sv -work uvm_pkg \
        -mfcu -suppress 2181 +acc=rmb
	$(G++) -g -DQUESTA -W -shared -Bsymbolic -I$(MODELSIM_INSTALL_DIR)/include $(DPI_SRC) -o _work/uvm_dpi.dll \
        $(MODELSIM_INSTALL_DIR)/win32aloem/mtipli.dll -lregex

rtl:
	vlog -sv +incdir+$(RTL_DIR) -f filelist_rtl.f -work dut_rtl

tb: uvm
	vlog -sv +incdir+$(RTL_DIR)+$(UVM_HOME)/src -f filelist_tb.f -work dut_tb -mfcu -suppress 2181 +acc=rmb

sim:
	vsim -t ns dut_top -do $(DO_CMD) \
		$(GUI_OPT) $(UVM_TESTNAME_OPT) $(UVM_VERBOSITY_OPT) \
		-sv_lib _work/uvm_dpi -work dut_tb $(LIB_LINKS) \
		-suppress 8887 -suppress 12003 -suppress 3009 -suppress 19 -suppress 8315

clean:
	rm -rf _work/* transcript *~ *.wlf *.vstf *.log *.tgz *.db *.bin

include ./MakefileLibs.mk

.PHONY: clean sim
