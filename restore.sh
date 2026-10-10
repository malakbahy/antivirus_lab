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
            echo "$i) $filename"
            i=$((i + 1))
        fi
    done

    echo "Enter the number of the file you want to restore (or 'q' to quit):"
    read choice

    if [ "$choice" = "q" ]
    then
        break
    fi

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

    if [ -n "$selected_file" ]; then
        echo "Choose an action for '$selected_file':"
        echo "1) Restore this file back into $DIR"
        echo "2) Permanently delete this file from $MALICIOUS_DIR"
        echo "3) Leave this file as-is"
        read action_choice

        case "$action_choice" in
            1)
                mv "$MALICIOUS_DIR/$selected_file" "$DIR/"
                echo "Restored $selected_file to $DIR."
                ;;
            2)
                rm "$MALICIOUS_DIR/$selected_file"
                echo "$selected_file permanently deleted."
                ;;
            3)
                echo "Leave this file as-is."
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
        

