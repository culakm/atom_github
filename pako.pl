#!/usr/bin/perl
###
# Pragmas
use strict;
use warnings;
#use DateTime::Format::Pg;
use Data::Dumper;


my $skip_number = 1;
my $string_orig = 41392;
my @array_orig = split //,$string_orig;
printf "Povodne cislo %s - pocet prvkov: %s\n",$string_orig, scalar(@array_orig);

my $max_index = scalar(@array_orig) - 1;

delete ($array_orig[2]);
print "ORIG po", Dumper(\@array_orig),"\n";
#printf("vysledok: %d\n", join('',@array_orig));




#splice (@array_orig,2,1);
array2int(\@array_orig);
sub array2int {
	my ($array) = @_;
	my @array_nn = grep { defined $_ } @{$array};
	my $int = sprintf("%d", join('',@array_nn));
	print "vysledok = ",$int +100,"\n";
}

=begin
my $max_out = 0;
for (my $i = $max_index; $i >= 0;  $i--){
	splice (@array_out,$j,1);
	for (my $j = $i11; $j >= 0; $j --){
		my @array_out = @array_orig;

		splice (@array_out,$i,1);
	}


	#print "ORIG po", Dumper(\@array_orig),"\n";
	print "OUT po", Dumper(\@array_out),"\n";
	my $max_here = sprintf("%d", join('',@array_out));
	if ($max_here > $max_out ){
		$max_out = $max_here;
	}
}

print "vysledok max : $max_out\n";
=begin
for (my $i = 0; $i < $max_index $i++){
	print $i,". prvok pola = ", $array_orig[$i], "\n";
}


for (my $i = $max_index; $i => 0;  $i--){
	print $i,". prvok pola = ", $array_orig[$i], "\n";
	delete ($array_orig[$i]);
	print Dumper(\@array_orig);
}


=cut
