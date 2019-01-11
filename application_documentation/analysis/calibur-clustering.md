#Calibur Clustering Application

Metadata
========
Original application development and lead PI: Yen Kaow Ng (kalngyk@gmail.com) & Shuai Cheng Li (shuaicli@gmail.com)

Rosetta port: Yen Kaow Ng, with help from Jared Adolf-Bryfogle (jadolfbr@gmail.com) and Andy Watkins (andy.watkins2@gmail.com)

Documentation and Testing: Jared Adolf-Bryfogle

Reference
=========
[Calibur: a tool for clustering large numbers of protein decoys](http://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-11-25)
Shuai Cheng and Yen Kaow Ng
BMC Bioinformatics 2010 11:25
DOI: 10.1186/1471-2105-11-25

Use
===
In order to run calibur, you must provide a pdblist with full paths to the decoys, one on each line.
the in:file:l option is also understood. 
```
calibur.macosclangrelease -pdb_list decoy_path_list
```

One can also specify a list of chains to use (```-chains ABC```), a chain (```-chains A```) or a specific stretch of residues, as shown below
```
calibur.macosclangrelease -pdb_list decoy_path_list -start 10 -end 20 -chains A
```

Calibur will then output each cluster (from largest to smallest), its center decoy, and the list of decoys that make up that cluster.  This information can easily be parsed or used to load structures into PyMol. 

Algorithm
=========
See Reference for a full description of the clustering algorithm.

Options
=======
```
-input:pdb_list
```
A file specifying the decoys. Each line of the file specifies a path (relative to the working directory) to a decoy's PDB file (-in:file:l also works here)


```
-res:start
```
(Optional) starts from this Residues C-alpha atom (instead of starting from the first C-alpha atom), default = 1
		
```
-res:end
```
(Optional) ends at this Residues C-alpha atom (instead of ending at the last C-alpha atom), default = 0

```
-res::chains
```
(Optional) specifies the chains to be used. By default, we scan for all alhpanumerics and empty chain, i.e. 'A', 'C', or ' '
		
```
-strategy::thres_finder
```
(Optional) specifies the threshold finding strategy. You may need to also use the -nofilter flag for some of these to find a cluster (2 and 3) This should be one of 0, 1, 2, 3. (default strategy: 0) 
			

 -  0: threshold results in only x% of \"edges\" between decoys; default x=100/sqrt(sqrt(#decoys))
			
 -  1: threshold = min dist + x * (most frequent dist - min dist) default x=0.666667 (=2/3)
			
 -  2: threshold = min dist + x * min(the avarage dist of decoys from a decoy; default x=0.666667 (=2/3)
			
 -  3: find threshold using ROSETTA's method (auto-detect parameters).  May result in no clustering
		
```
-strategy::nofilter
```
(Optional) disables the filtering of outlier decoys.", default=false
 
```
-strategy::thres
```
(Optional) specifies a doubleing point number x. which is used differently according to the threshold strategy specified. x is ignored if the strategy does not use it. x is used as the threshold if no threshold strategy is specified.", default = -1.0);

Limitations
===========
 - The app currently only works for protein residues through their C alpha atoms, so ligands and carbohydrates will not work.  They can be in the PDB file and should just be skipped over.

 - PDB file format supported (.pdb), Silent files mmCIF, and gzipped PDBs not supported.  This functionality is hopefully incoming, but for now, you will need to create pdb files from any silent files you have.


## See also
* [[The energy_based_clustering application | energy_based_clustering_application]].
* [[Utility applications | utilities-applications]]: other utility applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Preparing structures]]: How to prepare structures for use in Rosetta