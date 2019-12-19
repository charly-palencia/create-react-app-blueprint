#!/bin/bash
export LC_ALL=en_US.UTF-8
create_cra_project(){
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

# source ~/.zshrc &> ${log_path}

title " SETTING UP REACT BLUEPRINT" $LOGO;

# ============ NVM =============
if [ -d "$HOME/.nvm" ]; then
  title "NVM installation validation" $CHECK
else
  title " NVM is required for installation" $ERROR;
fi

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
rm ./myscript.log
cd $PROJECT_FOLDER
echo $LTS_NODE_VERSION > .nvmrc
nvm use >myscript.log 2>&1 </dev/null
installed "React app via create react app"

# ============ CHECK ENGINE =============
installing "Node check-engine"
npx -q json -I -f package.json -e "this.engines={\"node\":\">=$LTS_NODE_VERSION\"}" >myscript.log 2>&1 </dev/null &
show_spinner "$!"
npx -q json -I -f package.json -e "this.engines={\"node\":\">=$LTS_NODE_VERSION\"}" >myscript.log 2>&1 </dev/null &
show_spinner "$!"
npx -q json -I -f package.json -e "this.scripts.preinstall=\"npx check-engine\"" >myscript.log 2>&1 </dev/null &
show_spinner "$!"
npx -q check-engine >myscript.log 2>&1 </dev/null &
show_spinner "$!"
installed "node check engine"

# ============ NPM LIBRARIES =============
installing "styled-components"
npm install -s styled-components styled-components.macro reset-css >myscript.log 2>&1 </dev/null &
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

output "Include default example..."
DEMO_FILES=(components.js globalStyles.js store.js actions/index.js actionTypes/index.js reducers/index.js reducers/color.js history.js pages/Home.js App.js index.js )
mkdir -p src/actions
mkdir -p src/actionTypes
mkdir -p src/reducers
mkdir -p src/pages
for i in "${DEMO_FILES[@]}"
do
  bash <(wget -qO "./src/$i" "https://raw.githubusercontent.com/charly-palencia/create-react-app-blueprint/master/templates/$i") >myscript.log 2>&1 </dev/null &
  show_spinner "$!"
done

bash <(wget -qO "./jsconfig.json" "https://raw.githubusercontent.com/charly-palencia/create-react-app-blueprint/master/templates/jsconfig.json") >myscript.log 2>&1 </dev/null &
show_spinner "$!"

output "React Blueprint completed!" "🍺🎉"
rm ./myscript.log
}

upgrade_crabp(){
  installing "Upgrading React Blueprint"
  rm $HOME/bin/crabp
  (mkdir -p $HOME/bin && wget -O $HOME/bin/crabp https://raw.githubusercontent.com/charly-palencia/create-react-app-blueprint/master/helper.sh https://raw.githubusercontent.com/charly-palencia/create-react-app-blueprint/master/main.sh https://raw.githubusercontent.com/charly-palencia/create-react-app-blueprint/master/crabp.sh ) &

  # cat ./helper.sh ./main.sh ./crabp.sh > $HOME/bin/crabp &
  show_spinner "$!"
  chmod +x $HOME/bin/crabp
  output "React Blueprint upgrade completed!" $VERSION
}
