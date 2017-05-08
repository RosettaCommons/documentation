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

The segment_file_generator app requires two command line arguments: ```motif_file```(see above) and ```pdb_list_file```. The ```pdb_list_file``` is a text file listing of paths to pdb files separated by a newline character. Structure files can be queried from the RCSB protein database, or from sources such as the Richardson Lab's [Top 8000 Database](http://kinemage.biochem.duke.edu/databases/top8000.php) or the Dunbrack Lab's [PISCES Server](http://dunbrack.fccc.edu/PISCES.php).

----------------------
###Combining Segment Files

```example command line```


##See Also
* [[SEWING]] The SEWING home page
* [[SEWING Dictionary]]
* [[Model comparison with geometric hashing]]