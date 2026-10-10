#!/bin/bash
DIR="$1"
MALICIOUS_DIR="$2"

while true
do 
    i=1
    for file in "$MALICIOUS_DIR"/*
    do 
        if [ -f "$file" ]
        then
            filename=$(basename "$file")
            echo "$i: $filename"
            i=$((i + 1))
        fi
    done

    read -p "Choose a file: " choice

    i=1
    selected_file=""
    for file in "$MALICIOUS_DIR"/*
    do
        if [ -f "$file" ]
        then
            if [ "$i" -eq "$choice" ]
            then
                selected_file=$(basename "$file")
                break
            fi
            i=$((i + 1))
        fi
    done

    if [ -n "$selected_file" ]
    then
        echo "For $selected_file:"
        echo "1: Restore this file back into dir (it was a false positive)"
        echo "2: Permanently delete this file from malicious_dir (it was genuinely malicious)"
        echo "3: Go back "
        read -p "> " action_choice

        case "$action_choice" in
            1)
                mv "$MALICIOUS_DIR/$selected_file" "$DIR/"
                echo "Restored $selected_file to $DIR."
                ;;
            2)
                rm "$MALICIOUS_DIR/$selected_file"
                echo "$selected_file permanently deleted."
                break
                ;;
            3)
                continue
                ;;
            *)
                echo "Invalid choice."
                ;;
        esac
    else
        echo "Invalid selection."
    fi
    echo ""
done
        

