### data  

#### HspB#  
- folders for each of the four (1, 3, 5 and 8) small heat shock proteins analyzed  
- each folder has :  
    - a master `.fasta` file with all the sequences  
    - a `sections` folder with:
        - the `.fasta` file with the "excluded positions" from table 2 removed  
        - the `.fasta` file for each of the "regions" (also with the excluded positions removed)  
    - a `hyphy` folder with the FEL and MEME analysis results  

#### combined  
- `1-3-5-8.fasta`: the aligned fasta file with all the sequences  
- `1-3-5-8.newick`: the tree based on those aligned sequences  

#### trees  
- Not currently used (originally going to be the place for all the tree files)