# ResidueSetChainEnergy
*Back to [[Filters|Filters-RosettaScripts]] page.*
## ResidueSetChainEnergy

Computes the interaction energy between 2 groups of residues: 1. a set of residues and 2. all residues on a given chain. The groups may overlap. Useful for biasing design to back up a grafted loop or epitope. Group1 is defined with resnums, a list of residue numbers (1,2,3 for pose numbering or 1A,2A,3A for pdb numbering). Group2 is defined with chain, which is the rosetta chain number. If the residue set (Group1) is on the same chain as the user-defined chain (Group2), then the energy does include intra-group1 energies.

```xml
<ResidueSetChainEnergy name="(residue_set_chain_energy_filter &string)" scorefxn="(score12 &string)" score_type="(total_score &string)" resnums="(&string)" chain="(0 &int)" threshold="(&float)"/>
```

## See also

* [[Design in Rosetta|application_documentation/design/design-applications]]
* [[EnergyPerResidueFilter]]
* [[PackRotamersMover]]
* [[ResidueIEFilter]]
