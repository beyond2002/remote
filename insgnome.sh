#/bin/sh
#wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
#echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
sudo apt-get update
sudo apt-get upgrade -y
apt-get install ubuntu-desktop -y
apt-get install xserver-xorg-video-dummy -y
#sudo xargs -a packages_list.txt apt install
#sudo apt-get install gnome-shell ubuntu-desktop ubuntu-gnome-desktop autocutsel gnome-core gnome-panel gnome-themes-standard xserver-xorg xserver-xorg-core xserver-xorg-video-dummy anydesk -y
sudo cp xorg.conf /etc/X11/xorg.conf
#sudo su
#echo gnomevm@1 | anydesk --set-password