#!/bin/bash
clear
PROJECT_FOLDER=$1
if [ -z "$PROJECT_FOLDER" ]; then
  echo "Use path folder"
  exit 125
fi

source ~/.zshrc >& /dev/null
source ./helper.sh;
source ./installers/nvm.sh;

title "SETTING UP REACT BLUEPRINT" $LOGO;

printf "\nChecking dependencies... "

if command_exists nvm; then
  title "NVM already installed" $CHECK
  activate_nvm
else
  installing "NVM"
  install_nvm && activate_nvm
fi
installed "NVM"
LTS_NODE_VERSION="`wget -qO- https://resolve-node.now.sh/lts`"
installing "Node version: ${LTS_NODE_VERSION}\n" &> /dev/null
installed "Node version: ${LTS_NODE_VERSION}"
nvm install $LTS_NODE_VERSION &> /dev/null

installing "React app via create react app"
mkdir -p $PROJECT_FOLDER && cd $PROJECT_FOLDER &> /dev/null
npx -q create-react-app $PROJECT_FOLDER &> /dev/null

echo $LTS_NODE_VERSION > .nvmrc
nvm use &> /dev/null
npm i &> /dev/null

installed "\nReact app"

installing "node check engine"
npx -q json -I -f package.json -e "this.engines={\"node\":\">=$LTS_NODE_VERSION\"}" &> /dev/null
npx -q check-engine &> /dev/null
installed "node check engine"
