#!/usr/bin/perl
###
# Pragmas
use strict;
use warnings;
use Data::Dumper;


my $string_orig = 79245503;
my @array_orig = split //,$string_orig;
my $max_cislo = 0;
my $min_cislo = 99999999999999999990;

my $n = scalar(@array_orig); #pocet prvkov
my $k = 3; #pocet vyberov
my $c = fact($n)/(fact($k)*(fact($n-$k)));
printf "Pocet kombinacii: %s\n",$c;
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

for ( my $i = 1; $i <= $c; $i++){
	#print_array($A,$n);
	my @a2test = @array_orig;
	#print "orig array: ",Dumper(\@array_orig),"\n";
	#print "new array: ",Dumper(\@a2test),"\n";
	my $int = extract_int($A,\@a2test);

	#najdi max
	if ($int > $max_cislo){$max_cislo = $int;}
	if ($int < $min_cislo){$min_cislo = $int;}

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

print "Najmensie cislo je : $min_cislo \n";
print "Najvacsie cislo je : $max_cislo \n";

sub extract_int{
	my ($A,$a2test) = @_;
	my $n = scalar(@{$a2test});
	for (my $i = 0; $i < $n ; $i++){
		foreach my $A_status (@{$A}){
			if ($A_status->{'miesto'} == $i ){
				delete ($a2test->[$i]);
			}
		}
	}
	my $int = array2int($a2test);
	#print_array($A,$n);
	#print "testovane cislo: $int\n";
	return $int;
}

sub array2int {
	my ($array) = @_;
	my @array_nn = grep { defined $_ } @{$array};
	my $int = sprintf("%d", join('',@array_nn));
	return $int;
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
