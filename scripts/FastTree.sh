#!/bin/bash
#PBS -N FastTree
#PBS -l walltime=999:00:00
#PBS -e /home/aglucaci/sHSPs/scripts/STDOUT
#PBS -o /home/aglucaci/sHSPs/scripts/STDOUT
#@Usage: qsub -V -l nodes=1:ppn=4 -q epyc FastTree.sh -v FASTA={CODON_AWARE_MSA}

FASTTREE="/usr/local/bin/FastTree"
NP=4


$FASTTREE -gtr -nt $FASTA > $FASTA".FastTree.nwk"


exit 0
