## Metadata

Questions and comments to:

- Julia Koehler Leman (julia.koehler1982@gmail.com)
- Rebecca Alford (rfalford12@gmail.com)
- Corresponding PI: Jeffrey J. Gray (jgray@jhu.edu)

Last Updated: 2/8/18

## Description

This Mover docks two membrane proteins. It adds membrane components to the pose, then docks proteins along the flexible jump. **It assumes that protein 1 is fixed in the membrane.** 

## Code and Demo

The Mover lives in `main/source/src/protocols/docking/membrane/`.

## RosettaScripts interface

The following options are available within the RosettaScript interface:

`cen_sfxn_weights` - string - Set weight for the low resolution scorefunction.
`fa_sfxn_weights` - string - Set weight for the high resolution scorefunction.
`center` - RealVector - Membrane center x, y, z.
`normal` - RealVector  - membrane normal x, y, z.
`jump_num` - Size - Description.

## Flags / Options

|**Flag**|**Description**|
|:-------|:--------------|
|`-mp::dock::weights_cen <String>` | Scorefunction for low-resolution step. |
|`-mp::dock::weights_fa <String>` | Scorefunction for high-resolution step. |

## Reference

RosettaMP is described in 

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Elazar A, Tilley DC, Gray JJ (2015) An integrated framework advancing membrane protein modeling and design, PLoS Computational Biology (in press)
