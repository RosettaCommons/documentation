# BridgeChains
*Back to [[Mover|Movers-RosettaScripts]] page.*
## BridgeChains

Given a pose with a jump, this mover uses a fragment insertion monte carlo to connect the specified termini. The new fragment will connect the C-terminal residue of jump1 to the N-terminal residue of jump2, and will have secondary structure and ramachandran space given by "motif." This mover uses the VarLengthBuild code. The input pose must have at least two chains (jumps) to connect, or it will fail. 

```xml
<BridgeChains name="(&string)" motif="('' &string)" chain1="(1 &int)" chain2="(2 &int)" overlap="(3 &int)" scorefxn="(&string)" />
```

-   motif: The secondary structure + abego to be used for the backbone region to be rebuilt. Taken from input pose if not specified. The format of this string is:

    ```
    <Length><SS><ABEGO>-<Length2><SS2><ABEGO2>-...-<LengthN><SSN><ABEGON>
    ```

    For example, "1LX-5HA-1LB-1LA-1LB-6EB" will build a one residue loop of any abego, followed by a 5-residue helix, followed by a 3-residue loop of ABEGO BAB, followed by a 6-residue strand.

-   chain1: Indicates the chain which is to be located at the N-terminal end of the new fragment. Building will begin at the C-terminal residue of the jump.
-   chain2: Indicates the chain which is to be located at the C-terminal end of the new fragment.
-   overlap: Indicates the number of residues to rebuild before and after the new fragment. A value of 3 indicates that residues +/- 3 from the inserted segment will be rebuilt. This enable a smooth, continuous peptide chain.
-   scorefxn: **Required** The scorefunction to be used in the fragment insertion.

**Example**
 The following example connects the first jump in the protein with a 3-residue loop, a 10 residue helix and a 3-residue loop, and rebuilds residues that are +/- 4 positions from the inserted segment.

```xml
<SCOREFXNS>
    <ScoreFunction name="SFXN" weights="fldsgn_cen" />
</SCOREFXNS>
<MOVERS>
    <BridgeChains name="connect" chain1="1" chain2="2" motif="3LX-10HA-3LX" scorefxn="SFXN" overlap="4" />
</MOVERS>
<PROTOCOLS>
    <Add mover_name="connect" />
</PROTOCOLS>
```


##See Also

* [[I want to do x]]: Guide to choosing a mover
* [[LoopModelerMover]]
* [[FoldTree overview]]
* [[AddChainMover]]
* [[AddChainBreakMover]]
* [[AlignChainMover]]
* [[StartFromMover]]
* [[SwitchChainOrderMover]]
