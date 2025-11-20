#!/bin/bash

if [ -f ".env" ]; then
     set -a  # Automatically export all variables
     source .env
     set +a  # Stop auto-exporting
fi

KEY="$KEY"

encrypt_file() {
    file=$1
    echo "encrypting $file"
    if [[ $KEY ]]; then
        gpg --batch --yes --passphrase "$KEY" -c --cipher-algo AES256 $file
        #rm -f $file
    elif [[ ! $KEY ]]; then
        echo -e "no predefined key provided"
        gpg --batch --yes -c --cipher-algo AES256 $file
    fi
}