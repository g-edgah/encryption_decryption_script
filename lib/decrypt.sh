#!/bin/bash

if [ -f ".env" ]; then
     set -a  # Automatically export all variables
     source .env
     set +a  # Stop auto-exporting
fi

KEY="$KEY"

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