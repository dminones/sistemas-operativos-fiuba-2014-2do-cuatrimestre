#!/bin/bash

WHERE='Deployer.sh'
TRUE=1
FALSE=0

# Funciones

echo_y_log()
{
	WHAT=$1
	WHY=$2
	echo $WHY
	log $WHERE $WHAT $WHY
}

log()
{
	echo Log: $1 $2 $3
	# bash log.sh $1 $2 $3
}

# Chequea si se inicio anteriormente la instalacion
checkear_instalacion()
{
	echo $FALSE
}

# Pregunta que valores deben tomar las variables al usuario
preguntar_variables()
{
	FIN=$FALSE
	while [ $FIN -eq $FALSE ]
	do
		echo_y_log INFO "Defina el directorio de intralacion de los ejecutables ($BINDIR):"
		BINDIR=$(leer_o_default $BINDIR)
		echo_y_log INFO "Defina el directorio para maestros y tablas ($MAEDIR):"
		MAEDIR=$(leer_o_default $MAEDIR)
		echo_y_log INFO "Defina el directorio para el arribo del flujo de novedades ($NOVEDIR):"
		NOVEDIR=$(leer_o_default $NOVEDIR)
		echo_y_log INFO "Defina espacio minimo libre para el arribo de novedades en Mbytes ($DATASIZE):"
		DATASIZE=$(leer_o_default $DATASIZE)
		# chekear_espacio
		echo_y_log INFO "Defina el directorio para las Novedades aceptadas ($ACEPDIR):"
		ACEPDIR=$(leer_o_default $ACEPDIR)
		echo_y_log INFO "Defina el directorio de grabacion de los Pedidos e Informes de Salida ($REPODIR):"
		REPODIR=$(leer_o_default $REPODIR)
		echo_y_log INFO "Defina el directorio de grabacion de Archivos rechazados ($RECHDIR):"
		RECHDIR=$(leer_o_default $RECHDIR)
		echo_y_log INFO "Defina el directorio de logs ($LOGDIR):"
		LOGDIR=$(leer_o_default $LOGDIR)
		echo_y_log INFO "Defina el nombre del SubDirectorio de Resguardo de Archivos Duplicados ($DUPDIR):"
		DUPDIR=$(leer_o_default $DUPDIR)
		FIN=$TRUE
	done
}

# Pregunta una variable y espera la respuesta
leer_o_default()
{
	DEFAULT=$1
	read LEIDO
	log $WHERE INFO $LEIDO
	if [ $LEIDO != \n ]
	then
		echo $LEIDO
	else
		echo $DEFAULT
	fi
	
}

# Programa principal

# Variables con valores default
GRUPO=./grupo
CONFDIR=$GRUPO/conf
BINDIR=$GRUPO/bin
MAEDIR=$GRUPO/data
NOVEDIR=$GRUPO/flux
DATASIZE=100
ACEPDIR=$GRUPO/ok
REPODIR=$GRUPO/demande
RECHDIR=$GRUPO/nok
LOGDIR=$GRUPO/log
DUPDIR=$GRUPO/dup

Hola=es
preguntar Hola Estas?
echo Variable: $Hola
echo_y_log INFO "Inicio de Ejecucion de Deployer"
echo_y_log INFO "Log de la instalacion: $CONFDIR/Deployer.log"
echo_y_log INFO "Directorio predefinido de Configuración: $CONFDIR"
if [ $TRUE -eq $(checkear_instalacion) ]
then
	echo 1 Nothing for now...
else
	# chekear_terminos
	# chekear_perl
	preguntar_variables
fi
