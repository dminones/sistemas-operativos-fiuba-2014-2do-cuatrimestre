use strict;
use warnings;
use Fcntl qw(:flock);

&clearScr;
print "Inicio $0\n";
&canExecute;
&menuOption;
print "Fin $0\n";
&clearScr;

#################  Menu  #############################
#Genera el menu del proceso Liste
sub menuOption() {
	my($option);
	$option = "\n";
	print "Liste\n";
	while($option ne "0\n"){
		print "\n";
		print "1- Elaboración de informes\n";
		print "2- Elaboración de pedidos\n";
		print "\n";
		print "0- Finalizar\n";
		$option = <STDIN>;
		&clearScr;
		if($option eq "1\n"){
			&menuInfo;
			$option = "0\n"; 
		}elsif ($option eq "2\n"){
			&menuPedido;
			$option = "0\n";
		}elsif($option ne "0\n"){
			print "Opción incorrecta. Elija otra opción:\n";
		}	
	}
}

sub menuInfo() {

}

sub menuPedido() {
	my($option);
	$option = "\n";
	while($option ne "0\n"){
		print "Liste\n";
		print "\n";
		print "1- Por embargo\n";
		print "2- Por información de saldo\n";
		print "3- Por liberación\n";
		print "4- Por asignación\n";		
		print "5- Por nivel de urgencia\n";		
		print "\n";
		print "0- Finalizar\n";
		$option = <STDIN>;
		&clearScr;	
	}
}

#################  Validation  #######################
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

##################  Auxiliar  #########################
#Limpia la pantalla
sub clearScr(){
	print "\033[2J";
	print "\033[0;0H";
}

#######################################################

__DATA__
