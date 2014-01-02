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
#     LLVM_INCLUDE_DIRS - where to find llvm header files
#     LLVM_LIBRARY_DIRS - where to find llvm libraries
#     LLVM_LIBRARIES    - list of llvm libraries to be linked against
#     LLVM_CXXFLAGS     - llvm c++ compiler flags
#     LLVM_LDFLAGS      - llvm linker flags

find_program(LLVM_CONFIG llvm-config)
if (NOT LLVM_CONFIG)
    message(FATAL_ERROR "Could not find llvm-config")
endif (NOT LLVM_CONFIG)

include(StringUtils)

execute_process(
    COMMAND ${LLVM_CONFIG} --includedir
    OUTPUT_VARIABLE LLVM_INCLUDE_DIRS
)
trim(LLVM_INCLUDE_DIRS)

execute_process(
    COMMAND ${LLVM_CONFIG} --libdir
    OUTPUT_VARIABLE LLVM_LIBRARY_DIRS
)
trim(LLVM_LIBRARY_DIRS)

execute_process(
    COMMAND ${LLVM_CONFIG} --libs
    OUTPUT_VARIABLE LLVM_LIBRARIES
)
trim(LLVM_LIBRARIES)

execute_process(
    COMMAND ${LLVM_CONFIG} --cxxflags
    OUTPUT_VARIABLE LLVM_CXXFLAGS
)
trim(LLVM_CXXFLAGS)

execute_process(
    COMMAND ${LLVM_CONFIG} --system-libs
    OUTPUT_VARIABLE LLVM_LDFLAGS
)
trim(LLVM_LDFLAGS)
