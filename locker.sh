#!/usr/bin/bash

usage() {
    clear
    echo -e "\033[1;35m╔══════════════════════════════════════╗\033[0m"
    echo -e "\033[1;35m║         \033[1;36m🔒 FILE LOCKER TOOL🔒        \033[1;35m║\033[0m"
    echo -e "\033[1;35m╚══════════════════════════════════════╝\033[0m"
    echo
    echo -e "\033[1;33mDescription:\033[0m"
    echo -e "  \033[1;37mA simple utility to encrypt and decrypt files using OpenSSL\033[0m"
    echo
    echo -e "\033[1;36mUsage:\033[0m \033[1;37mlocker.sh [OPTION]\033[0m"
    echo
    echo -e "\033[1;32mOptions:\033[0m"
    echo -e "  \033[1;34m-lock, -l\033[0m      \033[1;37mEncrypt a file with password protection\033[0m"
    echo -e "  \033[1;34m-unlock, -u\033[0m    \033[1;37mDecrypt a previously encrypted file\033[0m"
}

if [[ "$1" == "-lock" || "$1" == "-l" ]]; then 
    read -p "enter the file name you wish to encrypt: "  file 

    if [[ ! -f "$file" ]]; then
        echo "No such file"
        exit 1
    fi
    echo "File exists"

    read -s -p "Enter your password here: " password
    echo     
    read -s -p "Enter your password again: " confirm_pass
    echo

    if [[ "$password" != "$confirm_pass" ]]; then
        echo "Passwords do not match"
        exit 1
    fi
    echo 

    echo "Encrypting File....."
    if openssl enc -aes-256-cbc -pbkdf2 -salt \
        -pass pass:"$password" \
        -in "$file" -out "$file".enc; then
        
        rm -f "$file"
        echo "File encrypted successfully: $file.enc"

    else
        echo "Encryption failed"
    fi

elif [[ "$1" == '-unlock' || "$1" == "-u" ]]; then
    read -p "enter the file name you wish to decrypt without .enc: "  file 

    if [[ ! -f "$file.enc" ]]; then 
        echo "No such file"
        exit 1
    fi
    
        echo 
        read -s -p "Enter the password: " password
        echo

        echo "Decrypting file...."
        if openssl enc -d -aes-256-cbc -pbkdf2 \
            -pass pass:"$password" \
            -in "$file".enc -out "$file"; then 

            rm -f "$file".enc
            echo "File decrypted successfully"
        else
            rm -f "$file"
            echo "Wrong Password"
        fi

elif [[ -z "$1" || "$1" == '-h' ]]; then 
    usage

else
    echo "Invalid option."

fi