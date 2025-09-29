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

    ls | grep "$file"
    if [[ $? -eq 0 ]]; then 
        echo "File exists"

        echo "Enter your password here "
        read -s password
        echo "Enter your password again "
        read -s confirm_pass

        if [[ "$password" == "$confirm_pass" ]]; then
            echo "Yayy you entered the password correctly"
            openssl enc -aes-256-cbc -pbkdf2 -salt \
            -pass pass:"$password" \
            -in "$file" -out "$file".enc
        
            rm "$file"
        else
            echo "Wrong password inputted"
        fi

    else
        echo "No such file"
    fi

elif [[ "$1" == '-unlock' || "$1" == "-u" ]]; then
    read -p "enter the file name you wish to decrypt without .enc: "  file 

    ls | grep "$file"
    if [[ "$?" -eq 0 ]]; then 
        echo "Enter the password" 
        read -s password
        openssl enc -d -aes-256-cbc -pbkdf2 \
        -pass pass:"$password" \
        -in "$file".enc -out "$file"

        if [[ "$?" -eq 0 ]]; then 
            echo "File unlocked"
            rm "$file".enc
        else
            echo "Wrong Password"
        fi

    else
        echo "File doesnt exist"
    
    fi

elif [[ -z "$1" ]]; then 
    usage

else
    echo "wrong argument"

fi