#!/usr/bin/perl

# Create the pos/neg examples using atpproved as positive and the
# remaining k-nn predictions as negative. Use just the names.

# run as: ../code/generate_trivdata.pl knnpreds64

open(G,"statements_holprefix") or die; 
while(<G>) {m/^([^ ]+) (.*)/ or die; $f{$1}=$2 . "\n" } 
open(F,"atpproved") or die; 
while(<F>) {m/(.*):(.*)/ or die; for $l (split(/ +/,$2)) {$h{$1}{$l}=()} } 
while(<>) 
{
    m/(.*):(.*)/ or die; 
    if(exists($h{$1})) 
    {
	open(H,">../trivdata/$1") or die; 
	print H "C ", $1,"\n"; 
	$c=0; 
	for $l (sort keys %{$h{$1}}) {print H "+ ",$l,"\n"; $c++} 
	$d=0; 
	for $l (split(/ +/,$2)) 
	{
	    die unless exists $f{$l}; 
	    if(($d<$c) && !(exists($h{$1}{$l})) ) 
	    {
		print H "- ",$l,"\n" ; 
		$d++; 
	    }   
	}
	close H; 
    }
}
