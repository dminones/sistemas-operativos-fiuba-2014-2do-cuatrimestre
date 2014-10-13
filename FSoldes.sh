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
	ACEPDIR_PATH="$JOB_PATH$ACEPDIR"
	SALDOS_LIS_FILE="saldos.lis"
}

format_bank(){
	NAME=$1
	LINEA=`grep "^$NAME" "$BANCOS_FILE"`
	
#	CODIGO_ENTIDAD=`echo $LINEA | sed 's/^[^;]*;\([^;]*\).*/\1/'`
#	UBIC_CBU=`echo $LINEA | sed 's/^[^;]*;[^;]*;[^;]*;\([^;]*\).*/\1/'`
#	UBIC_SALDO=`echo $LINEA | sed 's/^[^;]*;[^;]*;[^;]*;[^;]*;\([^;]*\).*/\1/'`
	FORMAT_CBU=`echo $LINEA | sed 's/^.*;//'`
	
	FIELD_BLOCK='\([^;]*;\)'
	REPEAT=1
	CODIGO_ENTIDAD=`echo $LINEA | sed "s/^$FIELD_BLOCK\{$REPEAT\}\([^;]*\).*/\2/"`
	
	REPEAT=3
	UBIC_CBU=`echo $LINEA | sed "s/^$FIELD_BLOCK\{$REPEAT\}\([^;]*\).*/\2/"`
	
	REPEAT=4
	UBIC_SALDO=`echo $LINEA | sed "s/^$FIELD_BLOCK\{$REPEAT\}\([^;]*\).*/\2/"`
	
#	echo $LINEA | sed 's/^\([^;]*;\)\{3\}\([^;]*\).*/\2/'
#	echo "$UBIC_SALDO"	
}

processFile(){
	FILE=$1	
	log 'processFile' 'info' "Archivo a procesar:$FILE"
	BANCO=`echo $FILE | sed 's/_.*$//'`
	echo "banco: $BANCO"
	FECHA=`echo $FILE | sed 's/^.*_//'`
	format_bank "$BANCO"
	echo "banco:$BANCO,entidad:$CODIGO_ENTIDAD ubic_cbu:$UBIC_CBU, ubic_saldo:$UBIC_SALDO, format_cbu:$FORMAT_CBU"
	
#	while read LINE;
#	do
#		echo "$LINE";
#	done < "$ACEPDIR_PATH$FILE"
}

#por ahora solo paso como parametro LINE. Los otros datos los uso "globales". 
#si despues aparece la necesidad lo cambio
processLine(){
	LINEA=$1
	
}

processAllFiles(){
	FILES=`ls "$ACEPDIR_PATH"`
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
