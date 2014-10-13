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
	ACEPDIR="acepdir/"
	BANCOS="bancos.dat"
	BANCOS_FILE="$JOB_PATH$MAEDIR$BANCOS"
	LOG_FILE="logdir/FSoldes"
}

format_bank(){
	NAME=$1
	LINEA=`grep "^$NAME" "$BANCOS_FILE"`
#	ENTIDAD=`echo $LINEA | sed 's/;.*//'`
#	CODIGO_ENTIDAD=`echo $LINEA | sed 's/[^;]*;\([^;]*\).*/\1/'`
	UBIC_CBU=`echo $LINEA | sed 's/^[^;]*;[^;]*;[^;]*;\([^;]*\).*/\1/'`
	UBIC_SALDO=`echo $LINEA | sed 's/^[^;]*;[^;]*;[^;]*;[^;]*;\([^;]*\).*/\1/'`
	FORMAT_CBU=`echo $LINEA | sed 's/^.*;//'`
#	log "format_bank()" "inf" "formateando banco: $ENTIDAD"
}

processFile(){
	FILE=$1	
	log 'processFile' 'info' "Archivo a procesar:$FILE"
	BANCO=`echo $FILE | sed 's/_.*$//'`
	echo "banco: $BANCO"
	FECHA=`echo $FILE | sed 's/^.*_//'`
	format_bank "$BANCO"
	echo "banco:$BANCO, ubic_cbu:$UBIC_CBU, ubic_saldo:$UBIC_SALDO, format_cbu:$FORMAT_CBU"
}

processAllFiles(){
	FILES=`ls "$JOB_PATH$ACEPDIR"`
	for FILE_ITEM in $FILES;
	do
		processFile "$FILE_ITEM"
	done
}

log(){
	WHERE=$1
	CODE=$2
	DESCRIPTION=$3
	./Logger.sh "$LOG_FILE" "$WHERE" "$CODE" "$DESCRIPTION"
}

# codigo de ejecucion
start_paths
log 'fsoldes' 'info' 'Inicio de FSoldes'
processAllFiles
