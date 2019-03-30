# Symmetry And RosettaScripts

The following set of movers are aimed at creating and manipulating symmetric poses within RosettaScripts. For the complete symmetry documentation, see the [[Symmetry User's Guide|symmetry]].

Notice that symmetric poses must be scored with symmetric score functions. See the 'symmetric' tag in the RosettaScripts score function documentation.

## Example: Symmetric FastRelax

The following RosettaScript runs a protocol similar to Rosetta's symmetric fast relax using the symmetric pack rotamers and symmetric min mover (note that the fastrelax mover respects symmetric poses, this example is merely done to illustrate the symmetric movers).

```xml
<ROSETTASCRIPTS>
    <TASKOPERATIONS>
        <InitializeFromCommandline name="init"/>
        <RestrictToRepacking name="restrict"/>
        <IncludeCurrent name="keep_curr"/>
    </TASKOPERATIONS>
    <SCOREFXNS>
        <ScoreFunction name="ramp_rep1" weights="score12_full" symmetric="1">
            <Reweight scoretype="fa_rep" weight="0.0088"/>
        </ScoreFunction>
        <ScoreFunction name="ramp_rep2" weights="score12_full" symmetric="1">
            <Reweight scoretype="fa_rep" weight="0.11"/>
        </ScoreFunction>
        <ScoreFunction name="ramp_rep3" weights="score12_full" symmetric="1">
            <Reweight scoretype="fa_rep" weight="0.22"/>
        </ScoreFunction>
        <ScoreFunction name="ramp_rep4" weights="score12_full" symmetric="1"/>
    </SCOREFXNS>
    <FILTERS>
    </FILTERS>
    <MOVERS>
        <SetupForSymmetry   name="setup_symm" definition="C2.symm"/>
        <SymPackRotamersMover name="repack1" scorefxn="ramp_rep1" task_operations="init,restrict,keep_curr"/>
        <SymPackRotamersMover name="repack2" scorefxn="ramp_rep2" task_operations="init,restrict,keep_curr"/>
        <SymPackRotamersMover name="repack3" scorefxn="ramp_rep3" task_operations="init,restrict,keep_curr"/>
        <SymPackRotamersMover name="repack4" scorefxn="ramp_rep4" task_operations="init,restrict,keep_curr"/>
        <SymMinMover name="min1" scorefxn="ramp_rep1" type="lbfgs_armijo_nonmonotone" tolerance="0.01" bb="1" chi="1" jump="ALL"/>
        <SymMinMover name="min2" scorefxn="ramp_rep2" type="lbfgs_armijo_nonmonotone" tolerance="0.01" bb="1" chi="1" jump="ALL"/>
        <SymMinMover name="min3" scorefxn="ramp_rep3" type="lbfgs_armijo_nonmonotone" tolerance="0.01" bb="1" chi="1" jump="ALL"/>
        <SymMinMover name="min4" scorefxn="ramp_rep4" type="lbfgs_armijo_nonmonotone" tolerance="0.00001" bb="1" chi="1" jump="ALL"/>
        <ParsedProtocol name="ramp_rep_cycle">
            <Add mover="repack1"/>
            <Add mover="min1"/>
            <Add mover="repack2"/>
            <Add mover="min2"/>
            <Add mover="repack3"/>
            <Add mover="min3"/>
            <Add mover="repack4"/>
            <Add mover="min4"/>
        </ParsedProtocol>
        <GenericMonteCarlo name="genericMC" mover_name="ramp_rep_cycle" scorefxn_name="ramp_rep4" temperature="100.0" trials="4"/> 
    </MOVERS>
    <APPLY_TO_POSE>
    </APPLY_TO_POSE>
    <PROTOCOLS>
        <Add mover="setup_symm"/>
        <Add mover="genericMC"/>
    </PROTOCOLS>
</ROSETTASCRIPTS>
```

## Issues with Symmetry and Rosetta Scripts

For the most part, simple movers and filters will handle symmetric poses without modification. More complicated movers may run into some problems. To adopt a complex mover for symmetry, see the section "How to adopt your protocol to use symmetry" in the "Symmetry User's Guide" in Rosetta's Doxygen documentation.

One RosettaScript-specific problem with parsable movers and symmetry has to do with how the scorefunction map is accessed in parse\_my\_tag. When getting a scorefunction off the data map, the following code WILL NOT WORK WITH SYMMETRY:

```
scorefxn_ = new ScoreFunction( *data.get< ScoreFunction * >( "scorefxns", sfxn_name ));
```

This ignores whether 'sfxn\_name' is symmetric or not. Instead, use clone to preserve whether or not the scorefunction is symmetric:

```
scorefxn_ = data.get< ScoreFunction * >( "scorefxns", sfxn_name )->clone();
```

This often is the problem when a mover gives the following error in a symmetric pose:

```
ERROR: !core::pose::symmetry::is_symmetric( pose )
ERROR:: Exit from: src/core/scoring/ScoreFunction.cc line: 547
```

##See Also

* [[Symmetry]]: Using symmetry in Rosetta
* [[SetupForSymmetryMover]]
* [[SetupNCSMover]]
* [[DetectSymmetryMover]]
* [[SymDofMover]]
* [[SymMinMover]]
* [[SymPackRotamersMover]]
* [[MakeBundleMover]]
