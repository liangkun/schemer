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
# CMakeLists.txt
#   CMake rules to build schemer system.
#
# Author: liangkun@outlook.com
#==============================================================================

cmake_minimum_required(VERSION 2.8)
project(schemer)

# The version number.
set(schemer_version_major 0)
set(schemer_version_minor 1)

enable_testing()

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH}
    "${PROJECT_SOURCE_DIR}/cmake_modules")

# Find dependencies
find_package(LLVM REQUIRED)
include_directories(${LLVM_INCLUDE_DIRS})
link_directories(${LLVM_LIBRARY_DIRS})
set(CMAKE_CXX_FLAGS ${LLVM_CXXFLAGS})

# Configuration file.
configure_file(
    "${PROJECT_SOURCE_DIR}/config.h.in"
    "${PROJECT_BINARY_DIR}/config.h"
)

include_directories("${PROJECT_BINARY_DIR}")

add_executable(schemer "schemer.cc")
target_link_libraries(schemer ${LLVM_LIBRARIES} ${LLVM_LDFLAGS})

add_test(schemer_runs schemer "-version")
set_tests_properties(schemer_runs PROPERTIES
    PASS_REGULAR_EXPRESSION
        "schemer.*${schemer_version_major}\\.${schemer_version_minor}.*"
)
