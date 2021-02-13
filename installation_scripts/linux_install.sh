#!/bin/bash
# Install script for OpenCV & TensorFlow for Linux
# Author: Michael D'Argenio
# mjdargen@gmail.com

echo "This script will update your packages, and install new packages to run OpenCV and TensorFlow."
echo "It can take up to an hour to run depending upon your system."
echo "Upon completion, you may need to reboot your machine before running."
echo "Python 3 should be installed before running script."
sleep 5s

# update packages and remove any unnecessary packages
sudo apt-get --assume-yes update
sudo apt-get --assume-yes upgrade
sudo apt-get --assume-yes autoremove
sudo apt-get --assume-yes clean

# install dependency packages
sudo apt-get --assume-yes install python3-pip
sudo apt-get --assume-yes install build-essential cmake pkg-config
sudo apt-get --assume-yes install libjpeg-dev libtiff5-dev libjasper-dev libpng-dev
sudo apt-get --assume-yes install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get --assume-yes install libxvidcore-dev libx264-dev
sudo apt-get --assume-yes install libfontconfig1-dev libcairo2-dev
sudo apt-get --assume-yes install libgdk-pixbuf2.0-dev libpango1.0-dev
sudo apt-get --assume-yes install libgtk2.0-dev libgtk-3-dev
sudo apt-get --assume-yes install libatlas-base-dev gfortran
sudo apt-get --assume-yes install libhdf5-dev libhdf5-serial-dev libhdf5-103
sudo apt-get --assume-yes install libqtgui4 libqtwebkit4 libqt4-test python3-pyqt5
sudo apt-get --assume-yes install libespeak-dev
sudo apt-get --assume-yes install python3-dev
sudo apt-get --assume-yes install curl wget

# install PIP
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py
sudo rm get-pip.py
sudo rm -rf ~/.cache/pip

# install pip packages
sudo pip3 install setuptools virtualenv virtualenvwrapper

# setup virtual environment
virtualenv TMenv
source TMenv/bin/activate

# install PIP packages in virtual environment
pip3 install -r ./installation_scripts/linux_requirements.txt
deactivate

# update packages and remove any unnecessary packages
sudo apt-get --assume-yes update
sudo apt-get --assume-yes upgrade
sudo apt-get --assume-yes autoremove
sudo apt-get --assume-yes clean

# for linux install
# if you get an error that states something similar to the following:
#   X Error: BadDrawable (invalid Pixmap or Window parameter) 9
# you will need to run the following command
sudo sh -c 'echo "QT_X11_NO_MITSHM=1" >> /etc/environment'

echo "Done!"
echo "To activate your virtual environment, use command 'source TMenv/bin/activate'."
echo "To exit your virtual enviroment, use command 'deactivate'."
