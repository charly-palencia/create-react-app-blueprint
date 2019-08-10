#!/bin/bash

# Implementation of crabpword script

NONE='\033[00m'
RED='\033[01;31m'
GREEN='\033[01;32m'
BLUE='\033[01;34m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'

# Script name
BASH_CLI_SCRIPT_NAME="${BLUE}⚛︎${NONE} ${GREEN}CRA BLUEPRINT${NONE}"

# Option name
BASH_CLI_OPT_NAME[0]="create"

# Alternative option name
BASH_CLI_OPT_ALT_NAME[0]="create"

# Data type consists of string, boolean, and cmd.
#   - string does not allow you set empty option value
#   - object allows you flag the option without giving value
#   - cmd is the command used in various situations in your script.
BASH_CLI_OPT_DATA_TYPE[0]="cmd"

# Setting mandatory and optional parameters for cmd "crabp"
# A cmd data type may require one or more mandatory and optional parameters
#
# Requirements of hellworld.sh
#
#  "-t | --text" is a mandatory parameter of the cmd "crabp"
#  "-u | --uppercase" is an optional parameter of the cmd "crabp"
#  "-l | --lowercase" is an optional parameter of the cmd "crabp"
#
# Reference numbers for setting mandatory and non-mandatory parameters
#
# - The index reference number of BASH_CLI_OPT_NAME[3]="crabp" is 3
# - The array index of BASH_CLI_OPT_NAME[0]="-t" is 0
# - The array index of BASH_CLI_OPT_NAME[1]="-u" is 1
# - The array index of BASH_CLI_OPT_NAME[2]="-l" is 2
#
# Mandatory parameter:
#  - BASH_CLI_OPT_NAME[3]="crabp" requires BASH_CLI_OPT_NAME[0]="-t" 
#
# Non-Mandatory parameters: 
#  - BASH_CLI_OPT_NAME[3]="crabp" requires BASH_CLI_OPT_NAME[1]="-u" 
#  - BASH_CLI_OPT_NAME[3]="crabp" requires BASH_CLI_OPT_NAME[2]="-l"
#
# BASH_CLI_MANDATORY_PARAM[3]="0"
# BASH_CLI_NON_MANDATORY_PARAM[3]="1,2"
BASH_CLI_OPT_DESC[0]="Create React Project using CRA blueprint menu dependencies 👨‍🍳
\t    For more information: https://github.com/charly-palencia/create-react-app-blueprint#what-does-this-setup-included\n
\t    ${BOLD}Example:${NONE}  ${GREEN}crabp${NONE} create ${BOLD}testApp${NONE}"

# Setting description of the option
# BASH_CLI_OPT_DESC[0]="text"
# BASH_CLI_OPT_DESC[1]="use uppercase"
# BASH_CLI_OPT_DESC[2]="use lowercase"
# BASH_CLI_OPT_DESC[3]="To print text from the value of -t"

# Implementation of "crabp" command
#
# Getting parameter values
#
# BASH_CLI_OPT_VALUE[] is an array variable that declared by the template base.sh
# The value of BASH_CLI_OPT_VALUE[] will be managed by the template
#
create() {
  create_cra_project $1
}

# Base CLI commands

BASH_CLI_ALL_ARGS=${@:2}
BASH_CLI_CURRENT_CMD_INDEX=0

for i in "${!BASH_CLI_OPT_NAME[@]}"
do
  if [ ! "${BASH_CLI_OPT_DATA_TYPE[$i]}"  ];  then
    echo "BASH_CLI_OPT_DATA_TYPE[$i]=\"\" empty string is not allowed."
    echo "The value must be one of these: \"string\", \"boolean\", or \"cmd\""
    exit
  else 
    if [ "${BASH_CLI_OPT_DATA_TYPE[$i]}" == "string" ] ; then 
      BASH_CLI_OPT_VALUE[$i]="<undefined>"
    elif [ "${BASH_CLI_OPT_DATA_TYPE[$i]}" == "boolean" ] ; then 
      BASH_CLI_OPT_VALUE[$i]=false
    elif [ "${BASH_CLI_OPT_DATA_TYPE[$i]}" == "cmd" ] ; then 
      BASH_CLI_OPT_VALUE[$i]="wait"
    else 
      echo "BASH_CLI_OPT_DATA_TYPE[$i]=${BASH_CLI_OPT_DATA_TYPE[$i]} is not allowed."
      echo "The value must be one of these: \"string\", \"boolean\", or \"cmd\""
      exit
    fi
  fi
done


SPECLINES=""
for i in "${!BASH_CLI_OPT_NAME[@]}"
do
  if [ "${BASH_CLI_OPT_DATA_TYPE[$i]}" != "cmd" ];  then
    SPECLINES+=" [${BASH_CLI_OPT_NAME[$i]}|${BASH_CLI_OPT_ALT_NAME[$i]} <${BASH_CLI_OPT_DESC[$i]}>]\n"
  fi
done
SPECLINES+=" [-h|--help]\n"

