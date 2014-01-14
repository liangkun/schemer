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
#   CMake rules to build libschemer and schemer executable.
#
# Author: liangkun@outlook.com
#==============================================================================

include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}
    ${LLVM_INCLUDE_DIRS}
)

link_directories(${LLVM_LIBRARY_DIRS})
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${LLVM_CXXFLAGS}")

BISON_TARGET(parser
    ${CMAKE_CURRENT_SOURCE_DIR}/schemer.y
    ${CMAKE_CURRENT_BINARY_DIR}/parser.cc
)
FLEX_TARGET(scanner
    ${CMAKE_CURRENT_SOURCE_DIR}/schemer.l
    ${CMAKE_CURRENT_BINARY_DIR}/scanner.cc
)
ADD_FLEX_BISON_DEPENDENCY(scanner parser)

# Configuration file.
configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/config.h.in
    ${CMAKE_CURRENT_BINARY_DIR}/config.h
)

include_directories(${CMAKE_CURRENT_BINARY_DIR})

add_library(schemer
    ${CMAKE_CURRENT_BINARY_DIR}/parser.cc
    ${CMAKE_CURRENT_BINARY_DIR}/scanner.cc
)

add_executable(schemer-bin schemer.cc)
set_target_properties(schemer-bin
    PROPERTIES OUTPUT_NAME schemer
)

target_link_libraries(schemer-bin schemer ${LLVM_LIBRARIES} ${LLVM_LDFLAGS})

add_test(schemer_runs schemer "-version")
set_tests_properties(schemer_runs PROPERTIES
    PASS_REGULAR_EXPRESSION
        "schemer.*${schemer_version_major}\\.${schemer_version_minor}.*"
)
