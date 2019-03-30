# RosettaMP Application: Symmetric Membrane Protien-Protein Docking (MPSymDock)

## Code and Demo
The membrane symmetric docking application is implemented as a C++ executable and can be found in `apps/public/membrane/mp_symdock.cc` 

A demo can be found in `Rosetta/demos/protocol_captures/mp_symdock`

Rosetta Revision #58096

## Background
Membrane proteins often assemble into symmetric complexes in the membrane environment. While the exact reason for internal symmetry is still debated, it has been suggested that symmetry enhances proteins stability and avoid traps in the energy landscape during conformational changes needed for function. The symmetric membrane protein-protein docking application combines the symmetry machinery, membrane framework, and symmetric docking application to assemble symmetric complexes in the membrane. 

## Algorithm
The application first constructs a symmetric membrane protein conformation from an asymmetric unit by placing a membrane virtual at the origin of the coordinate frame and arranging subunits around the membrane normal axis (cyclic symmetry). The symmetric docking application is then used to apply symmetric moves, packing operations, and iterations of scoring using the membrane all atom energy function to sample possible conformations. The ensemble of output models describe possible conformations of this complex in the membrane environment. 

This application currently only supports modeling of cyclic symmetries. 

## Example Command Lines
Membrane Symmetric Protein-Protein Docking is a C++ application in the Rosetta 3 software suite. 

```
./mp_symdock.<exe> -database /path/to/my/rosettadb @flags  
```

## Generating input files
The symmetric membrane protein-protein docking application requires two input files: 

1. Generating a Spanfile as described on the input generation page.
2. Generate a Symmetry definition file: 
Symmetry definition files describe the symmetry of the system and serve as instructions to Rosetta for building the full starting complex from an asymmetric unit. This file can be generated using the `make_symmdef_file.pl` script in `src/apps/public/symmetry/`. Detailed information for generation of symmetry definition files can be found at the [[make-symmdef-file]] page. In general, this script requires a PDB file, symmetry mode (NCS or PSEUDO only for membranes), specification of the asymmetric unit and symmetry group # if known. 

The symmetry definition file in this example was generated with the following commandline which is further explained in the supplementary material of the reference below. 

```
./make_symmdef_file.pl -m NCS -p 1afo.pdb -r 10.0 -a A -b B:2 
```

Symmetries can also be generated using a de novo protocol. If the user knows the symmetry group (e.g. C3), 
the user can generate a definition for this symmetry group independent of the structure. This script can 
be found in `src/apps/public/symmetry/make_symmdef_denovo.py`. More information for using this script can 
be found [[here|make-symmdef-file-denovo]].

## Options

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-mp:setup:spanfiles|Spanfile describing spanning topology of starting structure|String|
|-mp:scoring:hbond|Turn on depth-dependent hydrogen bonding term when using the membrane high resolution energy function|Boolean|
|--symmetry:symmetry_definition|Symmetry definition file|Path|
|-symmetry:initialize_rigid_body_dofs|Initialize rigid body configuration (symmetric)|Boolean|


## References
1. Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol. - In Press

2. DiMaio F, Leaver-Fay A, Bradley P, Baker D, André I (2011) Modeling Symmetric Macromolecular Structures in Rosetta3. PLoS ONE 6: e20450. 

3. Barth P, Schonbrun J, Baker D (2007) Toward high-resolution prediction and design of transmembrane helical protein structures. Proc Natl Acad Sci 104: 15682–15687. 

## Contact 
Questions and comments to: 

 - Rebecca F. Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

