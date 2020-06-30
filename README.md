# sHSPs

Data and Code for the Evolutionary Pressure on Structure and Disease Implications in Small Heat Shock Proteins analysis

#### My own rough working notes on procedure

1. Identification of vertebrate sHPSs with similarity to Human HspB1, 3, 5 or 8; 50% identity and 60% similarity to the human sequence
2. Sequence alignment

- Aligned as translated amino acids using muscle (version 3.8.31) with default settings as implemented in Ali-View (version 1.25)
- Trimmed by removing sites so that no gaps in the human sequence remained
- A tree was built with all sequences (aligned first) and sequences that didn't group with their type were removed

3. Selection analysis

- The imprint of selective pressures exerted on the small heat shock proteins was assessed using two HyPhy methods (FEL and BUSTED)
- FEL was performed on each type of sHSP using default settings on datamonkey (version 1.6.0)
- 12 total busted analyses were performed (one for each region of each Hsp) and the calculated aggregate omega values were the output of interest.
- The three domains of each HspB were delineated based on previous publications. As discussed further in the results, the distribution of selective pressures suggests slightly different demarcations of the regions than previously published assessments.
