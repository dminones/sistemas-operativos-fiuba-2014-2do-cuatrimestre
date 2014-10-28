#!/bin/perl
# Biblioteca de funciones para la interfaz de usuario
require $includeDir."accesoDatos.pl";
require $includeDir."accesoArchivo.pl";
use feature qw(switch);
use POSIX qw(strftime);

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
		print "Seleccione el archivo a consultar: \n";
		#modificar el tema del path
		$archivo = "$repodir".<STDIN>;
		chomp($archivo);
		if (-e $archivo || $archivo eq ""){
			open (ENTRADA,"<$archivo");
			$error="1";
		}else {
			&printArchNoExiste($archivo);
		}			
	}
	return ENTRADA;
}

sub menuPedido(){
	my $archivo; 
	my $error;
	$error="0";
	my @archivos;
	while ($error eq "0"){
		print "Seleccione el o los archivos para hacer pedidos. Utilizar \",\" para separar los nombres de los archivos : \n";
		$archivo = <STDIN>;
		chomp($archivo);
		@archivos = split(",",$archivo);
		foreach (@archivos){
			if (-e "$repodir$_" || $_ eq ""){
				$error = "1";
			}else {
				$error="0";
				&printArchNoExiste($_);
				last;
			}
		}			
	}
	return @archivos;
}

sub printArchivo(){
	($salida,%exp)=@_;
	foreach $key (keys(%exp)){
		$value = $exp{$key};
		chomp($value);
		print $salida "$key;$value\n";
	}
}

sub mostrarArchivosRepodir() {
	my ($directorio) = @_;
	my @files;
	if(opendir(REPODIRH,"$directorio")){
		@files=readdir(REPODIRH);
		close(REPODIRH);
	}
	
	foreach (@files){
		if($_ ne "." && $_ ne ".." && (-f $directorio.$_)){
		  print $_."\n";
		}
	}
}

sub mostrarArchivos(){
	system("clear");
	print "\n";
	print"Los archivos para consultar se encuentran en $repodir y son: \n";
	print "\n";
	&mostrarArchivosRepodir($repodir);
	print "\n";
}

sub deseaFiltrar(){
	my ($filtro) = @_;
	system("clear");
	print "\n";
	while($stdin ne "S" && $stdin ne "N" && $stdin ne "s" && $stdin ne "n"){
		my $pedido;
		given($filtro) {
			when("expediente") { print "Desea filtrar por expediente? (S/N):\n"; }
			when("camara") { print "Desea filtrar por camara? (S/N):\n"; }
			when("tribunal") { print "Desea filtrar por tribunal? (S/N):\n"; }
			when("estado") { print "Desea filtrar por estado? (S/N):\n"; }
			when("embargo") { 
				print "Desea filtrar por pedido de embargo? (S/N):"; 
				$pedido = "1"; 
			}
			when("infoSaldo") { 
				print "Desea filtrar por pedido de informacion de saldo? (S/N):";
				$pedido = "1"; 
			}
			when("liberacion") { 
				print "Desea filtrar por pedido de liberacion? (S/N):"; 
				$pedido = "1"; 
			}
			when("cumplimiento") { 
				print "Desea filtrar por pedido de cumplimiento? (S/N):"; 
				$pedido = "1"; 
			}
		}
		
 		my $stdin = <STDIN>;
		chomp($stdin);
		if(($stdin eq "S" || $stdin eq "s") && $pedido ne "1"){
			given($filtro){
				when("expediente") { &deseaFiltrarExpediente; }
				when("camara") { &deseaFiltrarCamara; }
				when("tribunal") { &deseaFiltrarTribunal; }
				when("estado") { &deseaFiltrarEstado; }
			}
			$stdin = <STDIN>;
			return $stdin;
		} elsif (($stdin eq "S" || $stdin eq "s") && $pedido eq "1"){
			return "S"
		} elsif ($stdin eq "N" || $stdin eq "n"){
			return "";
		} else {
			system("clear");
			print "\n";
			print "Opcion incorrecta. Debe elegir S si quiere desea filtrar o N si no quiere filtrar.\n";
			print "\n";
		}
	}
}

