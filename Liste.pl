#!/usr/bin/perl
require "./interfazUsuario.pl";
require "./accesoDatos.pl";
require "./auxiliar.pl";
$stdin = "";
while ($stdin != 5){
	$stdin=<STDIN>;	
	system("clear");
	introduction();
	startMenu();
	$stdin=<STDIN>;
	if ($stdin == 1 || $stdin == 2){		
		if ($stdin == 1){
			$entrada = &menuInfo;
			%expedientes = &getExpedientes($entrada);
			
			$param="CUMPLIMIENTO";
			%exp = &filtraPorEstado($param,%expedientes);
			
			open(SALIDA,">salida.dat");
			
			&printArchivo(SALIDA,%exp);			
		}

		if ($stdin == 2){
		}

	}
		
	if ($stdin == 4){	
		# mostrarAyuda();	
	}   
}


