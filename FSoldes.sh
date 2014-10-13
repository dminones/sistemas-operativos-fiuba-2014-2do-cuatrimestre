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
	MAEDIR_PATH="$JOB_PATH$MAEDIR"
	ACEPDIR="acepdir/"
	BANCOS="bancos.dat"
	BANCOS_FILE="$JOB_PATH$MAEDIR$BANCOS"
	LOG_FILE="logdir/FSoldes"
	ACEPDIR_PATH="$JOB_PATH$ACEPDIR"
	SALDOS_LIS_FILE="saldos.lis"
	SALDOS_DIR="$MAEDIR_PATH""saldos/"
}

format_bank(){
	NAME=$1
	LINEA=`grep "^$NAME" "$BANCOS_FILE"`
	FORMAT_CBU=`getLastCsvField "$LINEA"`	
	CODIGO_ENTIDAD=`getCsvFieldNumber "$LINEA" 2`
	UBIC_CBU=`getCsvFieldNumber "$LINEA" 4`
	UBIC_SALDO=`getCsvFieldNumber "$LINEA" 5`
}

#$1:linea, $2:numero de campo
getCsvFieldNumber(){
	typeset FIELD_BLOCK='\([^;]*;\)'
	typeset REPEAT=`expr $2 - 1`
	echo $1 | sed "s/^$FIELD_BLOCK\{$REPEAT\}\([^;]*\).*/\2/"
}

#$1:linea
getLastCsvField(){
	echo $1 | sed 's/^.*;//'
}

processFile(){
	FILE=$1	
	log 'processFile' 'info' "Archivo a procesar:$FILE"
	BANCO=`echo $FILE | sed 's/_.*$//'`
	FECHA=`echo $FILE | sed 's/^.*_//'`
	format_bank "$BANCO"
	echo "banco:$BANCO,entidad:$CODIGO_ENTIDAD, ubic_cbu:$UBIC_CBU, ubic_saldo:$UBIC_SALDO, format_cbu:$FORMAT_CBU"
	
	while read LINE;
	do
#		echo "$LINE";
		processLine "$LINE";
	done < "$ACEPDIR_PATH$FILE"
}

#por ahora solo paso como parametro LINE. Los otros datos los uso "globales". 
#si despues aparece la necesidad lo cambio
processLine(){
	LINEA=$1
	echo "$FILE" >> "$SALDOS_DIR$SALDOS_LIS_FILE"
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
