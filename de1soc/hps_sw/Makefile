# Architecture & compiler settings
export ARCH             := arm
export DEVICE_FAMILY    := soc_cv_av
export CROSS_COMPILE    := $(ARMGCC_ROOT)/arm-linux-gnueabihf-
export CC               := $(CROSS_COMPILE)gcc

# Build paths
export PROJECT_ROOT     = $(PWD)/..
export SOCEDS_ROOT      = $(SOCEDS_DEST_ROOT)/embedded
export HANDOFF_ROOT     = $(PROJECT_ROOT)/hw/hps_isw_handoff/soc_system_hps_0
export SPL_BSP_ROOT     = $(PROJECT_ROOT)/hw/software/spl_bsp/generated
export DRIVERS_ROOT     = $(PROJECT_ROOT)/hps_sw/altera/drivers
export HWLIBS_ROOT      = $(PROJECT_ROOT)/hps_sw/altera/hwlib
export NIOS2_HAL_ROOT   = $(PROJECT_ROOT)/hps_sw/altera/nios2_hal
export BUILD_ROOT       = $(PROJECT_ROOT)/hps_sw/_build
export PORT_ROOT        = $(PROJECT_ROOT)/hps_sw/port
export HAL_ROOT         = $(PROJECT_ROOT)/hps_sw/hal
export UTILS_ROOT       = $(PROJECT_ROOT)/hps_sw/utils
export APPS_ROOT        = $(PROJECT_ROOT)/hps_sw/apps

# Compiler & linker flags
export HEADERS      := $(SOCEDS_ROOT)/examples/hardware/cv_soc_devkit_ghrd/hardware/preloader/uboot-socfpga/arch/arm/include/asm \
                        $(HANDOFF_ROOT) \
                        $(SPL_BSP_ROOT) \
                        $(DRIVERS_ROOT)/inc \
                        $(HWLIBS_ROOT)/include \
                        $(HWLIBS_ROOT)/include/$(DEVICE_FAMILY) \
                        $(NIOS2_HAL_ROOT)/inc \
                        $(NIOS2_HAL_ROOT)/inc/os \
                        $(NIOS2_HAL_ROOT)/inc/priv \
                        $(NIOS2_HAL_ROOT)/inc/sys \
                        $(PORT_ROOT) \
                        $(HAL_ROOT) \
                        $(UTILS_ROOT) \

export CC_INCLUDES  = $(foreach header, $(HEADERS), -I$(header))

export CC_FLAGS = -g -Wall -std=gnu99 -D$(DEVICE_FAMILY) -march=armv7-a -mcpu=cortex-a9 
export LD_FLAGS = 

SUBDIRS = $(patsubst %/, %, $(filter-out '_build', $(wildcard */)))
export LOG_FILE = make_log.txt

ifeq ($(filter $(MAKECMDGOALS), 'default all altera port hal utils apps clean'),)
	TARGET := $(firstword $(MAKECMDGOALS))
endif

.PHONY: default all altera hal apps clean

default: all

all: altera port hal utils apps

altera port hal utils apps:
	$(MAKE) -C $@ -f Makefile all

$(TARGET):
	$(MAKE) -C apps -f Makefile $@

clean:
	@for entry in $(SUBDIRS); do \
		if [ ! -d $(entry) ]; then \
			$(MAKE) -C $(entry) -f Makefile clean; \
		fi ;\
	done
	rm -rf $(BUILD_ROOT)
