#!/bin/bash

#auotomate nmap and dirb and create related folder and files


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

#-d added. dont wanna check directories content
#dirb
dirb http://"$TARGET" -d -o "$NAME"/dirb_"$NAME".txt

#create main txt
touch "$NAME"/"$NAME".txt

#nikto
nikto -h "$TARGET" -o "$NAME"/nikto_"$NAME".txt

#nmap $TARGET -oN "$NAME"/"$NAME"_nmap.txt

#nmap -v -sS -sC -sV -O -p- -A -T4  10.0.2.5 -oN simplictf

#nmap -v -sS -sC -sV -O -p- -A -T4  10.0.2.5 -oN metasploitable2_nmap.txt


