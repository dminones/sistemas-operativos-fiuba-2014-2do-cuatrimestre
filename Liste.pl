#!/usr/bin/perl
use warnings;
use Fcntl qw(:flock);

&clearScr;
&canExecute;
&menuOption;
&clearScr;

#################  Menu  #####################################
#Genera el menu del proceso Liste
sub menuOption() {
	my($option);
	$option = "\n";
	print "Liste\n";
	while($option ne "0"){
		print "\n";
		print "1- Elaboración de informes\n";
		print "2- Elaboración de pedidos\n";
		print "\n";
		print "0- Finalizar\n";
		$option = <STDIN>;
		chomp($option);
		&clearScr;
		if($option eq "1"){
			&menuInfo;
			$option = "0"; 
		}elsif ($option eq "2"){
			&menuPedido;
			$option = "0";
		}elsif($option ne "0"){
			print "Opción incorrecta. Elija otra opción:\n";
		}	
	}
}
################################################################
################################################################
sub menuInfo() {
	my %expedientes = &getExpedientesArchivo;

	my($error);
	my($fin); $fin="";
	while($fin ne "q"){
		$error = "0";
		while ($error eq "0"){
			print "Escribir consulta: \n";
			$query = <STDIN>;
			chomp($query);
			$res = &validarQuery($query);
			if($res ne ""){
				print "Los parametros para filtrar $res no existen.\n";
			}else {
				$error = "1";
			}
		}
		
		$error = "0";
		my($option);
		while ($error eq "0"){
			print "Desea guardar el informe?(S/N):\n";
			$option = <STDIN>;
			chomp($option);
			if($option ne "S" && $option ne "s" && $option ne "N" && $option ne "n"){
				print "No existe esa opcion.\n";
			}else {
				if($option eq "S" || $option eq "s"){
					#Guardar los registros en un archivo
				} else {
					#Imprimir por pantalla los registros
				}
			}
		}
	}	
}

#################################################################
sub getExpedientesArchivo(){
	my($archivo,$query);
	my($error);
	$error="0";
	while ($error eq "0"){
		print "Archivo a consultar: \n";
		#modificar el tema del path
		$archivo = "/home/lucio/Documentos/sistemas/repodir/".<STDIN>;
		chomp($archivo);
		if (-e $archivo){
			open (ENTRADA,"<$archivo");
			$error="1";
		}else {
			print "ERROR: El archivo no existe.\n";
		}			
	}
	my %expedientes;
	# &clearScr;
	while ($linea=<ENTRADA>)
	{	
		my($key,$value);
		$key = substr($linea,0,index($linea,";"));
		$value = substr($linea,index($linea,";")+1,length($linea)-index($linea,";")-1);
		$expedientes{$key}=$value;
	}
	
	return %expedientes;
}

#################################################################
sub validarQuery(){
	my($consulta) = @_;
	my($resultado);
	$resultado = "";
	@data = split(" ",$consulta);
	#cam = camara
	#trib= tribunal
	#exp = expediente
	#est = estado
	#sal = saldo
	for($i=0;$i<$#data;$i = $i+2){
		if($data[$i] ne "cam" &&
		   $data[$i] ne "trib" &&  
		   $data[$i] ne "exp" &&  
		   $data[$i] ne "exp" &&
		   $data[$i] ne "sal"){
		   	if($resultado eq ""){
				$resultado = $data[$i];
		   	}else {
				$resultado = $resultado.", ".$data[$i];
		   	}
		}
	}
	return $resultado;
}

#################################################################
#################################################################
sub menuPedido() {
	my($option);
	$option = "\n";
	while($option ne "0"){
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
		chomp($option);
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
