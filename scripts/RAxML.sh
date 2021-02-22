#!/bin/bash
#PBS -N RAxML
#PBS -l walltime=999:00:00
#PBS -e /home/aglucaci/sHSPs/scripts/STDOUT
#PBS -o /home/aglucaci/sHSPs/scripts/STDOUT
#@Usage: qsub -V -l nodes=1:ppn=16 -q epyc RAxML.sh -v FASTA={CODON_AWARE_MSA}

RAxML="/usr/local/bin/raxml-ng-mpi"
NP=16

echo $RAxML --msa $FASTA --model GTR+G --threads $NP --seed 2 
$RAxML --msa $FASTA --model GTR+G --threads $NP --seed 2 

# Successful run
exit 0
