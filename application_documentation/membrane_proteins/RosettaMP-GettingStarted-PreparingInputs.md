# Preparing Input Files for RosettaMP Simulations

[[_TOC_]]

## Span Files 

### Description

A spanfile is a file format used by Rosetta for modeling of alpha-helical membrane proteins. It contains the number, length and sequence position of trans-membrane helices. A spanfile is generated using the sequence-based transmembrane helix prediction tool OCTOPUS ([http://octopus.cbr.su.se/](http://octopus.cbr.su.se/)) from a FASTA file. 

#### Generate transmembrane regions (OCTOPUS) file:

Input OCTOPUS topology file is generated at [http://octopus.cbr.su.se/](http://octopus.cbr.su.se/) using the protein sequence as input.

Sample OCTOPUS topology file:

```
##############################################################################
OCTOPUS result file
Generated from http://octopus.cbr.su.se/ at 2008-09-18 21:06:32
Total request time: 6.69 seconds.
##############################################################################

Sequence name: BRD4
Sequence length: 123 aa.
Sequence:
PIYWARYADWLFTTPLLLLDLALLVDADQGTILALVGADGIMIGTGLVGALTKVYSYRFV
WWAISTAAMLYILYVLFFGFTSKAESMRPEVASTFKVLRNVTVVLWSAYPVVWLIGSEGA
GIV

OCTOPUS predicted topology:
oooooMMMMMMMMMMMMMMMMMMMMMiiiiMMMMMMMMMMMMMMMMMMMMMooooooMMM
MMMMMMMMMMMMMMMMMMiiiiiiiiiiiiiiiiiiiiiMMMMMMMMMMMMMMMMMMMMM
ooo
```

#### Convert OCTOPUS file to .span file format:

BRD4.span - transmembrane topology prediction file generated using octopus2span.pl script as follows:

`octopus2span.pl <OCTOPUS topology file>`

Example command: 
`<path to rosetta>/Rosetta/tools/membrane_tools/octopus2span.pl BRD4.octopus`

Sample .span file:

```
TM region prediction for BRD4 predicted using OCTOPUS
4 123
antiparallel
n2c
   6    26
  31    51
  58    78
  97   117
```

1st line is comment line. 2nd line shows number of predicted transmembrane helices (4 in the command lines example below) and total number of residues (123 in the example below). 3rd line shows predicted topology of transmembrane helices in the membrane (currently only antiparallel topology is implemented). 4th line and all lines below show start and end residue numbers of each of the predicted transmembrane helices. 

NOTE: The current format repeats the numbers once while the original format repeated them twice.

### Flags

Spanfiles are read in using the option `-mp::setup::spanfiles <spanfile 1> <spanfile 2>`. While most of the Membrane Framework only uses the first spanfile (check your log file!!!), some specific applications might use two or more: the MPDocking setup uses two. If in doubt, check your log carefully. 
 
### Example

`-mp::setup::spanfiles 1afo.span`

NOTE: The flag for the original RosettaMembrane is `-in:file:spanfile 1afo.span` but this option will be deprecated. Please use the new one. 

## PDB File

### Description

Some applications require a protein structure as an input, such as MPrelax, MP ddg, and MPDocking. The documentation of the specific application will tell you what is needed. Generally, PDBs do not need to be transformed into the membrane coordinate frame for Rosetta to work. However, if knowledge of the protein orientation in the membrane is needed, there are two servers besides Rosetta that provide either transformed PDB files or the rotation / translation matrices required for this transformation. 

The PDBTM ([http://pdbtm.enzim.hu/](http://pdbtm.enzim.hu/)) is a weekly-updated PDB of TransMembrane proteins that has provides the transformed PDBs for download. It uses the TMDET server ([http://tmdet.enzim.hu/](http://tmdet.enzim.hu/)) to correctly position the protein in the membrane. The provided XML file contains both the rotation / translation matrices as well as the optimal membrane thickness for this protein.  

The OPM database ([http://opm.phar.umich.edu/](http://opm.phar.umich.edu/)) provides a similar service with the PPM server ([http://opm.phar.umich.edu/server.php](http://opm.phar.umich.edu/server.php)) which might be more accurate for prediction of the optimal membrane thickness for the specific protein. 

In Rosetta, two movers are available that transform the protein into the membrane coordinate frame, both of which do a simple transformation based on protein topology information. **Be aware that currently NEITHER of these two movers uses the scoring function for optimal high-resolution positioning, even though this functionality will be added shortly.**

The **MembranePositionFromTopologyMover** uses the protein topology (SpanningTopology from the spanfile) and the structure to calculate an optimal position and orientation (center and normal) of the membrane, as represented by the MembraneResidue. This mover should only be used for a **fixed protein and a flexible membrane** (i.e. a protein residue is at the root of the FoldTree).

The **TransformIntoMembraneMover** does the reverse from above by using the protein topology and the protein structure to calculate an optimal position and orientation of the membrane to then rotate and translate the protein into this fixed coordinate frame. This mover should only be used for a **fixed membrane and a flexible protein** (i.e. the membrane residue is at the root of the FoldTree).

The MembraneResidue can be present as a MEM residue in the HETATOM record in the PDB file and is read in automatically by the AddMembraneMover. If more than one membrane residue is present in the PDB, the one that should be considered can be read in using the flag `-mp::setup::membrane_rsd <membrane residue number>`. An example of this residue is this:
 
```
HETATM 1323 THKN MEM C  81      15.000   0.000   0.000  1.00  0.00           X  
HETATM 1324 CNTR MEM C  81      -1.425  -1.441   0.354  1.00  0.00           X  
HETATM 1325 NORM MEM C  81       1.016  -3.866  14.954  1.00  0.00           X  
```

### Flags

`-in::file::s <PDB input file>` to read in a PDB file

`-mp::setup::membrane_rsd <membrane residue number>` to read in the membrane residue from a PDB file that was generated by the new membrane framework. 

### Example

`-in::file::s 1afo.pdb`

`-mp::setup::membrane_rsd 81`

## Lips File

### Description

A lips file describes the lipophilicity (i.e. lipid environment preference) of a residue in a helix. This information can be used to orient the helices in the membrane and distinguish lipid-facing vs. protein-facing residues. The Rosetta implementation uses the LIPS server from Adamian & Liang on the back-end. Updates are coming soon. 

#### Generate .lips4 file.

BRD4.lips4 - lipophilicity prediction file created using run\_lips.pl script as follows (note that blastpgp and nr database are necessary to run run\_lips.pl script

```
run_lips.pl <fasta file> <span file> <path to blastpgp> <path to nr database> <path to alignblast.pl script>
```

Example command:

```
<path to mini>/mini/src/apps/public/membrane_abinitio/run_lips.pl BRD4.fasta BRD4.span /work/bjornw/Apps/blast/bin/blastpgp /scratch/shared/genomes/nr ~bjornw/mini/src/apps/public/membrane_abinitio/alignblast.pl
```

Sample lips4 file:

```
Lipid exposed data: resnum mean-lipo lipophil entropy
      6  -1.000   3.004   1.211
      9  -1.000   2.268   2.137
     10  -1.000   4.862   1.095
     13  -1.000   1.304   1.552
     16  -1.000   3.328   2.025
  ...
```

### Flags

`-mp:setup:lipsfile 1afo.lips4`

NOTE: The flag for the original RosettaMembrane is `-in:file:lipofile 1afo.lips4` but this option will be deprecated. Please use the new flag!

### Example

An example of how the original RosettaMembrane used lips files can be found in `Rosetta/main/tests/integration/tests/membrane_abinitio`. This functionality has not yet been tested in the membrane framework.

## References
* Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol. - In Press
* Yarov-Yarovoy V, Schonbrun J, Baker D. (2006 Mar 1) Multipass membrane protein structure prediction using Rosetta. Proteins. 62(4):1010-25.
* Barth P, Schonbrun J, Baker D. (2007 Oct 2) Toward high-resolution prediction and design of transmembrane helical protein structures. Proc Natl Acad Sci U S A. 104(40):15682-7.
* Barth P, Wallner B, Baker D. (2009 Feb 3) Prediction of membrane protein structures with complex topologies using limited constraints. Proc Natl Acad Sci U S A. 106(5):1409-14.

## Contact

- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))
