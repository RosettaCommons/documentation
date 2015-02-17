## Metadata

Authors: 
 - Author: Rebecca F. Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Updated: 2/17/15

## Citation
Rosetta Revision #57518

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Elazar A, Tilley DC, Gray JJ (2015)
An integrated framework advancing membrane protein modeling and design
PLoS ONE (in preparation) 

## About
Structural refinement can reveal an ensemble of states describing the conformation of a protein. It is also necessary to advance many low resolution structures determined by x-ray crystallography to atomic-level detail. These refined structures are used as inputs to several modeling protocols such as protein-protein docking, ligand docking, etc. 

## Algorithm Description
The membrane relax application combines the traditional fast relax algorithm with the membrane all atom energy function and an additional step for optimizing the membrane position. To refine the protein structure, several iterations to sample backbone and side chain conformations. In addition, the relative orientation of the membrane and protein is sampled by minimizing the transform in the membrane jump. Combination of high-resolution refinement and orienting the membrane position allows for simultaneous refinement of structure and optimization of membrane embedding. 

## Code and Demo
This application uses the membrane framework and is implemented as a Rosetta script. The script can be found in the Rosetta/demos/protocol_captures/2014/mpframework-relax directory called membrane_relax.xml which is passed to the rosetta_scripts executable. 

## Generating Inputs
The membrane relax application requires 1 input file: 

  1. Generating a Spanfile
  A spanfile describing transmembrane spanning regions can be generated using the OCTOPUS server (http://octopus.cbr.su.se/). This file must be converted to a Rosetta spanfile format using octopus2span.pl. Example command is given below: 

```
cd mpframework-relax/scripts/
./octopus2span.pl octopus_pred.out > spanfile.txt
```

## Options

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-parser:protocol <membrane_relax.xml>|Specify membrane relax protocol to rosetta scripts executable|XML Script|
|-membrane_new:setup:spanfiles|Spanfile describing spanning topology of starting structure|String|
|-membrane_new:scoring:hbond|Turn on depth-dependent hydrogen bonding term when using the membrane high resolution energy function|Boolean|
|-packing:prepack_missing_sidechains false|Wait to repack sidechains during pdb initialization until the membrane pose is fully initialized with the membrane framework|Boolean|

## Example Command Lines
To run this application, use the following command line: 

`./rosetta_scripts.<exe> -database /path/to/my/rosettadb @flags`

## References
1. Tyka MD, Keedy DA, Andre I, DiMaio F, Song Y, et al. (2011) Alternate states of proteins revealed by detailed energy landscape mapping. J Mol Biol. 

2. Barth P, Schonbrun J, Baker D (2007) Toward high-resolution prediction and design of transmembrane helical protein structures. Proc Natl Acad Sci 104: 15682–15687. 

3. Fleishman SJ, Leaver-Fay A, Corn JE, Strauch E-M, Khare SD, et al. (2011) RosettaScripts: A Scripting Language Interface to the Rosetta Macromolecular Modeling Suite. PLoS ONE 6: e20161. 