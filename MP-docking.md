## Metadata

Questions and comments to: 
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Rebecca F. Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Updated: 2/17/15

## Citation
Rosetta Revision #57518

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Elazar A, Tilley DC, Gray JJ (2015)
An integrated framework advancing membrane protein modeling and design
PLoS ONE (in preparation) 

## Algorithm Description
Structure determination of protein-protein complexes in the membrane bilayer is extraordinarily difficult due to the requirement for the membrane mimetic to maintain stability of the complex and because many complexes exceed the molecular weight limit for NMR spectroscopy. We combined RosettaMP with the RosettaDock algorithm to predict structures of protein-protein complexes in the membrane bilayer. The protocol consists of two steps: (1) a prepacking step to create a starting structure, and (2) protein-protein docking in the membrane bilayer. In the pre-packing step, the two partners are first separated by a large distance (keeping their membrane embedding constant), the side chains are repacked using rotamer trials, and the partners are moved back together. Next, the docking step samples random interface conformations using a score function that is created by combining the standard docking score functions with the membrane score terms (both in the low-resolution and all-atom stages). The membrane bilayer is kept fixed during this simulation. 

## Code and Demo
This application uses RosettaMP. Detailed information of how to run it can be found in Rosetta/demos/protocol_captures/2015/mpdocking. 

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