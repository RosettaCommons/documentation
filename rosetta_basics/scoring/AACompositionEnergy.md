# Residue type composition energy (aa_composition)
Documentation created by Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory.
Last edited 27 December 2017.

[[_TOC_]]

## Purpose and algorithm

This scoring term is intended for use during design, to penalize deviations from a desired residue type composition.  For example, a user could specify that the protein was to have no more than 5% alanines, no more than 3 glycines, at least 4 prolines, and be 40% to 50% hydrophobic with 5% aromatics, and that its surface have no more than 50% charged residues.  Calculating a score based on residue type composition is easy and fast, but is inherently not pairwise-decomposable.  This scoring term is intended to work with Alex Ford's changes to the packer that permit fast-to-calculate but non-pairwise-decomposable scoring terms to be used during packing or design.<br/>
<br/>
The basic idea is that the algorithm does the following:
- Goes through and counts the number of residues of the types that it is supposed to count in the regions of the pose that have been selected for counting.  (For example, it counts alanines in the core if the user has set a cap on the alanine fraction in the core, or aromatics, or whatnot.)
- Calculates the difference between the desired number and the observed number.
- Imposes a penalty, based on a lookup table, as a function of that difference.  For example, the user might decide that there should be no penalty for being within 1 residue of ideal, but that the penalty should increase sharply if we're more than 2 over and gradually of we're more than 2 under the desired number.  The user can provide the lookup table in ```.comp``` files that define the behaviour of this score term (see below).

## User control

This scoring term is controlled by ```.comp``` files, which define the desired residue type composition of a protein.  The ```.comp``` file(s) to use can be provided to Rosetta in three ways:
- The user can provide one or more ```.comp``` files as input at the command line with the ```-aa_composition_setup_file <filename1> <filename2> <filename3> ...``` flag.
- The user can provide one or more ```.comp``` files when setting up a particular scorefunction in RosettaScripts, using the ```<Set>``` tag to modify the scorefunction.  For example:

```xml
<SCOREFXNS>
	<ScoreFunction name="tala" weights="talaris2014.wts" >
		<Reweight scoretype="aa_composition" weight="1.0" />
		<Set aa_composition_setup_file="inputs/disfavour_polyala.comp" />
	</ScoreFunction>
</SCOREFXNS>
```
- The user can attach ```.comp``` files to a Pose with the [[AddCompositionConstraintMover]].  These remain attached to the pose, like any other constraint, until all constraints are cleared with the [[ClearConstraintsMover]], or until only sequence composition constraints are cleared with the [[ClearCompositionConstraintsMover]].  Note that the composition constraints added with the AddCompositionConstraintMover can have a [[ResidueSelector|ResidueSelectors]] attached to them as well.  This allows the user to define sub-regions of the pose (e.g. a single helix, the protein core, an inter-subunit binding interface) to which an amino acid composition constraint will be applied.  The ResidueSelector is evaluated prior to scoring or packing (but not evaluated repeatedly during packing).  Here is an example RosettaScript in which a LayerSelector is used to select the core of the protein, and the AddCompositionConstraintMover is used to impose a sequence composition requirement on core residues only:

```xml
<ROSETTASCRIPTS>
	<SCOREFXNS>
		<ScoreFunction name="tala" weights="talaris2014.wts" >
			<Reweight scoretype="aa_composition" weight="1.0" />
		</ScoreFunction>
	</SCOREFXNS>
	<RESIDUE_SELECTORS>
		<Layer name="corelayer" select_core="true" core_cutoff="0.5" surface_cutoff="0.25" />
	</RESIDUE_SELECTORS>
	<TASKOPERATIONS>
	</TASKOPERATIONS>
	<FILTERS>
	</FILTERS>
	<MOVERS>
		<AddCompositionConstraintMover name="addcomp1" filename="desired_core_composition.comp" selector="corelayer" />
		
		<FastDesign name=fdes1 scorefxn="tala" repeats="3" >
			<MoveMap name="fdes1_mm">
				<Span begin="1" end="30" chi="1" bb="0" />
			</MoveMap>
		</FastDesign>
	</MOVERS>
	<APPLY_TO_POSE>
	</APPLY_TO_POSE>
	<PROTOCOLS>
		<Add mover="addcomp1" />
		<Add mover="fdes1" />
	</PROTOCOLS>
</ROSETTASCRIPTS>

```

If the user uses more than one of the methods described above, _all_ of the ```.comp``` files provided will be used in scoring, provided the ```aa_composition``` scoreterm is on with a nonzero weight.

