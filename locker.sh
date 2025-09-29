#!/usr/bin/bash

if [[ "$1" == "-lock" || "$1" == "-l" ]]; then 
    echo "Enter your password here "
    read -s password
    echo "Enter your password again "
    read -s confirm_pass

    if [[ "$password" == "$confirm_pass" ]]; then
        read -p "enter the file name you wish to encrypt: "  file 

        ls | grep "$file"
        if [[ $? -eq 0 ]]; then 
            echo "File exists"
        else
            echo "No such file"
        fi

        echo "Yayy you entered the password correctly"
    else
        echo "Wrong password inputted"
    fi
fi
