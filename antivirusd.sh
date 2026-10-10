#!/bin/bash
DIR=$1
MALICIOUS_DIR=$2
INTERVAL=$3
FLAGGED_EXTENSIONS=("exe" "bat" "vbs" "scr" "ps1")
FLAGGED_KEYWORDS=("virus" "trojan" "malware" "worm" "ransomware")

ls -l "$DIR" > directory_info.last

while true
do
    ls -l "$DIR" > directory_info.new
    if ! diff -q directory_info.last directory_info.new > /dev/null
    then
        for file in "$DIR"/*
        do
            if [ -f "$file" ]
            then
                ext_matched=false
                file_ext="${file##*.}"
                for ext in "${FLAGGED_EXTENSIONS[@]}"; do
                    if [ "$file_ext" = "$ext" ]; then
                        ext_matched=true
                        break
                    fi
                done

                keyword_matched=false
                for kw in "${FLAGGED_KEYWORDS[@]}"; do
                    if grep -i -q "$kw" "$file"; then
                        keyword_matched=true
                        break
                    fi
                done

                if [ "$ext_matched" = true ] || [ "$keyword_matched" = true ]
                then
                    echo "$file is malicious and it is DELETED"
                    cp "$file" "$MALICIOUS_DIR/"
                    rm "$file"
                fi
            fi
        done
        ls -l "$DIR" > directory_info.last
    fi
    sleep "$INTERVAL"
done
