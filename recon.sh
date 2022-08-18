#!/bin/bash

#todo : script name will be fixed in usage function
#todo : add gobuster instead of dirb.  +done
#todo : add "export IP=$TARGET" to the $NAME.txt   +done




#auotomate nmap and dirb and create related folder and files


usage(){
	echo '*****************************************************************'
	echo "Usage: ${0} [-nd] [-t <IP>] [-f <name>] "
	echo '	*scanning nmap, creating folder and txt files, dirb and nikto are optional'
	echo '	*Give ip after -t'
	echo '	*Give name after -f'
	echo '	*-n for nikto, -d for dirb, -g for gobuster'
	echo "	*eg : ${0} -t 192.168.1.1 -n Home"
	echo '*****************************************************************'
	exit 1
	}


if [ "${#}" -eq 0 ]
then
	echo "You need to give parameters"
	usage
	exit 1
fi


while getopts t:f:ndg OPTION
do
	case ${OPTION} in
		t)
			TARGET="${OPTARG}"
			echo "Target is $TARGET"
			;;
		f)
			NAME="${OPTARG}"
			echo "name is $NAME" 
			;;
		n)
			NIKTO='true'
			echo "Nikto is on"
			;;
		d)
			DIRB='true'
			echo "Dirb is on"
			;;
		g)
			GOBUSTER='true'
			echo "Gobuster is on"
			;;
		?)
			usage
			;;
	esac
done


#check if the file exists. if exists end the script with exit status of 1
if [ ! -d "$NAME" ]
then	
	mkdir "$NAME"
else	
	echo "$NAME directory exist, check it out"
	exit 1
fi

#create main txt
touch "$NAME"/"$NAME".txt

#for easy copy and paste tasks
echo "export IP=$TARGET" >> "$NAME"/"$NAME".txt


# "&" added for parallel work, going to fix output order, it seems messy now.

#nmap  
#-sS -sC -sV -O removed. looks like -A is enough for them.
#nmap -A -v -p- -T4 $TARGET -oN "$NAME"/nmap_"$NAME".txt &

nmap -sC -sV -sS -T5 -v $TARGET -oN "$NAME"/nmap_"$NAME".txt


#-r added. dont wanna check directories content
#dirb

if [[ $DIRB = 'true' ]]
then
	dirb http://"$TARGET" -r -o "$NAME"/dirb_"$NAME".txt 
fi

#gobuster
if [[ $GOBUSTER = 'true' ]]
then
	gobuster dir -u http://"$TARGET" -w /usr/share/dirb/wordlists/common.txt -x "php,txt,html" -o "$NAME"/gobust_"$NAME".txt
fi


#nikto

if [[ $NIKTO = 'true' ]]
then
	nikto -h "$TARGET" -o "$NAME"/nikto_"$NAME".txt 
fi




