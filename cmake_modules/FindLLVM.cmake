#==============================================================================
# Copyright (c) 2014 Liang Kun.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# FindLLVM.cmake
#   Find the native LLVM includes and libraries
#
# Author: liangkun@outlook.com
#==============================================================================

# Output variables:
#     LLVM_FOUND        - True if llvm is found
#     LLVM_VERSION      - llvm version
#     LLVM_INCLUDE_DIRS - where to find llvm header files
#     LLVM_LIBRARY_DIRS - where to find llvm libraries
#     LLVM_LIBRARIES    - list of llvm libraries to be linked against
#     LLVM_CXXFLAGS     - llvm c++ compiler flags
#     LLVM_LDFLAGS      - llvm linker flags

if (${LLVM_FOUND})
    return()
endif (${LLVM_FOUND})

find_program(LLVM_CONFIG llvm-config)
if (NOT LLVM_CONFIG)
    message(FATAL_ERROR "Could not find llvm-config")
endif (NOT LLVM_CONFIG)
set(LLVM_FOUND "True" CACHE STRING "Found llvm")

include(StringUtils)

execute_process(
    COMMAND ${LLVM_CONFIG} --version
    OUTPUT_VARIABLE LLVM_VERSION
)
trim(LLVM_VERSION)
set(LLVM_VERSION ${LLVM_VERSION} CACHE STRING "llvm version")

execute_process(
    COMMAND ${LLVM_CONFIG} --includedir
    OUTPUT_VARIABLE LLVM_INCLUDE_DIRS
)
trim(LLVM_INCLUDE_DIRS)
set(LLVM_INCLUDE_DIRS ${LLVM_INCLUDE_DIRS} CACHE STRING "llvm include dirs")

execute_process(
    COMMAND ${LLVM_CONFIG} --libdir
    OUTPUT_VARIABLE LLVM_LIBRARY_DIRS
)
trim(LLVM_LIBRARY_DIRS)
set(LLVM_LIBRARY_DIRS ${LLVM_LIBRARY_DIRS} CACHE STRING "llvm library dirs")

execute_process(
    COMMAND ${LLVM_CONFIG} --libs
    OUTPUT_VARIABLE LLVM_LIBRARIES
)
trim(LLVM_LIBRARIES)
set(LLVM_LIBRARIES ${LLVM_LIBRARIES} CACHE STRING "llvm libraries")

execute_process(
    COMMAND ${LLVM_CONFIG} --cxxflags
    OUTPUT_VARIABLE LLVM_CXXFLAGS
)
trim(LLVM_CXXFLAGS)
set(LLVM_CXXFLAGS ${LLVM_CXXFLAGS} CACHE STRING "llvm cxxflags")

execute_process(
    COMMAND ${LLVM_CONFIG} --system-libs
    OUTPUT_VARIABLE LLVM_LDFLAGS
)
trim(LLVM_LDFLAGS)
set(LLVM_LDFLAGS ${LLVM_LDFLAGS} CACHE STRING "llvm ldflags")

message("-- Found LLVM: ${LLVM_CONFIG} (found version: ${LLVM_VERSION})")
