#!/bin/bash

FILE1=$1
git clone https://github.com/charly-palencia/create-react-app-blueprint.git  /var/tmp/create-react-app-blueprint
cd /var/tmp/create-react-app-blueprint
./main.sh $FILE1
cd -