sub deseaFiltrarExpediente(){
	print "\n";
	print "- Si desea filtrar por mas de un expediente escribir con el formato exp1,exp2,...,expN\n";
	print "  y presionar ENTER.\n";
	print "- Si desea filtrar por un expediente escribir exp1 y presionar ENTER.\n";
	print "- El formato del expediente es de la forma X/Y donde X es un numero de varios digitos e Y es un solo digito..\n";
	print "- El expediente sera filtrado solo si es ingresado correctamente y si existe.\n";
	print "\n";
	print "Seleccione el expediente: \n";
}

sub deseaFiltrarCamara(){
	print "\n";
	print "- Si desea filtrar por mas de una camara escribir con el formato cam1,cam2,...,camN\n";
	print "  y presionar ENTER.\n";
	print "- Si desea filtrar por una camara escribir cam1 y presionar ENTER.\n";
	print "\n";
	print "Las camaras existentes son:\n";
	
	open (CAMARAS,$maedir."camaras.dat");
	while($linea = <CAMARAS>){
		($cod) = split(";",$linea);
		print $cod."\n";
	}
	print "\n";
	print "Si no hay ningun registro con la camara seleccionada no se filtrara nada.\n";
	print "Seleccione la camara: \n";
}

sub deseaFiltrarTribunal(){
	print "\n";
	print "- Si desea filtrar por mas de un tribunal escribir con el formato trib1,trib2,...,tribN\n";
	print "  y presionar ENTER.\n";
	print "- Si desea filtrar por un tribunal escribir trib1 y presionar ENTER.\n";
	print "\n";
	print "Los tribunales existentes son:\n";
	
	open (TRIBUNALES,$maedir."pjn.dat");
	while($linea = <TRIBUNALES>){
		($cod) = split(";",$linea);
		print $cod."\n";
	}
	print "\n";
	print "Si no hay ningun registro con el tribunal seleccionado no se filtrara nada.\n";
	print "Seleccione el tribunal: \n";
}

sub deseaFiltrarEstado(){
	print "\n";
	print "- Si desea filtrar por mas de un estado escribir con el formato est1,est2,...,estN\n";
	print "  y presionar ENTER.\n";
	print "- Si desea filtrar por un estado escribir est1 y presionar ENTER.\n";
	print "\n";
	print "Los estados existentes son:\n";
	print "EN GESTION\n";
	print "SIN CUENTA ASOCIADA\n";
	print "REMITIDO\n";
	print "CUMPLIMIENTO\n";
	print "A DESPACHO\n";
	print "EN CASILLERO\n";
	print "\n";
	print "Si no hay ningun registro con el estado seleccionado o el mismo es invalido no se filtrara nada.\n";
	print "\n";
	print "Seleccione el estado: \n";
}

sub deseaFiltrarSaldo(){
	system("clear");
	print "\n";
	while($stdin ne "S" && $stdin ne "N" && $stdin ne "s" && $stdin ne "n"){
		print "Desea filtrar por saldo? (S/N):\n";
		my $stdin = <STDIN>;
		chomp($stdin);
		if($stdin eq "S" || $stdin eq "s"){
			while($stdin ne "1" && $stdin ne "2" && $stdin ne "3"){
				system("clear");
				print "\n";
				print "1- Filtrar por rango\n";
				print "2- Filtrar por Mayor\n";
				print "3- Filtrar por Menor\n";
				print "\n";
				$stdin = <STDIN>;
				chomp($stdin);
				if($stdin eq "1"){
					print "\n";
					print "Escriba limite inferior. El separador de decimales es el punto: \n";
					$stdin = <STDIN>;
					chomp($stdin);
					my $return = $stdin.",";
					print "\n";
					print "Escriba limite superior. El separador de decimales es el punto: \n";
					$stdin = <STDIN>;
					chomp($stdin);
					$return = $return.$stdin;
					return $return;
				}
				if($stdin eq "2"){
					print "\n";
					print "Escriba limite minimo. El separador de decimales es el punto: \n";
					$stdin = <STDIN>;
					chomp($stdin);
					return ">".$stdin;
				}
				if($stdin eq "3"){
					print "\n";
					print "Escriba limite maximo. El separador de decimales es el punto: \n";
					$stdin = <STDIN>;
					chomp($stdin);
					return "<".$stdin;
				}
			}
			return $stdin;
		} elsif ($stdin eq "N" || $stdin eq "n"){
			return "";
		} else {
			system("clear");
			print "\n";
			print "Opcion incorrecta. Debe elegir S si quiere desea filtrar o N si no quiere filtrar.\n";
			print "\n";
		}
	}
}

