## Metadata

The Rosetta Membrane Framework was developed by Julia Koehler Leman and Rebecca Alford at the Gray Lab at JHU. 
Last updated: 12/12/14. 

For questions please contact: 
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## Description

A lips file describes the lipophilicity (i.e. lipid environment preference) of a residue in a helix. This information can be used to orient the helices in the membrane and distinguish lipid-facing vs. protein-facing residues. The Rosetta implementation uses the LIPS server from Adamian & Liang on the back-end. Updates are coming soon. 

### Generate .lips4 file.

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

## Code and documentation

`core/conformation/membrane` contains the LipidAccInfo class that stores the information from the lips file. 

## Flags

`-mp:setup:lipsfile 1afo.lips4`

NOTE: The flag for the original RosettaMembrane is `-in:file:lipofile 1afo.lips4` but this option will be deprecated. Please use the new flag!

## Example

An example of how the original RosettaMembrane used lips files can be found in `Rosetta/main/tests/integration/tests/membrane_abinitio`. This functionality has not yet been tested in the membrane framework.

## References

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Tilley D, Elazar A, Gray JJ. (2015) An integrated framework enabling computational modeling and design of Membrane Proteins. PlosOne - in preparation 

## References for original RosettaMembrane

* Yarov-Yarovoy V, Schonbrun J, Baker D. (2006 Mar 1) Multipass membrane protein structure prediction using Rosetta. Proteins. 62(4):1010-25.
* Barth P, Schonbrun J, Baker D. (2007 Oct 2) Toward high-resolution prediction and design of transmembrane helical protein structures. Proc Natl Acad Sci U S A. 104(40):15682-7.
* Barth P, Wallner B, Baker D. (2009 Feb 3) Prediction of membrane protein structures with complex topologies using limited constraints. Proc Natl Acad Sci U S A. 106(5):1409-14.
