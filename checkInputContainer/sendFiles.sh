#!/bin/bash

string=$1
directory=$2
IFS=',' read -ra elements <<< "$string" 

cp $directory/${elements[0]} .
cp $directory/${elements[1]} . 

#crea due array separando i file R1 dagli R2