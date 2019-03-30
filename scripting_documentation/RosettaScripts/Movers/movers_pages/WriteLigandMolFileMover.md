# WriteLigandMolFile
*Back to [[Mover|Movers-RosettaScripts]] page.*
## WriteLigandMolFile

```xml
<WriteLigandMolFile name="(&string)" chain="(&string)" directory="(&string)" prefix="(&string)"/>
```

WriteLigandMolFile will output a V2000 mol file record containing all atoms of the specified ligand chain and all data stored in the current Job for each processed pose. The following options are required:

-   chain: The PDB chain ID of the ligand to be output
-   directory: The directory all mol records will be output to. Directory will be created if it does not exist.
-   prefix: the file prefix for the output files. If Rosetta is being run without MPI, the output path will be directory/prefix.sdf. If Rosetta has been compiled with MPI support, the output path will be directory/prefix\_nn.sdf where nn is the MPI rank ID that processed the pose. Each rosetta process or MPI controlled job should have a unique prefix or output to a separate directory to avoid file clobbering.


##See Also

* [[Preparing ligands]]: Information on preparing ligands for use in Rosetta
* [[Non-protein residues]]: Home page for using non-protein molecules in Rosetta
* [[I want to do x]]: Guide to choosing a mover
