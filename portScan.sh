#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"
deleteLine="\033[K"

#Signal Managment
function ctrl_c(){
	echo -e "$\n\n${redColour}[!]${endColour} ${grayColour}Exiting scan...${endColour}\n"
	exit 1
}

#Argument check
if [ $# -ne 1 ]; then
	echo "Usage: ./portScan.sh <ipAddr>"
	exit 1 
fi 
#Ctrl-C
trap ctrl_c SIGINT

#Main program
ip=$1
echo -e "${yellowColour}Starting port scan in $ip...${endColour}" 
for port in $(seq 1 65535);
do 
	timeout 1 bash -c "echo '' > /dev/tcp/$ip/$port" 2> /dev/null && echo -e "${deleteLine}${greenColour}[+]${endColour} ${grayColour}Puerto ${endColour}${blueColour}$port${endColour}${grayColour} - OPEN${endColour}" &

	echo -ne "\rScanning port: ${blueColour} $port / 65535 ${endColour} \r"
done

echo "${greenColour}FINISHED SCAN${endColour}"
