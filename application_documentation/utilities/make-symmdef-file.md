#Symmetry Definition file creation script.

*Last edited May 31 2010 by Frank DiMaio. Code by Frank DiMaio and Ingemar Andre.*

Code and Demo
=============

All the code is contained in the Perl script src/apps/public/symmetry/make_symmdef_file.pl.

Application purpose
===========================================

This script automatically creates symmetry definition files corresponding to the symmetry in some template PDB. If the template is not symmetrical it is "symmetrized" by the script.

Limitations
===========

This routine does not create symmetry definition files for ab initio symmetric modeling with fold\_and\_dock. Use See [[make_symmdef_file_denovo|make-symmdef-file-denovo]] instead.

If the input PDB is very asymmetric, the output PDB may be very far from the input. Generally this is undesirable; you may want to model this system asymmetrically.

The following symmetry types are currently unsupported by the script:

-   Polar helical symmetries (a D *n* point group at each helical translation) are not understood by the script
-   Tetrahedral, octahedral and icosahedral point symmetries may be generated, but asymmetrical variations in the input file will not be "symmetrized" (as with C *n* and D *n* )
-   2D (wallpaper) symmetry is not created by the script. A limited number of 2D symmetries may be generated in HELIX mode (see the experimental -c option).
-   General 3D symmetries are not available in the script. The CRYST mode assumes a fixed unit cell size; systems where the unit cell size may change are not created by the script.

Modes
=====

The script currently recognizes three different symmetry types: noncrystallographic (point) symmetries, crystallographic symmetry, and helical symmetry. A fourth (experimental) option, "pseudo-symmetry," models a nonsymmetric system using the symmetry machinery to attempt to reduce the conformational space (and running time) of the search at the cost of some accuracy.

Options
=======

These options are common to all symmetry modes:

```
    -m (NCS|CRYST|HELIX|PSEUDO) : [default NCS] which symmetric mode to run
            NCS: generate noncrystallographic (point) symmetries from multiple chains in a PDB file
            CRYST: generate crystallographic symmetry (fixed unit cell) from the CRYST1 line in a PDB file
            HELIX: generate helical/fiber symmetry from multiple chains in a PDB file
            PSEUDO: (EXPERIMENTAL) generate pseudo-symmetric system
    -p <string> : Input PDB file (one of -b or -p _must_ be given)
    -r <real>   : [default 10.0] the max CA-CA distance between two interacting chains
    -f          : [default false] enable fast distance checking (recommended for large systems)
```

These options are common to noncrystallographic symmetry modes (NCS):

```
    -a <char>   : [default A] the chain ID of the main chain
    -i <char>   : [default B] the chain IDs of one chain in each symmetric subcomplex
```

These options are specific to crystallographic symmetry modes (CRYST):

```
    -c <real>x6 : override the unit cell parameters in the PDB with these values
    -s <string> : override the spacegroup in the PDB with these values
    -k <real>   : (EXPERIMENTAL) Approximate the protein as a ball of this radius (only if no '-p'!)
```

These options are specific to helical symmetry modes (HELIX):

```
    -a <char>   : [default A] the chain ID of the main chain
    -b <char>   : [default B] the chain ID of the next chain along the fiber/helix
    -i <char>   : the chain ID of a chain in -a's point symmetry group
    -t <real>   : [default 2] the number of helical turns to generate along the -b direction
    -c <char>   : (EXPERIMENTAL) the chain ID of the symm chain perpendicular to the -b chain (simple 2D symmetry)
    -u <real>   : (EXPERIMENTAL) [default 1] the number of repeats to generate along the -c direction
```

These options are specific to the (experimental) pseudo symmetry mode (PSEUDO):

```
    -a <char>   : [default A] the chain ID of the main chain
```

Expected Outputs
================

**NCS mode**

A sample command script (to generate D3 symmetry, with chains A, B, and C forming a point group and chains D,E, and F forming a second point group):

```
make_symmdef_file.pl -m NCS -p D3.pdb -a A -i B E -r 12 > D3.symm
```

Several files are generated:

-   **D3.symm** – the symmetry definition file to send to Rosetta
-   D3\_symm.pdb – the symmetrized version of the input file, showing the complete point symmetry group.
-   D3\_model\_ABE.pdb – the same as above, but only showing chains that form an interface (where interface is defined by having a Ca-Ca distance less than 12 (-r 12) A) with chain A
-   D3\_INPUT.pdb – the input PDB to Rosetta's symmetry modeling. A single chain in the symmetric complex.
-   D3.kin – a KineMage image showing the connectivity of subunits in Rosetta

**CRYST mode**

Sample command script (using the CRYST1 line in the PDB file):

```
make_symmdef_file.pl -m CRYST -p p65.pdb > p65.symm
```

Several files are generated:

-   **p65.symm** – the symmetry definition file to send to Rosetta
-   p65\_symm.pdb – the symmetrized version of the input file, showing the input structure and all crystal contacts.

The input PDB (to Rosetta) in this case is simply 'p65.pdb', the input file sent to the script.

**HELIX mode**

Sample command script (with chains A, C, E, ... tracing up the helical axis and B, D, F, ... forming C2 symmetries up the axis):

```
make_symmdef_file.pl -m HELIX -p fiber.pdb -a A -b C -i B -r 12 -t 5 > fiber.symm
```

Several files are generated:

-   **fiber.symm** – the symmetry definition file to send to Rosetta
-   fiber\_symm.pdb – the symmetrized version of the input file, showing all '-t' turns of the helix
-   fiber\_model\_ACB.pdb – the same as above, but only showing chains that form an interface (where interface is defined by having a Ca-Ca distance less than 12 (-r 12) A) with chain A
-   fiber\_INPUT.pdb – the input PDB to Rosetta's symmetry modeling. A single chain in the symmetric complex.

A total of 5 turns of the helix (-t 5) are generated.

Alternately, a helical twist can be forced by appending : *n* to the helical chain. For example, the command script:

```
make_symmdef_file.pl -m HELIX -p fiber2.pdb -a A -b B:3 > fiber2.symm
```

forces the helix to have 3 subunits per turn.

Tips
====

Make sure that the system in \*\_symm.pdb looks right before submitting a symmetric refinement job!

## See Also

* [[Types of input files | file-types-list]] used in Rosetta.
* [[Symmetry]]: on symmetry mode
* [[Utility applications | utilities-applications]]: other utility applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
