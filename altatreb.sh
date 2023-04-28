#!/bin/bash
# AUTOR: PABLO SIERRA VERSION: 1.0
#--------------------------------------------
# altatreb.sh 
#--------------------------------------------
#############################################
# Script para dar de alta usuarios, grupos 
# y estructurar los directorios que estan 
# el en fichero
# pasado por parámtro.
#############################################

# AYUDA
Help()
{
echo -e "\e[32mMODO DE EMPLEO: altatreb.sh <file.txt>\e[0m"
echo -e "\e[36mFUNCIÓN:\e[0m Script para dar de alta usuarios, grupos y estructurar los directorios que estan el en fichero pasado por parámtro."
echo -e "\e[36mOPCIONES:\e[0m NONE"
echo -e "\e[36mPARÁMETROS:\e[0m <file.txt> "
echo -e "\e[36mCONDICIONES:\e[0m Ejecutar como root"


}
while getopts ":h" option; do
	case $option in
		h)Help
		exit;;
	esac
done
if [ $# -ne 1 ] 
then
   echo -e "\e[1;31mPosa un fitxer d'usuaris de parametre\e[0m" >&2
   Help
   exit
fi
##SI NO SE ES ROOT SALIR
if [ "$EUID" -ne 0 ]
then 
	echo "\e[1;32mPor favor, ejecute como ROOT\e[0m"
  Help
  exit
fi

##COMPROBAR RAIZ USUARIO
if ! [ -d "/usuaris" ]
then
	mkdir /usuaris
	chmod 770 /usuaris
fi
##COMPROBAR RAIZ PROJECTOS
if ! [ -d "/projectes" ]
then
	mkdir /projectes
	chmod 770 /projectes
fi

groupadd usuario

chgrp usuario /
chgrp usuario /projectes

let cont=0
while read linia 
do
	if [ $cont -gt 0 ]
	then 
		IFS=$':' 
		read dni nom tel dep pro <<< $linia

		##PARTE USUARIO RAIZ
		if ! [ -d "/usuaris/$dep" ]
		then
			groupadd $dep
			
			mkdir /usuaris/$dep
			chgrp $dep /usuaris/$dep
			useradd -m -d /usuaris/$dep/$dni $dni -g $dep
			usermod -G usuario $dni
			chmod 770 /usuaris/$dep
		else
			if [ -d "/usuaris/$dep/$dni" ]
			then
				echo "\e[1;31mEl usuario "$dni "ya existe\e[0m" >&2
		 	else
		 		useradd -m -d /usuaris/$dep/$dni $dni -g $dep
		 		usermod -G usuario $dni
		 	fi
		fi
		chgrp usuario /usuaris
		##PARTE PROJECTOS RAIZ
		IFS=,
		for elem in $pro
		do
		 	if ! [ -d "/projectes/$elem" ]
			then
				groupadd $elem
				gpasswd -r $elem
				mkdir /projectes/$elem
				chmod 770 /projectes/$elem
				chgrp $elem /projectes/$elem
			fi
			gpasswd -a $dni $elem
				
		done

	fi
	cont=$(($cont+1))				
done < $1















