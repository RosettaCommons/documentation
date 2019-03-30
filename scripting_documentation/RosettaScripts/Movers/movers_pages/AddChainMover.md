# AddChain
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AddChain

Reads a PDB file from disk and concatenates it to the existing pose.

```xml
<AddChain name="(&string)" file_name="(&string)" new_chain="(1&bool)" scorefxn="(score12 &string)" random_access="(0&bool)" swap_chain_number="(0 &Size)"/>
```

-   file\_name: the name of the PDB file on disk.
-   new\_chain: should the pose be concatenated as a new chain or just at the end of the existing pose?
-   scorefxn: used for scoring the pose at the end of the concatenation. Also calls to detect\_disulfides are made in the code.
-   random\_access: If true, you can write a list of file names in the file\_name field. At parse time one of these file names will be picked at random and throughout the trajectory this file name will be used. This saves command line variants.
-   swap\_chain\_number: If specified, AddChain will delete the chain with number 'swap\_chain\_number' and add the new chain instead.


##See Also

* [[I want to do x]]: Guide to choosing a mover
* [[AddChainBreakMover]]
* [[AlignChainMover]]
* [[BridgeChainsMover]]
* [[StartFromMover]]
* [[SwitchChainOrderMover]]
