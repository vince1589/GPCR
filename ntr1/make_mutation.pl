#!/usr/bin/perl

use strict;

open IN,"mut_list.dat" or die;

my %lab;

while(my $l = <IN>) {
	chomp($l);
	if ($l =~ m/Label:(.) Mut:(\D+)(\d+)(\D+)/) {
		print "$l\n";
		$lab{$1} = "$4$3$2";
		
	}
}


my @list = ("E","L","F","EL","EF","LF","ELF");



foreach my $one (@list) {
	system "rm wrk/*";
	system "cp pdb/GW5.pdb wrk/mut.pdb";
	my @sp = split(//,$one);
	print "$one\n";
	foreach my $s (@sp) {
		print "\t$s $lab{$s}\n";	
	#	die;
		system "perl ~/Maitrise/script_mutation/make_mutation.pl -prot wrk/mut.pdb -folder wrk/ -chain A -mut $lab{$s} -name temp.pdb";
		#die;
		system "mv wrk/temp.pdb wrk/mut.pdb";
	}
	system "cp wrk/mut.pdb pdb/$one\.pdb";
	
	system "~/Maitrise/ENCoM/bin/build_encom -i pdb/$one\.pdb -no -cov pdb/$one\.cov";
	
}
