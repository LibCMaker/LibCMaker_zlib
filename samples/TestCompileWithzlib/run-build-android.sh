export ANDROID_HOME=/home/work/apps/android/android-sdk-linux
export PATH=${ANDROID_HOME}/cmdline-tools/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}

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

cmr_JOBS_CNT=6  # NOTE: =4 for Travis CI.


# === Android ===

cmr_TARGET_OS=android
cmr_JOBS="-j${cmr_JOBS_CNT}"

cmr_CMAKE_RELEASE=cmake-3.6.0-Linux-x86_64
cmr_CMAKE_DIR="/home/work/apps/cmake/${cmr_CMAKE_RELEASE}"
cmr_CMAKE_CMD=${cmr_CMAKE_DIR}/bin/cmake
cmr_CTEST_CMD=${cmr_CMAKE_DIR}/bin/ctest

cmr_CMAKE_GENERATOR="Ninja"
cmr_CMAKE_BUILD_TYPE=Release

#cmr_ANDROID_NDK_VERSION=r19b
cmr_ANDROID_NDK_VERSION=r21
cmr_ANDROID_NDK_NAME=android-ndk-${cmr_ANDROID_NDK_VERSION}
cmr_ANDROID_NDK_PLATFORM=${cmr_ANDROID_NDK_NAME}-linux-x86_64
#cmr_ANDROID_NDK=${cmr_INSTALL_DIR}/${cmr_ANDROID_NDK_NAME}
cmr_ANDROID_NDK=/home/work/apps/android/android-ndk-linux/${cmr_ANDROID_NDK_NAME}
cmr_ANDROID_SDK=/home/work/apps/android/android-sdk-linux


cmr_CMAKE_TOOLCHAIN_FILE=${cmr_ANDROID_NDK}/build/cmake/android.toolchain.cmake

cmr_ANDROID_CPP_FEATURES="rtti exceptions"
cmr_ANDROID_TOOLCHAIN=clang


#      name: "Android, shared, x86"
#cmr_BUILD_SHARED_LIBS=ON
#cmr_ANDROID_STL=c++_shared
#cmr_ANDROID_ABI=x86
#cmr_ANDROID_NATIVE_API_LEVEL=16
#cmr_ANDROID_EMULATOR_API_LEVEL=16

#      name: "Android, static, x86"
cmr_BUILD_SHARED_LIBS=OFF
cmr_ANDROID_STL=c++_static
cmr_ANDROID_ABI=x86
cmr_ANDROID_NATIVE_API_LEVEL=16
cmr_ANDROID_EMULATOR_API_LEVEL=16


# before_install:

mkdir ${cmr_BUILD_DIR}
mkdir ${cmr_INSTALL_DIR}
mkdir ${cmr_DOWNLOAD_DIR}
mkdir ${cmr_SAMPLE_LIB_DIR}
ln -s ../../../../LibCMaker_${cmr_LIB_NAME} ${cmr_SAMPLE_LIB_DIR}

#wget -nv -c -N -P ${cmr_DOWNLOAD_DIR} https://cmake.org/files/v3.6/${cmr_CMAKE_RELEASE}.tar.gz
#tar -xf ${cmr_DOWNLOAD_DIR}/${cmr_CMAKE_RELEASE}.tar.gz --directory ${cmr_INSTALL_DIR}

#wget -nv -c -N -P ${cmr_DOWNLOAD_DIR} https://dl.google.com/android/repository/${cmr_ANDROID_NDK_PLATFORM}.zip
#unzip -q ${cmr_DOWNLOAD_DIR}/${cmr_ANDROID_NDK_PLATFORM}.zip -d ${cmr_INSTALL_DIR}

# NOTE: LibCMaker lib deps.
git clone https://github.com/LibCMaker/LibCMaker.git ${cmr_SAMPLE_LIB_DIR}/LibCMaker
git clone https://github.com/LibCMaker/LibCMaker_GoogleTest.git ${cmr_SAMPLE_LIB_DIR}/LibCMaker_GoogleTest


# script:
cd ${cmr_BUILD_DIR}

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
        -DANDROID_NDK=${cmr_ANDROID_NDK} \
          -DCMAKE_TOOLCHAIN_FILE=${cmr_CMAKE_TOOLCHAIN_FILE} \
          -DCMAKE_GENERATOR="${cmr_CMAKE_GENERATOR}" \
          -DANDROID_ABI=${cmr_ANDROID_ABI} \
          -DANDROID_NATIVE_API_LEVEL=${cmr_ANDROID_NATIVE_API_LEVEL} \
          -DANDROID_TOOLCHAIN=${cmr_ANDROID_TOOLCHAIN} \
          -DANDROID_STL=${cmr_ANDROID_STL} \
          -DANDROID_CPP_FEATURES="${cmr_ANDROID_CPP_FEATURES}" \
|| exit 1

${cmr_CMAKE_CMD} --build . -- ${cmr_JOBS} || exit 1

${cmr_CTEST_CMD} --output-on-failure || exit 1

#&& LD_LIBRARY_PATH="./inst/lib:$LD_LIBRARY_PATH" ${CTEST_CMD} --output-on-failure


# TODO: for LD_LIBRARY_PATH use (???) ${HOME_BUILD} from travis.

#&& ${CMAKE_CMD} -E env CTEST_OUTPUT_ON_FAILURE=1 \
#   ${CMAKE_CMD} --build ${lib_BUILD_DIR} --target test



# "-GAndroid Gradle - Unix Makefiles" \
# -DCMAKE_GENERATOR="Unix Makefiles" \
# -DCMAKE_GENERATOR="Android Gradle - Unix Makefiles" \
# -DCMAKE_MAKE_PROGRAM=make \
