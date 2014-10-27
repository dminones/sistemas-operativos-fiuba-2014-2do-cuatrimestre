#!/usr/bin/perl
require "./interfazUsuario.pl";


sub getExpedientes() {
	&mostrarArchivos("$repodir");
	my $entrada = &menuInfo;
	my %expedientes;
	while ($linea=<ENTRADA>)
	{	
		my($key,$value);
		my($exp,$cam,$trib,$car,$est,$cbu,$saldo,$accion)=split(";",$linea);
		$key = "$exp;$cam;$trib";
		$value = "$car;$est;$cbu;$saldo;$accion";
		$expedientes{$key}=$value;
	}
	return %expedientes;
}

sub getExpedientesPedido() {
	&mostrarArchivos("$repodir");
	my %expedientes;
	my @archivos = &menuPedido;
	foreach $path (@archivos){
		open (ENTRADA,"<$repodir$path");
		while ($linea=<ENTRADA>)
		{	
			my($key,$value);
			my($exp,$cam,$trib,$car,$est,$cbu,$saldo,$accion)=split(";",$linea);
			$key = "$exp;$cam;$trib";
			$value = "$car;$est;$cbu;$saldo;$accion";
			$expedientes{$key}=$value;
		}
		close(ENTRADA);
	}
	return %expedientes;
}

1;