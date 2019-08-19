ALTERA_OBJECTS 	= $(shell find $(BUILD_ROOT)/altera -name '*.o')
PORT_OBJECTS 	= $(shell find $(BUILD_ROOT)/port -name '*.o')
HAL_OBJECTS 	= $(shell find $(BUILD_ROOT)/hal -name '*.o')
UTILS_OBJECTS 	= $(shell find $(BUILD_ROOT)/utils -name '*.o')
CC_SOURCES  	= $(filter $(APP_ROOT)/%, $(shell find . -name '*.c'))
#CC_SOURCES  	= $(filter $(TARGET_ROOT)/%, $(shell find . -name '*.c'))
# CC_SOURCES  = $(filter $(wildcard $(TARGET_ROOT)/*.c), $(shell find . -name '*.c'))
CC_OBJECTS  	= $(patsubst %.c, $(BUILD_ROOT)/apps/%.o, $(CC_SOURCES))

ifeq ($(filter $(MAKECMDGOALS), 'default all clean'),)
	APP      := $(firstword $(MAKECMDGOALS))
	APP_ROOT := ./$(APP)
else
	APP      := ''
	APP_ROOT := .
endif

-include $(CC_SOURCES:.c=.d)

.PHONY: default all clean

default: all

all: $(APP)

$(APP): $(CC_OBJECTS) $(PORT_OBJECTS) $(HAL_OBJECTS) $(UTILS_OBJECTS) $(APP_ROOT)/$(APP)

$(APP_ROOT)/$(APP): $(CC_OBJECTS) $(PORT_OBJECTS) $(HAL_OBJECTS) $(UTILS_OBJECTS)
	@echo Linking ./$@ ...
	@$(CC) $(LD_FLAGS) $^ -o $@ 2>$(LOG_FILE)

$(BUILD_ROOT)/apps/%.o: %.c
	@if [ ! -d $(@D) ]; then \
		mkdir -p $(@D); \
	fi
	@echo Compiling $@ ...
	@$(CC) $(CC_FLAGS) $(CC_INCLUDES) -c $^ -o $@
	@$(CC) -MM $(CC_FLAGS) $(CC_INCLUDES) -c $^ > $(BUILD_ROOT)/apps/$*.d
	@mv -f $(BUILD_ROOT)/apps/$*.d $(BUILD_ROOT)/apps/$*.d.tmp
	@sed -e 's|.*:|$*.o:|' < $(BUILD_ROOT)/apps/$*.d.tmp > $(BUILD_ROOT)/apps/$*.d
	@sed -e 's/.*://' -e 's/\\$$//' < $(BUILD_ROOT)/apps/$*.d.tmp | fmt -1 | \
	  sed -e 's/^ *//' -e 's/$$/:/' >> $(BUILD_ROOT)/apps/$*.d
	@rm -f $(BUILD_ROOT)/apps/$*.d.tmp

clean:
	@for entry in $(wildcard *); do \
		if [ -d $(entry) ]; then \
			echo $(entry); \
			rm -f ./$(entry)/$(entry); \
		fi ; \
	done
	@rm $(LOG_FILE)
	@echo ./apps cleared!
