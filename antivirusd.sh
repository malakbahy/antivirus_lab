#!/bin/bash
DIR=$1
MALICIOUS_DIR=$2
INTERVAL=$3
ls -l $DIR > directory_info.last
while true
do
    ls -l "$DIR" > directory_info.new
    if ! diff -q directory_info.last directory_info.new > /dev/null
    then
            for file in "$DIR"/*
            do
                if [ -f "$file" ]
                then
                    if echo "$file" | grep -E -q '\.(exe|bat|vbs|scr|ps1)$' || grep -i -q -E 'virus|trojan|malware|worm|ransomware' "$file"
                    then
                        echo "$file is malicious and it is DELETED"
                        cp "$file" "$MALICIOUS_DIR/"
                        rm "$file"
                    fi
                fi
             done
             cp  directory_info.new directory_info.last 
    fi
    sleep "$INTERVAL"
done
