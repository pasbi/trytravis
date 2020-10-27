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
    mingw-w64-x86_64-double-conversion

git clone https://gitlab.com/inkscape/lib2geom
cmake -G"Unix Makefiles" \
  -B build-lib2geom \
  -S lib2geom

cmake --build build-lib2geom --target install
echo "lib2geom CMAKEOUTPUT.log:"
cat build-lib2geom/CMakeFiles/CMakeOutput.log
exit 1

build_dir="build"
cmake -G"Unix Makefiles" \
  -B "$build_dir" \
  -S . \
  -DQT_QM_PATH="/mingw64/share/qt5/translations/"

cmake --build "$build_dir" --target package

