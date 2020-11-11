#RemoveMetalConnectionsMover

##RemoveMetalConnectionsMover

Documentation and mover by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).  Documentation added on Remembrance Day 2020. 

[[_TOC_]]

### Description
This mover complements the function of the `-in:auto_setup_metals` command line flag or the [[SetupMetalsMover]] by providing a means of _removing_ the automatically-added bonds between metals and metal-liganding residues and of removing the corresponding variant types.  Note that, at the present time, this mover does _not_ remove metal constraints.  Those must be removed using the [[ClearConstraintsMover]]. 

### Setup and options
[[include:mover_RemoveMetalConnectionsMover_type]]

###Example
The following script applies metal-binding constraints to the input pose, then relaxes it using the [[FastRelax|FastRelaxMover]] mover, then removes metal constraints, introduces a mutation, adds back metal constraints, and relaxes again:

```xml
<ROSETTASCRIPTS>
        <SCOREFXNS>
                <ScoreFunction name="r15_cst" weights="ref2015_cst.wts" >
                        <Reweight scoretype="metalbinding_constraint" weight="1.0" />
                </ScoreFunction>
        </SCOREFXNS>
        <MOVERS>
                <SetupMetalsMover name="setup_metals" metals_detection_LJ_multiplier="1.0" />
                <FastRelax name="frlx1" scorefxn="r15_cst" />
		<RemoveMetalConnectionsMover name="remove_metal_bonds" />
		<ClearConstraintsMover name="clear_csts" />
		<MutateResidue name="introduce_mutation" target="63" new_res="ALA" /> #We suppose that residue 63 was a metal-binding residue. 
        </MOVERS>
        <PROTOCOLS>
                <Add mover="setup_metals" />
                <Add mover="frlx1" />
		<Add mover="remove_metal_bonds" />
		<Add mover="clear_csts" />
		<Add mover="introduce_mutation" />
		<Add mover="setup_metals" />
		<Add mover="frlx1" />
        </PROTOCOLS>
</ROSETTASCRIPTS>

```

###See Also
* [[Metals|Workng with metalloproteins in Rosetta]]
* [[AddConstraintsToCurrentConformationMover]]
* [[ClearConstraintsMover]]
* [[SetupMetalsMover]]
