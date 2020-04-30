#/bin/sh
sudo apt-get update
sudo apt install -y build-essential autoconf libtool pkg-config git shtool
cd ~
git clone http://github.com/pupnp/pupnp.git
cd pupnp
./bootstrap

./configure --enable-debug
bear make
