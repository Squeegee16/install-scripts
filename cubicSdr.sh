#! /bin/sh
cd ~
if [ ! -d "~/applications" ]
then
	mkdir applications && echo "making app folders"
	mkdir applications/cubic
else
	mkdir applications/cubic && echo "making app folder"
fi
cd applications/cubic

sudo apt-get install cmake automake build-essential -y
sudo apt-get install libpulse-dev libgtk-3-dev -y
###soapy-sdr
echo "getting SoapySDR"
git clone https://github.com/pothosware/SoapySDR.git
cd SoapySDR
mkdir build
cd build
cmake ../ -DCMAKE_BUILD_TYPE=Release
make -j4
sudo make install
sudo ldconfig
SoapySDRUtil --info
cd ~/applications/cubic
###liquid dsp
echo "getting liquid dsp"
git clone https://github.com/jgaeddert/liquid-dsp.git
cd liquid-dsp
./bootstrap.sh
CFLAGS="-march=native -O3" ./configure --enable-fftoverride
make -j4
sudo make install
sudo ldconfig
cd ~/applications/cubic
### soapy sdr
sudo apt-get install librtlsdr-dev -y
git clone https://github.com/pothosware/SoapyRTLSDR.git
cd SoapyRTLSDR
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make
sudo make install
sudo ldconfig
cd ~/applications/cubic
###wxwidgets
echo "getting wxWidgets"
wget https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.3/wxWidgets-3.1.3.tar.bz2
tar -xvjf wxWidgets-3.1.3.tar.bz2
rm wxWidgets-3.1.3.tar.bz2
cd wxWidgets-3.1.3/
mkdir -p wxWidgets-staticlib/
./autogen.sh
./configure --with-opengl --disable-shared --enable-monolithic --with-libjpeg --with-libtiff --with-libpng --with-zlib --disable-sdltest --enable-unicode --enable-display --enable-propgrid --disable-webkit --disable-webview --disable-webviewwebkit --prefix=`echo ~/applications/cubic/wxWidgets-staticlib` CXXFLAGS="-std=c++0x"
make -j4 && sudo make install
cd ~/applications/cubic
##cubic SDR
echo "getting cubicsdr"
git clone https://github.com/cjcliffe/CubicSDR.git
cd CubicSDR
mkdir build
cd build
cmake ../ -DCMAKE_BUILD_TYPE=Release -DwxWidgets_CONFIG_EXECUTABLE=~/applications/cubic/wxWidgets-3.1.3/wxWidgets-staticlib/bin/wx-config -DUSE_HAMLIB=1
make
sudo make install
cd ~/applications
echo "Installation Complete"
