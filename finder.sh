#!/bin/bash

source=$1
target=$2

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    echo "finder.sh <sourcedir> <targetdir>"
    exit 1
fi

#echo "[*] Finding files by keyword in name"
#for keyword in $(cat keywords.txt)
#do
#    echo "Keyword: $keyword"
#    upkeyword="$(tr '[:lower:]' '[:upper:]' <<< ${keyword:0:1})${keyword:1}"
#    mkdir $target/FicheroNombre$upkeyword
#    find $source -iname "*$keyword*" | parallel cp -r {} $target/FicheroNombre$upkeyword/
#    if [ "$(ls -A $target/FicheroNombre$upkeyword)" ]; then
#        echo "OK"
#    else
#        echo "No files found"
#        touch $target/FicheroNombre$upkeyword/NingunFicheroEncontrado.txt
#    fi
#done

#echo "[*] Finding files by extension"
#for extension in $(cat extensions.txt)
#do
#    echo "Extension: $extension"
#    upextension="$(echo ${extension} | tr [:lower:] [:upper:])"
#    mkdir $target/FicheroExtension$upextension
#    find $source -iname "*.$extension" | parallel cp -r {} $target/FicheroExtension$upextension/
#    if [ "$(ls -A $target/FicheroExtension$upextension)" ]; then
#        echo "OK"
#    else
#        echo "No files found"
#        touch $target/FicheroExtension$upextension/NingunFicheroEncontrado.txt
#    fi
#done

echo "[*] Finding files by content but only checking files with extension"
include="" 
for extension in $(cat extensions.txt)
do
    includes="$includes --include=\"*.$extension\""
done
for keyword in $(cat keywords.txt)
do
    echo "Keyword: $keyword"
    upkeyword="$(tr '[:lower:]' '[:upper:]' <<< ${keyword:0:1})${keyword:1}"
    mkdir $target/FicheroContenido$upkeyword
    eval grep $keyword -l $includes -r $source | parallel cp -r {} $target/FicheroContenido$upkeyword/
    if [ "$(ls -A $target/FicheroContenido$upkeyword)" ]; then
        echo "OK"
    else
        echo "No files found"
        touch $target/FicheroContenido$upkeyword/NingunFicheroEncontrado.txt
    fi
done
