#!/usr/bin/env bash

set -e

cd $(dirname $0)

dist="$(lsb_release -cs)"
repo="$(basename -s .git `git config --get remote.origin.url`)"
echo "Build $repo on Ubuntu $dist".

echo "installing dependencies ..."
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y ninja-build zlib1g-dev libssl-dev libffi-dev \
                    libgl-dev python3-dev
case "$dist" in
"xenial" | "bionic")
  sudo apt-add-repository -y ppa:ubuntu-toolchain-r/test
  sudo apt-add-repository -y ppa:beineri/opt-qt-5.12.3-"$dist"
  sudo apt update -y
  sudo apt install -y g++-8
  sudo apt install -y qt512tools qt512translations qt512svg \
                      qt512base qt512imageformats

  CXX_COMPILER=g++-8
  C_COMPILER=gcc-8
  QT_PREFIX="/opt/qt512"
  QT_QM_PATH="/usr/share/qt5/translations/"
  ;;
 "disco" | "eaon")
  sudo apt install -y g++ gcc
  sudo apt install -y qtbase5-dev qtchooser qt5-qmake \
                      qtbase5-dev-tools qt5-default \
                      libqt5svg5-dev qttools5-dev \
                      qttools5-dev pybind11-dev
  CXX_COMPILER=g++
  C_COMPILER=gcc
  ;;
esac
sudo apt install -y libpoppler-qt5-dev libkf5itemmodels-dev

wget https://github.com/Kitware/CMake/releases/download/v3.14.5/cmake-3.14.5-Linux-x86_64.tar.gz
tar xf cmake-3.14.5-Linux-x86_64.tar.gz
cmake_3_14=$(pwd)/cmake-3.14.5-Linux-x86_64/bin/cmake

if [ -d build ]; then
  rm -r build
fi
mkdir build

cd build
$cmake_3_14 -GNinja \
            -DCMAKE_BUILD_TYPE=Release \
            -DCMAKE_CXX_COMPILER="$CXX_COMPILER" \
            -DCMAKE_C_COMPILER="$C_COMPILER" \
            -DQT_QM_PATH="$QT_QM_PATH" \
            -DCMAKE_PREFIX_PATH="$QT_PREFIX" \
            -DCMAKE_INSTALL_PREFIX=/usr \
            ..

ninja
