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

   bash <(wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh) >myscript.log 2>&1 </dev/null &
   show_spinner "$!"
 fi

 export NVM_DIR="$HOME/.nvm"
 [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" >myscript.log 2>&1 </dev/null 
 [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" >myscript.log 2>&1 </dev/null 

installed "NVM"

# ============ NODE VERSION =============
LTS_NODE_VERSION=$(wget -qO- https://resolve-node.now.sh/lts)

installing "Node version: ${LTS_NODE_VERSION}"
nvm install $LTS_NODE_VERSION >myscript.log 2>&1 </dev/null &
show_spinner "$!"

nvm use $LTS_NODE_VERSION >myscript.log 2>&1 </dev/null
installed "Node version: ${LTS_NODE_VERSION}"

# ============ CREATE REACT APP =============
installing "React app via create react app"
npx -q create-react-app $PROJECT_FOLDER >myscript.log 2>&1 </dev/null &
show_spinner "$!"
cd $PROJECT_FOLDER
echo $LTS_NODE_VERSION > .nvmrc
nvm use >myscript.log 2>&1 </dev/null
installed "React app via create react app"

# ============ CHECK ENGINE =============
installing "Node check-engine"
npx -q json -I -f package.json -e "this.engines={\"node\":\">=$LTS_NODE_VERSION\"}" >myscript.log 2>&1 </dev/null &
show_spinner "$!"
npx -q json -I -f package.json -e "this.scripts.preinstall=\"npx check-engine\"" >myscript.log 2>&1 </dev/null &
show_spinner "$!"
npx -q check-engine >myscript.log 2>&1 </dev/null &
show_spinner "$!"
installed "node check engine"

# ============ NPM LIBRARIES =============
installing "styled-components"
npm install -s styled-components reset-css >myscript.log 2>&1 </dev/null &
show_spinner "$!"
installed "styled-components" $NAILS

installing "react-routers"
npm install -s react-router react-router-dom >myscript.log 2>&1 </dev/null &
show_spinner "$!"
installed "react-routers" $DOOR

installing "redux"
npm install -s redux react-redux redux-thunk connected-react-router >myscript.log 2>&1 </dev/null &
show_spinner "$!"
installed "redux" $CHAIN

installing "eslint & prettier"
npm i -D stylelint stylelint-processor-styled-components  stylelint-config-styled-components stylelint-config-recommended prettier eslint-config-prettier >myscript.log 2>&1 </dev/null &
show_spinner "$!"
installed "eslint & prettier" $CONSTRUCTOR

output "Modify default example..."

cp  -f /var/tmp/create-react-app-blueprint/templates/components.js src/components.js
cp  -f /var/tmp/create-react-app-blueprint/templates/globalStyles.js src/globalStyles.js

output "Include basic redux example..."
cp /var/tmp/create-react-app-blueprint/templates/store.js src/store.js
cp -rf /var/tmp/create-react-app-blueprint/templates/redux/actions src/actions
cp -rf /var/tmp/create-react-app-blueprint/templates/redux/actionTypes src/actionTypes
cp -rf /var/tmp/create-react-app-blueprint/templates/redux/reducers src/reducers

output "Include example pages ..."
cp  -f /var/tmp/create-react-app-blueprint/templates/history.js src/history.js
cp  -rf /var/tmp/create-react-app-blueprint/templates/pages src/pages

output "Change defaut APP.js"
cp -f /var/tmp/create-react-app-blueprint/templates/App.js src/App.js
cp -f /var/tmp/create-react-app-blueprint/templates/index.js src/index.js

output "React Blueprint completed!" "🍺🎉"

