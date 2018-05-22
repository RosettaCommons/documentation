## Metadata

Questions and comments to:

- Julia Koehler Leman (julia.koehler1982@gmail.com)
- Rebecca Alford (rfalford12@gmail.com)
- Corresponding PI: Jeffrey J. Gray (jgray@jhu.edu)

Last Updated: 2/8/18

## Description

This Mover optimizes the protein embedding in the membrane given the smooth high-res score function; transforms the protein into the membrane, optimizes the membrane position (flexible), and uses the optimized embedding to reposition the protein in the membrane.

## Code and Demo

The Mover lives in `main/source/src/protocols/membrane/`.

## RosettaScripts interface

TODO: Currently not compatible with RosettaScripts. 

## Flags / Options

|**Flag**|**Description**|
|:-------|:--------------|
|`-mp::transform::optimize_embedding <bool>` | Use the scorefunction to optimize the embedding after an initial coarse grained setting. |

## Reference

RosettaMP is described in 

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Elazar A, Tilley DC, Gray JJ (2015) An integrated framework advancing membrane protein modeling and design, PLoS Computational Biology (in press)
