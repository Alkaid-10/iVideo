# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.18

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/user/Projects/iVideo

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/user/Projects/iVideo/build

# Utility rule file for iVideo_autogen.

# Include the progress variables for this target.
include CMakeFiles/iVideo_autogen.dir/progress.make

CMakeFiles/iVideo_autogen:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/user/Projects/iVideo/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Automatic MOC and UIC for target iVideo"
	/usr/bin/cmake -E cmake_autogen /home/user/Projects/iVideo/build/CMakeFiles/iVideo_autogen.dir/AutogenInfo.json Debug

iVideo_autogen: CMakeFiles/iVideo_autogen
iVideo_autogen: CMakeFiles/iVideo_autogen.dir/build.make

.PHONY : iVideo_autogen

# Rule to build all files generated by this target.
CMakeFiles/iVideo_autogen.dir/build: iVideo_autogen

.PHONY : CMakeFiles/iVideo_autogen.dir/build

CMakeFiles/iVideo_autogen.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/iVideo_autogen.dir/cmake_clean.cmake
.PHONY : CMakeFiles/iVideo_autogen.dir/clean

CMakeFiles/iVideo_autogen.dir/depend:
	cd /home/user/Projects/iVideo/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/user/Projects/iVideo /home/user/Projects/iVideo /home/user/Projects/iVideo/build /home/user/Projects/iVideo/build /home/user/Projects/iVideo/build/CMakeFiles/iVideo_autogen.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/iVideo_autogen.dir/depend

