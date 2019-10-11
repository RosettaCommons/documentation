# SetupForSymmetry
*Back to [[Mover|Movers-RosettaScripts]] page.*
Page last updated 11 October 2019.

The meat and potatoes of this protocol is described in the [[KeepSequenceSymmetry]] page.

This mover enables the optional "Power Mode" in the SequenceSymmetricAnnealer.
Power Mode is only intended to be used when you wish to go beyond the simple case
(where every chain in the protein is part of the same symmetric system).

In this mode, it is up to the user to define which chains need to keep symmetry with each other.
This allows you to design systems that have multiple groups of dimers, trimers, and even completely asymmetric proteins alongside each other.

There is no reason to use this mover if your whole protein is part of one symmetric system (one dimer, for example).

### Example
Say you have 7 chains: 2 dimers and a trimer (2+2+3):
```xml
<RESIDUE_SELECTORS>
	<Chain name="dimer1" chains="1,2"/>
	<Chain name="dimer2" chains="3,4"/>
	<Chain name="trimer" chains="5,6,7"/>
</RESIDUE_SELECTORS>
<MOVERS>
	<SetupForSymmetry name="setup_seq_symm" independent_regions="dimer1,dimer2,trimer"/>
</MOVERS>
```

### Developer Info

Introduced in PR 4260

##See Also

* [[SymDofMover]]
* [[SymMinMover]]
* [[SymPackRotamersMover]]
* [[MakeBundleMover]]
