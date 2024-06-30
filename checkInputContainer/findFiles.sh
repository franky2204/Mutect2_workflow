#!/bin/bash

# Percorso della cartella contenente i file
folder_path=$1
string=""

# Itera attraverso i file nella cartella
for file in "$folder_path"/*; do #cicla ogni file della cartella
	if [[ $file =~ 1.f ]]; then #controlla il file contenga nel nome R1, da controllare 
		r2_file="${file/1.f/2.f}" #crea una stringa rimpiazzando R1 con R2, da controllare 
		if [ -f "$r2_file" ]; then #controlla chge esista un file con lo stesso nome
			file=$(basename "$file") 
			r2_file=$(basename "$r2_file")
			if [ -n "$string" ]; then #se string non è vuota
				string="$string,\"$file,$r2_file\"" #aggiunge i nomi dei due file separati da una virgola e li attacca dietro gli altri
			else
				string="\"$file,$r2_file\"" #aggiunge i nomi dei due file senza estensione separati da una virgola
			fi
		fi
	fi
done
echo "{\"value\": [$string]}" #ritorna una stringa del tipo "value": ["a1R1.xyz,a1R2.xyz","a2R1.xyz,a2R2.xyz"...]
