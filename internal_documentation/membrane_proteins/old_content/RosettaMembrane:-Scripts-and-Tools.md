# RosettaMembrane: Scripts and Tools

The RosettaMembrane framework maintains a series of dependencies on external data (notably span files, embedding files, and lipophobicity data) and uses the resource manager. I have moved the scripts for processing this data and the resource definition files in the Rosetta/tools repository under membrane_tools. This page serves as documentation for each script and its usage. 

## Membrane Data Pre-Processing

### alignblast.pl
Alignblast is a script dependency for run_lips.pl and is used to generate a multiple alignent file from Blast or PsiBlast output. This file is used in the process of generating lipophobicity data (.lips or .lips4 file). Original Authors: Rosetta External

```
alignblast.pl [options] blast.out alignment-file
```

### run_lips.pl
Generate a data file describing the lipid accesisbility of residues in a membrane protein. This calculation is based upon PsiBlast output and membrane helical spanning definition (generated separately). Requires the .span file and a .fasta sequence. (Original Authors: Vladmir Yarov-Yaravoy and Bjorn Wallner)
Script Usage: 

```
run_lips.pl <myseq.fasta> <mytopo.span> /path/to/blast /path/to/nr alignblast.pl
```

### octopus2span.pl
Required formatting script for converting membrane helical spanning definiiton data from OCTOPUS to Rosetta's .span file format. Requires a .oct data file and generated from the Fasta sequence. Original Authors: Vladmir Yarov-Yaravoy and Bjorn Wallner 
Script Usage: 

```
octopus2span.pl mytopo.oct > mytopo.span
```

## Membrane Framework Development Utils

### mptest_ut.py
Utility script for developing membrane framework code. This script will run all current unit tests associated with the membrane framework. Good practice to run this subset of tests while changing any framework related code. Make a copy of the script in 'Rosetta/main/source' and run. Original Author: Rebecca Alford (@rfalford12)
Script Usage: 

```
./mptest_ut.py
```

## Membrane Framework Protocol Utils

### prep_mpdb.py
Prepare all required data files for running the membrane framework (span files, embedding data, resource definition file, etc). Requires clean_pdb.py and its dependencies. Original Author: Rebecca Alford (@rfalford12). 
Script Usage: 

```
python prep_mpdb.py --pdb <PDBID> --chains <list of chains> 
```

### write_mp_xml.py
Script for writing a reosurce definition file template for membrane framework protocols given a PDB id. Can be modified and then used. Original Author: Rebecca Alford (@rfalford12). 
Script Usage: 

```
python write_mp_xml.py --workdir $(pwd) --chains chains.txt --outfile PDBID.xml
```
