# ****************************************************************************
#  Project:  LibCMaker_zlib
#  Purpose:  A CMake build script for zlib library
#  Author:   NikitaFeodonit, nfeodonit@yandex.com
# ****************************************************************************
#    Copyright (c) 2017-2019 NikitaFeodonit
#
#    This file is part of the LibCMaker_zlib project.
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published
#    by the Free Software Foundation, either version 3 of the License,
#    or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#    See the GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <http://www.gnu.org/licenses/>.
# ****************************************************************************

#-----------------------------------------------------------------------
# The file is an example of the convenient script for the library build.
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Lib's name, version, paths
#-----------------------------------------------------------------------

set(ZLIB_lib_NAME "zlib")
set(ZLIB_lib_VERSION "1.2.8" CACHE STRING "ZLIB_lib_VERSION")
set(ZLIB_lib_DIR "${CMAKE_CURRENT_LIST_DIR}" CACHE PATH "ZLIB_lib_DIR")

# To use our Find<LibName>.cmake.
list(APPEND CMAKE_MODULE_PATH "${ZLIB_lib_DIR}/cmake/modules")


#-----------------------------------------------------------------------
# LibCMaker_<LibName> specific vars and options
#-----------------------------------------------------------------------

option(COPY_ZLIB_CMAKE_BUILD_SCRIPTS "COPY_ZLIB_CMAKE_BUILD_SCRIPTS" ON)


#-----------------------------------------------------------------------
# Library specific vars and options
#-----------------------------------------------------------------------

if(BUILD_SHARED_LIBS)
  option(ZLIB_SHARED "Build shared lib" ON)
  option(ZLIB_STATIC "Build static lib" OFF)
else()
  option(ZLIB_SHARED "Build shared lib" OFF)
  option(ZLIB_STATIC "Build static lib" ON)
endif()
option(ZLIB_EXAMPLES "Build zlib examples" OFF)
option(ZLIB_TESTS "Build zlib tests" OFF)

option(ASM686 "Enable building i686 assembly implementation" ON)
option(AMD64 "Enable building amd64 assembly implementation" ON)

set(INSTALL_BIN_DIR "${CMAKE_INSTALL_PREFIX}/bin" CACHE PATH
  "Installation directory for executables"
)
set(INSTALL_LIB_DIR "${CMAKE_INSTALL_PREFIX}/lib" CACHE PATH
  "Installation directory for libraries"
)
set(INSTALL_INC_DIR "${CMAKE_INSTALL_PREFIX}/include" CACHE PATH
  "Installation directory for headers"
)
set(INSTALL_MAN_DIR "${CMAKE_INSTALL_PREFIX}/share/man" CACHE PATH
  "Installation directory for manual pages"
)
set(INSTALL_PKGCONFIG_DIR "${CMAKE_INSTALL_PREFIX}/share/pkgconfig" CACHE PATH
  "Installation directory for pkgconfig (.pc) files"
)

option(SKIP_INSTALL_ALL "SKIP_INSTALL_ALL" OFF)
option(SKIP_INSTALL_LIBRARIES "SKIP_INSTALL_LIBRARIES" OFF)
option(SKIP_INSTALL_HEADERS "SKIP_INSTALL_HEADERS" OFF)
option(SKIP_INSTALL_FILES "SKIP_INSTALL_FILES" OFF)


#-----------------------------------------------------------------------
# Build, install and find the library
#-----------------------------------------------------------------------

cmr_find_package(
  LibCMaker_DIR   ${LibCMaker_DIR}
  NAME            ${ZLIB_lib_NAME}
  VERSION         ${ZLIB_lib_VERSION}
  LIB_DIR         ${ZLIB_lib_DIR}
  REQUIRED
  FIND_MODULE_NAME ZLIB
)
