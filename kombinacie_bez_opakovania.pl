#!/usr/bin/perl
###
# Pragmas
use strict;
use warnings;
use Data::Dumper;

my $n = 5; #pocet prvkov
my $k = 3; #pocet vyberov
my $c = fact($n)/(fact($k)*(fact($n-$k)));
my $Imax = $n-1;

my $A = [];
for (my $i = 0; $i < $k; $i++){
	my $max_miesto = $Imax - ($k - ($i+1));
	my $miesto = $i;
	$A->[$i] = {
		'max_miesto' 	=> $max_miesto,
		'miesto'		=> $miesto
	};
}
printf "Pocet kombinacii: %s\n",$c;
for ( my $i = 1; $i <= $c; $i++){
	print_array($A,$n);
	my $posun = 0;
	for (my $j = ($k - 1); $j >= 0; $j--){
		if ($posun){
			last;
		}
		if ($A->[$j]{'miesto'} < $A->[$j]{'max_miesto'}){
			$A->[$j]{'miesto'}++;
			$posun = 1;
			if (exists $A->[$j+1]){
				my $nove_miesto = $A->[$j]{'miesto'} + 1;
				for(my $m = $j+1; $m < $k; $m++){
					$A->[$m]{'miesto'} = $nove_miesto++;
				}
			}
		}
	}
}



sub print_array{
	my ($A,$n) = @_;
	for (my $i = 0; $i < $n ; $i++){
		my $check = 0;
		#print "$i : ";
		my $out = ' * ';

		foreach my $A_status (@{$A}){
			if ($A_status->{'miesto'} == $i ){
				$out = ' 0 ' ;
			}
			#print Dumper($A_status);
			#print $A_status->{'miesto'},"\n";

		}
		print $out;
	}
	print "\n";
}



sub fact{
	my ($n) = @_;
	my $f = 1;
	my $i = 1;
	$f *= ++$i while $i < $n;
	return $f;
}
