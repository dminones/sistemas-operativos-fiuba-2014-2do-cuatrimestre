#!/bin/perl
# Biblioteca de funciones para el manejo de la información
use feature qw(switch);

sub getExpedientes() {
	my $entrada = @_;
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


####################################### Filtros Informes##########################################################
sub filtraPorSaldo(){
	my ($valorParametro, %expedientes) = @_;
	my @filtExp = split(",",$valorParametro);
	my $length = @filtExp;
	my %expedientesSal;
	foreach $key (keys(%expedientes)){
		if($length == 1){
			$ret = &filtrarPorMayorMenor($valorParametro,$key,$expedientes{$key});
			if($ret eq "0"){
				$expedientesSal{$key}= $expedientes{$key};
				
			}
		}
		
		if($length == 2){
			$ret = &filtrarPorRango($valorParametro,$key,$expedientes{$key});
			if($ret eq "0"){
				$expedientesSal{$key}= $expedientes{$key};			
			}
		}		
	}
	return %expedientesSal;
}

sub filtrarPorMayorMenor() {
	my($param,$key,$value) = @_;
	
	my ($x,$y,$z,$saldo,) = split(";",$value);
	
	$operador = substr($param,0,1);
	$valor = substr($param,1,length($param));
	
	if($saldo eq ""){
		$saldo = "0";
	}
	
	if($operador eq "<"){
		if($saldo < $valor){
			return "0";
		}
	}
	
	if($operador eq ">"){
		if($saldo > $valor){
			return "0";
		}
	}
	
	return "1";
}

sub filtrarPorRango() {
	my($param,$key,$value,%exp) = @_;
	my ($x,$y,$z,$saldo,) = split(";",$value);
	
	($desde,$hasta)=split(",",$param);
	
	if($saldo > $desde && $saldo < $hasta){
		return "0";
	}
	
	return "1";
}

sub filtraPorEstado(){
	my ($valorParametro, %expedientes) = @_;
	my @filtExp = split(",",$valorParametro);
	my $length = @filtExp;
	my %expedientesSal;
	foreach $key (keys(%expedientes)){
		my $encontrado = 0; my $cantidad = 0;
		
		my ($x,$estado,,,) = split(";",$expedientes{$key});
		
		for($i=0;$i<$length;$i++){
			if($estado eq $filtExp[$i]){
				$expedientesSal{$key} = $expedientes{$key};
				$cantidad++;
				last; 
			}
		}
	}
	return %expedientesSal;
}

sub filtraPorParametroDeClave(){
	my ($filtro, $valorParametro, %expedientes) = @_;
	my @filtExp = split(",",$valorParametro);
	my $length = @filtExp;
	print $filtro;
	my %expedientesSal;
	foreach $key (keys(%expedientes)){
		my $encontrado = 0; my $cantidad = 0;
		my $param;
		
		given($filtro){
			when("expediente") { $param = &filtrarExpediente($key); }
			when("camara") { $param = &filtrarCamara($key); }
			when("tribunal") { $param = &filtrarExpediente($key); }
		}
		
		for($i=0;$i<$length;$i++){
			if($param eq $filtExp[$i]){
				$expedientesSal{$key} = $expedientes{$key};
				$cantidad++;
				last; 
			}
		}
		
		if($cantidad == $length){
			last;
		}
	}
	return %expedientesSal;
}

sub filtrarExpediente(){
	my ($key) = @_;
	my ($exp,,) = split(";",$key);
	return $exp;
}

sub filtrarCamara(){
	my ($key) = @_;
	my ($key,$cam,) = split(";",$key);
	return $cam;
}	

sub filtrarTribunal(){
	my ($key) = @_;
	my ($key,$cam,$trib) = split(";",$key);
	return $trib;
}

####################################### Filtros Pedidos  ##########################################################		
	
1;