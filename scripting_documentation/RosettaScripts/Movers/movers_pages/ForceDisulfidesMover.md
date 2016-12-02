# ForceDisulfides
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ForceDisulfides

Set a list of cysteine pairs to form disulfides and repack their surroundings. Useful for cases where the disulfides aren't recognized by Rosetta. The disulfide fixing uses Rosetta's standard, Conformation.fix\_disulfides( .. ), which only sets the residue type to disulfide. The repacking step is necessary to realize the disulfide bond geometry. Repacking takes place in 6A shells around each affected cystein.


```
<ForceDisulfides name="&string" scorefxn="(score12 &string)" disulfides="(&list of residue pairs)"/>
```
-   scorefnx: Score function used for repacking
-   disulfides: For instance: 23A:88A,22B:91B. Can also take regular Rosetta numbering as in: 24:88,23:91.


##See Also

* [[DisulfideMover]]
* [[DisulfidizeMover]]
* [[RemodelMover]]
* [[I want to do x]]: Guide to choosing a mover
