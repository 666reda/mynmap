#!/bin/bash

# usage : # mynmap.sh compromised.htb
# this script perform a full nmap scan, a -sV/-sC scan in open ports, then a UDP scan on top 100 ports
# the script create 3 files : nmap.txt.full, nmap.txt, nmap.udp.txt
# typical wrapper when targeting a single box (HTB, OSCP...)

# commands to add if you want more thorough scan :
	# nmap --script discovery -Pn -v -oN nmap.txt.disc 10.11.1.1
	# nmap -p 139,445 -Pn -v --script vuln -oN nmap.txt.vuln 10.11.1.1
	# nmap -p 139,445 -Pn -v --script smb* -oN nmap.txt.smb 10.11.1.1
	# ffuf -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -fc 404 -u http://site.com/FUZZ -c -of html -o site_brute.html

if [ $# -ne 1 ]; then
 echo ""
 echo "[*] Usage : # ${0##*/} <target-IP>"
 echo ""
 exit 1
fi

WHITE='\033[1;37m' # white color
NC='\033[0m' # no color

printf "\n${WHITE}######################### Running Nmap Full Scan #########################${NC}\n\n"
nmap -Pn -p- -v -oN nmap.txt.full $1
# storing open port in variable
openports=$(cat nmap.txt.full | grep ^[0-9] | cut -d '/' -f 1 | tr '\n' ',' | sed s/,$//)


printf "\n${WHITE}######################### Running Nmap -sC/-sV on Open Ports ($openports) #########################${NC}\n\n"
nmap -Pn -sV -sC -v -oN nmap.txt $1 -p $openports


printf "\n${WHITE}######################### Runnning Nmap UDP Scan on top 100 ports #########################${NC}\n\n"
nmap -Pn -sU --top-ports 100 -sV -sC -v -oN nmap.txt.udp $1
