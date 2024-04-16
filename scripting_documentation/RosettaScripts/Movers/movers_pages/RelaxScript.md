# Relax Scripts in Database

*Back to [[FastRelax|FastRelaxMover]] page.*

*Back to [[FastDesign|FastDesignMover]] page.*

## Available Scripts

| Script Name | Description |
| ----------- | ----------- |
| default     | Currently an alias for MonomerRelax2019 or MonomerDesign2019 (if you are designing) |
| legacy      | The default relax script used until August 13, 2019 |
| no_cst_ramping | |
| rosettacon2018 | **(deprecated)** Slightly stronger repulsive term in the early rounds. This script was created for people to play with but has since been optimized (see below). Send questions to jack@med.unc.edu |
| MonomerRelax2019 | Same family as rosettacon2018, optimized for non-interface relax runs |
| MonomerDesign2019 | Same family as rosettacon2018, optimized for non-interface design runs |
| InterfaceRelax2019 | Same family as rosettacon2018, optimized for interface relax runs |
| InterfaceDesign2019 | Same family as rosettacon2018, optimized for interface design runs |
| KillA2019 | Similar to MonomerDesign2019 (which works as a good one-size-fits-all script) but incorporates reference-value ramping to ensure that the designs have native-like amino acid distributions |

All scripts exist in `main/database/sampling/relax_scripts`

## Examples

```xml
<FastRelax name="example1" relaxscript="default"/>

<FastDesign name="example2" relaxscript="KillA2019"/>
```

##See Also
* [[FastRelaxMover]]
* [[FastDesignMover]]
* [[Relax]]: The relax application
* [[Preparing structures]]: Page on preparing structures for use in Rosetta using relax.
* [[I want to do x]]: Guide to chosing a mover
