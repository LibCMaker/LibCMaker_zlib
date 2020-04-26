
#CMAKE_HOME="/home/work/apps/android/android-sdk-linux/cmake/3.6.4111459"
#CMAKE_HOME="/home/work/apps/android/android-sdk-linux/cmake/3.10.2.4988404"


# === Global ===

cmr_LIB_NAME=zlib
cmr_BUILD_TESTING=ON

cmr_SAMPLE_DIR=$(pwd)  # Current dir.
cmr_SAMPLE_LIB_DIR=${cmr_SAMPLE_DIR}/libs

cmr_BUILD_DIR=${cmr_SAMPLE_DIR}/build
cmr_INSTALL_DIR=${cmr_BUILD_DIR}/install
cmr_DOWNLOAD_DIR=${cmr_BUILD_DIR}/download

cmr_JOBS_CNT=4  # NOTE: =4 for Travis CI.


# === Linux ===

cmr_TARGET_OS=linux
cmr_JOBS="-j${cmr_JOBS_CNT}"

cmr_CMAKE_RELEASE=cmake-3.4.0-Linux-x86_64
cmr_CMAKE_DIR="/home/work/apps/cmake/${cmr_CMAKE_RELEASE}"
cmr_CMAKE_CMD=${cmr_CMAKE_DIR}/bin/cmake
cmr_CTEST_CMD=${cmr_CMAKE_DIR}/bin/ctest


cmr_CMAKE_BUILD_TYPE=Release
cmr_BUILD_SHARED_LIBS=ON


# before_install:

mkdir ${cmr_BUILD_DIR}
mkdir ${cmr_INSTALL_DIR}
mkdir ${cmr_DOWNLOAD_DIR}
mkdir ${cmr_SAMPLE_LIB_DIR}
ln -s ../../../../LibCMaker_${cmr_LIB_NAME} ${cmr_SAMPLE_LIB_DIR}

#wget -nv -c -N -P ${cmr_DOWNLOAD_DIR} https://cmake.org/files/v3.4/${cmr_CMAKE_RELEASE}.tar.gz
#tar -xf ${cmr_DOWNLOAD_DIR}/${cmr_CMAKE_RELEASE}.tar.gz --directory ${cmr_INSTALL_DIR}

# NOTE: LibCMaker lib deps.
git clone https://github.com/LibCMaker/LibCMaker.git ${cmr_SAMPLE_LIB_DIR}/LibCMaker
#git clone https://github.com/LibCMaker/LibCMaker_GoogleTest.git ${cmr_SAMPLE_LIB_DIR}/LibCMaker_GoogleTest


# before_script:
cd ${cmr_BUILD_DIR}

# script:
${cmr_CMAKE_CMD} ${cmr_SAMPLE_DIR} \
        -Dcmr_BUILD_MULTIPROC_CNT=${cmr_JOBS_CNT} \
        -Dcmr_PRINT_DEBUG=ON \
        -DCMAKE_VERBOSE_MAKEFILE=ON \
        -DCMAKE_COLOR_MAKEFILE=ON \
        -DBUILD_TESTING=${cmr_BUILD_TESTING} \
        -DCMAKE_INSTALL_PREFIX=${cmr_INSTALL_DIR} \
        -Dcmr_DOWNLOAD_DIR=${cmr_DOWNLOAD_DIR} \
        -Dcmr_UNPACKED_DIR=${cmr_DOWNLOAD_DIR}/unpacked \
          -DCMAKE_BUILD_TYPE=${cmr_CMAKE_BUILD_TYPE} \
          -DBUILD_SHARED_LIBS=${cmr_BUILD_SHARED_LIBS} \

${cmr_CMAKE_CMD} --build . -- ${cmr_JOBS}

${cmr_CTEST_CMD} --output-on-failure




#&& LD_LIBRARY_PATH="./inst/lib:$LD_LIBRARY_PATH" ${CTEST_CMD} --output-on-failure


# TODO: for LD_LIBRARY_PATH use (???) ${HOME_BUILD} from travis.

#&& ${CMAKE_CMD} -E env CTEST_OUTPUT_ON_FAILURE=1 \
#   ${CMAKE_CMD} --build ${lib_BUILD_DIR} --target test
