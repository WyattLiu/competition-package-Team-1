#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

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

my $file = "$ARGV[0]";
open(my $fh, '<', $file);
my $long_string = "";
while (my $line = <$fh>) {
    chomp $line;
    $long_string .= $line;
}
my $processed_text = $long_string;
$processed_text =~ s/<unk>//g;
$processed_text =~ s/N//g;
$processed_text =~ s/[^a-zA-Z0-9]//g;
$processed_text = uc($processed_text);

while(<STDIN>) {
    chomp $_;
    my $text = $_;
    $text =~ s/[^a-zA-Z0-9]//g;
    my $min_score = 99999; 
    my $key_best = 0;
    my $string_best = "";
    my $key = 0;
    while($key!=26) {
        my $text_1 = "";
        foreach my $char (split(//,$text)) {
            if (exists $A_to_one{$char}) {
                my $encrypted_value = $A_to_one{$char};
                my $original_value = ($encrypted_value - $key)%26;
                $text_1 = $text_1 . $one_to_A{$original_value};
            } else {
                $text_1 .= $char;
            }
        }
        my $processed_text = $long_string;
        my $score_1 = 0;
        my @lambda = (1e-5,1e-4,1e-3,1e-2,1e-1,0.88889); 
        my @chunks_1 = ( $text_1 =~ m/.{7}/g);
        foreach my $chunk (@chunks_1){
           my $i = 1;
           my $prev = "";
           my $curr = "";
           while($i!=8) {
                $prev = $curr;
                my $curr = substr($chunk, 0, $i);
                if ($i>1) {
                    my $count_curr = count($curr);
                    my $count_prev = count($prev);
                    if ($count_prev!=0) {
                        $score_1 += log10($count_curr/$count_prev);
#                        print STDERR "DEBUG: $score_1\n";
                    }
                }
                $i++;
           }
        }
        if($score_1<$min_score) {
            $min_score = $score_1;
            $key_best = $key;
            $string_best = $text_1;
        }
          
    $key++;    
    }

    # I get key
    print "$string_best\n";
}

sub count {
    my ($_key) = @_;
    my $num_match = () = $processed_text =~ m/(?=$_key)/g;
    return $num_match;
}

# offcial page
# https://perldoc.perl.org/functions/log.html
sub log10 {
    my $n = shift;
    if($n==0) {
        return 0;
    }
    return log($n)/log(10);
}
