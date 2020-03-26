#! /bin
# https://www.youtube.com/watch?v=g_AoAGjQMl8&feature=youtu.be
## RTl-SDR
sudo apt-get update
sudo apt-get install cmake build-essential libusb-1.0-0-dev -y
cd ~
git clone git://git.osmocom.org/rtl-sdr.git
cd rtl-sdr
mkdir build
cd build
cmake ../ -DINSTALL_UDEV_RULES=ON -DDETACH_KERNEL_DRIVER=ON
make
sudo make install
sudo ldconfig



## direwolf
sudo apt-get remove --purge pulseaudio
sudo apt-get autoremove
rm -rf ~/.pulse
sudo reboot
sudo apt-get install libasound2-dev -y
cd ~
git clone https://www.github.com/wb2osz/direwolf
cd direwolf
make
sudo make install
make install-conf
make install-rpi

echo 'complete'
