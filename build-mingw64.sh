echo "Hello from the try travis build script for the MinGW64 platform"

pacman --noconfirm -S \
  mingw-w64-x86_64-ninja \
  mingw-w64-x86_64-qt5 \
  mingw-w64-x86_64-poppler \
  mingw-w64-x86_64-python

echo "\n\nQt content begin\n======="
pacman -Ql mingw-w64-qt5
echo "\n\nQt content end\n======="

build_dir="build"
cmake -GNinja \
  -B "$build_dir" \
  -S . \
  -DQT_QM_PATH="/mingw64/usr/share/qt/translations/"

cmake --build "$build_dir"

