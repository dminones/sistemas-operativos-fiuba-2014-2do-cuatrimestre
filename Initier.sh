#!/bin/bash

ARCHIVOCONF="$GRUPOCONF/Deployer.conf"
log(){
LOGFILE= "$LOGDIR/log.txt"
WHERE='Initier.sh'
WHEN= date #falta hora
WHO=$USER
WHAT=$1
WHY=$2
}

verificarAmbiente(){ # falta comando
AMBIENTE=false
if [ -v ARCHIVOCONF -a -v BINDIR -a -v MAEDIR -a -v NOVEDIR -a -v DATASIZE -a -v ACEPDIR -a -v REPODIR -a -v RECHDIR -a -v LOGDIR -a -v DUPDIR]
then

AMBIENTE=true
fi
export $AMBIENTE
}

iniciarVariablesDeAmbiente(){  # falta todo
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
if [ $respuesta = 'Si']
	ejecutarRecept
else log INFO "Recept no activado. Si quiere arrancarlo ejecute el comando ./Debut.sh"
echo "Recept no activado. Si quiere arrancarlo ejecute el comando ./Debut.sh"
}

ejecutarRecept(){
./Recept.sh &
echo "Recept corriendo. Si quiere detenerlo ejecute el comando ./Stop.sh"
log INFO "Recept corriendo bajo el no. : <Process Id de Recept>. Si quiere detenerlo ejecute el comando ./Stop.sh"

}

verificarAmbiente
if[$AMBIENTE=false]
	then
	echo "Inicilizando ambiente"
	inicializarVariablesDeAmbiente
	log INFO "Inicio de Initier"
	log INFO "Inicializando ambiente"
	checkearInstalacion
	if[$instalacion = "NO"]
		then log ERR"Instalacion incompleta.Falta un archivo. Por favor, verifique e intenten nuevamente."
		echo "Instalacion incompleta.Falta un archivo. Por favor, verifique e intenten nuevamente."	
		else
		darPermisos
		arrancarRecept
		fi
log ERR "Ambiente ya inicializado, si quiere reiniciar, termine su sesion e ingrese nuevamente."
echo "Ambiente ya inicializado, si quiere reiniciar, termine su sesion e ingrese nuevamente."
fi
log "Initier" "Informative" "Fin de Initier"
cerrarArchivoDeLogYTerminarProceso # falta todo
