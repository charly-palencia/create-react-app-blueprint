#!/bin/bash

function install_nvm {
 "` wget -qO-  https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh  -w 20 | bash`" &> /dev/null
}

function activate_nvm {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}
