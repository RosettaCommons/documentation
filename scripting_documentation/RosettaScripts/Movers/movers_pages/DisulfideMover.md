# DisulfideMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## DisulfideMover

Introduces a disulfide bond into the interface. The best-scoring position for the disulfide bond is selected from among the residues listed in `     targets    ` . This could be quite time-consuming, so specifying a small number of residues in `     targets    ` is suggested.

If no targets are specified on either interface partner, all residues on that partner are considered when searching for a disulfide. Thus including only a single residue for `     targets    ` results in a disulfide from that residue to the best position across the interface from it, and omitting the `     targets    ` param altogether finds the best disulfide over the whole interface.

Disulfide bonds created by this mover, if any, are guaranteed to pass a DisulfideFilter.

```xml
<DisulfideMover name="&string" targets="(&string)"/>
```

-   targets: A comma-seperated list of residue numbers. These can be either with rosetta numbering (raw integer) or pdb numbering (integer followed by the chain letter, eg '123A'). Targets are required to be located in the interface. Default: All residues in the interface. *Optional*



##See Also

* [[ForceDisulfidesMover]]
* [[DisulfidizeMover]]
* [[RemodelMover]]
* [[I want to do x]]: Guide to choosing a mover
