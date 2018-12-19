ALTERA_OBJECTS 	= $(shell find $(BUILD_ROOT)/altera -name '*.o')
CC_SOURCES  	= $(shell find . -name '*.c')
CC_OBJECTS  	= $(patsubst %.c, $(BUILD_ROOT)/libs/%.o, $(CC_SOURCES))

-include $(CC_SOURCES:.c=.d)

.PHONY: default all clean

default: all

all: $(CC_OBJECTS)

$(BUILD_ROOT)/libs/%.o: %.c
	@if [ ! -d $(@D) ]; then \
		mkdir -p $(@D); \
	fi
	@echo Compiling $@ ...
	@$(CC) $(CC_FLAGS) $(CC_INCLUDES) -c $^ -o $@
	@$(CC) -MM $(CC_FLAGS) $(CC_INCLUDES) -c $^ > $(BUILD_ROOT)/libs/$*.d
	@mv -f $(BUILD_ROOT)/libs/$*.d $(BUILD_ROOT)/libs/$*.d.tmp
	@sed -e 's|.*:|$*.o:|' < $(BUILD_ROOT)/libs/$*.d.tmp > $(BUILD_ROOT)/libs/$*.d
	@sed -e 's/.*://' -e 's/\\$$//' < $(BUILD_ROOT)/libs/$*.d.tmp | fmt -1 | \
	  sed -e 's/^ *//' -e 's/$$/:/' >> $(BUILD_ROOT)/libs/$*.d
	@rm -f $(BUILD_ROOT)/libs/$*.d.tmp

clean:
	@rm $(LOG_FILE)
	@echo ./libs cleared!
