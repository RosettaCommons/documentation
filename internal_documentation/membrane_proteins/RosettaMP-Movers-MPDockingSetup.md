## Metadata

Questions and comments to:

- Julia Koehler Leman (julia.koehler1982@gmail.com)
- Rebecca Alford (rfalford12@gmail.com)
- Corresponding PI: Jeffrey J. Gray (jgray@jhu.edu)

Last Updated: 2/1/18

## Description

This Mover reads in 2 poses and 2 spanfiles, concatenates them, and prints them out. It currently only works for 2 poses.

## Code and Demo

The Mover lives in `main/source/src/protocols/docking/membrane/`.

## RosettaScripts interface

TODO: Currently not compatible with RosettaScripts. 

## Flags / Options

|**Flag**|**Description**|
|:-------|:--------------|
|`-mp::setup::optimize1 <Type>` | Optimize partner 1 when intializing from cmd. |
|`-mp::setup::optimize2 <Type>` | Optimize partner 2 when intializing from cmd. |

## Reference

Currently unpublished. RosettaMP is described in 

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Elazar A, Tilley DC, Gray JJ (2015) An integrated framework advancing membrane protein modeling and design, PLoS Computational Biology (in press)
