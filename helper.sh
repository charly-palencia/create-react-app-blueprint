#!/bin/bash

# set encoding=utf-8

#EMOJIS
GEAR="⚙️"
SMALL_BLUE_DIAMOND="🔹"
HOURGLASS="\xE2\x8F\xB3"
CHECK_MARK=✓
CHAIN="🔗"
DOOR="🚪"
NAILS="💅"
CONSTRUCTOR="👷"
ERROR="🛑"


#COLORS
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
GREY='\e[90m'
NC='\e[0m' # No Color
MAC='MAC OS'
LINUX='LINUX'

function title {
  TITLE=$1
  printf "\n${2-$GEAR}  ${TITLE}\n"
  printf -- "··············································\n"
}

function output {
  TITLE=$1
  printf "\n${2-$GEAR}  ${TITLE}\n"
}

function installing {
  printf "\n${HOURGLASS} Installing ${1}... "
}

function installed {
  printf "\r${2-$CHECK_MARK} ${GREEN}${1} installed successfully${NC}\n"
  if [ ! -z "${3}" ]; then
    printf "\t${3}\n"
  fi
}

function command_exists {
  type "$1" &> /dev/null
}

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

  #Validate if command line response with errors
  wait $pid
  local -r my_status=$?
  if [ $my_status -ne 0 ]; then
    local -r line=$(tail -1 ./myscript.log)
    printf "\r${2-$ERROR} ${RED}${line}${NC}\n"
    exit 1
  fi
  printf "    \b\b\b\b"
}
