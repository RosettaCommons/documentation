# DomainAssembly
*Back to [[Mover|Movers-RosettaScripts]] page.*
## DomainAssembly (Not tested thoroughly)

Do domain-assembly sampling by fragment insertion in a linker region. frag3 and frag9 specify the fragment-file names for 9-mer and 3-mer fragments.

```xml
<DomainAssembly name="(&string)" linker_start_(pdb_num/res_num, see below) linker_end_(pdb_num/res_num, see below) frag3="(&string)" frag9="(&string)"/>
```

-   pdb\_num/res\_num: see the main [[RosettaScripts Documentation|RosettaScripts#rosettascripts-conventions_specifying-residues]] for more.


