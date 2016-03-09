## Metadata

The Rosetta Membrane Framework was developed by Julia Koehler Leman and Rebecca Alford at the Gray Lab at JHU. 
Last updated: 12/12/14. 

For questions please contact: 
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## Description

A spanfile is a file format used by Rosetta for modeling of alpha-helical membrane proteins. It contains the number, length and sequence position of trans-membrane helices. A spanfile is generated using the sequence-based transmembrane helix prediction tool OCTOPUS ([http://octopus.cbr.su.se/](http://octopus.cbr.su.se/)) from a FASTA file. 

### Generate transmembrane regions (OCTOPUS) file:

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

### Convert OCTOPUS file to .span file format:

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

## Flags

Spanfiles are read in using the option `-mp::setup::spanfiles <spanfile 1> <spanfile 2>`. While most of the Membrane Framework only uses the first spanfile (check your log file!!!), some specific applications might use two or more: the MPDocking setup uses two. If in doubt, check your log carefully. 
 
## Example

`-mp::setup::spanfiles 1afo.span`

NOTE: The flag for the original RosettaMembrane is `-in:file:spanfile 1afo.span` but this option will be deprecated. Please use the new one. 

## References

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Tilley D, Elazar A, Gray JJ. (2015) An integrated framework enabling computational modeling and design of Membrane Proteins. PlosOne - in preparation 

## References for original RosettaMembrane

* Yarov-Yarovoy V, Schonbrun J, Baker D. (2006 Mar 1) Multipass membrane protein structure prediction using Rosetta. Proteins. 62(4):1010-25.
* Barth P, Schonbrun J, Baker D. (2007 Oct 2) Toward high-resolution prediction and design of transmembrane helical protein structures. Proc Natl Acad Sci U S A. 104(40):15682-7.
* Barth P, Wallner B, Baker D. (2009 Feb 3) Prediction of membrane protein structures with complex topologies using limited constraints. Proc Natl Acad Sci U S A. 106(5):1409-14.
