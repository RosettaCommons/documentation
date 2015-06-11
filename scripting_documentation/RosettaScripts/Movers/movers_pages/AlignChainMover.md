# AlignChain
## AlignChain

Align a chain in the working pose to a chain in a pose on disk (CA superposition).

```
<AlignChain name=(&string) source_chain=(0&Int) SymMinMover name=min4 scorefxn=ramp_rep4 type=lbfgs_armijo_nonmonotone tolerance=0.00001 bb=1 chi=1 jump=ALL/target_chain=(0&Int) target_name=(&string)/>
```

-   source\_chain: the chain number in the working pose. 0 means the entire pose.
-   target\_chain: the chain number in the target pose. 0 means the entire pose.
-   target\_name: file name of the target pose on disk. The pose will be read just once at the start of the run and saved in memory to save I/O.

target and source chains must have the same length of residues.


##See Also

* [[I want to do x]]: Guide to choosing a mover
* [[SuperimposeMover]]
* [[AddChainMover]]
* [[AddChainBreakMover]]
* [[BridgeChainsMover]]
* [[StartFromMover]]
* [[SwitchChainOrderMover]]