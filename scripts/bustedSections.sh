echo "running busted on all the sections"
for filename in ./../data/*/sections/*.fasta; do
    echo $filename
    iqtree -s $filename
    hyphy busted --alignment $filename --tree $filename.bionj
    break

done