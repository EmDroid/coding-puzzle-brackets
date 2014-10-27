##
# @file
#
# Linux makefile for the Brackets coding puzzle
#
# @author Emil Maskovsky
#


###############
#    Setup    #
###############

# the single threaded executable target
TARGET = brackets

# the multi threaded executable target
TARGET_MT = $(TARGET)_mt

# the unit test target
TEST_TARGET = $(TARGET)_test

# the object files
OBJS = \
	StandardValidator.o \
	StreamInputReader.o \
	StreamOutputWriter.o \
	StandardProcessor.o \
	VectorInputReader.o \
	VectorOutputWriter.o \
	MultithreadProcessor.o

# the single threaded executable object files
OBJS_TARGET = \
	$(TARGET).o

# the multi threaded executable object files
OBJS_TARGET_MT = \
	$(TARGET_MT).o

# the unit test executable object files
OBJS_TEST = $(OBJS) \
	$(TEST_TARGET).o

# optimization and debugging settings
OPTFLAGS = -g -O0 -fno-inline
#OPTFLAGS = -O2 -DNDEBUG

# the compiler flags
CPPFLAGS = $(OPTFLAGS) -std=c++0x -Wall -Wextra -Werror -I inc

# the linker flags
LDFLAGS = $(OPTFLAGS)

# the source file paths
VPATH = src:client:test


#####################
#    Build rules    #
#####################

.PHONY: all test clean cleanall

all: $(TARGET) $(TARGET_MT)

test: all $(TEST_TARGET)
	./$(TEST_TARGET)

clean:
	-rm -f $(OBJS) $(OBJS_TARGET) $(OBJS_TEST) $(OBJS:.o=.d) $(OBJS_TARGET:.o=.d) $(OBJS_TARGET_MT:.o=.d) $(OBJS_TEST:.o=.d) $(TEST_TARGET)

cleanall: clean
	-rm -f $(TARGET) $(TARGET_MT)

$(TARGET): $(OBJS) $(OBJS_TARGET)
	$(CXX) $(LDFLAGS) -o $@ $^

$(TARGET_MT): $(OBJS) $(OBJS_TARGET_MT)
	$(CXX) $(LDFLAGS) -o $@ $^

$(TEST_TARGET): $(OBJS) $(OBJS_TEST)
	$(CXX) $(LDFLAGS) -o $@ $^

.cpp.o:
	$(CXX) -c $(CPPFLAGS) -o $@ $<


######################
#    Dependencies    #
######################

# autogenerate dependencies

.SUFFIXES: .d

.cpp.d:
	$(CXX) -MM -MP $(CPPFLAGS) -MT $@ -MT $(@:.d=.o) -o $@ $<

-include $(OBJS:.o=.d) $(OBJS_TARGET:.o=.d) $(OBJS_TARGET_MT:.o=.d) $(OBJS_TEST:.o=.d)


# rebuild everything if the makefile changes (e.g. flags change)

$(OBJS) $(OBJS_TARGET) $(OBJS_TEST) $(OBJS:.o=.d) $(OBJS_TARGET:.o=.d) $(OBJS_TARGET_MT:.o=.d) $(OBJS_TEST:.o=.d): \
	makefile


# EOF