sub preguntarFiltros(){
	my(%expedientes) = @_;
	my %exp;
	
	my $consulta = "Consulta:  ";	
	my $return = &deseaFiltrar("expediente");
	chomp($return);
	if ($return ne ""){
		%exp= &filtraPorParametroDeClave("expediente",$return,%expedientes);
		%expedientes = &clonarHash(%exp);
		$consulta = "$consulta Expediente: $return ";
	}
	
	$return = &deseaFiltrar("camara");
	chomp($return);
	if ($return ne ""){
		%exp= &filtraPorParametroDeClave("camara",$return,%expedientes);
		%expedientes = &clonarHash(%exp);
		$consulta = "$consulta Camara: $return ";
	}
	
 	$return = &deseaFiltrar("tribunal");
	chomp($return);
	if ($return ne ""){
		%exp= &filtraPorParametroDeClave("tribunal",$return,%expedientes);
		%expedientes = &clonarHash(%exp);
		$consulta = "$consulta Tribunal: $return ";
	}
	
 	$return = &deseaFiltrar("estado");
	print $return;
	chomp($return);
	if ($return ne ""){
		%exp= &filtraPorEstado($return,%expedientes);
		%expedientes = &clonarHash(%exp);
		$consulta = "$consulta Estado: $return ";
	}
	
 	$return = &deseaFiltrarSaldo;
	chomp($return);
	if ($return ne ""){
		%exp= &filtraPorSaldo($return,%expedientes);
		%expedientes = &clonarHash(%exp);
		$consulta = "$consulta Saldo: $return ";
	}
	return ($consulta,%expedientes);
}

sub printArchNoExiste() {
	my ($arch) = @_;
	print "ERROR: El archivo $arch no existe.\n";
}

sub deseaGuardar(){
	my ($consulta,%exp) = @_;
	my $stdin = "\n";
	while($stdin ne "S" && $stdin ne "N" && $stdin ne "s" && $stdin ne "n"){
		system("clear");
		print "\n";
		print "Desea guaardar la consulta? (S/N):\n";
		$stdin = <STDIN>;
		chomp($stdin);
		if($stdin eq "S" || $stdin eq "s"){
			print "\n";
			print "Escriba el nombre del archivo:\n";
			my $file = <STDIN>;
			chomp($file);
			open(SALIDA,">$repodir$file");
			&printArchivo(SALIDA,%exp);
			# close(SALIDA);
		} elsif ($stdin eq "N" || $stdin eq "n"){
			print $consulta."\n";
			print "\n";
			foreach (keys(%exp)){
				print $_.";".$exp{$_};
			}
			<STDIN>;
			print "Presione una tecla para continuar...\n";
		} else {
			system("clear");
			print "\n";
			print "Opcion incorrecta. Debe elegir S si quiere desea filtrar o N si no quiere filtrar.\n";
			print "\n";
		}
	}
}

sub deseaContinuar(){
	while($stdin ne "S" && $stdin ne "N" && $stdin ne "s" && $stdin ne "n"){
		system("clear");
		print "\n";
		print "Desea continuar consultando expedientes? (S/N):\n";
		my $stdin = <STDIN>;
		chomp($stdin);
		if($stdin eq "S" || $stdin eq "s"){
			return "0";
		} elsif ($stdin eq "N" || $stdin eq "n"){
			return "1";
		} else {
			system("clear");
			print "\n";
			print "Opcion incorrecta. Debe elegir S si quiere desea filtrar o N si no quiere filtrar.\n";
			print "\n";
		}
	}
}

