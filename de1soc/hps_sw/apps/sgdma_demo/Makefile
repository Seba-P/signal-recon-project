# Architecture & compiler settings
ARCH 			= arm
DEVICE_FAMILY 	= soc_cv_av
CROSS_COMPILE 	= $(ARMGCC_ROOT)/arm-linux-gnueabihf-
CC 				= $(CROSS_COMPILE)gcc
TARGET 			= sgdma_demo

# Build paths
PROJECT_ROOT 	= ../../..
SOCEDS_ROOT 	= $(SOCEDS_DEST_ROOT)/embedded
HWLIBS_ROOT 	= $(PROJECT_ROOT)/hps_sw/altera/hwlib
DRIVERS_ROOT 	= $(PROJECT_ROOT)/hps_sw/altera/nios2_hal
HANDOFF_ROOT 	= $(PROJECT_ROOT)/hw/hps_isw_handoff/soc_system_hps_0
SPL_BSP_ROOT 	= $(PROJECT_ROOT)/hw/software/spl_bsp/generated
TARGET_ROOT 	= .
#BUILD_ROOT 		= $(PROJECT_ROOT)/hps_sw/build

# Source & object files
HWLIBS_USED_SRC := 
TARGET_USED_SRC := main.c sgdma_drv.c sgdma_utils.c fifo.c test_vector.c
DRIVERS_USED_SRC := 
SPL_BSP_USED_SRC :=
HANDOFF_USED_SRC :=

HWLIBS_SRC := $(patsubst %.c, %.o, $(foreach file, $(HWLIBS_USED_SRC), $(HWLIBS_ROOT)/src/$(file)))
TARGET_SRC := $(patsubst %.c, %.o, $(foreach file, $(TARGET_USED_SRC), $(TARGET_ROOT)/$(file)))
DRIVERS_SRC := $(patsubst %.c, %.o, $(foreach file, $(DRIVERS_USED_SRC), $(DRIVERS_ROOT)/src/$(file)))
SPL_BSP_SRC := $(patsubst %.c, %.o, $(foreach file, $(SPL_BSP_USED_SRC), $(SPL_BSP_ROOT)/$(file)))
HANDOFF_SRC := $(patsubst %.c, %.o, $(foreach file, $(HANDOFF_USED_SRC), $(HANDOFF_ROOT)/$(file)))

# Compiler & linker flags
HEADERS := ${SOCEDS_ROOT}/examples/hardware/cv_soc_devkit_ghrd/hardware/preloader/uboot-socfpga/arch/arm/include/asm \
				${HWLIBS_ROOT}/include \
				$(HWLIBS_ROOT)/include/$(DEVICE_FAMILY) \
				$(DRIVERS_ROOT)/inc \
				$(SPL_BSP_ROOT) \
				$(HANDOFF_ROOT) \
				$(TARGET_ROOT)
#CC_INCLUDES += -I$(SPL_BSP_ROOT) -I$(HANDOFF_ROOT)
CC_INCLUDES = $(foreach header, $(HEADERS), -I$(header))
CC_SOURCES = $(TARGET_SRC) $(HWLIBS_SRC) $(DRIVERS_SRC) $(SPL_BSP) $(HANDOFF_SRC)

CC_FLAGS = -g -Wall -std=gnu99 -D$(DEVICE_FAMILY) -march=armv7-a -mcpu=cortex-a9 
#-mtune=cortex-a9 -marm -mabi=aapcs-linux -mno-thumb-interwork
#CC_FLAGS += -march=armv7-a -mfloat-abi=hard -mfpu=vfp3 -mthumb-interwork -mthumb
LD_FLAGS = 

LOG_FILE = make_log.txt

default: Makefile $(TARGET)
$(TARGET): $(CC_SOURCES) 
	@$(CC) $(LD_FLAGS) $^ -o $@ 2>$(LOG_FILE) 
%.o : %.c
	@$(CC) $(CC_FLAGS) $(CC_INCLUDES) -c $< -o $@ 
%.h : 

.PHONY: clean
clean:
	@rm -f $(TARGET) $(wildcard $(TARGET_ROOT)/*.o $(TARGET_ROOT)/*.a $(TARGET_ROOT)/*.d $(TARGET_ROOT)/*.~)
	@rm -f $(wildcard $(HWLIBS_ROOT)/src/hwmgr/*.o $(HWLIBS_ROOT)/src/hwmgr/*.a $(HWLIBS_ROOT)/src/hwmgr/*.d $(HWLIBS_ROOT)/src/hwmgr/*.~) \
		$(wildcard $(HWLIBS_ROOT)/src/hwmgr/$(DEVICE_FAMILY)/*.o $(HWLIBS_ROOT)/src/hwmgr/$(DEVICE_FAMILY)/*.a \
		$(HWLIBS_ROOT)/src/hwmgr/$(DEVICE_FAMILY)/*.d $(HWLIBS_ROOT)/src/hwmgr/$(DEVICE_FAMILY)/*.~) \
		$(wildcard $(HWLIBS_ROOT)/src/utils/*.o $(HWLIBS_ROOT)/src/utils/*.a $(HWLIBS_ROOT)/src/utils/*.d $(HWLIBS_ROOT)/src/utils/*.~) 
	@rm -f $(wildcard $(DRIVERS_ROOT)/src/*.o $(DRIVERS_ROOT)/src/*.a $(DRIVERS_ROOT)/src/*.d $(DRIVERS_ROOT)/src/*.~)
	@rm -f $(LOG_FILE)
