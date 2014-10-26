Trabajo Práctico de Sistemas Operativos
===============================================

COMO COPIAR DESDE UN MEDIO EXTERNO EL INSTALABLE:
1) Insertar el dispositivo de almacenamiento con el contenido del TP
2) Crear en el directorio corriente un directorio de trabajo
3) Copiar el archivo *.tgz en ese directorio 
4) Descomprimir el *.tgz de manera de generar un *.tar
5) Extraer los archivos del tar. 

INSTALACION
b) Instrucciones de instalación
c) Que se requiere para poder instalar, Que nos deja la instalación y donde

EJECUTAR CDOSSIER
d) Cuáles son los primeros pasos para poder correr el paquete una vez instalado
e) Que comprobaciones se pueden hacer para asegurar que todo está en condiciones para 
empezar

FRENAR EJECUCION DE COMANDOS
f) Como frenar la ejecución de comandos 




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
