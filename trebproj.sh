
#!/bin/bash
# AUTOR: PABLO SIERRA VERSION: 1.0
#--------------------------------------------
# trebproj.sh 
#--------------------------------------------
#############################################
# Script que recibe un proyecto por parametro 
# y pone al usuario en el directorio de trabajo 
# del proyecto, modifica su grupo activo, nos 
# dice el tiempo que ha estado en el proyecto 
# cuando efectua un EXIT y vuelve a poner el 
# grupo activo anterior
#############################################

# AYUDA
Help()
{
echo -e "\e[32mMODO DE EMPLEO: trebproj.sh <proyecto>\e[0m"
echo -e "\e[36mFUNCIÓN:\e[0m SScript que recibe un proyecto por parametro y pone al usuario en el directorio de trabajo del proyecto, modifica su grupo activo, nos dice el tiempo que ha estado en el proyecto cuando efectua un EXIT y vuelve a poner el grupo activo anterior"
echo -e "\e[36mOPCIONES:\e[0m NONE"
echo -e "\e[36mPARÁMETROS:\e[0m <proyecto> "
echo -e "\e[36mCONDICIONES:\e[0m Cualquier usuario dado de alta"


}
while getopts ":h" option; do
	case $option in
		h)Help
		exit;;
	esac
done

if [ $# -ne 1 ] 
then
   echo -e "\e[1;31mPonga un proyecto como argumento\e[0m" >&2
   Help
   exit
fi
## si no exite el proyecto ERROR, y hacemos cambio al directorio principal de trabajo (linkeamos)
if ! [ -d "/projectes/$1" ]
then
   echo -e "\e[1;31mEl proyecto no existe\e[0m" >&2
   Help
   exit
fi

user=`whoami`
ln -s $HOME /projectes/$1/$user

cd /projectes/$1


time newgrp $1
