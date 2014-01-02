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
# StringUtils.cmake
#   Common utils to process string in cmake.
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
