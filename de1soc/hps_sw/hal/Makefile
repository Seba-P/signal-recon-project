ALTERA_OBJECTS 	= $(shell find $(BUILD_ROOT)/altera -name '*.o')
PORT_OBJECTS 	= $(shell find $(BUILD_ROOT)/port -name '*.o')
CC_SOURCES  	= $(shell find . -name '*.c')
CC_OBJECTS  	= $(patsubst %.c, $(BUILD_ROOT)/hal/%.o, $(CC_SOURCES))

-include $(CC_SOURCES:.c=.d)

.PHONY: default all clean

default: all

all: $(CC_OBJECTS)

$(BUILD_ROOT)/hal/%.o: %.c
	@if [ ! -d $(@D) ]; then \
		mkdir -p $(@D); \
	fi
	@echo Compiling $@ ...
	@$(CC) $(CC_FLAGS) $(CC_INCLUDES) -c $^ -o $@
	@$(CC) -MM $(CC_FLAGS) $(CC_INCLUDES) -c $^ > $(BUILD_ROOT)/hal/$*.d
	@mv -f $(BUILD_ROOT)/hal/$*.d $(BUILD_ROOT)/hal/$*.d.tmp
	@sed -e 's|.*:|$*.o:|' < $(BUILD_ROOT)/hal/$*.d.tmp > $(BUILD_ROOT)/hal/$*.d
	@sed -e 's/.*://' -e 's/\\$$//' < $(BUILD_ROOT)/hal/$*.d.tmp | fmt -1 | \
	  sed -e 's/^ *//' -e 's/$$/:/' >> $(BUILD_ROOT)/hal/$*.d
	@rm -f $(BUILD_ROOT)/hal/$*.d.tmp

clean:
	@rm $(LOG_FILE)
	@echo ./hal cleared!
