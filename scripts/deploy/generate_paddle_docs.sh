#!/bin/bash
set -e

PADDLE_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}")/../../" && pwd )"

echo $PADDLE_ROOT

ls $PADDLE_ROOT

echo $TRAVIS_BUILD_DIR
ls -l $TRAVIS_BUILD_DIR
cd ../../

export PYTHONPATH=$PYTHONPATH:`pwd`/Paddle/build/python
export PYTHONPATH=$PYTHONPATH:$TRAVIS_BUILD_DIR/build/python

echo "-------------------"
echo "Set PYTHONPATH to $PYTHONPATH"

ls -l $PYTHONPATH
ls -l $PYTHONPATH/paddle
ls -l /paddle
ls -l /paddle/build
ls -l /paddle/build/python
ls -l $TRAVIS_BUILD_DIR/build/

echo "------------"
