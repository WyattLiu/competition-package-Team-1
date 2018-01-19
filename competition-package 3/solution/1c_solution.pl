#!/usr/bin/perl

use strict;
use warnings;
#use Data::Dumper;

my %A_to_X;
my %one_to_A;

$A_to_X{A}="?";
$A_to_X{B}="?";
$A_to_X{C}="?";
$A_to_X{D}="?";
$A_to_X{E}="?";
$A_to_X{F}="?";
$A_to_X{G}="?";
$A_to_X{H}="?";
$A_to_X{I}="?";
$A_to_X{J}="?";
$A_to_X{K}="?";
$A_to_X{L}="?";
$A_to_X{M}="?";
$A_to_X{N}="?";
$A_to_X{O}="?";
$A_to_X{P}="?";
$A_to_X{Q}="?";
$A_to_X{R}="?";
$A_to_X{S}="?";
$A_to_X{T}="?";
$A_to_X{U}="?";
$A_to_X{V}="?";
$A_to_X{W}="?";
$A_to_X{X}="?";
$A_to_X{Y}="?";
$A_to_X{Z}="?";

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
    if($_=~/([\w\s]+)\|\s?([\w]*)\s?\|\s?(.*)/) {
        my $OP = $1;
        my $key_string = $2;
        my $msg = $3;
        my $output = "";
        my @key = split(//,$key_string);
        # need to hash in
        my $index_map = 0;
        foreach my $i (@key) {
            $A_to_X{$one_to_A{$index_map}}=$i;
            $index_map++;
        }
        #print Dumper(@key);
        my %X_to_A = reverse %A_to_X;
        if ($OP =~ /ENCRYPT/) {
            foreach my $char (split(//,$msg)) {
                # hash to value
                if (exists $A_to_X{$char}) {
                    $output = $output . $A_to_X{$char};
                } else {
                    $output = $output . $char;
                }
            }
        } elsif ($OP =~ /DECRYPT/) {
            foreach my $char (split(//,$msg)) {
                if (exists $X_to_A{$char}) {
                    $output = $output . $X_to_A{$char};
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


