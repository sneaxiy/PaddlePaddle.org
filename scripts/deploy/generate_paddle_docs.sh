#!/bin/bash
set -e

echo "-----------------------------"
echo "Enter generate_paddle_docs.sh"

PADDLE_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}")/../../" && pwd )"

echo "PADDLE_ROOT: $PADDLE_ROOT"

if [ -d "$PADDLE_ROOT" ]; then
ls $PADDLE_ROOT
fi


echo "TRAVIS_BUILD_DIR: $TRAVIS_BUILD_DIR"
ls $TRAVIS_BUILD_DIR
cd ../../

export PYTHONPATH=$PYTHONPATH:`pwd`/Paddle/build/python
export PYTHONPATH=$PYTHONPATH:$TRAVIS_BUILD_DIR/build/python

echo "-------------------"
echo "Set PYTHONPATH to $PYTHONPATH"

if [ -d "$PYTHONPATH" ]; then
echo "PYTHONPATH: $PYTHONPATH"
ls $PYTHONPATH
fi

if [ -d "/paddle/build" ]; then
echo "/paddle/build"
ls /paddle/build
fi

if [ -d "$TRAVIS_BUILD_DIR/build" ]; then
echo "TRAVIS_BUILD_DIR/build/python: $TRAVIS_BUILD_DIR/build/python"
ls $TRAVIS_BUILD_DIR/build/python
fi

echo "possible module?---"
ls $TRAVIS_BUILD_DIR/build/python/paddle

echo "------------ done testing ----------------"
