#!/bin/bash

apt-get install -y pkg-config libfreetype6-dev python3-pip python3-matplotlib python3-numpy python3-tornado python3-scipy ipython3 ipython3-notebook

echo "Installing python libraries via pip3..."
pip3 install theano

