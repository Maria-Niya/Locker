#!/usr/bin/bash

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

fi