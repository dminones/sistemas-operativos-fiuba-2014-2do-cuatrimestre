#!/bin/bash

WHERE='Initier.sh'

log(){
WHAT=$1
WHY=$2
echo $WHY
log $WHERE $WHAT "WHY"
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
	log "Initier" "Informative" "Falta el archivo bancos.dat. Instale nuevamente"
	echo "Falta el archivo bancos.dat. Instale nuevamente"
fi

ARCHIVOCAMARAS="$MAEDIR/camaras.dat"
if ! [-f "$ARCHIVOCAMARAS"]
	then export instalacion="NO"
	log "Initier" "Informative" "Falta el archivo camaras.dat. Instale nuevamente"
	echo "Falta el archivo camaras.dat. Instale nuevamente"
fi

ARCHIVOPJN="$MAEDIR/pjn.dat"
if ! [-f "$ARCHIVOPJN"]
	then export instalacion="NO"
	log "Initier" "Informative" "Falta el archivo pjn.dat. Instale nuevamente"
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
		cantParametros=$#
		parametroUno=$1
		arrancarRecept
		fi
else log "Initier" "Informative" "Ambiente ya inicializado, si quiere reiniciar termine su sesion e ingrese nuevamente."
echo "Ambiente ya inicializado, si quiere reiniciar, termine su sesion e ingrese nuevamente."
fi
log "Initier" "Informative" "Fin de Initier"
cerrarArchivoDeLogYTerminarProceso
