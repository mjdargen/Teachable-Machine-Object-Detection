:: Install script for OpenCV & TensorFlow for Windows
:: Author: Michael D'Argenio
:: mjdargen@gmail.com

:: windows
ECHO This script will update your packages, and install new packages to run OpenCV and TensorFlow.
ECHO It can take up to 30 minutes to run depending upon your system.
ECHO Upon completion, you may need to reboot your machine before running.
ECHO Python 3 should be installed before running script.
timeout /t 10

:: install PIP
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
del get-pip.py

:: install PIP packages
pip install setuptools
pip install virtualenv virtualenvwrapper-win

:: setup virtual environment
virtualenv ../TMenv
call ..\TMenv\Scripts\activate

:: install PIP packages in virtual environment
..\TMenv\Scripts\pip install numpy==1.18.1
..\TMenv\Scripts\pip install scipy==1.4.1
..\TMenv\Scripts\pip install pypiwin32
..\TMenv\Scripts\pip install pyttsx3==2.71
..\TMenv\Scripts\pip install matplotlib
..\TMenv\Scripts\pip install cvlib==0.2.3
..\TMenv\Scripts\pip install opencv-python==4.2.0.32
..\TMenv\Scripts\pip install tensorflow==2.0.0
deactivate

ECHO Done!
echo To activate your virtual environment, use command './TMenv/Scripts/activate'.
echo To exit your virtual enviroment, use command 'deactivate'.
