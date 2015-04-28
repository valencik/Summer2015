#!/usr/bin/env bash

BUILD_DIR=dist/

mkdir $BUILD_DIR
cd $BUILD_DIR

echo "Convert iPython Notebooks to Python code in '$BUILD_DIR'"

ipython3 nbconvert --to python ../notebooks/*.ipynb

cd ..