SCRIPT_OPTIONS=""
SCRIPT_CMDS=""
for i in "${!BASH_CLI_OPT_DATA_TYPE[@]}"
do
  if [ "${BASH_CLI_OPT_DATA_TYPE[$i]}" != "cmd" ];  then
    SCRIPT_OPTIONS="${SCRIPT_OPTIONS} 
    \t    ${BASH_CLI_OPT_NAME[$i]} \n"
  else 

    SCRIPT_CMDS="${SCRIPT_CMDS} 
    \t${BASH_CLI_OPT_NAME[$i]}
    \t    ${BASH_CLI_OPT_DESC[$i]} \n"
  fi
done

# HELP METHOD
function help {
      echo -e "\n ${BASH_CLI_SCRIPT_NAME} \n\n Usage: ${SPECLINES}
      \tThese are common ${BASH_CLI_SCRIPT_NAME} commands used in various situations:
            ${SCRIPT_CMDS}
      "
}

if [ $# -eq 0  ];  then
  help
  exit
fi

while [ "$1" != "" ]; do
  for i in ${!BASH_CLI_OPT_NAME[@]}
  do
    if [[ ( "${BASH_CLI_OPT_NAME[$i]}" == "$1" ) ||  
      ( "${BASH_CLI_OPT_ALT_NAME[$i]}" == "$1" ) ]] ; then
          if [ "${BASH_CLI_OPT_DATA_TYPE[$i]}" == "string" ] ; then 
            if [[ ( ${2:0:1} == "-" ) || ( ${2:0:1} == "") ]] ; then 
              BASH_CLI_OPT_VALUE[$i]='<undefined>'
            else  
              BASH_CLI_OPT_VALUE[$i]=$2 
              shift
            fi
          fi   

          if [ ${BASH_CLI_OPT_DATA_TYPE[$i]} == "boolean" ] ; then 
            BASH_CLI_OPT_VALUE[$i]=true
          fi 

          if [ ${BASH_CLI_OPT_DATA_TYPE[$i]} == "cmd" ] ; then 
            BASH_CLI_OPT_VALUE[$i]="invoked"
          fi 

        else 
          if [[ ( "$1" == "-h" ) || ( "$1" == "--help" ) ]] ; then
            help
            exit
          fi

    fi
  done
  shift
done

validate_mandatory_options(){
  local i
  for i in $(echo ${BASH_CLI_MANDATORY_PARAM[$BASH_CLI_CURRENT_CMD_INDEX]} | tr "," "\n")
  do
    if [ "${BASH_CLI_OPT_DATA_TYPE[$i]}" == "boolean" ];  then
      echo -e "\n Warning!! \n"
      echo -e "\t Please check your script implementation" 
      echo -e "\t All mandatory options (BASH_CLI_MANDATORY_PARAM[]) must be configured with string datatype option"
      echo -e "\t BASH_CLI_OPT_NAME[$i]=\"${BASH_CLI_OPT_NAME[$i]}\" is currently using boolean data type and it does not allow to be a mandatory option"
      echo -e "\n"
      exit
    fi
    validate_string_parameter "${BASH_CLI_OPT_NAME[$i]}" "${BASH_CLI_OPT_VALUE[$i]}" "${BASH_CLI_OPT_DATA_TYPE[$i]}" "${BASH_CLI_OPT_DESC[$i]}"
  done
}

validate_string_parameter() {
  local pname=$1
  local pvalue=$2
  local pdatatype=$3
  local pdesc=$4
  if [ "${pvalue}" == "<undefined>" ];  then
    echo -e "\t\tMissing mandatory option: \"${pname}\" (${pdesc}) is mandatory option"

    if [ "${pdatatype}" == "string" ];  then
      echo -e "\t\tExample: ./${BASH_CLI_SCRIPT_NAME} ${BASH_CLI_OPT_NAME[$BASH_CLI_CURRENT_CMD_INDEX]} ${pname} \"String Value\" "
    fi
    exit
  fi
}

show_optional_parameters() {
  local i
  local options
  for i in $(echo "${BASH_CLI_NON_MANDATORY_PARAM[$BASH_CLI_CURRENT_CMD_INDEX]}" | tr "," "\n")
  do
    options="${options} ${BASH_CLI_OPT_NAME[$i]}" 
  done
  echo -e "\n\tAll optional parameters of this command: ${options}"

  echo -e "\tCurrent value:"
  for i in $(echo ${BASH_CLI_NON_MANDATORY_PARAM[$BASH_CLI_CURRENT_CMD_INDEX]} | tr "," "\n")
  do
    echo -e "\t\t${BASH_CLI_OPT_NAME[$i]} ${BASH_CLI_OPT_VALUE[$i]}"
  done
}

process() {
  local j

  for j in "${!BASH_CLI_OPT_NAME[@]}"
  do
    if [ "${BASH_CLI_OPT_DATA_TYPE[$j]}" == "cmd" ];  then
      if [ "${BASH_CLI_OPT_VALUE[$j]}" == "invoked" ];  then
        BASH_CLI_CURRENT_CMD_INDEX=$j
        validate_mandatory_options
        # ${BASH_CLI_OPT_NAME[$BASH_CLI_CURRENT_CMD_INDEX]} 
        ${BASH_CLI_OPT_NAME[$BASH_CLI_CURRENT_CMD_INDEX]} "${BASH_CLI_ALL_ARGS}"
        break
      fi
    fi
  done
}

process $BASH_CLI_ALL_ARGS
