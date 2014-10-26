#!/bin/bash

#.Logger
GRUPO_PATH="$HOME/grupo05"
GRUPO_CONF="$GRUPO/conf"
ARCHIVO_CONF="$GRUPO/Deployer.conf"

readonly K_FALSE=0
readonly K_TRUE=1

log(){
LOGFILE= "$LOGDIR/log.txt"
WHERE='Initier.sh'
WHEN= date #falta hora
WHO=$USER
WHAT=$1
WHY=$(echo "$2"| sed 's-\\n-\n-')
log $WHEN $WHERE $WHO $WHAT "$WHY"
}

ambienteEstaSeteado(){
local SETEADO=$K_TRUE

GRUPO_PATH="variable"
GRUPO_CONF="variable"
ARCHIVO_CONF="variable"
BINDIR="variable"
MAEDIR="variable"
NOVEDIR="variable"
DATASIZE="variable"
ACEPDIR="variable"
REPODIR="variable"
RECHDIR="variable"
LOGDIR="variable"
DUPDIR="variable"

if [ -z $GRUPO_PATH ] || [ -z $GRUPO_CONF ] || [ -z $ARCHIVO_CONF ] || [ -z $BINDIR ] || [ -z $MAEDIR ] || [ -z $NOVEDIR ] || [ -z $DATASIZE ] || [ -z $ACEPDIR ] || [ -z $REPODIR ] || [ -z $RECHDIR ] || [ -z $LOGDIR ] || [ -z $DUPDIR ];
then
	SETEADO=$K_FALSE
fi

echo "$SETEADO"

#AMBIENTE=false
#if [ -v GRUPO_PATH -a -v GRUPO_CONf -a -v ARCHIVO_CONF -a -v BINDIR -a -v MAEDIR -a -v #NOVEDIR -a -v DATASIZE -a -v ACEPDIR -a -v REPODIR -a -v RECHDIR -a -v LOGDIR -a -v #DUPDIR]
#then AMBIENTE=true
#fi
#export $AMBIENTE
}

iniciarVariablesDeAmbiente(){  # falta todo
IFS=$'\n'
for record in $(<$ARCHIVO_CONF)
do var
	log INFO "TP SO7508 Segundo Cuatrimestre 2014. Tema E Copyright Grupo 05"
	log INFO "Directorio Configuracion: $GRUPO_CONF (mostrar path y listar archivos)"
	log INFO "Directorio Ejecutables: $BINDIR (mostrar path y listar archivos)"
	log INFO "Directorio Tablas:$MAEDIR"
	log INFO "Directorio Flujo de Novedades: $NOVEDIR"
	log INFO "Directorio Novedades Aceptadas: $ACEPDIR"
	log INFO "Directorio Pedidos y Informes de Salida: $REPODIR"
	log INFO "Directorio Archivos Rechazados: $RECHDIR"
	log INFO "Directorio de Log de Comandos: $LOGDIR"
	log INFO "SubDirectorio de Resguardo de Archivos Duplicados: $DUPDIR"
	log INFO "Estado del Sistema: Inicializado"
done
}


cheackearInstalacion(){
instalacion="SI"
ARCHIVOBANCOS="$MAEDIR/bancos.dat"
if ! [-f "$ARCHIVOBANCOS"]
	then export instalacion="NO"
	log INFO "Falta el archivo bancos.dat. Instale nuevamente"
	echo "Falta el archivo bancos.dat. Instale nuevamente"
fi

ARCHIVOCAMARAS="$MAEDIR/camaras.dat"
if ! [-f "$ARCHIVOCAMARAS"]
	then export instalacion="NO"
	log INFO "Falta el archivo camaras.dat. Instale nuevamente"
	echo "Falta el archivo camaras.dat. Instale nuevamente"
fi

ARCHIVOPJN="$MAEDIR/pjn.dat"
if ! [-f "$ARCHIVOPJN"]
	then export instalacion="NO"
	log INFO "Falta el archivo pjn.dat. Instale nuevamente"
	echo "Falta el archivo pjn.dat. Instale nuevamente"
fi
}

darPermisos(){
ACCESO="$BINDIR/*"
for file in $ACCESO
do
	if [ "$file" != "ACCESO" ]
	then 
		chmod +x "$file"
	fi
done
}

arrancarRecept(){
echo "Desea efectuar la activacion del Recept?" Si - No
read respuesta
if [ $respuesta = 'Si'];
then
	ejecutarRecept
else 
	log INFO "Recept no activado. Si quiere arrancarlo ejecute el comando ./Debut.sh"
	echo "Recept no activado. Si quiere arrancarlo ejecute el comando ./Debut.sh"
fi
}

ejecutarRecept(){
./Recept.sh &
echo "Recept corriendo. Si quiere detenerlo ejecute el comando ./Stop.sh"
log INFO "Recept corriendo bajo el no. : <Process Id de Recept>. Si quiere detenerlo ejecute el comando ./Stop.sh"

}

AMBIENTE_SETEADO=`ambienteEstaSeteado`
if [ $AMBIENTE_SETEADO -eq $K_TRUE ];
then
	echo "Ambiente ya inicializado, si quiere reiniciar termine su sesion e ingrese nuevamente"
else
	echo "no inicializado"
fi


#if[$AMBIENTE=false]
#	then
#	echo "Inicilizando ambiente"
#	inicializarVariablesDeAmbiente
#	log INFO "Inicio de Initier"
#	log INFO "Inicializando ambiente"
#	checkearInstalacion
#	if[$instalacion = "NO"]
#		then log ERR"Instalacion incompleta.Falta un archivo. Por favor, verifique e intenten nuevamente."
#		echo "Instalacion incompleta.Falta un archivo. Por favor, verifique e intenten nuevamente."	
#		else
#		darPermisos
#		arrancarRecept
#		fi
#log ERR "Ambiente ya inicializado, si quiere reiniciar, termine su sesion e ingrese nuevamente."
#echo "Ambiente ya inicializado, si quiere reiniciar, termine su sesion e ingrese nuevamente."
#fi
#log "Initier" "Informative" "Fin de Initier"
#cerrarArchivoDeLogYTerminarProceso # falta todo