sub deseaMismoArchivo(){
	my $stdin;
	while($stdin ne "S" && $stdin ne "N" && $stdin ne "s" && $stdin ne "n"){
		system("clear");
		print "\n";
		print "Desea utilizar el mismo archivo de entrada? (S/N):\n";
		$stdin = <STDIN>;
		chomp($stdin);
		if($stdin eq "S" || $stdin eq "s"){
			return "0";
		} elsif ($stdin eq "N" || $stdin eq "n"){
			return "1";
		} else {
			system("clear");
			print "\n";
			print "Opcion incorrecta. Debe elegir S si quiere desea filtrar o N si no quiere filtrar.\n";
			print "\n";
		}
	}
}

sub seleccionarPedido() {
	my($option);
	$option = "\n";
	system("clear");
	while($option ne "0"){
		print "Tipos de pedido\n";
		print "\n";
		print "1- Pedido de embargo\n";
		print "2- Pedido de información de saldo\n";
		print "3- Pedido de liberación\n";
		print "4- Pedido de asignación\n";		
		print "5- Pedido por nivel de urgencia de 0 dias\n";
		print "6- Pedido por nivel de urgencia de 1 dias\n";
		print "7- Pedido por nivel de urgencia de 2 dias\n";
		print "8- Pedido por nivel de urgencia de 4 dias\n";		
		print "\n";
		print "Seleccione el tipo de pedido. Pueden ser uno, varios o todos. El formato es ped1,ped2,...,pedN ";
		print "En el caso de no seleccionar nada se tomara como que se seleccionaron todos.\n";
		
		$option = <STDIN>;
		chomp($option);
		
		while ( ($option lt 1) || ($option gt 8)){
		  print "Opcion incorrecta. Intente nuevamente \n";
		  $option = <STDIN>;
		  chomp($option);
		 }
				
		return $option;
	}
}

sub generarPedido(){
	my($param,%exp)=@_;
	my @opciones = split(",",$param);
	my %exp;
	my %exp1;
	my %exp2;
	my %exp3;
	my %exp4;
	my %exp5;
	my %exp6;
	
	my %expAcumulado;
	my %expTemporal;
	
	foreach (@opciones){
		given($_){
			when("1") {
			  %exp = &filtraPorAccion("PEDIDO URGENTE EMBARGAR CON CBU INFORMADA",%expedientes);
				  %expTemporal = (%expAcumulado,%exp);
				  }
			when("2") {  %exp = &filtraPorAccion("ESPERAR 48 HORAS PARA HACER RECLAMO CON CBU INFORMADA",%expedientes);
				  %expTemporal = (%expAcumulado,%exp);
			}
			when("3") {  %exp = &filtraPorAccion("PEDIDO URGENTE PARA LIBERAR CUENTA",%expedientes);
				  %expTemporal = (%expAcumulado,%exp);
			}
			when("4") { %exp1 = &filtraPorAccion("PEDIDO URGENTE ASIGNAR NUEVA CBU POR CBU INCORRECTA",%expedientes);
				  %exp2 = &filtraPorAccion("PEDIDO ESTÁNDAR DE ASIGNACION DE CUENTA",%expedientes);
				  %exp3 = &filtraPorAccion("ESPERAR 48 HORAS PARA RECLAMAR ASIGNACION DE CUENTA",%expedientes);
				  %exp4 = &filtraPorAccion("ESPERAR 96 HORAS PARA RECLAMAR ASIGNACION DE CUENTA",%expedientes);
				  %exp5 = (%exp1,%exp2);
				  %exp6 = (%exp3,%exp4);
				  %exp1 = (%exp5,%exp6);
				  %expTemporal = (%expAcumulado,%exp1);
				  
			}
			when("5") { %exp1 = &filtraPorAccion("PEDIDO URGENTE EMBARGAR CON CBU INFORMADA",%expedientes);
				  %exp2 = &filtraPorAccion("PEDIDO URGENTE PARA LIBERAR CUENTA",%expedientes);
				  %exp2 = &filtraPorAccion("PEDIDO URGENTE ASIGNAR NUEVA CBU POR CBU INCORRECTA",%expedientes);
				  %exp5 = (%exp1,%exp2);
				  %exp6 = (%exp3,%exp5);
				  %expTemporal = (%expAcumulado,%exp6);
			}
			when("6") { %exp1 = &filtraPorAccion("PEDIDO ESTÁNDAR DE ASIGNACION DE CUENTA",%expedientes);
				  %expTemporal = (%expAcumulado,%exp1);
			}
			when("7") { %exp1 = &filtraPorAccion("ESPERAR 48 HORAS PARA RECLAMAR ASIGNACION DE CUENTA",%expedientes);
				  %exp2 = &filtraPorAccion("ESPERAR 48 HORAS PARA HACER RECLAMO CON CBU INFORMADA",%expedientes);
				  %exp5 = (%exp1,%exp2);
				  %expTemporal = (%expAcumulado,%exp5);
			}
			when("8") { %exp1 = &filtraPorAccion("ESPERAR 96 HORAS PARA RECLAMAR ASIGNACION DE CUENTA",%expedientes); 
				  %expTemporal = (%expAcumulado,%exp1);
			}
		}
		%expAcumulado = %expTemporal;
	}
	return %expAcumulado;
}

