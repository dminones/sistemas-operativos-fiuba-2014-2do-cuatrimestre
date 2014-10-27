#!/bin/perl
# Biblioteca de funciones para el manejo de la información
use feature qw(switch);

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
	my %expedientesSal;
	foreach $key (keys(%expedientes)){
		my $encontrado = 0; my $cantidad = 0;
		my $param;
		
		given($filtro){
			when("expediente") { $param = &filtrarExpediente($key); }
			when("camara") { $param = &filtrarCamara($key); }
			when("tribunal") { $param = &filtrarTribunal($key); }
		}
		
		for($i=0;$i<$length;$i++){
			if($param eq $filtExp[$i]){
				$expedientesSal{$key} = $expedientes{$key};
				$cantidad++;
				last; 
			}
		}
		
		if($cantidad == $length && $filtro eq "expediente"){
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
	my ($x,$cam,) = split(";",$key);
	return $cam;
}	

sub filtrarTribunal(){
	my ($key) = @_;
	my ($x,$y,$trib) = split(";",$key);
	return $trib;
}

####################################### Filtros Pedidos  ##########################################################		

sub filtraPorAccion(){
	my ($valorParametro, %expedientes) = @_;
	my %expedientesSal;
	foreach $key (keys(%expedientes)){
		my $encontrado = 0; my $cantidad = 0;
		
		my ($x,$y,$z,$w,$accion) = split(";",$expedientes{$key});
		
		chomp($accion);
		
		if($accion eq $valorParametro){
			$expedientesSal{$key} = $expedientes{$key};
		}
	}
	return %expedientesSal;
}

#######################################################################################################################

sub clonarHash(){
	my(%exp1) = @_;
	my %exp2;
	foreach $key (keys(%exp1)){
		$exp2{$key} = $exp1{$key};
	}
	
	return %exp2;
}

	
1;