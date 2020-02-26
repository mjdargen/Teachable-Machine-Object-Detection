#!/bin/bash
# Install script for OpenCV & TensorFlow for Mac
# Author: Michael D'Argenio
# mjdargen@gmail.com

echo "This script will update your packages, and install new packages to run OpenCV and TensorFlow."
echo "It can take up to an hour to run depending upon your system."
echo "Upon completion, you may need to reboot your machine before running."
echo "Python 3 should be installed before running script."
sleep 5s

# install homebrew package manager
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# update packages and remove any unnecessary packages
brew update
brew upgrade
brew cleanup

# install dependency packages
brew install cmake pkg-config curl wget
brew install jpeg libpng libtiff openexr
brew install eigen tbb hdf5 pyqt qt
brew install opencv --with-contrib
brew install espeak

# PIP Python Package installations
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py
sudo rm get-pip.py
sudo rm -rf ~/.cache/pip

# install pip packages
sudo pip3 install setuptools
sudo pip3 install virtualenv virtualenvwrapper

# setup virtual environment
virtualenv TMenv
source TMenv/bin/activate

# install PIP packages in virtual environment
pip3 install numpy==1.18.1
pip3 install scipy==1.4.1
pip3 install pyttsx3==2.71
pip3 install matplotlib
pip3 install cvlib==0.2.3
pip3 install opencv-contrib-python==4.1.2.30
pip3 install tensorflow==2.0.0
deactivate

# update packages and remove any unnecessary packages
brew update
brew upgrade
brew cleanup

echo "Done!"
echo "To activate your virtual environment, use command 'source TMenv/bin/activate'."
echo "To exit your virtual enviroment, use command 'deactivate'."
