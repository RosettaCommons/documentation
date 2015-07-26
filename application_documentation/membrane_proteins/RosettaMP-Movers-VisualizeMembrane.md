## Metadata

Questions and comments to:

- Rebecca Alford (rfalford12@gmail.com)
- Julia Koehler Leman (julia.koehler1982@gmail.com)
- Corresponding PI: Jeffrey J. Gray (jgray@jhu.edu)

Last Updated: 4/26/15

## Description

This Mover can be used in case visualization is done outside of Pymol. If you use Pymol, we advise using the built-in visualization of the PymolMover (ADD LINK HERE). It outputs hetero-atoms (HETATM) to the PDB file.

## Code and Demo

The Mover lives in `main/source/src/protocols/membrane/visualize`.

## RosettaScripts interface

The following options are available via RosettaScripts:
`spacing` - Float - Desired spacing of the HETATMs in the PDB output that represent the membrane bilayer.
`width` - Float - Half of the width of the membrane square visualized in the xy-plane. Default is 100A.
`thickness` - Float - Half (correct?) of the membrane thickness.

## Reference
This Mover is currently unpublished. RosettaMP and previous protocols were published in:

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Elazar A, Tilley DC, Gray JJ (2015) An integrated framework advancing membrane protein modeling and design, PLoS Computational Biology (in press)
