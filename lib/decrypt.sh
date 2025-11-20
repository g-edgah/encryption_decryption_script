#!/bin/bash

if [ -f ".env" ]; then
     set -a  # Automatically export all variables
     source .env
     set +a  # Stop auto-exporting
fi

KEY="$KEY"

process_folder_decryption() {
    folder=$1
    read -p "decrypt folder $1 [Y/n]?: " confirmation
    if [[ $confirmation =~ ^[Yy]$ ]] || [[ -z $confirmation ]]; then
        for file in "${folder[@]}"; do
            decrypt_file "$file"
            echo "$file"
        done
    elif [[ $confirmation =~ ^[Nn]$ ]]; then
        echo  -e "decryption cancelled"
    else
        echo -e "invalid option"
    fi
}


decrypt_file() {
    file=$1
    echo "decrypting $file"
    if [[ $KEY ]]; then
        gpg --batch --yes --passphrase "$KEY" -o "${file%.gpg}" -d --cipher-algo AES256 $file
        rm -f $file
    elif [[ ! $KEY ]]; then
        echo -e "no predefined key provided"
        gpg --batch --yes -o "${file%.gpg}" -d --cipher-algo AES256 $file
    fi
}

decryption() {
    while true; do
               
        echo -e "\ndecrypt?"
        echo "  1. entire folder"
        echo "  2. file(s)"
        echo "  3. exit decryption"
        echo -e "  4. exit program\n"
        read -p "select an option [1/2/3]: " -r
        echo ""

        if [[ $REPLY == 1 ]]; then
            if [[ -d $FOLDER ]]; then
                process_folder_decryption $FOLDER
            elif [[ ! -d $FOLDER ]]; then
                while true; do
                    read -p "no folder specified. enter path of folder containing files: " input_folder
                    if [[ -d $input_folder ]]; then
                        process_folder_decryption input_folder
                    elif [[ ! -d $input_folder ]]; then
                        echo "folder specified does not exist"
                    fi
                done

            fi
        elif [[ $REPLY == 2 ]]; then
            undecrypted_files=()
            undecrypted_files_no=1
            while true; do
                read -p "enter relative or full path of file $undecrypted_files_no (type 'done' when all files have been specified): " filepath

                if [[ -z "$filepath" ]]; then
                    echo -e "\n no input provided \n"
                    continue
                elif [[ "$filepath" == "done" ]]; then
                    echo "done collecting files to decrypt"
                    break
                elif [[ -f "$filepath" ]]; then
                    files+=("$filepath")
                    ((undecrypted_files_no++))
                elif [[ ! -f "$filepath" ]]; then
                    echo " file not found: $filepath"
                fi
            done

            echo ""
            read -p "decrypt files [Y/n]: " confirm

            if [[ $confirm =~ ^[Yy]$ ]] || [[ -z $confirm ]]; then
                for file in "${files[@]}"; do
                    decrypt_file "$file"
                    echo "$file"
                done
            elif [[ $confirm =~ ^[Nn] ]]; then
                echo  -e "encryption cancelled"
            else
                echo -e "invalid option"
            fi

        elif [[ $REPLY == 3 ]]; then
            echo "exiting decryption"
            break
        elif [[ $REPLY == 4 ]]; then
            echo "exiting program"
            exit
        elif [[ -z "$REPLY" ]]; then
            echo -e "\n no option selected. please pick an option \n"
        else
            echo -e "\n invalid option. please pick an option from those provided \n"
        fi
    done
}