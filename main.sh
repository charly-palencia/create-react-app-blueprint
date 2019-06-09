#!/bin/bash
clear
PROJECT_FOLDER=$1
root_path=$(pwd)
log_path=/dev/null
-rm log.txt &> ${log_path}

for arg in "$@"
do
  if [ "$arg" == "--verbose" ] || [ "$arg" == "-v" ]
  then
    install -m 777 /dev/null log.txt
    log_path="${root_path}/log.txt"
    echo 'React Bluepint Logs' > ${log_path}
  fi
done

if [ -z "$PROJECT_FOLDER" ]; then
  echo "Use path folder"
  exit 125
fi

source ~/.zshrc &> ${log_path}
source ./helper.sh;

title " SETTING UP REACT BLUEPRINT" $LOGO;

# ============ NVM =============
 if command_exists nvm; then
   title "NVM already installed" $CHECK
 else
   installing "NVM"
   $(wget --wait=20 -qO -  https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash &>> ${log_path}) &
   wait
 fi

 export NVM_DIR="$HOME/.nvm"
 [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
 [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# installed "NVM"

# ============ NODE VERSION =============
LTS_NODE_VERSION="`wget -qO- --wait=20 https://resolve-node.now.sh/lts`"
installing "Node version: ${LTS_NODE_VERSION}" 
`nvm install $LTS_NODE_VERSION &> ${log_path}` &
wait
nvm use $LTS_NODE_VERSION &> ${log_path}
installed "Node version: ${LTS_NODE_VERSION}"

# ============ CREATE REACT APP =============
installing "React app via create react app"
npx -q create-react-app $PROJECT_FOLDER &> ${log_path} &
wait
installed "\nReact app"
cd $PROJECT_FOLDER
echo $LTS_NODE_VERSION > .nvmrc
nvm use &> ${log_path}

# ============ CHECK ENGINE =============
installing "Node check-engine"
npx -q json -I -f package.json -e "this.engines={\"node\":\">=$LTS_NODE_VERSION\"}" &> ${log_path} &
npx -q json -I -f package.json -e "this.scripts.preinstall=\"npx check-engine\"" &> ${log_path} &
npx -q check-engine &> ${log_path} &
wait
installed "node check engine"

# ============ NPM LIBRARIES =============
installing "styled-components"
npm install -s styled-components reset-css &> ${log_path} &
wait
installed "styled-components" $NAILS

installing "react-routers"
npm install -s react-router react-router-dom &> ${log_path} &
wait
installed "react-routers" $DOOR

installing "redux"
npm install -s redux react-redux redux-thunk connected-react-router &> ${log_path} &
wait
installed "redux" $CHAIN

installing "eslint & prettier"
npm i -D stylelint stylelint-processor-styled-components  stylelint-config-styled-components stylelint-config-recommended prettier eslint-config-prettier &> ${log_path} &
wait
installed "eslint & prettier" $CONSTRUCTOR

output "Modify default example..."

pwd

cp  -f ../templates/components.js src/components.js
cp  -f ../templates/globalStyles.js src/globalStyles.js

output "Include basic redux example..."
cp ../templates/store.js src/store.js
cp -rf ../templates/redux/actions src/actions
cp -rf ../templates/redux/actionTypes src/actionTypes
cp -rf ../templates/redux/reducers src/reducers

output "Include example pages ..."
cp  ../templates/history.js src/history.js
cp  -rf ../templates/pages src/pages

output "Change defaut APP.js"
cp -f ../templates/App.js src/App.js
cp -f ../templates/index.js src/index.js

output "React Blueprint completed!" "🍺🎉"

