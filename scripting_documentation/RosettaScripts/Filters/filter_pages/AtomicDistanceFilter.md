# AtomicDistance
*Back to [[Filters|Filters-RosettaScripts]] page.*
## AtomicDistance

Are two specified atoms within a cutoff distance? More specific than AtomicContact (which reports if *any* atom is within the cutoff) or ResidueDistance (which works by neighbor atoms only). Residues can be specified either with pose numbering, or with PDB numbering, with the chain designation (e.g. 34B). One of atomname or atomtype (but not both) needs to be specified for each partner. If atomtype is specified (using the [[Rosetta AtomTypes]] for the atoms) for one or both atoms, the closest distance of all relevant combinations is used.

```xml
<AtomicDistance name="(&string)" residue1="(&string)" atomname1="(&string)" atomtype1="(&string)" residue2="(&sring)" atomname2="(&string)" atomtype2="(&string)" distance="(4.0 &integer)"/>
```
## See Also

* [[AtomicContactFilter]]
* [[AtomicContactCountFilter]]
* [[ResidueCountFilter]]
* [[ResidueDistanceFilter]]

