#!/bin/bash

#auotomate nmap and dirb and create related folder and files
#just for githubcheck

TARGET=$1
NAME=$2

echo $TARGET
echo $NAME

#check if the file exists. if exists end the script with exit status of 1
if [ ! -d "$NAME" ]
then	mkdir "$NAME"
else	echo ""$NAME" directory exist, check it out"
exit 1
fi

#create main txt
touch "$NAME"/"$NAME".txt

echo "$TARGET" >> "$NAME"/"$NAME".txt

#nmap  
nmap -v -sS -sC -sV -O -p- -A -T4 $TARGET -oN "$NAME"/nmap_"$NAME".txt

#-r added. dont wanna check directories content
#dirb
dirb http://"$TARGET" -r -o "$NAME"/dirb_"$NAME".txt


#nikto
nikto -h "$TARGET" -o "$NAME"/nikto_"$NAME".txt


