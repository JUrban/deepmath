#!/usr/bin/perl

# Create the pos/neg examples using atpproved as positive and the
# remaining k-nn predictions as negative. Use the named form and count
# success of a trivial predictor based on the pos/neg counts so far.
# This now results in 71.75 accuracy for knnpreds64.

# run as: ../code/generate_trivdatamk.pl knnpreds64

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
	for $l (sort keys %{$h{$1}}) {if($p{$l}>$n{$l}) {$s++} elsif($p{$l}<$n{$l}) {$ns++} print H "+ ",$l,"\n"; $p{$l}++; $c++} 
	$d=0; 
	for $l (split(/ +/,$2)) 
	{
	    die unless exists $f{$l}; 
	    if(($d<$c) && !(exists($h{$1}{$l})) ) 
	    {
		if($p{$l}>$n{$l}) {$ns++} elsif($p{$l}<$n{$l}) {$s++} 
		print H "- ",$l,"\n" ; 
		$n{$l}++;
		$d++; 
	    }   
	}
	close H; 
    }
}
$rr=$s/($s+$ns);
print "$s::$ns::$rr\n";
