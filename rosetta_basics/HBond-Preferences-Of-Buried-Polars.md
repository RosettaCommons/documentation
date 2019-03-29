Note: Brian doesn't know where to put this data. At least here it will be public on the web.

Author: Brian Coventry 2019

# Description
This great site: [Atlas of Side-Chain and Main-Chain Hydrogen Bonding](http://prowl.rockefeller.edu/aainfo/hbonds.html), collected statistics on the h-bonding preferences of buried polar atoms. This information is incredibly useful, but unfortunately, it was created in 1993.

With the PDB much larger than it was in 1993, a similar analysis was performed on Rosetta-relaxed version the PISCES dataset[1].

## Criteria 

In order be considered buried, the following must be true:

1. With a 0.9Å probe radius, the group must have 0 SASA

2. Using molecular surface atomic depth[2][3], the group must be buried to at least 5.5Å

For the "entire group" graphs, every atom of the group must pass the above two criteria in order to be counted.

In order to be considered h-bonding:
1. Rosetta beta_nov16 must classify an h-bond having at least -0.25 kcal/mol energy*

\*Note: the bb_donor_acceptor_check() was set to False




# Citations 
1. G. Wang and R. L. Dunbrack, Jr. PISCES: a protein sequence culling server. Bioinformatics, 19:1589-1591, 2003. 

2. D. Xu, Y. Zhang (2009) Generating Triangulated Macromolecular Surfaces by Euclidean Distance Transform. PLoS ONE 4(12): e8140.

3. D. Xu, H. Li, Y. Zhang (2013) Protein Depth Calculation and the Use for Improving Accuracy of Protein Fold Recognition. Journal of Computational Biology 20(10):805-816.
