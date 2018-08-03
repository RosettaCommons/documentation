# Relax Scripts in Database

*Back to [[FastRelax|FastRelaxMover]] page.*

*Back to [[FastDesign|FastDesignMover]] page.*


## Available Scripts

| Script Name | Description | Recommended For |
| ----------- | ----------- | --------------- |
| default     | | Everything, in general |
| no_cst_ramping | TODO | |
| rosettacon2018 | Slightly stronger repulsive term than default. | Monomer core redesign/repacking and interface design/repacking. |

## Examples

```xml
<FastRelax name="example1" relaxscript="default"/>

<FastDesign name="example2" relaxscript="default" dualspace="1"/>

<FastDesign name="example3" relaxscript="rosettacon2018"/>
```

##See Also
* [[FastRelaxMover]]
* [[FastDesignMover]]
* [[Relax]]: The relax application
* [[Preparing structures]]: Page on preparing structures for use in Rosetta using relax.
* [[I want to do x]]: Guide to chosing a mover