sub generarMensajes() {
	my (%exp) = @_;
	my $salida;
	$salida = &deseaGuardarPedidos();
	chomp($salida);
	foreach $key (keys(%exp)){
		&printMensaje($key,$salida,%exp);
	}
	print "Presione una tecla para continuar\n";
	<STDIN>;
}

sub printMensaje() {
	my($key,$salida,%exp) = @_;
	my ($x,$y,$z,$w,$mensaje) = split(";",$exp{$key});
	chomp($mensaje);
	given($mensaje){
		when("PEDIDO URGENTE EMBARGAR CON CBU INFORMADA") { &printEmbargo($salida,$key,$exp{$key}); }
		when("ESPERAR 48 HORAS PARA HACER RECLAMO CON CBU INFORMADA") { &printReclamo48CBU($salida,$key,$exp{$key}); }
		when("PEDIDO URGENTE PARA LIBERAR CUENTA") { &printLiberacion($salida,$key,$exp{$key}); }
		when("PEDIDO URGENTE ASIGNAR NUEVA CBU POR CBU INCORRECTA") { &printAsginacionCBUIncorrecta($salida,$key,$exp{$key}); }
		when("PEDIDO ESTÁNDAR DE ASIGNACION DE CUENTA") { &printEstandarAsginacion($salida,$key,$exp{$key}); }
		when("ESPERAR 48 HORAS PARA RECLAMAR ASIGNACION DE CUENTA") { &print48Asginacion($salida,$key,$exp{$key}); }
		when("ESPERAR 96 HORAS PARA RECLAMAR ASIGNACION DE CUENTA") { &print96Asginacion($salida,$key,$exp{$key}); }
	
	}
}

sub deseaGuardarPedidos(){
	my $stdin = "\n";
	while($stdin ne "S" && $stdin ne "N" && $stdin ne "s" && $stdin ne "n"){
		system("clear");
		print "\n";
		print "Desea guardar la consulta? (S/N):\n";
		$stdin = <STDIN>;
		chomp($stdin);
		if($stdin eq "S" || $stdin eq "s"){
			print "\n";
			print "Escriba el nombre del archivo:\n";
			my $file = <STDIN>;
			chomp($file);
			return $file;
		} elsif ($stdin eq "N" || $stdin eq "n"){
			return "";
		} else {
			system("clear");
			print "\n";
			print "Opcion incorrecta. Debe elegir S si quiere desea filtrar o N si no quiere filtrar.\n";
			print "\n";
		}
	}
}

