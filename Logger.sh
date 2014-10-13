######
#params:

#1)filename
#2)where
#3)code
#4)description

######

#functions
start_paths(){
	JOB_PATH="../../Documents/facultad/sistemasOperativos/tp/"
	EXTENSION=".log"
}

count_lines(){
	FILE=$1
	if [ -f $FILE ]; then #se fija si existe el archivo de log
		LIMIT=30
		LINES_TO_DELETE='1,5d'
		LINES=`wc -l < $FILE`
		if [ $LINES -ge $LIMIT ]; then
			sed -i "$LINES_TO_DELETE" "$FILE"
		fi
	fi
}

log(){
	start_paths
	FILE=$1
	FILE_PATH="$JOB_PATH$FILE$EXTENSION"
	count_lines "$FILE_PATH"
	
	WHERE=$2
	DATETIME=`date +'%Y/%m/%d %T'`
	CODE=$3
	DESCRIPTION=$4
	MESSAGE="$DATETIME - $USER - $WHERE - $CODE - $DESCRIPTION"
	echo "$MESSAGE" >> "$FILE_PATH"
}


# codigo de ejecucion
log "$@"
