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