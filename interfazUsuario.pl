#!/bin/perl
# Biblioteca de funciones para la interfaz de usuario
# require "./accesoDatos.pl";

sub introduction(){
	print "Sistema Liste para consultas. TP Sistemas Operativos - 2°2014 - Grupo 9\n";
	print "\n";
}

sub startMenu(){	
	print "#######################################################################\n";
	print "#      Elija una opcion, y presione ENTER para continuar:             #\n";
	print "#######################################################################\n";
	print "#      1- Elaboración de informes              			      #\n";
	print "#      2- Elaboración de pedidos                                      #\n";
	print "#      3- Ayuda			    				      #\n";
	print "#              			    				      #\n";
	print "#      0- Salir                        				      #\n";	
	print "#######################################################################\n";	
}

sub menuInfo(){
	my $archivo; 
	my $error;
	$error="0";
	while ($error eq "0"){
		print "Archivo a consultar: \n";
		#modificar el tema del path
		$archivo = "/home/lucio/Escritorio/tp/".<STDIN>;
		chomp($archivo);
		if (-e $archivo){
			open (ENTRADA,"<$archivo");
			$error="1";
		}else {
			&printArchNoExiste;
		}			
	}
	return ENTRADA;
}

sub printArchivo(){
	($salida,%exp)=@_;
	foreach $key (keys(%exp)){
		$value = $exp{$key};
		chomp($value);
		print $salida "$key;$value\n";
	}
}

sub printArchNoExiste() {
	print "ERROR: El archivo no existe.\n";
}

1;