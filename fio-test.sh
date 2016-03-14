#!/bin/bash

# Colour Codes
NOBOLD="\033[0m"
BOLD="\033[1m"
BLACK="\033[30m"
GREY="\033[0m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"

SIZE="2g"
DIRECTORY="/data/whisper"
BLOCKSIZE="8k"
FIO_OPTIONS="--size=${SIZE} --directory=${DIRECTORY} --blocksize=${BLOCKSIZE} --direct=1 --fsync=0 --numjobs=4 --nrfiles=1 --group_reporting --loops=1"

# Write Only
JOBNAME="write"
echo -e "${BOLD}Running fio test for ${NOBOLD}${CYAN}\"${JOBNAME}\"${NOBOLD}"
fio --name=${JOBNAME} --rw=write ${FIO_OPTIONS}
echo -e ""

# Readwrite, 5% read increments to 50%
for percent in $(seq 5 5 50); do
  JOBNAME="rw${percent}"
  echo -e "${BOLD}Running fio test for ${NOBOLD}${CYAN}\"${JOBNAME}\"${NOBOLD}"
  fio --name=${JOBNAME} --rw=rw --rwmixread=${percent} ${FIO_OPTIONS}
  echo -e ""
done
