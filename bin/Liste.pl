#!/usr/bin/perl
$grupo = $ENV{'GRUPO'};
$repodir = $grupo.$ENV{'REPODIR'}."/";
$maedir = $grupo.$ENV{'MAEDIR'}."/";
$includeDir = $grupo.$ENV{'BINDIR'}."/";
use lib $includeDir."interfazUsuario.pl";
use lib $includeDir."accesoDatos.pl";
use lib $includeDir."accesoArchivo.pl";
use lib $includeDir."auxiliar.pl";

require $includeDir."interfazUsuario.pl";
require $includeDir."accesoDatos.pl";
require $includeDir."accesoArchivo.pl";
require $includeDir."auxiliar.pl";

$stdin = "5";
while ($stdin != 0){
	system("clear");
	introduction();
	startMenu();
	$stdin=<STDIN>;
	if ($stdin == 1 || $stdin == 2){		
		if ($stdin == 1){
			my $fin = "0";
			my $mismoArchivo = "1";
			while($fin ne "1"){
				if($mismoArchivo eq "1"){
					%expedientes = &getExpedientes;
				}
				my ($consulta,%exp) = &preguntarFiltros(%expedientes);
				&deseaGuardar($consulta,%exp);
				$fin = &deseaContinuar();
				if($fin eq "0"){
					$mismoArchivo = &deseaMismoArchivo();
				}
			}
			$stdin = 0;
		}

		if ($stdin == 2){
			my $fin = "0";
			my $mismoArchivo = "1";
			while($fin ne "1"){
				if($mismoArchivo eq "1"){
					%expedientes = &getExpedientesPedido;
				}
				$param = &seleccionarPedido;
				print $param;
				%exp = &generarPedido($param,%expedientes);
				
				&generarMensajes(%exp);
			}
			$stdin = 0;
		}

	}
		
	if ($stdin == 4){	
		# mostrarAyuda();	
	} 
	
	print "Ha llegado a su fin.\n";  
}


