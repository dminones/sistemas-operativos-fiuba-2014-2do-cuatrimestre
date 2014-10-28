Trabajo Práctico de Sistemas Operativos
	Grupo 05 (2do cuatrimestre - 2014)
===============================================

COMO COPIAR DESDE UN MEDIO EXTERNO EL INSTALABLE:

1) Insertar el dispositivo de almacenamiento con el contenido del TP
2) Crear en el directorio corriente un directorio de trabajo
3) Copiar el archivo grupo05.tgz en ese directorio
4) Ir al directorio de trabajo
5) Ejecutar: tar -zxvf grupo05.tgz

INSTALACION:

Requerimientos para poder instalar:

- Haber extraido el archivo grupo05.tar en el directorio de trabajo (Ver COMO COPIAR DESDE UN MEDIO EXTERNO EL INSTALABLE)
- Perl versión 5 o superior

Para instalar, desde la consola:

1) Ir al directorio de trabajo
2) Ir a la carpeta "tp"

cd $grupo/tp

3) Ejecutar Deployer
IMPORTANTE: Todos los directorios que se piden son relativos al directorio de trabajo

./Deployer

4) Puede pasar algunos de los siguentes:
4.1) Instalacion Completa: El script se cierra
4.2) Instalacion Incompleta: Decidir si se continua la instalacion, sigue en el punto 8
4.3) Instalacion Inexistente: Sigue en el punto siguente

5) Aceptar términos y condiciones
6) Definir directorios y variables cuando lo pida
7) Confirmar estructura de directorios (sino se confirma vuelve al punto 6)
8) Confirmar inicio de instalación

PARA EJECUTAR INITIER:

Desde la consola:

1) Ir al directorio de trabajo

cd $grupo/

2) Ir al directorio de instalación de los ejecutables

cd $grupo/bin

3) Ejecutar Initier

. ./Initier

4) Decidir si quiere ejecutar Recept

PARA EJECUTAR RECEPT:

Desde la consola:

1) Ir al directorio de trabajo
2) Ir al directorio de instalación de los ejecutables
3) Ejecutar: Debut Recept

PARA DETENER RECEPT:

Desde la consola:

1) Ir al directorio de trabajo
2) Ir al directorio de instalación de los ejecutables
3) Ejecutar: Stop Recept

PARA EJECUTAR FSOLDES:

Desde la consola:

1) Ir al directorio de trabajo
2) Ir al directorio de instalación de los ejecutables
3) Ejecutar: Debut FSoldes

PARA EJECUTAR CDOSSIER:

Desde la consola:

1) Ir al directorio de trabajo
2) Ir al directorio de instalación de los ejecutables
3) Ejecutar: Debut Cdossier

PARA EJECUTAR LISTE:

Desde la consola:

1) Ir al directorio de trabajo
2) Ir al directorio de instalación de los ejecutables
3) Ejecutar Liste

Debut "Liste.pl"

Que se requiere para poder instalar, Que nos deja la instalación y donde

d) Cuáles son los primeros pasos para poder correr el paquete una vez instalado
e) Que comprobaciones se pueden hacer para asegurar que todo está en condiciones para
empezar

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
