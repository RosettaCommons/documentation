# DisulfideFilter
*Back to [[Filters|Filters-RosettaScripts]] page.*
## DisulfideFilter

Require a disulfide bond between the interfaces to be possible. 'Possible' is taken fairly loosely; a reasonable centroid disulfide score is required (fairly close CB atoms without too much angle strain).

Residues from `     targets    ` are considered when searching for a disulfide bond. As for [[DisulfideMover|Movers-RosettaScripts#DisulfideMover]] , if no residues are specified from one interface partner all residues on that partner will be considered.

```xml
<DisulfideFilter name="&string" targets="(&string)"/>
```

-   targets: A comma-seperated list of residue numbers. These can be either with rosetta numbering (raw integer) or pdb numbering (integer followed by the chain letter, eg '123A'). Targets are required to be located in the interface. Default: All residues in the interface. *Optional*

## See also:

* [[AveragePathLengthFilter]]
* [[DisulfideFilter]]
