ALTERA_OBJECTS 	= $(shell find $(BUILD_ROOT)/altera -name '*.o')
# PORT_OBJECTS 	= $(shell find $(BUILD_ROOT)/port -name '*.o')
# HAL_OBJECTS 	= $(shell find $(BUILD_ROOT)/hal -name '*.o')
CC_SOURCES  	= $(shell find . -name '*.c')
CC_OBJECTS  	= $(patsubst %.c, $(BUILD_ROOT)/utils/%.o, $(CC_SOURCES))

-include $(CC_SOURCES:.c=.d)

.PHONY: default all clean

default: all

all: $(CC_OBJECTS)

$(BUILD_ROOT)/utils/%.o: %.c
	@if [ ! -d $(@D) ]; then \
		mkdir -p $(@D); \
	fi
	@echo Compiling $@ ...
	@$(CC) $(CC_FLAGS) $(CC_INCLUDES) -c $^ -o $@
	@$(CC) -MM $(CC_FLAGS) $(CC_INCLUDES) -c $^ > $(BUILD_ROOT)/utils/$*.d
	@mv -f $(BUILD_ROOT)/utils/$*.d $(BUILD_ROOT)/utils/$*.d.tmp
	@sed -e 's|.*:|$*.o:|' < $(BUILD_ROOT)/utils/$*.d.tmp > $(BUILD_ROOT)/utils/$*.d
	@sed -e 's/.*://' -e 's/\\$$//' < $(BUILD_ROOT)/utils/$*.d.tmp | fmt -1 | \
	  sed -e 's/^ *//' -e 's/$$/:/' >> $(BUILD_ROOT)/utils/$*.d
	@rm -f $(BUILD_ROOT)/utils/$*.d.tmp

clean:
	@rm $(LOG_FILE)
	@echo ./utils cleared!
