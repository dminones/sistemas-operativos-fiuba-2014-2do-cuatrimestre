#!/bin/perl
# Biblioteca de funciones auxiliares
use Fcntl qw(:flock);

#Verifica si se puede ejecutar el proceso Liste
sub canExecute(){
	&isRunning;
	&isInitialized;
}

#Verifica que el ambiente este inicializado
sub isInitialized(){
}

#Verifica que no haya un proceso Liste en ejecucion
sub isRunning(){
	unless (flock(DATA, LOCK_EX|LOCK_NB)) {
	    print "$0 ya se encuenra en ejecución.\n";
	    exit(1);
	}
}

#Limpia la pantalla
sub clearScr(){
	print "\033[2J";
	print "\033[0;0H";
}

1;

__DATA__