#!/bin/bash
# Aprendendo a organizar arquivos espalhados

log_path="/home/$USER/LOGS/log.txt" 
arquivo=$(zenity --entry --text "Que tipo de arquivo deseja procurar?")

#Busca somente na pasta local do usuário
find /home/arthur/ -name "$arquivo" \
    | tee >(zenity --progress --text "Procurando" --pulsate --auto-close)\
     >/home/arthur/LOGS/log.txt

echo $(zenity --info --text "Encontrado `awk 'END { print NR }' $log_path` ocorrências")

pasta=$(zenity --file-selection --title "Pra onde deseja movê-los?" --directory)

if [ -n "$pasta" ] ; then
	while read linha 
	do 
	   mv -f "$linha" $pasta
	done < $log_path
	echo $(zenity --notification --text "Movido com sucesso para $pasta" --window-icon="info" )
else
	echo $(zenity --info --text "Cancelado pelo usuário")
fi

unset arquivo
unset pasta