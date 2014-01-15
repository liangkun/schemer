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
#   Top level cmake rules to build schemer system.
#
# Author: liangkun@outlook.com
#==============================================================================

cmake_minimum_required(VERSION 2.8)
project(schemer)

# The version number.
set(schemer_version_major 0)
set(schemer_version_minor 1)

enable_testing()

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/cmake_modules)
set(CMAKE_CXX_FLAGS "-std=c++11")

# Find dependencies
find_package(LLVM REQUIRED)
find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)
find_package(GTest REQUIRED)

set(GTEST_BOTH_LIBRARIES ${GTEST_BOTH_LIBRARIES} -lpthread)

add_subdirectory(src)