A ```.comp``` file consists of one or more ```PENALTY_DEFINITION``` blocks.  Lines that can be present in a ```PENALTY_DEFINITION``` block include:
- ```PENALTY_DEFINITION``` Starts the block.
- ```TYPE <restype1> <restype2> <restype3> ...``` Indicates that a residue should be counted if its three-letter code matches ANY of the names provided.
- ```NOT_TYPE <restype1> <restype2> <restype3> ...``` Indicates that a residue should NOT be counted if its three-letter code matches ANY of the names provided.  The residue is not counted even if it matches properties listed in ```PROPERTIES``` or ```OR_PROPERTIES``` lines.
- ```PROPERTIES <property1> <property2> <property3> ...``` Indicates that a residue should be counted if it has ALL of the properties listed.  Note that a list of currently valid residue properties is autogenerated [[here|rs_ResiduePropertySelector_type]].
- ```OR_PROPERTIES <property1> <property2> <property3> ...``` Indicates that a residue should be counted if it has ANY of the properties listed.
- ```NOT_PROPERTIES <property1> <property2> <property3> ...``` Indicates that a residue should NOT be counted if it has ANY of the properties listed.
- ```DELTA_START <integer>``` This indicates how far from the desired number of residues our penalties table extends.  For example, a value of '-5' means that we will be providing penalty values for up to five residues fewer than the desired number.
- ```DELTA_END <integer>``` This indicates how far beyond the desired number of residues our penalties table extends.  For example, a value of '7' means that we will be providing penalty values for up to seven residues more than the desired number.
- ```FRACT_DELTA_START <float>``` <b>New 28-Apr-2016</b> This is an alternative to ```DELTA_START``` that indicates how far below the desired fractional composition our penalties table extends.  For example, a value of '-0.05' means that we will be providing penalty values for up to 5% fewer than the desired number.  (So if we specified a desired fractional composition of 0.07 (7%) for alanine, then ```FRACT_DELTA_START -0.05``` indicates that the penalties table provides penalties down to a 2% alanine.)  <i>Either</i> ```DELTA_START``` <i>or</i> ```FRACT_DELTA_START``` must be used.
- ```FRACT_DELTA_END <float>``` <b>New 28-Apr-2016</b> This is an alternative to ```DELTA_END``` that indicates how far above the desired fractional composition our penalties table extends.  For example, a value of '0.08' means that we will be providing penalty values for up to 8% more than the desired number.  (So if we specified a desired fractional composition of 0.03 (3%) for valine, then ```FRACT_DELTA_END 0.08``` indicates that the penalties table provides penalties up to a 11% valine.)  <i>Either</i> ```DELTA_END``` <i>or</i> ```FRACT_DELTA_END``` must be used.
- ```PENALTIES <float1> <float2> <float3> ...``` The actual penalties table.  If ```DELTA_START``` and ```DELTA_END``` were used, then entries must be provided for every integer value from DELTA_START to DELTA_END.  These values represent the energetic penalty for having N residues too few, N+1 residues too few, N+2 residues too few ... M-1 residues too many, M residues too many.  If ```FRACT_DELTA_START``` and ```FRACT_DELTA_END``` are used, then any number of penalty values may be specified; they will be linearly interpolated within the range [FRACT_DELTA_START, FRACT_DELTA_END].  In either case, the end functions are applied if residue type counts fall outside of the range.
- ```FRACTION <float>``` This indicates that this residue type, or residues with the defined properties, are ideally this fraction of the total.  For example, a value of 0.25 would mean that, ideally, a quarter of residues in the protein were those defined by this ```PENALTY_DEFINITION```.  If a ResidueSelector was used when applying a composition constraint to a pose, the fraction represents the portion of selected residues (e.g. 50% of core residues, 10% of residues in helix 3, 40% of residues in the binding interface).  Otherwise, it represents the fraction of total residues in the pose.
-  ```ABSOLUTE <integer>``` An alternative to ```FRACTION```, this indicates the absolute number of residues of the given type or properties desired in the structure.  For example, a value of 3 would mean that we want 3 residues of the given type or properties.
- ```BEFORE_FUNCTION <string>``` and ```AFTER_FUNCTION <string>``` This defines the behaviour of the penalty function outside of the user-defined range.  Allowed values are CONSTANT (first or last value repeats), LINEAR (linearly-ramping penalty based on the slope of the first two or last two penalty values), or QUADRATIC (parabolic penalty centred on zero and passing through the first two or last two penalty values).
- ```END_PENALTY_DEFINITION``` Ends the block.

The ```PENALTY_DEFINITION```, ```PENALTIES```, and ```END_PENALTY_DEFINITION``` lines are always required.  The ```BEFORE_FUNCTION``` and ```AFTER_FUNCTION``` lines are optional, and default to QUADRATIC if not specified.  One ```FRACTION``` *or* one ```ABSOLUTE``` line must also be present (but not both).  ```DELTA_START``` and ```DELTA_END```, *or* ```FRACT_DELTA_START``` and ```FRACT_DELTA_END```, lines are required.  The ```TYPE```, ```NOT_TYPE```, ```PROPERTIES```, ```OR_PROPERTIES```, and ```NOT_PROPERTIES``` lines are all optional, and can be used in conjunction with one another.  The logic for deciding whether to count a residue or not is as follows:

