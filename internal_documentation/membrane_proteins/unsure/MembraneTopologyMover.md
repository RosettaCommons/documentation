# MembraneTopology
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MembraneTopology

Simple wrapper around the MembraneTopology object in core/scoring. Takes in a membrane span file and inserts the membrane topology into the pose cache. The pose can then be used with a membrane score function.

```
<MembraneTopology name=(&string) span_file=(&string)/>
```

Span files have the following structure:

-   comment line
-   1 23 number of tm helices, number of residues
-   parallel topology
-   n2c n2c or c2n
-   1 27 1 27 the residue spans in rosetta-internal numbering. For some reason needs to be written twice for each membrane span


