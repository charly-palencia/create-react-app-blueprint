#!/bin/bash
root_path=$(pwd)
file=$1
$app_path="${root_path}/${file}"
echo $app_path
#rm -rf /var/tmp/create-react-app-blueprint
#git clone https://github.com/charly-palencia/create-react-app-blueprint.git  /var/tmp/create-react-app-blueprint
#cd /var/tmp/create-react-app-blueprint
#echo "==>$FILE1"
#echo "${ROOT_PATH}/${FILE1}"
#./main.sh "$ROOT_PATH/$FILE1"
#cd -
