#!/bin/bash

WHERE='Initier.sh'
GRUPOCONF="$GRUPO/conf"
ARCHIVOCONF="$GRUPOCONF/Deployer.conf"
echo_y_log(){
LOGFILE= "$LOGDIR/log.txt"
WHAT=$1
WHAT=$2
WHY=$3
LOGMESSAGE= "$1;$2;$3"
echo -e $LOGMESSAGE | cat >> $LOGFILE
}

verificarAmbiente(){
AMBIENTE=false
if [ ]
then

AMBIENTE=true
fi
export $AMBIENTE
}

iniciarVariablesDeAmbiente(){
}

cheackearInstalacion(){
instalacion="SI"
ARCHIVOBANCOS="$MAEDIR/bancos.dat"
if ! [-f "$ARCHIVOBANCOS"]
	then export instalacion="NO"
	echo_y_log INFO "Falta el archivo bancos.dat. Instale nuevamente"
fi

ARCHIVOCAMARAS="$MAEDIR/camaras.dat"
if ! [-f "$ARCHIVOCAMARAS"]
	then export instalacion="NO"
	echo_y_log INFO "Falta el archivo camaras.dat. Instale nuevamente"
fi

ARCHIVOPJN="$MAEDIR/pjn.dat"
if ! [-f "$ARCHIVOPJN"]
	then export instalacion="NO"
	echo_y_log INFO "Falta el archivo pjn.dat. Instale nuevamente"
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
if [ $respuesta = 'Si']
	ejecutarRecept
echo "Recept corriendo. Para deternerlo ejecute el comando Stop.sh"
else echo_y_log INFO "Recept no activado. Si quiere arrancarlo ejecute el comando ./Debut.sh"
}

ejecutarRecept(){
./Recept.sh &
echo_y_log "Recept corriendo. Si quiere detenerlo ejecute el comando ./Stop.sh"
log log "Recept corriendo bajo el no. : <Process Id de Recept>"

}

verificarAmbiente
if[$AMBIENTE=false]
	then
	echo "Inicilizando ambiente"
	inicializarVariablesDeAmbiente
	log "Initier" "Informative" "Inicio de Initier"
	log "Initier" "Informative" "Inicializando ambiente"
	checkearInstalacion
	if[$instalacion = "NO"]
		then echo "Instalacion incompleta.Falta un archivo. Por favor, verifique e intenten nuevamente."	
		else
		darPermisos
		arrancarRecept
		fi
echo_y_log"Ambiente ya inicializado, si quiere reiniciar, termine su sesion e ingrese nuevamente."
fi
log "Initier" "Informative" "Fin de Initier"
cerrarArchivoDeLogYTerminarProceso
