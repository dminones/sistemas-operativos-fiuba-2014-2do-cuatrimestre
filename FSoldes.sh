#######
#formato bancos.dat:

#1)entidad
#2)codigo_entidad
#3)descripcion_entidad
#4)ubicacion del CBU
#5)ubicacion del Saldo
#6)formato del CBU

#######


#functions
start_paths(){
	JOB_PATH="../../Documents/facultad/sistemasOperativos/tp/"
	MAEDIR="maedir/"
	BANCOS="bancos.dat"
	BANCOS_FILE="$JOB_PATH$MAEDIR$BANCOS"
	LOG_FILE="logdir/FSoldes"
}

format_bank(){
	NAME=$1
	LINEA=`grep "^$NAME" "$BANCOS_FILE"`
	echo "$LINEA"
	ENTIDAD=`echo $LINEA | sed 's/;.*//'`
	CODIGO_ENTIDAD=`echo $LINEA | sed 's/[^;]*;\([^;]*\).*/\1/'`
	UBIC_CBU=`echo $LINEA | sed 's/[^;]*;[^;]*;[^;]*;\([^;]*\).*/\1/'`
	UBIC_SALDO=`echo $LINEA | sed 's/[^;]*;[^;]*;[^;]*;[^;]*;\([^;]*\).*/\1/'`
	FORMAT_CBU=`echo $LINEA | sed 's/.*;//'`
}

# codigo de ejecucion
start_paths
format_bank $1
