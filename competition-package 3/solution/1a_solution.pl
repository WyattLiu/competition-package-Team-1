#!/usr/bin/perl

use strict;
use warnings;

# I need 2 hash table to hash A->1 then 1-A

my %A_to_one;
my %one_to_A;

# hardcode in the hash table

$A_to_one{A}=0;
$A_to_one{B}=1;
$A_to_one{C}=2;
$A_to_one{D}=3;
$A_to_one{E}=4;
$A_to_one{F}=5;
$A_to_one{G}=6;
$A_to_one{H}=7;
$A_to_one{I}=8;
$A_to_one{J}=9;
$A_to_one{K}=10;
$A_to_one{L}=11;
$A_to_one{M}=12;
$A_to_one{N}=13;
$A_to_one{O}=14;
$A_to_one{P}=15;
$A_to_one{Q}=16;
$A_to_one{R}=17;
$A_to_one{S}=18;
$A_to_one{T}=19;
$A_to_one{U}=20;
$A_to_one{V}=21;
$A_to_one{W}=22;
$A_to_one{X}=23;
$A_to_one{Y}=24;
$A_to_one{Z}=25;

$one_to_A{0}="A";
$one_to_A{1}="B";
$one_to_A{2}="C";
$one_to_A{3}="D";
$one_to_A{4}="E";
$one_to_A{5}="F";
$one_to_A{6}="G";
$one_to_A{7}="H";
$one_to_A{8}="I";
$one_to_A{9}="J";
$one_to_A{10}="K";
$one_to_A{11}="L";
$one_to_A{12}="M";
$one_to_A{13}="N";
$one_to_A{14}="O";
$one_to_A{15}="P";
$one_to_A{16}="Q";
$one_to_A{17}="R";
$one_to_A{18}="S";
$one_to_A{19}="T";
$one_to_A{20}="U";
$one_to_A{21}="V";
$one_to_A{22}="W";
$one_to_A{23}="X";
$one_to_A{24}="Y";
$one_to_A{25}="Z";

while(<STDIN>){
    if($_=~/([\w\s]+)\|([\d\s]*)\|\s?(.*)/) {
        my $OP = $1;
        my $key = $2;
        my $msg = $3;
        my $output = "";
#        print "DEBUG: $OP ::: $key ::: $msg\n";
        # process it here
        # get the value of the letter
        if ($OP =~ /ENCRYPT/) {
            foreach my $char (split(//,$msg)) {
                # hash to value
                if (exists $A_to_one{$char}) {
                    my $original_value = $A_to_one{$char};
                    my $encrypted_value = ($original_value + $key)%26;
                    $output = $output . $one_to_A{$encrypted_value};
                    #print "DEBUG: $output\n";
                } else {
                    $output = $output . $char;
                }
            }
        } elsif ($OP =~ /DECRYPT/) {
            foreach my $char (split(//,$msg)) {
                if (exists $A_to_one{$char}) {
                    my $encrypted_value = $A_to_one{$char};
                    my $original_value = ($encrypted_value - $key)%26;
                    $output = $output . $one_to_A{$original_value};
                } else {
                    $output = $output . $char;
                }
            }
        } else {
            print "Unexpected operation\n";
        }
        print "$output\n";
    } else {
        print "Cannot readin due to unexpected format\n";
    }
}


