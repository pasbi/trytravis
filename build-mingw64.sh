echo "Hello from the try travis build script for the MinGW64 platform"

make --version
gcc --version
g++ --version
cmake --version
pacman --version
pacman -Ss ninja
ninja --version

ls
build_dir="build"
cmake -GNinja \
  -B "$build_dir" \
  -S .

cmake --build "$build_dir"

