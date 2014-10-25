Trabajo Práctico de Sistemas Operativos
===============================================

1)LOGGER
En el script hay que incluir el archivo logger, y despues se llama a la funcion log
ejemplo:

#importar
. Logger

#loggear
log "$LOG_FILE" "$WHERE" "$CODE" "$DESCRIPTION"

params:
1)filename: ruta con la carpeta a partir de $grupo/ y sin la extension (ej: logdir/FSoldes, conf/Deployer)
2)where
3)code
4)description

2) CsvParser
Hay que importarlo, y despues tiene dos metodos

-getCsvFieldNumber ($1:linea, $2:numero de campo)
-getLastCsvField ($1:linea)

ejemplos:
. CsvParser
FORMAT_CBU=`getLastCsvField "$LINEA"`	
CODIGO_ENTIDAD=`getCsvFieldNumber "$LINEA" 2`

3) Ayuda de archivos
#importar
. utilidadArchivo
#copiar
copiar "$LOG_DIR" "$LOG_NAME" "$DUP_DIR" "$FILE_NAME" "$DIR_1" "$DIR_2"
#mover
mover "$LOG_DIR" "$LOG_NAME" "$DUP_DIR" "$FILE_NAME" "$DIR_1" "$DIR_2"

parametros:
1. directorio donde se encuentra el log (1º param de la funcion log)
2. where del log
3. nombre de la carpeta donde se van a poner los archivos duplicados (valor de $DUP_DIR)
4. nombre del archivo a copiar/mover
5. path completo del origen
6. path completo del destino

PD: no logre importar la funcion log dentro de esta :P
