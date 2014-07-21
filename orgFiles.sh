#!/bin/bash
# Aprendendo a organizar arquivos espalhados

log_path="$HOME/log.txt" 
arquivo=$(zenity --entry --text "Que tipo de arquivo deseja procurar?")

if [ -n "$arquivo" ] ; then
#Busca somente na pasta local do usuário, mas pode ser alterado
	find $HOME -name "$arquivo" \
	    | tee >(zenity --progress --text "Procurando" --pulsate --auto-close)\
	    >$log_path

	echo $(zenity --info --text "Encontrado `awk 'END { print NR }' $log_path` ocorrências")

	pasta=$(zenity --file-selection --title "Pra onde deseja movê-los?" --directory)

	if [ -n "$pasta" ] ; then
		while read linha 
		do 
		   mv -f "$linha" $pasta
		done < $log_path
		rm $log_path
		echo $(zenity --notification --text "Movido com sucesso para $pasta" --window-icon="info" )
	else
		echo $(zenity --info --text "Cancelado pelo usuário")
	fi
fi

unset arquivo
unset pasta
unset log_path