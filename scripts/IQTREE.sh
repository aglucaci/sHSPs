#!/bin/bash
#PBS -N IQTREE
#PBS -l walltime=999:00:00
#PBS -e /home/aglucaci/sHSPs/scripts/STDOUT
#PBS -o /home/aglucaci/sHSPs/scripts/STDOUT

#@Usage: qsub -V -l nodes=1:ppn=16 -q epyc IQTREE.sh -v FASTA={CODON_AWARE_MSA}


IQTREE="/opt/iqtree/iqtree-1.6.6-Linux/bin/iqtree"

NP=16

# standard command
#echo $IQTREE -s $FASTA -nt $NP -alrt 1000 -bb 1000
#$IQTREE -s $FASTA -nt $NP -alrt 1000 -bb 1000

# for short sequences
echo $IQTREE -s $FASTA -nt AUTO -alrt 1000 -bb 1000
$IQTREE -s $FASTA -nt AUTO -alrt 1000 -bb 1000
exit 0
