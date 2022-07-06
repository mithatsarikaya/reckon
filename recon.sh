#!/bin/bash


TARGET=$1
NAME=$2

echo $TARGET
echo $NAME
#comment
#check if the file exists. if exists end the script with exit status of 1
if [ ! -d "$NAME" ]
then	mkdir "$NAME"
else	echo ""$NAME" directory exist, check it out"
exit 1
fi

  
nmap -v -sS -sC -sV -O -p- -A -T4 $TARGET -oN "$NAME"/"$NAME"_nmap.txt


dirb http://"$TARGET" -o "$NAME"/"$NAME"_dirb.txt

touch "$NAME"/"$NAME".txt

#nmap $TARGET -oN "$NAME"/"$NAME"_nmap.txt

#nmap -v -sS -sC -sV -O -p- -A -T4  10.0.2.5 -oN simplictf

#nmap -v -sS -sC -sV -O -p- -A -T4  10.0.2.5 -oN metasploitable2_nmap.txt


