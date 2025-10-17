#!/usr/bin/bash
RED='\033[1;31m'    # Errors
GREEN='\033[1;32m'  # Success
CYAN='\033[1;36m'   # Prompts
NC='\033[0m'       #no colour

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
    read -p "$(echo -e "${CYAN}enter the file name you wish to encrypt: ${NC}")"  file 

    if [[ ! -f "$file" ]]; then
        echo -e "${RED}Error: No such file$"
        exit 1
    fi
    echo -e "${GREEN}File exists${NC}"

    read -s -p "$(echo -e "${CYAN}Enter your password here:${NC}") " password
    echo     
    read -s -p "$(echo -e "${CYAN}Enter your password again:${NC}") " confirm_pass
    echo

    if [[ "$password" != "$confirm_pass" ]]; then
        echo -e "${RED}Passwords do not match${NC}"
        exit 1
    fi
    echo 

    echo -e "${CYAN}Encrypting File.....${NC}"
    if openssl enc -aes-256-cbc -pbkdf2 -salt \
        -pass pass:"$password" \
        -in "$file" -out "$file".enc; then
        
        rm -f "$file"
        echo -e "${GREEN}File encrypted successfully: $file.enc${NC}"

    else
        echo -e "${RED}Encryption failed ${NC}"
    fi

elif [[ "$1" == '-unlock' || "$1" == "-u" ]]; then
    read -p "$(echo -e "${CYAN}enter the file name you wish to decrypt without .enc:${NC}") "  file 

    if [[ ! -f "$file.enc" ]]; then 
        echo _e "${RED}No such file${NC}"
        exit 1
    fi
    
        echo 
        read -s -p "$(echo -e "${CYAN}Enter the password: ${NC}")" password
        echo

        echo -e "${CYAN}Decrypting file....${NC}"
        if openssl enc -d -aes-256-cbc -pbkdf2 \
            -pass pass:"$password" \
            -in "$file".enc -out "$file"; then 

            rm -f "$file".enc
            echo -e"${GREEN}File decrypted successfully ${NC}"
        else
            rm -f "$file"
            echo -e"${RED}Wrong Password ${NC}"
        fi

elif [[ -z "$1" || "$1" == '-h' ]]; then 
    usage

else
    echo -e"${RED}Invalid option.${NC}"

fi