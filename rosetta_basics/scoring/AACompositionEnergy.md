# Residue type composition energy (aa_composition)
Documentation created by Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory.
Last edited 17 November 2015.

## Purpose and algorithm

This scoring term is intended for use during design, to penalize deviations from a desired residue type composition.  For example, a user could specify that the protein was to have no more than 5% alanines, no more than 3 glycines, at least 4 prolines, and be 40% to 50% hydrophobic with 5% aromatics.  Calculating a score based on residue type composition is easy and fast, but is inherently not pairwise-decomposable.  This scoring term is intended to work with Alex Ford's recent changes to the packer that permit fast-to-calculate but non-pairwise-decomposable scoring terms to be used during packing or design.<br/>
<br/>
The basic idea is that the algorithm does the following:
- Goes through and counts the number of residues of the types that it is supposed to count.  (For example, it counts alanines if the user has set a cap on the alanine fraction, or aromatics, or whatnot.)
- Calculates the difference between the desired number and the observed number.
- Imposes a penalty, based on a lookup table, as a function of that difference.  For example, the user might decide that there should be no penalty for being within 1 residue of ideal, but that the penalty should increase sharply if we're more than 2 over and gradually of we're more than 2 under the desired number.  The user can provide the lookup table in ```.comp``` files that define the behaviour of this score term (see below).

## User control

This scoring term is controlled by ```.comp``` files, which define the desired residue type composition of a protein.  The ```.comp``` file to use can be:
- Set at the command line with the ```-aa_composition_setup_file <filename>``` flag.
- Set from RosettaScripts using the ```<Set>``` tag to modify the scorefunction.  For example:

```
<tala weights="talaris2014.wts" >
	<Reweight scoretype=aa_composition weight=1.0 />
	<Set aa_composition_setup_file="inputs/disfavour_polyala.comp" />
</tala>
```

A ```.comp``` file consists of one or more ```PENALTY_DEFINITION``` blocks, each with five to six lines.  Lines that can be present include:
- ```PENALTY_DEFINITION``` Starts the block.
- ```TYPE <restype>``` Indicates that this block sets the prevalence of a particular residue type.
- ```PROPERTIES <property1> <property2> <property3>...``` An alternative to ```TYPE```, this indicates that this block sets the prevalence of residues with a particular set of properties.
- ```NOT_PROPERTIES <property1> <property2> <property3>...``` Used in conjunction with ```PROPERTIES``` and as an alternative to ```TYPE```, this indicates that this block sets the prevalence of residues that have the properties listed in the ```PROPERTIES``` line *and* do *not* have the properties listed on this line.
- ```DELTA_START <integer>``` This indicates how far from the desired number of residues our penalties table extends.  For example, a value of '-5' means that we will be providing penalty values for up to five residues fewer than the desired number.
- ```DELTA_END <integer>``` This indicates how far beyond the desired number of residues our penalties table extends.  For example, a value of '7' means that we will be providing penalty values for up to seven residues more than the desired number.
- ```PENALTIES <float1> <float2> <float3> ...``` The actual penalties table.  Entries must be provided for every integer value from DELTA_START to DELTA_END.  These values represent the energetic penalty for having N residues too few, N+1 residues too few, N+2 residues too few ... M-1 residues too many, M residues too many.  The penalty values at the extreme ends of the range are applied if residue type counts fall outside of the range.
- ```FRACTION <float>``` This indicates that this residue type, or residues with the defined properties, are ideally this fraction of the total.  For example, a value of 0.25 would mean that, ideally, a quarter of residues in the protein were those defined by this ```PENALTY_DEFINITION```.
-  ```ABSOLUTE <integer>``` An alternative to ```FRACTION```, this indicates the absolute value of residues of the given type or properties desired in the structure.  For example, a value of 3 would mean that we want 3 residues of the given type or properties.
- ```BEFORE_FUNCTION <string>``` and ```AFTER_FUNCTION <string>``` This defines the behaviour of the penalty function outside of the user-defined range.  Allowed values are CONSTANT (first or last value repeats), LINEAR (linearly-ramping penalty based on the slope of the first two or last two penalty values), or QUADRATIC (parabolic penalty centred on zero and passing through the first two or last two penalty values).
- ```END_PENALTY_DEFINITION``` Ends the block.

The ```PENALTY_DEFINITION```, ```DELTA_START```, ```DELTA_END```, ```PENALTIES```, and ```END_PENALTY_DEFINITION``` lines are always required.  The ```BEFORE_FUNCTION``` and ```AFTER_FUNCTION``` lines are optional, and default to QUADRATIC if not specified.  One ```FRACTION``` *or* one ```ABSOLUTE``` line must also be present (but not both).  Either a ```TYPE``` line, *or* a ```PROPERTIES``` / ```NOT_PROPERTIES``` pair of lines must be present (though if the latter, you can have either ```PROPERTIES``` or ```NOT_PROPERTIES``` or both).  Here's an example ```.comp``` file that penalizes deviatoins from having 10% aromatic residues in a protein (note that the pound sign can be used to comment one of these files):

```
# This is a .comp file for requiring that a structure be ten percent aromatic.
# File created 21 July 2015 by Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory.
# This penalty definition block specifies that, for aromatics, there will be a 100-point penalty for
# having ANY fewer or ANY more than the desired number of aromatic residues.
PENALTY_DEFINITION
PROPERTIES AROMATIC
NOT_PROPERTIES POLAR CHARGED
DELTA_START -1
DELTA_END 1
PENALTIES 100 0 100
FRACTION 0.1
BEFORE_FUNCTION CONSTANT
AFTER_FUNCTION CONSTANT
END_PENALTY_DEFINITION
```

## Organization of the code

- The scoring term lives in ```core/scoring/methods/AACompositionEnergy.cc``` and ```core/scoring/methods/AACompositionEnergy.hh```.
- Like any whole-body energy, the **AACompositionEnergy** class implements a ```finalize_total_energy()``` function that takes a pose.  This calculates the score.  Internally, it calls ```calculate_aa_composition_energy()```, which takes a vector of owning pointers to Residues (which can be called directly during packing).
- On initialization, the term creates an internal AACompositionEnergySetup object that stores the user-defined settings for the desired residue type composition.  This class is defined in ```core/scoring/methods/AACompositionEnergySetup.cc``` and ```core/scoring/methods/AACompositionEnergySetup.hh```.  At a future date, I might try associating setup objects with poses so that at different points in a protocol, a user could score with different settings.
- The ```.comp``` files are located in ```/database/scoring/score_functions/aa_composition/```.

##See Also

* [[Scoring explained]]
* [[Score functions and score types |score-types]]
* [[Adding a new energy method to Rosetta|new-energy-method]]
