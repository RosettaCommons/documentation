# FavorNativeResidue
*Back to [[Mover|Movers-RosettaScripts]] page.*
## FavorNativeResidue

```xml
<FavorNativeResidue name="" bonus="(1.5 &bool)"/>
```

Adds residue\_type\_constraints to the pose with the given bonus. The name is a slight misnomer -- the "native" residue which is favored is actually the identity of the residue of the current pose at apply time (-in:file:native is not used by this mover).

Running this mover multiple times will have a cumulative effect.  For example, if FavorNativeResidue with a bonus of 1.5 is called twice in the same protocol, after the second instance, the bonus for each residue will be 3.0.

For more flexible usage see [[FavorSequenceProfileMover]] (with "scaling=prob matrix=IDENTITY", this will show the same native-bonus behavior).

IMPORTANT NOTE: This mover will update the weights of all of your scorefunctions to the weight provided in "bonus," unless that scorefunction already has a non-zero constraint weight.  This may be what you want, but it can also lead to unexpected behavior.  For example, if you want to determine the total_score without constraints (e.g. "pure" ref2015) using a SimpleMetric and you define a scorefxn without any constraint weights (e.g. "ref2015.wts"), FavorNativeResidue will add the residue_type_constraint of 1.5 to that scorefunction!  If you want to get the same effect without changing your scorefunction weights, use the following mover instead:
```xml
<FavorSequenceProfile name="favournative" weight="1.5" use_current="true" matrix="IDENTITY"/>
```

##See Also

* [[FavorSequenceProfileMover]]
* [[FavorSymmetricSequenceMover]]
* [[ResidueTypeConstraintMover]]
* [[I want to do x]]: Guide to choosing a mover
