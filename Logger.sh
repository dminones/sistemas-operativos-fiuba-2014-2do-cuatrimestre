#functions
start_paths(){
	JOB_PATH="../../Documents/facultad/sistemasOperativos/tp/"
	EXTENSION=".log"
}

log(){
	start_paths
	FILE=$1
	WHERE=$2
	DATETIME=`date +'%Y/%m/%d %T'`
	CODE=$3
	DESCRIPTION=$4
	FILE_PATH="$JOB_PATH$FILE$EXTENSION"
	MESSAGE="$DATETIME - $USER - $WHERE - $CODE - $DESCRIPTION"
	echo "$MESSAGE" >> "$FILE_PATH"
}

# codigo de ejecucion
log "$@"
