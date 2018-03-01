#!usr/bin/perl
use strict;
use warnings;

my $outfile1 = 'runprograph.sh';
my $outfile2 = 'stripblank.sh';
my $outfile3 = 'copymusc.sh';
my $outfile4 = 'copyHPrs6.sh';
my $size;
my $loopcount;
my $prograph_infile;
my $fh;

#Initialize the shell scripts

open($fh, '>', $outfile1) or die "Could not open file '$outfile1' $!";
print $fh "#!/bin/bash\n";
close $fh;

open($fh, '>', $outfile2) or die "Could not open file '$outfile2' $!";
print $fh "#!/bin/bash\n";
close $fh;

open($fh, '>', $outfile3) or die "Could not open file '$outfile3' $!";
print $fh "#!/bin/bash\n";
close $fh;

open($fh, '>', $outfile4) or die "Could not open file '$outfile4' $!";
print $fh "#!/bin/bash\n";
close $fh;


#Iterate thru the directories


foreach $loopcount(301..4473)

{
#Read in HPrs6 out file and determine whether it's empty

$size = -s "./musc_$loopcount/protein_align_single_line_nogaps_HPrs6-0-0.out";

if ($size > 0)

#If not empty, create four shell script files to:

{
# 4) copy and rename the HPrs6 low comlexity file to another directory
open($fh, '>>', $outfile4) or die "Could not open file $outfile4";
print $fh "cp ./musc_$loopcount/protein_align_single_line_nogaps_HPrs6-0-0.out ../bio582_files/HPrs6_$loopcount.out\n";
close $fh;


# 3) copy and rename the musc gapped alignment file to another directory
open($fh, '>>', $outfile3) or die "Could not open file $outfile3";
print $fh "cp ./musc_$loopcount/musc_${loopcount}_protein_align_single_line.fasta ../bio582_files/musc_$loopcount.gapped.fasta\n";
close $fh;

# 2) strip away the top empty line of the nogap input file that was causing ProGraph to abort
open($fh, '>>', $outfile2) or die "Could not open file $outfile2";
print $fh "sed -i -e '1, 1d' ./musc_$loopcount/musc_${loopcount}_protein_align_single_line_nogaps.fasta\n";
close $fh;

# 1) run ProGraph with the required input and output files specified
$prograph_infile = "./musc_$loopcount/musc_${loopcount}_protein_align_single_line_nogaps.fasta";
open($fh, '>>', $outfile1) or die "Could not open file $outfile1";
print $fh "./bin/ProGraphMSA_64 -f -o ../bio582_files/prog_$loopcount.gapped.fasta $prograph_infile\n";
close $fh;


};

};
