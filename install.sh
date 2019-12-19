#!/bin/bash
ERROR="🛑"
RED='\e[31m'
NC='\e[0m' # No Color

function command_exists {
  command -v "$1" &> /dev/null
}

if [ -z "$LC_ALL" ]; then
  if command_exists apt-get; then
    sudo apt-get install locales
  fi

  printf  "\r${2-$ERROR} ${RED}ERROR Locales are not found.${NC}

  🐧 Linux OS:
  You must to include those variable in your shell profile:

    export LANGUAGE=en_US.UTF-8
    export LANG=en_US.UTF-8
    export LC_ALL=\"en_US.UTF-8\"

  After that, run in your terminal this:
    sudo locale-gen en_US.UTF-8

  🍏 MAC OS:

  You must to include those variable in your shell profile:

  export LC_CTYPE=en_US.UTF-8
  export LC_ALL=en_US.UTF-8

    For any cases, please refresh your terminal (e.g. source ~/.bashrc) or open a new tab and try again the installation process.\n"
  exit 1;
fi


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
(mkdir -p $HOME/bin && wget -O $HOME/bin/crabp https://raw.githubusercontent.com/charly-palencia/create-react-app-blueprint/master/helper.sh https://raw.githubusercontent.com/charly-palencia/create-react-app-blueprint/master/main.sh https://raw.githubusercontent.com/charly-palencia/create-react-app-blueprint/master/crabp.sh ) &

# cat ./helper.sh ./main.sh ./crabp.sh > $HOME/bin/crabp
show_spinner "$!"
chmod +x $HOME/bin/crabp

local_crabp_setting='
# ------- crabp command settings ----
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi
# ------- crabp command settings ----
'

if [ $SHELL == "/bin/sh" ]; then
  [ -f ~/.bash_profile ] && echo "${local_nvm_setting}" >> ~/.bash_profile
  [ -f ~/.bashrc ] && echo "${local_nvm_setting}" >>  ~/.bashrc
else
  [ -f ~/.zshrc ] && echo "${local_nvm_setting}" >>  ~/.zshrc
fi
