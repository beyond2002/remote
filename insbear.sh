#/bin/sh
sudo apt-get update
sudo apt-get -y install cmake
sudo apt-get -y install gcc-multilib
cd ~
git clone https://github.com/rizsotto/Bear.git
export BEAR_SOURCE_DIR=~/Bear
mkdir build32
cd ~/build32
cmake "$BEAR_SOURCE_DIR" -DCMAKE_C_COMPILER_ARG1="-m32"
VERBOSE=1 make all
cd ~
mkdir build64
cd ~/build64
cmake "$BEAR_SOURCE_DIR" -DCMAKE_C_COMPILER_ARG1="-m64"
VERBOSE=1 make all
sudo make install
cd ~
sudo install -m 0644 ~/build32/libear/libear.so  /lib/i386-linux-gnu
sudo install -m 0644 ~/build32/libear/libear.so  /lib/x86_64-linux-gnu


