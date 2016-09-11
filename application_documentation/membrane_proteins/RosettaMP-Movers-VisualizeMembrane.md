# Movers for Visualization: Visualize Membrane Mover

## Description

This Mover can be used in case visualization is done outside of Pymol. If you use Pymol, we advise using the built-in visualization of the PymolMover (ADD LINK HERE). It outputs hetero-atoms (HETATM) to the PDB file.

## RosettaScripts interface

The following options are available via RosettaScripts:
`spacing` - Float - Desired spacing of the HETATMs in the PDB output that represent the membrane bilayer.
`width` - Float - Half of the width of the membrane square visualized in the xy-plane. Default is 100A.
`thickness` - Float - Half (correct?) of the membrane thickness.

## Contact

- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## References

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol. - In Press


