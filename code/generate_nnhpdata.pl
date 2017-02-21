#!/usr/bin/perl

# Create the pos/neg examples using atpproved as positive and the
# remaining k-nn predictions as negative. Use the holprefix form

# run as: ../code/generate_nnhpdata.pl knnpreds64

open(G,"statements_holprefix") or die; 
while(<G>) {m/^([^ ]+) (.*)/ or die; $f{$1}=$2 . "\n" } 
open(F,"atpproved") or die; 
while(<F>) {m/(.*):(.*)/ or die; for $l (split(/ +/,$2)) {$h{$1}{$l}=()} } 
while(<>) 
{
    m/(.*):(.*)/ or die; 
    if(exists($h{$1})) 
    {
	open(H,">../nnhpdata/$1") or die; 
	print H "C ", $f{$1}; 
	$c=0; 
	for $l (sort keys %{$h{$1}}) {print H "+ ",$f{$l}; $c++} 
	$d=0; 
	for $l (split(/ +/,$2)) 
	{
	    die unless exists $f{$l}; 
	    if(($d<$c) && !(exists($h{$1}{$l})) ) 
	    {
		print H "- ",$f{$l} ; 
		$d++; 
	    }   
	}
	close H; 
    }
}
