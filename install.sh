#!/usr/bin/env bash

#set -e
# Any subsequent(*) commands which fail will cause the shell script to exit immediately

VIRTUAL_ENV_NAME="summer2015"
PYTHON_VERSION=python3

# Messages
MSG_UNSUPPORTED_OS="echo \"Unsupported Operating System\""

echo
echo "= Installing Operating-Specific Dependencies ="
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # ...
    echo "== Linux Detected =="
    sudo apt-get install -y $PYTHON_VERSION

    echo "=== Check if Ubuntu 12.04 or higher ==="
    # See http://ubuntuforums.org/showthread.php?t=1803754
    verNum=$( lsb_release -r | awk '{ print $2 }' | sed 's/[.]//' )
    if [ $verNum -eq 1204 ]; then
        # Ubuntu 12.04
        echo "Detected Ubuntu 12.04."
        sudo apt-get install -y pkg-config python-pip
        sudo apt-get build-dep python-matplotlib python-numpy python-scipy
    else
        # Assume Ubuntu 13.04 or higher
        echo "Assuming Ubuntu version 13.04 or higher."
        sudo apt-get install -y pkg-config python3-pip
        sudo apt-get build-dep python3-matplotlib python3-numpy python3-scipy
    fi

elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    echo "== Mac OS X Detected =="
    echo "Install $PYTHON_VERSION..."
    brew install $PYTHON_VERSION

elif [[ "$OSTYPE" == "cygwin" ]]; then
    # POSIX compatibility layer and Linux environment emulation for Windows
    echo "== Windows (Cygwin) Detected =="
    $(MSG_UNSUPPORTED_OS)
elif [[ "$OSTYPE" == "msys" ]]; then
    # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    echo "== Windows (msys) Detected =="
    $(MSG_UNSUPPORTED_OS)
elif [[ "$OSTYPE" == "win32" ]]; then
    # I'm not sure this can happen.
    echo "== Windows Detected =="
    $(MSG_UNSUPPORTED_OS)
    
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    # ...
    echo "== FreeBSD Detected =="
    $(MSG_UNSUPPORTED_OS)
else
    # Unknown.
    echo "== Unknown Operating System =="
    exit
fi

# Check if virtualenvwrapper installed
echo
echo "== Check for virtualenvwrapper =="
which virtualenvwrapper.sh > /dev/null
if [ $? -ne 0 ]; then
    echo "[Optional] It is recommended that you install and use virtualenvwrapper from \
        http://virtualenvwrapper.readthedocs.org/en/latest/install.html#basic-installation"
else
    echo "Found virtualenvwrapper, will install Python dependencies in a virtualenv."

    # 'which' will print absolute path to virtualenvwrapper.sh
    source `which virtualenvwrapper.sh`
    
    echo
    echo "=== Create Python Virtual Environment for dependencies named '$VIRTUALE_ENV_NAME' ==="
    mkvirtualenv -p $PYTHON_VERSION $VIRTUAL_ENV_NAME

    echo
    echo "=== Activate Python Virtual Environment: '$VIRTUAL_ENV_NAME' ==="
    workon $VIRTUAL_ENV_NAME

fi

echo
echo "=== Install Python dependencies ==="
pip3 install -r requirements.txt

echo
echo "All done! You can start developing by running ./notebook"
echo

