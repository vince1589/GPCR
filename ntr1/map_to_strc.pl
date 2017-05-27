#!/usr/bin/perl

use strict;



open OUT, ">Corr.pml" or die;

for my $i (0..50) {
	my $id = sprintf("%.2f",$i/50);
	print OUT "set_color colordef$i = [$id,$id,1.00]\n";
}
for my $i (51..100) {
	my $id = sprintf("%.2f",1-($i-50)/50);
	print OUT "set_color colordef$i = [1.00,$id,$id]\n";
}

print OUT "load pdb/wt.pdb,prot\n";

print OUT "hide everything\n";
print OUT "show cartoon\n";

open IN, "Rank_cor.dat" or die;
<IN>;
while(my $l = <IN>) {
	chomp($l);
	if ($l =~ m/\"\d+\",\"...(\d+)A\",\"(\S+)\"/) {
		my $res = $1;
		my $val = $2;
		my $diff = 0;
		my $tdiff = 0;
		my $max = 1;
		if ($val < 0) {
		#	print "$diff = int(-$val/$max*50)\n";
			$diff = int($val/$max*50)+50;
		} else {
			$diff = int($val/$max*50)+50;
		}
		
		if ($diff > 100) {$diff = 100;}
		if ($diff < 0) {$diff = 0;}
		my $buf = "\/\/\/A\/$res\/ & prot";
		printf OUT "color colordef%d,$buf\n",$diff;
		print "$val $diff $tdiff\n";
	} else {
		print "$l";
	}

}

close IN;


