#!/bin/bash


figlet "SQLIMASS"
echo "By:FrankoSav"

show_menu() {
    echo "1-> Perform SQL injection test on a URL"
    echo "2-> Perform SQL injection test on multiple URLs"
    echo "3-> Perform SQL injection test on a URL file"
    echo "4-> Exit"
}


while true; do
    show_menu
    read -p "Select A Option: " option
    case $option in
        1)
            read -p "Enter URL " url
            sqlmap -u "$url" --dbs
        ;;
        2)
            read -p "Enter a space-separated list of URLs: " urls
            # temporary file to store urls
            temp_file=$(mktemp)
            
            # adding each URL to a line of the file
            for url in $urls; do
                echo "$url" >> "$temp_file"
            done
            
            # Running SQLMap with the -m option to provide the file URLs
            sqlmap -m "$temp_file" --dbs
            
            # Deleting the temporary file
            rm "$temp_file"
        ;;
        3)
            read -p "Enter the path to the URLs file: " file
            # See if the file works
            if [ ! -f "$file" ]; then
                echo "URL file does not exist"
            else
                # Running SQLMAP with the m parameter to provide the URL file
                sqlmap -m "$file" --dbs
            fi
        ;;
        4)
            exit 0
        ;;
        *)
            echo "Invalid Option"
        ;;
    esac
done
