#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

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
    if($_ =~ /(.*)\|\s?(.*)/) {
        my $text_1 = $1;
        my $text_2 = $2;
        $text_1 =~ s/[^a-zA-Z0-9]//g;
        $text_2 =~ s/[^a-zA-Z0-9]//g;
        my $processed_text = $long_string;
        my $score_1 = 0;
        my $score_2 = 0; 
        my @lambda = (1e-5,1e-4,1e-3,1e-2,1e-1,0.88889); 
        my @chunks_1 = ( $text_1 =~ m/.{7}/g);
        my @chunks_2 = ( $text_2 =~ m/.{7}/g);
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
        foreach my $chunk (@chunks_2){
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
                        $score_2 += log10($count_curr/$count_prev);
                    }
                }
                $i++;
            }
        }
        if($score_1<$score_2) {
            print "1\n";
        } else {
            print "2\n";
        }
        
    } else {
        print "Unexpected format\n";
    }
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
