# AveragePathLength
*Back to [[Filters|Filters-RosettaScripts]] page.*
## AveragePathLength

Computes the [average shortest path length](http://en.wikipedia.org/wiki/Average_path_length) on the "network" of the single-chain protein topology, considering residues as nodes and peptide and disulfide bonds as edges. Natural proteins with many disulfides tend to select disulfide configurations that minimize average path length, although average path length is a poorer metric for placing disulfides than the more correct [[DisulfideEntropyFilter]], so in general there is no longer a reason to use this filter.

Topologies will pass the filter if their average path length is lower than a fixed threshold (`max_path_length`) and a chain length-dependent threshold. The chain length-dependent threshold was computed by surveying natural proteins with 3 or greater disulfide bonds and 60 or fewer residues, and is computed as:

threshold = (0.1429 n) + 0.8635 + `     path_tightness    `

where n is the number of residues in the chain and `     path_tightness    ` is user specified. Larger values for path\_tightness lead to a higher (and thus looser) threshold.

```xml
<AveragePathLength name="&string" path_tightness="(1 &Real)" max_path_length="(10000 &Real)"/>
```

## See also:

* [[DisulfideEntropyFilter]]
* [[DisulfideFilter]]
