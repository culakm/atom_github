#!/usr/bin/perl
###
# Pragmas
use strict;
use warnings;
use Data::Dumper;


#https://www.hackmath.net/cz/kalkulacka/kombinace-a-permutace?n=10&k=4&order=1&repeat=0

my $graphic = 0;
# String obsahujuci cislo, pocet cisel je pocet prvkov
my $string_orig = 79245503;
my @array_orig = split //,$string_orig;
my $max_cislo = 0;
my $min_cislo = 0;

# Pocet prvkov
my $n = scalar(@array_orig);
# Maximalny index pre poziciu v poli prvkov
my $Imax = $n-1;
# Pocet vyberov
my $k = 3;
# pocet kombinacii bez opakovania a bez poradia
my $c = fact($n)/(fact($k)*(fact($n-$k)));
printf "Pocet kombinacii: %s\n",$c;


# priprava pola pozicii pre vybery
# kazdy vyber ma
# max_miesto = maximalny index na ktorom sa moze vyskytnut
# miesto = index na ktorom sa momentalne nachadza
my $A = [];
for (my $i = 0; $i < $k; $i++){
	my $max_miesto = $Imax - ($k - ($i+1));
	my $miesto = $i;
	$A->[$i] = {
		'max_miesto' 	=> $max_miesto,
		'miesto'		=> $miesto
	};
}

# Prechadzame pocet moznych kombinacii
for ( my $i = 1; $i <= $c; $i++){

	# vytlaci umiestnenie prvkov v aktualnej kombinacii
	print_array($A,$n) if $graphic;
	# Vytvorenie testovacieho pola v ktorom budu podla pola pozicii nastavene niektore prvky ako undef
	my @a2test = @array_orig;
	my $int = extract_int($A,\@a2test);

	# prvy beh naloaduje max a min
	if ($i == 1){
		$max_cislo = $int;
		$min_cislo = $int;
	}
	else {
		#porovnaj max
		if ($int > $max_cislo){$max_cislo = $int;}
		#porovnaj min
		if ($int < $min_cislo){$min_cislo = $int;}
	}

	# bol niektory vyber uz posunuty?
	my $posun = 0;
	for (my $j = ($k - 1); $j >= 0; $j--){
		# uz sa niektory vyber predtym v tejto kombinacii pohol
		if ($posun){
			last;
		}
		if ($A->[$j]{'miesto'} < $A->[$j]{'max_miesto'}){
			# posun vyber
			$A->[$j]{'miesto'}++;
			$posun = 1;
			# existuje nejaky vyber viac v pravo ako je tento vyber?
			if (exists $A->[$j+1]){
				# nastav najblizsie nove miesto
				my $nove_miesto = $A->[$j]{'miesto'} + 1;
				# Pre vsetky vybery ktore su viac v pravo ako je tento vyber uprav miesto tak aby bolo co najblizsie ku mne
				for(my $m = $j+1; $m < $k; $m++){
					$A->[$m]{'miesto'} = $nove_miesto++;
				}
			}
		}
	}
}

print "Najmensie cislo je : $min_cislo \n";
print "Najvacsie cislo je : $max_cislo \n";

# Z pola cisel $a2test zmen na undef cisla na poziciach ozacenych v $A
# vrati int cislo jednej kombinacie
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
	return $int;
}

# Z pola cisel vynechaj vsetky prvky ktore su undef a vytvor z toho int
sub array2int {
	my ($array) = @_;
	my @array_nn = grep { defined $_ } @{$array};
	my $int = sprintf("%d", join('',@array_nn));
	return $int;
}

# Podla pola $A vytvor riadok tejto kombinacie kde vybery su 0 a ostatne *
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
		}
		print $out;
	}
	print "\n";
}


# Vypocet faktorialu
sub fact{
	my ($n) = @_;
	my $f = 1;
	my $i = 1;
	$f *= ++$i while $i < $n;
	return $f;
}
