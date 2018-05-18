## Metadata

Questions and comments to:

- Julia Koehler Leman (julia.koehler1982@gmail.com)
- Rebecca Alford (rfalford12@gmail.com)
- Corresponding PI: Jeffrey J. Gray (jgray@jhu.edu)

Last Updated: 2/8/18

## Description

This Mover relaxes a membrane protein by iteratively relaxing ranges of the protein; no ramping required. It is much faster than FastRelax and good for large to very large proteins (tested up to 5250 residues).

## Code and Demo

The Mover lives in `main/source/src/protocols/relax/membrane/`.

## RosettaScripts interface

The following options are available within the RosettaScript interface:

`native` - String - Provide the native PDB file.
`sfxn` - String - Provide the score function weights file name.
`center_resnumber` - Integer - Provide the center residue number.
`set_tm_helical` - bool - Set helical secondary structure in TM region.
`optmem` - bool - Set option to optimize membrane.

## Flags / Options

|**Flag**|**Description**|
|:-------|:--------------|
|`-mp::transform::optimize_embedding <bool>` | Use the scorefunction to optimize the embedding after an initial coarse grained setting. |

## Reference

RosettaMP is described in 

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Elazar A, Tilley DC, Gray JJ (2015) An integrated framework advancing membrane protein modeling and design, PLoS Computational Biology (in press)
