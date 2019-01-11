## Metadata

Questions and comments to:

- Julia Koehler Leman (julia.koehler1982@gmail.com) 
- Rebecca Alford (rfalford12@gmail.com)
- Corresponding PI: Jeffrey J. Gray (jgray@jhu.edu)

Last Updated: 2/8/18

## Description

This Mover is used in the global membrane protein docking protocol (the MPFindInterfaceMover). The first partner is fixed in the membrane and this Mover spins the second (movable) partner around the first partner in the membrane. The Mover samples a random position within a 100 A square and then docks the partners together using the DockingSlideIntoContactMover from the general docking protocol. [The DockingSlideIntoContactMover was adjusted such that the stepsize depends on the distance between the partners and not in 1A steps - this is considerably faster than the latter.]

## Code and Demo

The Mover lives in `main/source/src/protocols/membrane`.

## RosettaScripts interface

The following options are available within the RosettaScript interface:

`jump_num` - Integer - Provide the jump number.
`rand_range` - bool - Set random range.
`range` - Integer - Provide the sampling range.
`x` - Real - Set x position.
`y` - Real - Set y position.

## Flags / Options

|**Flag**|**Description**|
|:-------|:--------------|
|`-mp::setup::spanfiles <spanfile>` | Add spanfile when registering options from Command Line. |

## Reference
RosettaMP and previous protocols were published in:

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Elazar A, Tilley DC, Gray JJ (2015) An integrated framework advancing membrane protein modeling and design, PLoS Computational Biology (in press)
