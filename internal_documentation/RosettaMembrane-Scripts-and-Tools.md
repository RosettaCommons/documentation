The RosettaMembrane framework requires a few external scripts located in `tools/membrane_tools.` I have also provided some utility scripts for running the framework (data prep, generating resource definition files, etc). Below is info for each script and its usage. 

### alignblast.pl
Dependency script for run_lips.pl - used for generating a multiple alignment file from Blast or PsiBlast output. Script Usage: 

```
alignblast.pl [options] blast.out alignment-file
```

### run_lips.pl
Generate a lipophobicity data file for a membrane bound protein given its helical span file and fasta sequence. Script Usage: 

```
run_lips.pl <myseq.fasta> <mytopo.span> /path/to/blast /path/to/nr alignblast.pl
```

### octopus2span.pl
Convert .oct data file format from OCTOPUS (generates helical spanning topology) to a .span file format to be used by the Rosetta framework. Script usage: 

```
octopus2span.pl mytopo.oct > mytopo.span
```

### mptest_ut.py
This script is a utility script - will run all unit tests associated with the membrane framework. Probably good practice to run this subset of tests if you are changing anything in the membrane framework. Move it to `main/source/` and run: 

```
./mptest_ut.py
```

### prep_mpdb.py
Prep all data files required for running the membrane framework (span files, embedding data, resource definition files, etc). Requires clean_pdb.py and the BCL. Sticking it in here as a utility. Script Usage: 

```
python prep_mpdb.py --pdb <PDBID> --chains <list of chains> 
```

### write_mp_xml.py
Write xml definition file for membrane framework protocols given a PDB id. Script usage: 

```
python write_mp_xml.py --workdir $(pwd) --chains chains.txt --outfile PDBID.xml
