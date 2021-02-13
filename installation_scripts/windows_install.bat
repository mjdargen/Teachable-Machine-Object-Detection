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
pip install setuptools virtualenv virtualenvwrapper-win

:: setup virtual environment
virtualenv ./TMenv
call .\TMenv\Scripts\activate

:: install PIP packages in virtual environment
.\TMenv\Scripts\pip install -r ./installation_scripts/windows_requirements.txt
deactivate

ECHO Done!
echo To activate your virtual environment, use command './TMenv/Scripts/activate'.
echo To exit your virtual environment, use command 'deactivate'.
