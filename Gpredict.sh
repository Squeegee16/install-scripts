#! /bin/sh
sudo apt-get update -y

##base dependanceies
sudo apt-get install cmake automake build-essential -y

## dependanceies for g-predict
sudo apt-get install intltoot libcurl4-openssl-dev libglib2.0 libgoocanvas-2.0-dev
if[ ! -d ~/applications]
then 
  mkdir applications 
else
  mkdir applications
fi
#g-predict
git clone -C gpredict https://github.com/csete/gpredict.git
cd gpredict
./configure
make 
sudo make install
cd ..
