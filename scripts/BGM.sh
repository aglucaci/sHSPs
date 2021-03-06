#!/bin/bash
#PBS -N BGM
#PBS -l walltime=999:00:00
#PBS -e /home/aglucaci/sHSPs/scripts/STDOUT
#PBS -o /home/aglucaci/sHSPs/scripts/STDOUT
#@ Usage: qsub -V -l nodes=1:ppn=8 -q epyc FEL.sh -v FASTA={CODON_AWARE_MSA},TREE={TREE_NEWICK}


HYPHYMPI="/home/aglucaci/hyphy-develop/HYPHYMPI"
RES="/home/aglucaci/hyphy-develop/res"
BGM="BGM"
NP=8


echo mpirun --np $NP $HYPHYMPI LIBPATH=$RES $BGM --alignment $FASTA --tree $TREE
mpirun --np $NP $HYPHYMPI LIBPATH=$RES $BGM --alignment $FASTA --tree $TREE

exit 0
