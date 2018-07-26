#Segment File Generation
If you are looking for the old sewing documentation on generating model files, please see the [[Model Generation|Model Generation ]] page.


----------------------
###Creating a Motif File
Motif Files define what type of secondary structures you'd like to extract from your input files.
Each line defines a new motif, and will be outputted as its own unique segment file. Each motif contains the DSSP code along with the minimum and maximum number of residues allowed for each secondary structure separated by spaces. Motifs composed of multiple secondary structure units are comma separated. 

For example, a motif composed of helix loop helix segments with helices that have a minimum of 5 residues and a maximum of 20 residues, connected by loops which are a maximum of 5 residues, would be defined as: ```H 5 20, L 1 5, H 5 20```

The following DSSP codes are allowed: ```H``` (helix), ```L``` (loop), ```E``` (strand), ```N``` (any), ```U``` (not helix), ```Y``` (not loop), and ```R``` (not strand)

----------------------
###Using the segment_file_generator app

The segment_file_generator app requires two command line arguments: ```motif_file```(see above) and ```pdb_list_file```. The ```pdb_list_file``` is a text file listing the paths to pdb files, separated by a newline character. Structure files can be queried from the RCSB protein database, or from sources such as the Richardson Lab's [Top 8000 Database](http://kinemage.biochem.duke.edu/databases/top8000.php) or the Dunbrack Lab's [PISCES Server](http://dunbrack.fccc.edu/PISCES.php).

The application also takes one optional argument, ```strict_dssp_changes``` (default true). **NOTE 07/26/2018: There is currently a bug in the application that causes it to fail unless this flag is set to false.** When ```strict_dssp_changes``` is true, single-residue secondary structure elements are not recognized, allowing (for example) kinked helices to be treated as a single element rather than multiple elements.

Example run:
```sh
./segment_file_generator.default.xxx -database ~/Rosetta/main/database/ -ignore_unrecognized_res -pdb_list_file pdbs.txt -motif_file motifs.txt
```

We highly recommend using the ```-ignore_unrecognized_res``` flag, unless your input files have already been properly sterilized.

----------------------
###Combining Segment Files

While not recommended due to lack of validation, it is possible to generate SEWING structures using multiple motifs. For example, you could use a segment file which contains both HLH and HLELH structures to generate an alpha+beta structure. To do so, simply combine the two segment files together:

```sh
cp smotifs_H_1_100_L_1_100_H_1_100.segments HLH_HLELH_combined_segment_file.segments && cat smotifs_H_1_100_L_1_100_E_1_100_L_1_100_H_1_100.segments >> HLH_HLELH_combined_segment_file.segments
```


##See Also
* [[SEWING]] The SEWING home page
* [[SEWING Dictionary]]
* [[Model comparison with geometric hashing]]