#!/bin/bash

set encoding=utf-8

#EMOJIS
GEAR="⚙️"
SMALL_BLUE_DIAMOND="🔹"
HOURGLASS="\xE2\x8F\xB3"
CHECK_MARK=✓
CHAIN="🔗"
DOOR="🚪"
NAILS="💅"
CONSTRUCTOR="👷"


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
  printf "\n${2-$GEAR} ${TITLE}\n"
  printf -- "··············································\n"
}

function output {
  TITLE=$1
  printf "\n${2-$GEAR} ${TITLE}\n"
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
  echo $(command -v "${1}")
  command -v "$1" &> /dev/null
}

