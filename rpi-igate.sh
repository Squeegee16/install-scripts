#! /bin/sh
# https://www.youtube.com/watch?v=g_AoAGjQMl8&feature=youtu.be
sudo apt-get update -y
sudo apt-get install git

## python-misc
sudo apt-get install python3-dev cmake build-essential python-pip libusb-1.0-0-dev

## RTl-SDR
echo 'blacklist dvb_usb_rtl28xxu' >no-rtl.conf
echo 'blacklist rtl2832' >>no-rtl.conf
echo' blacklist rtl2830' >>no-rtl.conf

sudo mv no-rtl.conf /etc/modprobe.d/
cd ~
git clone git://git.osmocom.org/rtl-sdr.git
cd rtl-sdr
mkdir build
cd build
cmake ../ -DINSTALL_UDEV_RULES=ON -DDETACH_KERNEL_DRIVER=ON
make
sudo make install
sudo ldconfig
cd ~
sudo cp rtl-sdr/rtl-sdr.rules /etc/udev/rules.d/

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
