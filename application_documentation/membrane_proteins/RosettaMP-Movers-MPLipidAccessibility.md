## Metadata

Questions and comments to:

- Julia Koehler Leman (julia.koehler1982@gmail.com)
- Rebecca Alford (rfalford12@gmail.com)
- Corresponding PI: Jeffrey J. Gray (jgray@jhu.edu)

Last Updated: 2/8/18

## Description

This Mover computes which residues are lipid accessible and puts that information into the B-factors: 50 is lipid accessible, 0 is lipid INaccessible. 

## Code and Demo

The Mover lives in `main/source/src/protocols/membrane/`.

Algorithm: First, it sets the B-Factor to zero for all atoms. Then it computes concave and outer hulls and goes through the slices. Residues that are on the boundary are lipid-exposed. If the angle between COM-CA-CB is smaller than the cutoff, then it is not lipid-exposed.

## RosettaScripts interface

The following options are available within the RosettaScript interface:

`angle_cutoff` - Real - Provide the angle cutoff.
`slice_width` - Real - Provide the slice width.
`shell_radius` - Real - Provide the shell radius.
`dist_cutoff` - Real - Provide the distance cutoff.
`tm_alpha` - bool - Provide the tm_alpha.


## Flags / Options

|**Flag**|**Description**|
|:-------|:--------------|
|`-mp::lipid_acc::angle_cutoff <Real>` | Cutoff for CA-CB-COM angle to identify lipid accessible residues, in degrees. < 90 faces towards COM, > 90 faces away from COM. Default = 65. For smaller proteins like GPCRs (number of spans <= 7), default = 45. |
|`-mp::lipid_acc::slice_width <Real>` | Width of the slice in Angstrom to compute hull. Default = 10.0.  |
|`-mp::lipid_acc::shell_radius <Real>` | Radius of shell from outermost atoms that are still counted as boundary, i.e. how thick is lipid-exposed layer from the outside. Default = 6.0. |
|`-mp::lipid_acc::dist_cutoff <Real>` | Distances between boundary atoms longer than this cutoff (in 2D) will be cut in. Anything larger will be kept as boundary atoms. Default = 10.0. |
|`-mp::lipid_acc::tm_alpha <Bool>` | Is the main secondary structure in the membrane helical? Default = true.  |

## Reference

RosettaMP is described in 

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Elazar A, Tilley DC, Gray JJ (2015) An integrated framework advancing membrane protein modeling and design, PLoS Computational Biology (in press)
