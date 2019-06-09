#!/bin/bash

project_folder="${1}"
dir=`pwd`
app_path="${dir}/${project_folder}"
#Remove previous version  
rm -rf /var/tmp/create-react-app-blueprint
#Clone latest version  
git clone https://github.com/charly-palencia/create-react-app-blueprint.git  /var/tmp/create-react-app-blueprint
#go to tmp folder
cd /var/tmp/create-react-app-blueprint
#Install CRA blueprint
echo "=>>> ${app_path}"
./main.sh $app_path
cd -
