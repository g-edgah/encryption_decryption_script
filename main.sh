#!/bin/bash

#loading environment variables
if [ -f ".env" ]; then
     set -a  # Automatically export all variables
     source .env
     set +a  # Stop auto-exporting
fi

FOLDER="$FOLDER"
KEY="$KEY"

source ./lib/decrypt.sh
source ./lib/encrypt.sh


main() {
    while true; do
        echo "what would you like to do?"
        echo "  1. encryption"
        echo "  2. decryption"
        echo "  3. exit"
        read -p "select an option [1/2/3]: " -r
        
        if [[ $REPLY == 1 ]]; then
           while true; do
                echo "encrypting"
                echo "encrypt?"
                echo "  1. entire folder"
                echo "  2. file(s)"
                echo "  3. exit"
                read -p "select an option [1/2/3]: " -r

                if [[ $REPLY == 1 ]]; then
                elif [[ $REPLY == 2]]; then
                elif [[ $REPLY == 3]]; then
                elif [[ -z "$REPLY" ]]; then
                    echo -e "\n no option selected. please pick an option \n"
                else
                    echo -e "\n invalid option. please pick an option from those provided \n"
                fi
            done
            break
        elif [[ $REPLY == 2 ]]; then
            while true; do
                echo "decrypting"
                echo "decrypt?"
                echo "  1. entire folder"
                echo "  2. file(s)"
                echo "  3. exit"
                read -p "select an option [1/2/3]: " -r

                if [[ $REPLY == 1 ]]; then
                elif [[ $REPLY == 2]]; then
                elif [[ $REPLY == 3]]; then
                elif [[ -z "$REPLY" ]]; then
                    echo -e "\n no option selected. please pick an option \n"
                else
                    echo -e "\n invalid option. please pick an option from those provided \n"
                fi
            done
            break
        elif [[ $REPLY == 3 ]]; then
            echo "exiting"
            break
        elif [[ -z "$REPLY" ]]; then
            echo -e "\n no option selected. please pick an option \n"
        else
            echo -e "\n invalid option. please pick an option from those provided \n"
        fi
    done
}

main