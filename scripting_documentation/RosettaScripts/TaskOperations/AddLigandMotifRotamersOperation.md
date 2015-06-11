# AddLigandMotifRotamers
## AddLigandMotifRotamers

Using a library of protein-ligand interactions, identify possible native-like interactions to the ligand and add those rotamers to the packer, possibly with a bonus.

    <AddLigandMotifRotamers name=(&string)/>

Since it only makes sense to run AddLigandMotifRotamers once (it takes a very long time), I have not made the options parseable. You can however read in multiple weight files in order to do motif weight ramping.

