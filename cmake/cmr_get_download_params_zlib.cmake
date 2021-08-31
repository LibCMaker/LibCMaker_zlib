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

# Part of "LibCMaker/cmake/cmr_get_download_params.cmake".

  include(cmr_get_version_parts)
  cmr_get_version_parts(${version} major minor patch tweak)

  # zlib versions 1.2.9-1.2.11 have bugs if compiled or/and linked with C++.
  if(version VERSION_EQUAL "1.2.8")
    set(arch_file_sha
      "36658cb768a54c1d4dec43c3116c27ed893e88b02ecfcb44f2166f9c0b7f2a0d")
  endif()
  if(version VERSION_EQUAL "1.2.11")
    set(arch_file_sha
      "c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1")
  endif()

  # https://zlib.net/zlib-1.2.11.tar.gz
  # http://prdownloads.sourceforge.net/libpng/zlib-1.2.11.tar.gz?download
  set(base_url "http://prdownloads.sourceforge.net/libpng")
  set(src_dir_name    "zlib-${version}")
  set(arch_file_name  "${src_dir_name}.tar.gz")
  set(unpack_to_dir   "${unpacked_dir}/${src_dir_name}")

  set(${out_ARCH_SRC_URL}   "${base_url}/${arch_file_name}?download" PARENT_SCOPE)
  set(${out_ARCH_DST_FILE}  "${download_dir}/${arch_file_name}" PARENT_SCOPE)
  set(${out_ARCH_FILE_SHA}  "${arch_file_sha}" PARENT_SCOPE)
  set(${out_SHA_ALG}        "SHA256" PARENT_SCOPE)
  set(${out_UNPACK_TO_DIR}  "${unpack_to_dir}" PARENT_SCOPE)
  set(${out_UNPACKED_SOURCES_DIR}
    "${unpack_to_dir}/${src_dir_name}" PARENT_SCOPE
  )
  set(${out_VERSION_BUILD_DIR} "${build_dir}/${src_dir_name}" PARENT_SCOPE)
