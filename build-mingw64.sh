echo "Hello from the try travis build script for the MinGW64 platform"

set -e

pacman --noconfirm -S \
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
    mingw-w64-x86_64-dlfcn

pacman -Ql mingw-w64-x86_64-qt5

build_dir="build"
cmake -GNinja \
  -B "$build_dir" \
  -S . \
  -DQT_QM_PATH="/mingw64/share/qt5/translations/"

cmake --build "$build_dir"
# C:\tools\msys64\mingw64