sub printEmbargo(){
	my ($salida,$key,$value)=@_;
	my $result = &printEncabezado($key,$value);
	my($x,$y,$CBU,,) = split(";",$value);
	$result = $result."\n";
	my $date = getDate("1");
	strftime "%Y/%m/%d", localtime;
	$result = $result."Tema: Pedido de Embargo sobre cuenta bancaria Fecha de Origen: $date Fojas: 1\n";
	$result = $result."Extracto: solicítese en carácter de URGENTE la tramitación de embargo sobre la cuenta bancaria asignada en fojas precedentes: CBU Nro: $CBU\n";
	
	if($salida eq ""){
		print $result;
	} else {
		open(SALIDA,">>$repodir$salida");
		print SALIDA $result;
		close(SALIDA);
	}
}

sub printReclamo48CBU(){
	my ($salida,$key,$value)=@_;
	my $result = &printEncabezado($key,$value);
	my($x,$y,$CBU,,) = split(";",$value);
	$result = $result."\n";
	my $date = &getWorkingDays;
	my ($cod,$banco) = getBanco($CBU);
	
	$result = $result."Tema: Pedido de Información de saldo sobre cuenta bancaria Fecha de Origen: $date Fojas: 1\n";
	$result = $result."Extracto: Solicítese a la Entidad Bancaria $cod $banco que informe diariamente el saldo de la cuenta bancaria asignada en fojas precedentes CBU Nro: $CBU\n";
	
	if($salida eq ""){
		print $result;
	} else {
		open(SALIDA,">>$repodir$salida");
		print SALIDA $result;
		close(SALIDA);
	}
}

sub printLiberacion(){
	my ($salida,$key,$value)=@_;
	
	my $result = &printEncabezado($key,$value);
	my($x,$y,$CBU,,) = split(";",$value);
	$result = $result."\n";
	my $date = strftime "%Y/%m/%d", localtime;
	$result = $result."Tema: Pedido de Liberación de Embargo sobre cuenta bancaria Fecha de Origen: $date Fojas: 1\n";
	$result = $result."Extracto: solicítese en carácter de URGENTE la tramitación de liberación de embargo sobre la cuenta bancaria asignada en fojas precedentes: CBU Nro: $CBU\n";
	
	if($salida eq ""){
		print $result;
	} else {
		open(SALIDA,">>$repodir$salida");
		print SALIDA $result;
		close(SALIDA);
	}
}

sub printAsginacionCBUIncorrecta(){
	my ($salida,$key,$value)=@_;
	my $result = &printEncabezado($key,$value);
	my($x,$y,$CBU,,) = split(";",$value);
	$result = $result."\n";
	my $date = strftime "%Y/%m/%d", localtime;
	$result = $result."Tema: Pedido de Asignación de Cuenta Bancaria Fecha de Origen: $date Fojas: 1\n";
	$result = $result."Extracto: solicítese en carácter de URGENTE la Asignación de una NUEVA cuenta bancaria dado que la asignada en fojas precedentes es inválida: $CBU\n";
	
	if($salida eq ""){
		print $result;
	} else {
		open(SALIDA,">>$repodir$salida");
		print SALIDA $result;
		close(SALIDA);
	}
}

sub printEstandarAsginacion(){
	my ($salida,$key,$value)=@_;
	my $result = &printEncabezado($key,$value);
	my($x,$y,$CBU,,) = split(";",$value);
	$result = $result."\n";
	my $date = getDate(1);
	$result = $result."Tema: Pedido de Asignación de Cuenta Bancaria Fecha de Origen: $date Fojas: 1\n";
	$result = $result."Extracto: solicítese asignación de cuenta bancaria a través de su Clave Bancaria Uniforme (CBU) y pedido de informe diario de saldo sobre dicha cuenta a la entidad bancaria correspondiente.";
	
	if($salida eq ""){
		print $result;
	} else {
		open(SALIDA,">>$repodir$salida");
		print SALIDA $result;
		close(SALIDA);
	}
}

