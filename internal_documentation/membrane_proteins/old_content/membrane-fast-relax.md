[[_TOC_]]

## Metadata

Authors: 
 - Author: Rebecca F. Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Updated: May 2015

## Citation
Rosetta Revision #57518

Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Tiley DC, Elazar A, Gray JJ (2015)
An integrated framework advancing membrane protein modeling and design
PLosCompBio (Under Review) 

## About
High-resolution refinement is key for advancing low resolution structures from x-ray
crystallography to atomic level detail. For membrane proteins, this method can also
reveal an ensemble of possible membrane embeddings: the position and orientation of 
the biomolecule with respect to the membrane bilayer. 

## Description
The membrane relax application combines the Rosetta FastRelax algorithm with the
all atom energy function for membrane proteins and a gradient-based technique 
for optimizing the membrane embedding. First, a series of small backbone moves, 
rotamer trials, and minimization are used to refine the protein structure. In addition, 
the membrane position is optimized by minimizing the "jump" or connecting relating
the MEM residue to the biomolecule. 

This protocol is currently designed for single chain refinement with an MEM jump. Further
consideration needed by the user for multiple chains 

## Code and Demo
The membrane protein refinement application, MPrelax is implemented as a Rosetta Script and can be found in `apps/public/membrane/mp_relax.xml` which can be passed as input to the `rosetta_scripts` executable

A demo for this application including detailed steps, command lines, and example inputs can be found in `Rosetta/demos/protocol_captures/2015/MPrelax`. 


## Generating Inputs
Two inputs are required for the membrane relax application: 
  (1) PDB for the protein structure of interest
  (2) Span file describing the location of trans-membrane spans

Steps for generating these inputs are found below. A set of example inputs can 
also be found in the demo directory. Here, Metarhodopsin II (PDB ID: 3pxo) is 
used as an example: 

1. PDB File: Generate a PDB file where the membrane protein structure is transformed 
   into PDB coordinates (z-axis is membrane normal). This can be done 
   either by downloading the transformed PDB directly from the PDBTM website 
   (http://pdbtm.enzim.hu/) or by downloading a PDB file from the PDB and running
   it through the PPM server (http://opm.phar.umich.edu/server.php).

2. Span File: Generate a spanfile from the PDB structure using
   the spanfile_from_pdb application described in the MP_spanfile-from-pdb protocol
   capture in Rosetta/demos/protocol_captures/2014. An example commandline using 
   3pxo is also provided here: 

```   
Rosetta/main/source/bin/spanfile_from_pdb.linuxgccrelease -database /path/to/db -in:file:s example_inputs/3pxo_tr.pdb
```
   For this example, this command will produce 1 output file: 
     = 3pxo_tr.span: Spanfile containing predicted trans-membrane spans

```
cd mpframework-relax/scripts/
./octopus2span.pl octopus_pred.out > spanfile.txt
```

## Options

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-parser:protocol <mp_relax.xml>|Use the membrane relax protocol Rosetta script|XML Script|
|-mp:setup:spanfiles|Spanfile describing spanning topology of starting structure|String|
|-mp:scoring:hbond|Turn on depth-dependent hydrogen bonding term when using the membrane high resolution energy function|Boolean|
|-relax:fast|Use the FastRelax mode of Rosetta Relax (uses 5-8 repeat cycles)|Boolean|
|-relax:jump_move|Allow the MEM and other jumps to move during refinement|Boolean|
|-packing:prepack_missing_sidechains false|Wait to repack sidechains during pdb initialization until the membrane pose is fully initialized with the membrane framework|Boolean|

## Example Command Lines
To run this application, use the following command line: 

`./rosetta_scripts.<exe> -database /path/to/my/rosettadb @flags`

## References
1. Tyka MD, Keedy DA, Andre I, DiMaio F, Song Y, et al. (2011) Alternate states of proteins revealed by detailed energy landscape mapping. J Mol Biol. 

2. Barth P, Schonbrun J, Baker D (2007) Toward high-resolution prediction and design of transmembrane helical protein structures. Proc Natl Acad Sci 104: 15682–15687. 

3. Fleishman SJ, Leaver-Fay A, Corn JE, Strauch E-M, Khare SD, et al. (2011) RosettaScripts: A Scripting Language Interface to the Rosetta Macromolecular Modeling Suite. PLoS ONE 6: e20161. 