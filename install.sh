#!/bin/bash

# project_folder="${1}"
# dir=`pwd`
# app_path="${dir}/${project_folder}"
##Remove previous version
#rm -rf /var/tmp/create-react-app-blueprint
##Clone latest version
#git clone https://github.com/charly-palencia/create-react-app-blueprint.git  /var/tmp/create-react-app-blueprint
##go to tmp folder
#cd /var/tmp/create-react-app-blueprint
###Install CRA blueprint
##echo "=>>> ${app_path}"
##./main.sh $app_path
##cd -

show_spinner()
{
  local -r pid="${1}"
  local -r delay='0.75'
  local spinstr='\|/-'
  local temp
  while ps a | awk '{print $1}' | grep -q "${pid}"; do
    temp="${spinstr#?}"
    printf " [%c]  " "${spinstr}"
    spinstr=${temp}${spinstr%"${temp}"}
    sleep "${delay}"
    printf "\b\b\b\b\b\b"
  done
  printf "    \b\b\b\b"
}
(wget -O /usr/local/bin/crabp https://raw.githubusercontent.com/charly-palencia/create-react-app-blueprint/master/helper.sh https://raw.githubusercontent.com/charly-palencia/create-react-app-blueprint/master/main.sh https://raw.githubusercontent.com/charly-palencia/create-react-app-blueprint/master/crabp.sh ) &
show_spinner "$!"
chmod +x /usr/local/bin/crabp
