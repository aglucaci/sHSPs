#/bin/bash
# @Usage: bash sHSPs_PIPELINE.sh
# @Date: 2-22-2021

# Description: Heat-Shock protein, comparative evolutionary analysis
#              This pipeline has been engineered to run on an HPC cluster

# Github repo: https://github.com/rdvelazquez/sHSPs 

# #####################################################################
# Declares
# #####################################################################
# Set base directory
BASEDIR="/home/aglucaci/sHSPs"

# 'scripts' already exists, create STDOUT directory
mkdir -p $BASEDIR/scripts/STDOUT

# Helper scripts....
RAxML_script=$BASEDIR"/scripts/RAxML.sh"
IQTREE_script=$BASEDIR"/scripts/IQTREE.sh"
GARD_script=$BASEDIR"/scripts/GARD.sh"
FEL_script=$BASEDIR"/scripts/FEL.sh"
BUSTEDS_script=$BASEDIR"/scripts/BUSTEDS.sh"
FastTree_script=$BASEDIR"/scripts/FastTree.sh"

clear

echo "## Heat-Shock Protein -- comparative evolutionary analysis"
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo "## Started: $dt"

echo "## Settings"
echo "# Base directory: "$BASEDIR
echo ""

# #####################################################################
# Main subroutine
# #####################################################################
# We already have alignments.
# These are located in ...
GENES=(HspB1 HspB3 HspB5 HspB8)
for g in ${GENES[@]}; do                                                                                                                                                                     
  echo "## Processing gene: "$g
   for f in $BASEDIR/data/$g/sections/*.fasta; do      # Clean up the fasta '<unknown description>' causes downstream issues
      echo " () Cleaning FASTA: "$f
      sed -i 's|\ .*||' $f
   done
done

## Phase 1 ------------------------------------------------------------
# Infer ML Tree, on all of the fasta files in sections
for g in ${GENES[@]}; do
   echo "## Processing gene: "$g
   for f in $BASEDIR/data/$g/sections/*.fasta; do
      echo "FASTA: "$f
      echo " ()  Inferring ML Tree"
     
      # IQ-Tree
      #TREEFILE=$f".treefile"

      # FastTree
      TREEFILE=$f".FastTree.nwk"
      
      if [ -s $TREEFILE ]; then
          echo " ()  Newick tree -- exists --"
          jobid_1=0
      else
          # RAxML returned with errors, invalid characters in sequence names
          # -- not going to change that now, just use IQTREE instead.
          #echo qsub -V -l nodes=1:ppn=16 -q epyc $RAxML_script -v FASTA=$f      
          #cmd="qsub -V -l nodes=1:ppn=16 -q epyc $RAxML_script -v FASTA=$f"

          # IQTREE also gave issues, pertaining to identical sequences
          #echo qsub -V -l nodes=1:ppn=16 -q epyc $IQTREE_script -v FASTA=$f      
          #cmd="qsub -V -l nodes=1:ppn=16 -q epyc $IQTREE_script -v FASTA=$f"
   
          echo qsub -V -l nodes=1:ppn=4 -q epyc $FastTree_script -v FASTA=$f
          cmd="qsub -V -l nodes=1:ppn=4 -q epyc $FastTree_script -v FASTA=$f"
          jobid_1=$($cmd | cut -d' ' -f3)
      fi

      # FEL
      # Run Selection Analyses - FEL
      # This is run on 'SitesRemoved' fasta files with their tree
      if [[ "$f" == *"sitesRemoved"* ]]; then 
          echo " ()  Performing selection analyses -- FEL"
          OUTPUT_FEL=$f".FEL.json"
          if [ -s $OUTPUT_FEL ]; then
              echo " ()   FEL -- output exists --" 
          else
              #echo $OUTPUT_FEL
              echo qsub -V -W depend=afterok:$jobid_1 -l nodes=1:ppn=8 -q epyc $FEL_script -v FASTA=$f,TREE=$TREEFILE
              cmd="qsub -V -W depend=afterok:$jobid_1 -l nodes=1:ppn=8 -q epyc $FEL_script -v FASTA=$f,TREE=$TREEFILE"
              jobid_2=$($cmd | cut -d' ' -f3)
         fi
      fi

      # BUSTEDS
      # Run Selection Analyses - BUSTEDS
      # These are run on 'section' fasta, meaning sequence partitins
      # as described in table2.csv
      if [[ "$f" != *"sitesRemoved"* ]]; then
          OUTPUT_BUSTEDS=$f".BUSTEDS.json"
          echo " ()  Performing selection analyses -- BUSTEDS"
          if [ -s $OUTPUT_BUSTEDS ]; then
              echo " ()  BUSTEDS -- output exists --"
          else
              #echo $OUTPUT_BUSTEDS
              echo qsub -V -W depend=afterok:$jobid_1 -l nodes=1:ppn=8 -q epyc $BUSTEDS_script -v FASTA=$f,TREE=$TREEFILE
              cmd="qsub -V -W depend=afterok:$jobid_1 -l nodes=1:ppn=8 -q epyc $BUSTEDS_script -v FASTA=$f,TREE=$TREEFILE"
              jobid_3=$($cmd | cut -d' ' -f3) 
         fi
      fi     
   # finish inner loop
   echo ""
   done
   # finish outer loop
   echo ""
done

## Phase 2 ------------------------------------------------------------
# Looking for evidence of recombination, Run GARD, on full fastas
echo "## Looking for evidence of recombination, Run GARD, on full fastas"

for g in ${GENES[@]}; do
   echo "# Looking for evidence of recombination" 
   for f in $BASEDIR/data/$g/*.fasta; do
      echo $f
      # Clean up the fasta '<unknown description>' causes downstream issues
      sed -i 's|\ .*||' $f
      
      OUTPUT_GARD=$f".GARD.json"
      if [ -f $OUTPUT_GARD ]; then
          echo "GARD has run or is currently running -- check .bestgard file"
     else
          echo "GARD cmd"
          echo qsub -V -l nodes=1:ppn=16 -q epyc GARD.sh -v FASTA=$f
          qsub -V -l nodes=1:ppn=16 -q epyc $GARD_script -v FASTA=$f
     fi 
   done
done


exit 0
# #####################################################################
# End of file
# #####################################################################
