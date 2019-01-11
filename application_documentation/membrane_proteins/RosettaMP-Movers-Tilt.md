## Metadata

Questions and comments to:

- Julia Koehler Leman (julia.koehler1982@gmail.com) 
- Rebecca Alford (rfalford12@gmail.com)
- Corresponding PI: Jeffrey J. Gray (jgray@jhu.edu)

Last Updated: 2/8/18

## Description

This Mover is used in the global docking protocol (MPFindInterfaceMover) and tilts a span, protein or partner in the membrane, depending on the jump number. The tilted partner will be the downstream partner. Be aware: the jump number can NOT be the membrane jump! The tilt axis is the axis perpendicular to the axis connecting the embedding centers of the two partners. There is also the option to set a random tilt angle in the range of +/-45 degrees around the normal. 

## Code and Demo

The Mover lives in `main/source/src/protocols/membrane`.

## RosettaScripts interface

The following options are available within the RosettaScript interface:

`jump_num` - Integer - Provide the jump number.
`angle` - Real - Provide the rotation angle in degrees.
`random_angle` - bool - Random tilt angle between -20 and 20 degrees.

## Flags / Options

|**Flag**|**Description**|
|:-------|:--------------|
|`-mp::setup::spanfiles <spanfile>` | Add spanfile when registering options from Command Line. |

## Reference
RosettaMP and previous protocols were published in:

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Elazar A, Tilley DC, Gray JJ (2015) An integrated framework advancing membrane protein modeling and design, PLoS Computational Biology (in press)
