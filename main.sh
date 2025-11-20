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

                    if [[ -d $FOLDER ]]; then
                        read -p "encrypt folder $FOLDER [Y/n]?: " folder
                        if [[ $folder =~ ^[Yy]$ ]] || [[ -z $folder ]]; then
                            for file in "${folder[@]}"; do
                                encrypt_file "$file"
                                echo "$file"
                            done
                        elif [[ $confirm =~ ^[Nn] ]]; then
                            echo  -e "encryption cancelled"
                        else
                            echo -e "invalid option"
                        fi
                    elif [[ ! -d $FOLDER ]]; then
                        read -p "no folder specified. enter path of folder containing files: " input_folder
                        if 

                    fi

                elif [[ $REPLY == 2 ]]; then
                    files=()
                    i=1
                    while true; do
                        read -p "enter relative or full path of file $i: " filepath

                        if [[ -z "$filepath" ]]; then
                            echo -e "\n no input provided \n"
                            continue
                        elif [[ "$filepath" == "done" ]]; then
                            echo "done collecting files to encrypt"
                            break
                        elif [[ -f "$filepath" ]]; then
                            files+=("$filepath")
                            ((i++))
                        elif [[ ! -f "$filepath" ]]; then
                            echo " file not found: $filepath"
                        fi
                    done

                    read -p "encrypt files [Y/n]: " confirm

                    if [[ $confirm =~ ^[Yy]$ ]] || [[ -z $confirm ]]; then
                        for file in "${files[@]}"; do
                            encrypt_file "$file"
                            echo "$file"
                        done
                    elif [[ $confirm =~ ^[Nn] ]]; then
                        echo  -e "encryption cancelled"
                    else
                        echo -e "invalid option"
                    fi


                elif [[ $REPLY == 3 ]]; then
                    console "something"
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
                    echo "1"
                elif [[ $REPLY == 2 ]]; then
                    echo "2"
                elif [[ $REPLY == 3 ]]; then
                    echo "3"
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