echo "Hello from the try travis build script for the MinGW64 platform"

pacman -sS qt5
pacman -sS poppler
pacman -sS python

pacman -S mingw-w64-x86_64-ninja \
          mingw-w64-x86-64-qt5 \
          mingw-w64-x86-64-poppler \
          mingw-w64-x86-64-python

echo "\n\nQt content begin\n======="
pacman -Ql mingw-w64-qt5
echo "\n\nQt content end\n======="

build_dir="build"
cmake -GNinja \
  -B "$build_dir" \
  -S . \
  -DQT_QM_PATH="/mingw64/usr/share/qt/translations/"

cmake --build "$build_dir"

