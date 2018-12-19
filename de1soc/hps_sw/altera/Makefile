CC_SOURCES  = $(shell find . -name '*.c')
CC_OBJECTS  = $(patsubst %.c, $(BUILD_ROOT)/altera/%.o, $(CC_SOURCES))

-include $(CC_OBJECTS:.o=.d)

.PHONY: default all clean

default: all

all: $(CC_OBJECTS)

$(BUILD_ROOT)/altera/%.o: %.c
	@if [ ! -d $(@D) ]; then \
		mkdir -p $(@D); \
	fi
	@echo Compiling $@ ...
	@$(CC) $(CC_FLAGS) $(CC_INCLUDES) -c $^ -o $@
	@$(CC) -MM $(CC_FLAGS) $(CC_INCLUDES) -c $^ > $(BUILD_ROOT)/altera/$*.d
	@mv -f $(BUILD_ROOT)/altera/$*.d $(BUILD_ROOT)/altera/$*.d.tmp
	@sed -e 's|.*:|$*.o:|' < $(BUILD_ROOT)/altera/$*.d.tmp > $(BUILD_ROOT)/altera/$*.d
	@sed -e 's/.*://' -e 's/\\$$//' < $(BUILD_ROOT)/altera/$*.d.tmp | fmt -1 | \
	  sed -e 's/^ *//' -e 's/$$/:/' >> $(BUILD_ROOT)/altera/$*.d
	@rm -f $(BUILD_ROOT)/altera/$*.d.tmp

clean:
	@rm $(LOG_FILE)
	@echo ./altera cleared!