sub print48Asginacion(){
	my ($salida,$key,$value)=@_;
	my $result = &printEncabezado($key,$value);
	my($x,$y,$CBU,,) = split(";",$value);
	$result = $result."\n";
	my $date = getDate(2);
	$result = $result."Tema: Pedido de Liberación de Embargo sobre cuenta bancaria Fecha de Origen: $date Fojas: 1\n";
	$result = $result."Extracto: Reitérese solicitud de asignación de cuenta bancaria a través de su Clave Bancaria Uniforme (CBU) y pedido de informe diario de saldo sobre dicha cuenta a la entidad bancaria correspondiente.\n";
	
	if($salida eq ""){
		print $result;
	} else {
		open(SALIDA,">>$repodir$salida");
		print SALIDA $result;
		close(SALIDA);
	}
}

sub print96Asginacion(){
	my ($salida,$key,$value)=@_;
	my $result = &printEncabezado($key,$value);
	my($x,$y,$CBU,,) = split(";",$value);
	$result = $result."\n";
	my $date = getDate(4);
	$result = $result."Tema: Pedido de Liberación de Embargo sobre cuenta bancaria Fecha de Origen: $date Fojas: 1\n";
	$result = $result."Extracto: Reitérese solicitud de asignación de cuenta bancaria a través de su Clave Bancaria Uniforme (CBU) y pedido de informe diario de saldo sobre dicha cuenta a la entidad bancaria correspondiente.\n";
	
	if($salida eq ""){
		print $result;
	} else {
		open(SALIDA,">>$repodir$salida");
		print SALIDA $result;
		close(SALIDA);
	}
}

sub printEncabezado(){
	my($key,$value) = @_;
	
	my($exp,$cam,$trib) = split(";",$key);
	my($nomb,$x,$y,$z,$W) = split(";",$value);
	my $result;
	
	$result = "\n";	
	my $cod; my $camNomb;
	open (CAMARAS,$maedir."camaras.dat");
	while($linea = <CAMARAS>){
		($cod,$camNomb) = split(";",$linea);
		if($cam eq $cod){
			$result = $result."($cod)$camNomb  ";
		}
	}
	
	my $tCod; my $desc1; my $desc2;
	open (TRIBUNAL,$maedir."pjn.dat");
	while($linea = <TRIBUNAL>){
		($tCod,$desc1,$desc2) = split(";",$linea);
		if($trib eq $tCod){
			$result = $result."($tCod)$desc1 $desc2  Oficina de Remisión: Mesa de entradas\n";
		}
	}
	
	$result = $result."EXPEDIENTE:  $exp    CARATULA:  $nomb\n";
	
	return $result;
}

sub getDate(){
	my($day) = @_;
	
	$epoc = time();
	$epoc = $epoc + $day * 24 * 60 * 60;   # one day before of current date.

	my $date = strftime "%Y/%m/%d", localtime($epoc);
	
	return $date;
}

sub getWorkingDays(){
	my $today = strftime "%w", localtime;
	my $days = 2;
	
	if($today eq 4 || $today eq 5){
		$days = 4;
	} 
	
	if($today = 6){
		$days=3;
	}
	my $result = &getDate($days);
	return $result;

}

sub getBanco(){
	my ($CBU) = @_;
	
	my $cod = substr($CBU,0,3);
	
	open (ENTRADA,"<$maedir/bancos.dat");
	while($linea = <ENTRADA>){
		my($x,$bCod,$desc) = split(";",$linea);
		if($cod eq $bCod){
			return ($bCod,$desc);
		}		
	}
	return "";
}

sub mostrarAyuda(){
  system("clear");
  print "\n";
  print "AYUDA:\n";
  print "\n";
  print "1- Esta opcion representa a los informes. Cada registro del informe representa un\n";
  print "expediente, el cual podra ser filtrado por distintas caracteristicas. Estos \n";
  print "informes finalmente podran ser usados para la ejecucion de los pedidos.\n";
  print "\n";
  print "2- Esta opcion es para la ejecucion de los distintos pedidos en base al archivo de \n";
  print "expedientes.\n";
  print "\n";
  print "En ambos casos se puede elegir el modo de presentacion, ya sea imprimir por pantalla o guardarlo en un archivo.\n";
  print "\n";
  print "Presione una tecla para volver al menu de inicio...\n";
  <STDIN>;
  
  
}


1;