Count if ( any TYPE matches ) OR ( ( no NOT_TYPE matches ) AND ( ( no NOT_PROPERTIES property is present) AND ( (no PROPERTIES or OR_PROPERTIES are defined) OR ( all PROPERTIES are present) OR ( any OR_PROPERTIES are present ) ) ) ).

Here's an example ```.comp``` file that penalizes deviations from having 10% aromatic residues in a protein (note that the pound sign can be used to comment one of these files):

```
# This is a .comp file for requiring that a structure be ten percent aromatic.
# File created 21 July 2015 by Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory.
# This penalty definition block specifies that, for aromatics, there will be a 100-point penalty for
# having ANY fewer or ANY more than the desired number of aromatic residues.

PENALTY_DEFINITION

# Define residue types to control
PROPERTIES AROMATIC
NOT_PROPERTIES POLAR CHARGED

# Declare desired quantity of these residues
FRACTION 0.1

# Set the penalty for having too few, at the desired number, and too many of the specified residues
PENALTIES 100 0 100

# Set how many residues you can be below the desired quantity before a penalty is applied. Since
# this value is a delta, the desired number of residues is "0", or zero residues away from the target.
# Therefore, "-1" indicates that the penalty will be applied once there is one fewer than the
# desired quantity
DELTA_START -1

# Set how many residues you can be above the desired quantity before a penalty is applied. Since
# this value is a delta, the desired number of residues is "0", or zero residues away from the target.
# Therefore, "1" indicates that the penalty will be applied once there is one more than the
# desired quantity
DELTA_END 1

#set how the penalties are applied
BEFORE_FUNCTION CONSTANT
AFTER_FUNCTION CONSTANT
END_PENALTY_DEFINITION
```

Here's a more complicated .comp file that imposes the requirement that the protein have 40% aliphatic or aromatic residues other than leucine (i.e. ALA, PHE, ILE, MET, PRO, VAL, TRP, or TYR), and 5% leucines:


```
# This is a .comp file for requiring that a structure be ten percent aromatic.
# File created 21 July 2015 by Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory.
PENALTY_DEFINITION
OR_PROPERTIES AROMATIC ALIPHATIC
NOT_TYPE LEU
FRACT_DELTA_START -0.05
FRACT_DELTA_END 0.05
PENALTIES 100 0 100 # The above two lines mean that if we're 5% below or 5% above the desired content, we get a 100-point penalty.
FRACTION 0.4 # Forty percent aromatic or aliphatic, but not leucine
BEFORE_FUNCTION CONSTANT
AFTER_FUNCTION CONSTANT
END_PENALTY_DEFINITION

PENALTY_DEFINITION
TYPE LEU
DELTA_START -1
DELTA_END 1
PENALTIES 100 0 100
FRACTION 0.05 # Five percent leucine
BEFORE_FUNCTION CONSTANT
AFTER_FUNCTION CONSTANT

END_PENALTY_DEFINITION
```

## Use with symmetry
As of 6 March 2016, the aa_composition score term should be fully compatible with symmetry, including mirror symmetry.  Note that it counts all residues in the pose or selection, not only those in the asymmetric unit.  In poses with mirror symmetry, it is properly aware of inverted types in mirrored subunits.

## Organization of the code

- The scoring term lives in ```core/scoring/aa_composition_energy/AACompositionEnergy.cc``` and ```core/scoring/aa_composition_energy/AACompositionEnergy.hh```.
- Like any whole-body energy, the **AACompositionEnergy** class implements a ```finalize_total_energy()``` function that takes a pose.  This calculates the score.  Internally, it calls ```calculate_aa_composition_energy()```, which takes a vector of owning pointers to Residues (which can be called directly during packing).
- On initialization, the term creates an internal AACompositionEnergySetup object that stores the user-defined settings for the desired residue type composition.  This class is defined in ```core/scoring/aa_composition_energy/AACompositionEnergySetup.cc``` and ```core/scoring/aa_composition_energy/AACompositionEnergySetup.hh```.  AACompositionEnergySetup objects can also be stored in AACompositionConstraints associated with a Pose.  At scoring or packing time, the AACompositionEnergy constructs a vector of owning pointers to its internal AACompositionEnergySetup objects and to all those stored in the pose, and uses all of these for scoring.
- The ```.comp``` files are located in ```/database/scoring/score_functions/aa_composition/```.

##See Also

* [[Scoring explained]]
* [[Score functions and score types |score-types]]
* [[Adding a new energy method to Rosetta|new-energy-method]]
* [[Design-centric guidance terms|design-guidance-terms]]
* [[AddCompositionConstraintMover]]
* [[ClearCompositionConstraintsMover]]
* [[AddHelixSequenceConstraints mover|AddHelixSequenceConstraintsMover]]
* [[AARepeatEnergy|Repeat-stretch-energy]]
* [[HBNetEnergy]]
* [[BuriedUnsatPenalty]]
* [[NetChargeEnergy]]
* [[VoidsPenaltyEnergy]]
