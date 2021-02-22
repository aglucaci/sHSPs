#!/bin/bash
#PBS -N GARD
#PBS -e /home/aglucaci/sHSPs/scripts/STDOUT
#PBS -o /home/aglucaci/sHSPs/scripts/STDOUT
#PBS -l walltime=999:00:00
#@ Usage: qsub -V -l nodes=1:ppn=32 -q epyc GARD.sh -v FASTA={CODON_AWARE_MSA}

HYPHYMPI="/home/aglucaci/hyphy-develop/HYPHYMPI"
RES="/home/aglucaci/hyphy-develop/res"
MAFFT="/usr/local/bin/mafft"
GARD="GARD"
NP=16

echo mpirun --np $NP $HYPHYMPI LIBPATH=$RES $GARD --type nucleotide --code Universal --alignment $FASTA --rv GDD
mpirun --np $NP $HYPHYMPI LIBPATH=$RES $GARD --type nucleotide --code Universal --alignment $FASTA --rv GDD

exit 0
