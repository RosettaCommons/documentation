# SwitchChainOrder
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SwitchChainOrder

Reorder the chains in the pose, for instance switching between chain B and A. Can also be used to cut out a chain from the PDB (simply state which chains should remain after cutting out the undesired chain).

```xml
<SwitchChainOrder name="(&string)" chain_order="(&string)"/>
```

chain_order: a string of chain numbers. This is the order of chains in the new pose. For instance, "21" will form a pose ordered B then A, "12" will change nothing. Can also be used to reduce the number of chains. For example "1" will only take the first chain. PDBInfoLabels are preserved.

[[include:mover_SwitchChainOrder_type]]


-   chain\_order: a string of chain numbers. This is the order of chains in the new pose. For instance, "21" will form a pose ordered B then A, "12" will change nothing.


##See Also

* [[I want to do x]]: Guide to choosing a mover
* [[AddChainMover]]
* [[AddChainBreakMover]]
* [[AlignChainMover]]
* [[BridgeChainsMover]]
* [[StartFromMover]]
