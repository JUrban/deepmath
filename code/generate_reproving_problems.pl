#!/usr/bin/perl

# Create the ATP problems using the info in atpproved

# run as: ../code/generate_reproving_problems.pl 

open(G,"statements2") or die; 
while(<G>) {m/^fof.([^,]+),/ or die; $f{$1}=$_ } 
open(F,"atpproved") or die; 
while(<F>) 
{
    m/(.*):(.*)/ or die; 
    ($nn,$ll) = ($1,$2);
    @l0 = split(/ +/,$ll);
    $cc = $f{$nn};
    $cc =~ s/, axiom,/, conjecture,/;
    open(H,">../reprove/$nn") or die; 
    print H $cc; 
    for $l (@l0) { print H $f{$l} }
    close H;
} 
