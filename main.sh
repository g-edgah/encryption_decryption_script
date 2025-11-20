#!/bin/bash

#loading environment variables
if [ -f ".env" ]; then
     set -a  # Automatically export all variables
     source .env
     set +a  # Stop auto-exporting
fi

FOLDER="$FOLDER"


source ./lib/decrypt.sh
source ./lib/encrypt.sh

current_dir="$PWD"


main() {
    while true; do
        echo ""
        echo "what would you like to do?"
        echo "  1. encryption"
        echo "  2. decryption"
        echo -e "  3. exit\n"
        read -p "select an option [1/2/3]: " -r
        echo ""
        

        # encryption
        if [[ $REPLY == 1 ]]; then
            encryption

        #decryption
        elif [[ $REPLY == 2 ]]; then
            decryption

        #exit  
        elif [[ $REPLY == 3 ]]; then
            echo ""
            echo "exiting program"
            break

        elif [[ -z "$REPLY" ]]; then
            echo -e "\n no option selected. please pick an option \n"

        else
            echo -e "\n invalid option. please pick an option from those provided \n"
        fi
    done
}

main