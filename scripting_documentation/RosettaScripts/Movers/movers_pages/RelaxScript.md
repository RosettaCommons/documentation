# Relax Scripts in Database

*Back to [[FastRelax|FastRelaxMover]] page.*

*Back to [[FastDesign|FastDesignMover]] page.*

## Available Scripts

| Script Name | Description |
| ----------- | ----------- |
| default     | always points to the recommended script to use. Currently points to "legacy" |
| legacy      | The default relax script used until 2019 |
| no_cst_ramping | TODO |
| rosettacon2018 | Slightly stronger repulsive term than default. Send questions to jack@med.unc.edu |
| KillA2019 | Similar to rosettacon2018 but incorporates reference-value ramping to ensure that the designs have native-like amino acid distributions. Send questions to jack@med.unc.edu |

All scripts exist in `main/database/sampling/relax_scripts`

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