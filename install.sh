#!/bin/bash
ROOT_PATH =$(pwd)
FILE1=$1
git clone https://github.com/charly-palencia/create-react-app-blueprint.git  /var/tmp/create-react-app-blueprint
cd /var/tmp/create-react-app-blueprint
echo "$ROOT_PATH/$FILE1"
#./main.sh "$ROOT_PATH/$FILE1"
cd -
