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
# Utils.cmake
#   Common utils used in cmake.
#
# Author: liangkun@outlook.com
#==============================================================================

# trim leading and tailing whitespaces in var.
macro(trim var)
    if (${${var}} MATCHES "^[ \t\r\n]+")
        string(REGEX REPLACE "^[ \t\r\n]+" "" ${var} ${${var}})
    endif (${${var}} MATCHES "^[ \t\r\n]+")

    if (${${var}} MATCHES "[ \t\r\n]+$")
        string(REGEX REPLACE "[ \t\r\n]+$" "" ${var} ${${var}})
    endif (${${var}} MATCHES "[ \t\r\n]+$")
endmacro(trim var)

# add a new gtest(using gtest)
macro(add_gtest gtest_source)
    string(REGEX REPLACE "(\\.cc)|(\\.cpp)" "" gtest_name ${gtest_source})
    add_executable(${gtest_name} ${gtest_source})
    target_link_libraries(${gtest_name}
        schemer
        ${LLVM_LIBRARIES}
        ${GTEST_BOTH_LIBRARIES}
    )
    add_test(${gtest_name} ${gtest_name})
endmacro(add_gtest source_file)
