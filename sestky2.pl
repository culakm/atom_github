#!/usr/bin/perl
###
# Pragmas
use strict;
use warnings;
use Data::Dumper;


my $start = 100;
my $stop = 999;
my $sucin_rovny = 6;
my $count = 0;
for (my $cislo = $start; $cislo <= $stop; $cislo++){

	my $sucin_cisla = sucin_cisla($cislo);
	#print "cislo: $cislo, jeho sucin: $sucin_cisla\n";
	if ( $sucin_cisla == $sucin_rovny ){
		$count++;
		#print "$start\n";
		print "CISLO: $cislo, jeho sucin je $sucin_rovny  !!!\n";
	}
}

print "Cisel pri ktorych je sucin ich cifier  $sucin_rovny : $count\n";
sub sucin_cisla {
	my ($number) = @_;
	my $array = number2array($number);
	my $result =  array_sucin($array);
	return $result;
}

sub number2array {
	my ($number) = @_;
	my @array = split //,$number;
	return \@array;
}



sub array_sucin {
	my ($array) = @_;
	my $result = 1;
	foreach my $element (@{$array}){
		$result = $result * $element;
	}
	return $result;
}
