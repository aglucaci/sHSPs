#!/bin/bash
#PBS -N BUSTEDS
#PBS -l walltime=999:00:00
#PBS -e /home/aglucaci/sHSPs/scripts/STDOUT
#PBS -o /home/aglucaci/sHSPs/scripts/STDOUT
#@ Usage: qsub -V -l nodes=1:ppn=8 -q epyc BUSTEDS.sh -v FASTA={CODON_AWARE_MSA},TREE={TREE_NEWICK}


HYPHYMPI="/home/aglucaci/hyphy-develop/HYPHYMPI"
RES="/home/aglucaci/hyphy-develop/res"
BUSTEDS="BUSTED"
NP=8


echo mpirun --np $NP $HYPHYMPI LIBPATH=$RES $BUSTEDS --alignment $FASTA --tree $TREE --srv Yes --output $FASTA".BUSTEDS.json"
mpirun --np $NP $HYPHYMPI LIBPATH=$RES $BUSTEDS --alignment $FASTA --tree $TREE --srv Yes --output $FASTA".BUSTEDS.json"

exit 0
