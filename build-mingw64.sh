echo "Hello from the try travis build script for the MinGW64 platform"

build_dir="build"
cmake -GNinja \
  -B "$build_dir" \
  -S . \
  -DQT_QM_PATH="/mingw64/usr/share/qt/translations/"

cmake --build "$build_dir"
# C:\tools\msys64\mingw64
