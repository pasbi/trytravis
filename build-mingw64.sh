echo "Hello from the try travis build script for the MinGW64 platform"

# set -e

pacman --noconfirm -S \
    make \
    mingw-w64-x86_64-ninja \
    mingw-w64-x86_64-qt5 \
    mingw-w64-x86_64-poppler \
    mingw-w64-x86_64-python \
    mingw-w64-x86_64-pybind11 \
    mingw-w64-x86_64-kitemmodels-qt5 \
    mingw-w64-x86_64-openssl \
    mingw-w64-x86_64-libffi \
    mingw-w64-x86_64-zlib \
    mingw-w64-x86_64-python-pytest \
    mingw-w64-x86_64-dlfcn \
    mingw-w64-x86_64-nsis \
    mingw-w64-x86_64-boost \
    mingw-w64-x86_64-double-conversion \
    mingw-w64-x86_64-gsl \
    mingw-w64-x86_64-cython \
    mingw-w64-x86_64-gtk3 \
    mingw-w64-x86_64-gtkmm3 \
    mingw-w64-x86_64-gtest

git clone https://gitlab.com/inkscape/lib2geom
echo "CONFIGURE LIB2GEOM:"
cmake -G"Unix Makefiles" \
  -B build-lib2geom \
  -S lib2geom

echo "BUILD LIB2GEOM:"
cmake --build build-lib2geom --target install

echo "CONFIGURE omm"
build_dir="build"
cmake -G"Unix Makefiles" \
  -B "$build_dir" \
  -S . \
  -DCMAKE_BUILD_TYPE=Release \
  -DQT_QM_PATH="/mingw64/share/qt5/translations/"

echo "CMAKEOUTPUT.log:"
cat build/CMakeFiles/CMakeOutput.log

echo "BUILD omm"
cmake --build "$build_dir" --target package

