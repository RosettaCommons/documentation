# FavorNativeResidue
*Back to [[Mover|Movers-RosettaScripts]] page.*
## FavorNativeResidue

```
<FavorNativeResidue bonus="(1.5 &bool)"/>
```

Adds residue\_type\_constraints to the pose with the given bonus. The name is a slight misnomer -- the "native" residue which is favored is actually the identity of the residue of the current pose at apply time (-in:file:native is not used by this mover).

Running this mover multiple times will have a cumulative effect.  For example, if FavorNativeResidue with a bonus of 1.5 is called twice in the same protocol, after the second instance, the bonus for each residue will be 3.0.

For more flexible usage see FavorSequenceProfile (with "scaling=prob matrix=IDENTITY", this will show the same native-bonus behavior).


##See Also

* [[FavorSequenceProfileMover]]
* [[FavorSymmetricSequenceMover]]
* [[ResidueTypeConstraintMover]]
* [[I want to do x]]: Guide to choosing a mover