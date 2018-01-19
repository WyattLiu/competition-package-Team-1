#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

while(<STDIN>) {
    if($_ =~ /(.*)\|\s?(.*)/) {
        my $text = $1;
        my $key = $2;
        $key =~ s/[^a-zA-Z0-9]//g;
        if ($text ne "PTB ") {
            my $processed_text = $text;
            $processed_text =~ s/<unk>//g;
            $processed_text =~ s/N//g;
            $processed_text =~ s/[^a-zA-Z0-9]//g;
            $processed_text = uc($processed_text);
#            print STDERR "DEBUG: $processed_text key $key\n";
            my $num_match = () = $processed_text =~ m/(?=$key)/g;
            print "$num_match\n";
        } else {
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
            my $num_match = () = $processed_text =~ m/(?=$key)/g;
            print "$num_match\n";
        }
    } else {
        print "Unexpected format\n";
    }
}
