#!/bin/bash
ROOT_PATH =$(pwd)
FILE1=$1
echo $FILE1
echo "$ROOT_PATH/$FILE1"
rm -rf /var/tmp/create-react-app-blueprint
git clone https://github.com/charly-palencia/create-react-app-blueprint.git  /var/tmp/create-react-app-blueprint
cd /var/tmp/create-react-app-blueprint
#./main.sh "$ROOT_PATH/$FILE1"
cd -
