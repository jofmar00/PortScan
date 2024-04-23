#!/bin/bash

#Colours
green="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"
deleteLine="\033[K"

#Title
function printTitle(){
	echo "                      __  _____                "
	echo "    ____  ____  _____/ /_/ ___/_________ _____ "
	echo "   / __ \/ __ \/ ___/ __/\__ \/ ___/ __ \`/ __ \\"
	echo "  / /_/ / /_/ / /  / /_ ___/ / /__/ /_/ / / / /"
	echo " / .___/\____/_/   \__//____/\___/\__,_/_/ /_/ "
	echo "/_/    "
	echo -e "\n By Jofmar00"
}

#Scan function
function scan(){
	bash -c "echo '' > /dev/tcp/$ip/$port" 2> /dev/null && 
	echo -e "${deleteLine}${green}[+]${endColour} ${gray}Puerto ${endColour}${blue}$port${endColour}${gray} - OPEN${endColour}" &
}


#Signal Managment
function ctrl_c(){
	echo -e "$\n\n${red}[!]${endColour} ${gray}Exiting scan...${endColour}\n"
	exit 1
}
############   --- MAIN PROGRAM --- #########
#Argument check
if [ $# -ne 1 ]; then
	echo "Usage: ./portScan.sh <ipAddr>"
	exit 1
fi

#Ctrl-C
trap ctrl_c SIGINT
printTitle
ip=$1
echo -e "${yellow}Starting port scan in $ip...${endColour}"
for port in $(seq 1 65535);
do
	scan
	echo -ne "\rScanning port: ${blue} $port / 65535 ${endColour} \r"
done

echo "${green}FINISHED SCAN${endColour}"
