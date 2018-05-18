# Net charge energy (netcharge) 
Documentation created by Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory on 26 November 2017.

<i>Note:  This page documents the ```netcharge``` score term.  For information about the NetCharge Filter, see [[this page|NetChargeFilter]].</i>

<b><i>Also note:  The ```netcharge``` score term is currently unpublished.  If you use this in your project, please include Vikram K. Mulligan as an author.</i></b>

[[_TOC_]]

## Purpose and algorithm

This scoring term is intended for use during design, to penalize deviations from a desired net charge in a pose or region.  For example, a user could specify that protein was to have an overall net charge of +1, but that a binding interface was to have a net charge of -2.  Because this is a score rather than a design algorithm, it can be used in conjunction with any existing design algorithm that uses the packer (including the [[FastDesign|FastDesignMover]] and [[PackRotamers|PackRotamersMover]] movers, or the [[fixbb]] application).  Moreover, it can be used in conjunction with other score terms that guide design, such as [[aa_composition|AACompositionEnergy]].

Calculating a score based on net charge is easy and fast (one need only sum the charges of all amino acids in the protein, take the difference from the desired charge, and look up a suitable penalty for that difference from a lookup table), but the calculation is inherently not pairwise-decomposable.  This scoring term is intended to work with Alex Ford's changes to the packer that permit fast-to-calculate but non-pairwise-decomposable scoring terms to be used during packing or design.

## User control

### Commandline flags or RosettaScripts control

To use this term, it must be turned on by reweighting `netcharge` to a non-zero value, either in the weights file used to set up the scorefunction, or in the scorefunction definition in RosettaScripts, in PyRosetta, or in C++ code.

This scoring term is controlled by ```.charge``` files, which define the desired charge in a pose or a sub-region of a pose defined by residue selectors.  If no ```.charge``` files are provided, then the `netcharge` score term always returns a score of zero.  The ```.charge``` file(s) to use can be provided to Rosetta in three ways:
- The user can provide one or more ```.charge``` files as input at the command line with the ```-netcharge_setup_file <filename1> <filename2> <filename3> ...``` flag.  The charge specifications will be applied globally, to the whole pose, whenever it is scored with the `netcharge` score term.
- The user can provide one or more ```.charge``` files when setting up a particular scorefunction in RosettaScripts (or in PyRosetta or C++ code), using the ```<Set>``` tag to modify the scorefunction.  The charge specification will be applied globally, to the whole pose, whenever this particular scorefunction is used.  For example:

```xml
<SCOREFXNS>
	<ScoreFunction name="r15" weights="ref2015.wts" >
		<Reweight scoretype="netcharge" weight="1.0" />
		<Set netcharge_setup_file="inputs/positive_three.charge" />
	</ScoreFunction>
</SCOREFXNS>
```
- The user can attach ```.charge``` files to a Pose with the [[AddNetChargeConstraintMover]].  These remain attached to the pose, like any other constraint, until all constraints are cleared with the [[ClearConstraintsMover]], or until only sequence composition constraints are cleared with the [[ClearCompositionConstraintsMover]].  Note that the net charge constraints added with the AddNetChargeConstraintMover can have a [[ResidueSelector|ResidueSelectors]] attached to them as well.  This allows the user to define sub-regions of the pose (_e.g._ a single helix, the protein surface, an inter-subunit binding interface) to which a net charge constraint will be applied.  The ResidueSelector is evaluated prior to scoring or packing (but not evaluated repeatedly during packing).  Here is an example RosettaScript in which a LayerSelector is used to select the surface of the protein, and the AddNetChargeConstraintMover is used to impose the requirement that surface residues only have a net charge of +2:

```xml
<ROSETTASCRIPTS>
	<SCOREFXNS>
		<ScoreFunction name="r15" weights="ref2015.wts" >
			<Reweight scoretype="netcharge" weight="1.0" />
		</ScoreFunction>
	</SCOREFXNS>
	<RESIDUE_SELECTORS>
		<Layer name="surflayer" select_core="false" select_boundary="false" select_surface="true" core_cutoff="0.5" surface_cutoff="0.25" />
	</RESIDUE_SELECTORS>
	<TASKOPERATIONS>
	</TASKOPERATIONS>
	<FILTERS>
	</FILTERS>
	<MOVERS>
		<AddNetChargeConstraintMover name="netcharge_cst" filename="plustwo.charge" selector="surflayer" />
		
		<FastDesign name=fdes1 scorefxn="r15" repeats="3" >
			<MoveMap name="fdes1_mm">
				<Span begin="1" end="30" chi="1" bb="0" />
			</MoveMap>
		</FastDesign>
	</MOVERS>
	<APPLY_TO_POSE>
	</APPLY_TO_POSE>
	<PROTOCOLS>
		<Add mover="netcharge_cst" />
		<Add mover="fdes1" />
	</PROTOCOLS>
</ROSETTASCRIPTS>

```

If the user uses more than one of the methods described above, _all_ of the ```.charge``` files provided will be used in scoring, provided the `netcharge` scoreterm is on with a nonzero weight.  This can be useful to apply complicated charge requirements, such as, "The net charge of the whole protein must be +1, but the net charge of the first helix must be -3 and the net charge of the binding pocket must be +3".

### Definition file (".charge")

A `.charge` file defines a single desired net charge, which can either be enforced globally or regionally within a pose.  It also defines the penalty function to apply if the actual net charge deviates from the desired net charge.  This penalty function is very important: it is what guides the packer towards solutions that have the desired net charge.  Ideally, we want the penalty function to gradually ramp down to a minimum at the desired net charge.

A `.charge` file _must_ contain a ```DESIRED_CHARGE``` line, a ```PENALTIES_CHARGE_RANGE``` line, and a ```PENALTIES``` line.  Optionally, it may also contain ```BEFORE_FUNCTION``` and ```AFTER_FUNCTION``` lines.  Each of these is defined below:

|  Line  |  Description |  Example |
| ------ | ------- | -------- |
| ```DESIRED_CHARGE <signed int>``` | The desired net charge for the whole pose or region, expressed as a signed integer.  This line is mandatory. | ```DESIRED_CHARGE -7 #I want a charge of negative seven in this pose or region.``` |
| ```PENALTIES_CHARGE_RANGE <signed int> <signed int>``` | The range of possible observed net charges over which penaltes are defined.  This line is mandatory. | ```PENALTIES_CHARGE_RANGE -9 -5 #The PENALTIES line will list penalties for observed net charges ranging from -9 to -5.``` |
| ```PENALTIES <real> <real> <real> ...``` | The values that the `netcharge` score term should return given observed net charges corresponding to each value in the range defined in the ```PENALTIES_CHARGE_RANGE``` line.  One value must be provided for each charge in the range.  This line is mandatory. | ```PENALTIES 100 10 0 5 10 #In this example, much harsher penalties are imposed below the desired net charge than above it.``` |
| ```BEFORE_FUNCTION <string>``` | Outside the range of penalties defined in the ```PENALTIES_CHARGE_RANGE``` line, this is the behaviour of the penalty function at more negative values.  Options are ```CONSTANT``` (value at low end of range repeats for any observed charge below the range), ```LINEAR``` (first two values are linearly extrapolated for values below the range), or ```QUADRATIC``` (first two values are fitted to a parabola and quadratically extrapolated below the range).  This line is optional; if not specified, it defaults to ```QUADRATIC```. | ```BEFORE_FUNCTION QUADRATIC #Ramp quadratically for observed net charges below the range defined.``` |
| ```AFTER_FUNCTION <string>``` | Outside the range of penalties defined in the ```PENALTIES_CHARGE_RANGE``` line, this is the behaviour of the penalty function at more positive values.  Options are ```CONSTANT``` (value at high end of range repeats for any observed charge above the range), ```LINEAR``` (last two values are linearly extrapolated for values above the range), or ```QUADRATIC``` (last two values are fitted to a parabola and quadratically extrapolated above the range).  This line is optional; if not specified, it defaults to ```QUADRATIC```. | ```AFTER_FUNCTION LINEAR #Ramp linearly for observed net charges below the range defined.``` |

Note that the ```.charge``` file does _not_ specify whether the desired net charge is a global or local net charge.  That is determined by the manner in which the ```.charge``` file is applied: if it is applied using the [[AddNetChargeConstraintMover]], and a residue selector is provided, it will define the expected charge in a region of a pose; otherwise, it will be applied to the whole pose.

#### Example ```.charge``` file requiring 0 net charge

The following example shows a ```.charge``` file requiring that the net charge in a pose or region be exactly 0.

```
DESIRED_CHARGE 0 #Desired net charge is zero.
PENALTIES_CHARGE_RANGE -1 1 #Penalties are listed in the observed net charge range of -1 to +1.
PENALTIES 10 0 10 #The penalties are 10 for an observed charge of -1, 0 for an observed charge of 0, and 10 for an observed charge of +1.
BEFORE_FUNCTION QUADRATIC #Ramp quadratically for observed net charges of -2 or less.
AFTER_FUNCTION QUADRATIC #Ramp quadratically for observed net charges of +2 or greater.
```

#### Example ```.charge``` file requiring net charge in the range of -1 to +3

The following example shows a ```.charge``` file requiring that the net charge in a pose or region be in the range of -1 to +3.  Within this range, the penalty returned is zero; outside of this range, it rapidly becomes positive.

```
DESIRED_CHARGE 0 #Desired net charge is zero.
PENALTIES_CHARGE_RANGE -2 4 #Penalties are listed in the observed net charge range of -2 to +4.
PENALTIES 10 0 0 0 0 0 10 #The penalties are 10 for an observed charge of -2, 0 for an observed charge of -1 to +3, and 10 for an observed charge of +4.
BEFORE_FUNCTION QUADRATIC #Ramp quadratically for observed net charges of -3 or less.
AFTER_FUNCTION QUADRATIC #Ramp quadratically for observed net charges of +5 or greater.
```

#### Example ```.charge``` file requiring net charge of at most -3

The ```CONSTANT``` out-of-bounds behaviour is useful in cases in which we want to specify a maximum but no minimum or a minimum but no maximum.  In this case, we specify that we want a net charge of, at most, -3.

```
DESIRED_CHARGE -3 #Desired net charge is -3.
PENALTIES_CHARGE_RANGE -4 -2 #Penalties are listed in the observed net charge range of -4 to -2.
PENALTIES 0 0 10 #The penalties are 0 for an observed charge of -4, 0 for an observed charge of -3, and 10 for an observed charge of -2.
BEFORE_FUNCTION CONSTANT #Return 0 for observed net charges of -5 or less.
AFTER_FUNCTION QUADRATIC #Ramp quadratically for observed net charges of -1 or greater.
```
#### Example ```.charge``` file requiring net absolute charge greater than 2

The ```.charge``` file format is sufficietly versatile to allow us to penalize net charges near zero, but allow net charges that are either very positive or very negative.  Here's an example:

```
DESIRED_CHARGE 0 #Desired net charge is zero.
PENALTIES_CHARGE_RANGE -2 2 #Penalties are listed in the observed net charge range of -2 to +2.
PENALTIES 0 25 50 25 0 #The penalties are 0 for an observed charge of -2 or +2, 25 for an observed charge of -1 or +1, and 50 for an observed charge of 0.
BEFORE_FUNCTION CONSTANT #Return 0 for observed net charges of -3 or less.
AFTER_FUNCTION CONSTANT #Return 0 for observed net charges of +3 or greater.
```

## Regional control with net charge constraints

A desired net charge for a region in a pose (e.g. the binder in a binder-target complex, a single helix of a larger protein, a binding interface) can be set using net charge constraints.  Like geometric constraints, these are attached to a pose, and are read by the ```netcharge``` score term when the pose is scored or packed.  Net charge constraints can be added with the [[AddNetChargeConstraintMover]].  An example, in which a binding interface is selected with a residue selector and constrained to have a net negative charge, is shown below:

```xml
<ROSETTASCRIPTS>
        <SCOREFXNS>
                <ScoreFunction name="r15" weights="ref2015.wts" >
                        <Reweight scoretype="netcharge" weight="1.0" />
                </ScoreFunction>
        </SCOREFXNS>
        <RESIDUE_SELECTORS>
		# The interface is selected by selecting residues in chain A that are within 15 Angstroms of residue 53 in chain B:
		<Index name="select_b53" resnums="53B" />
		<Chain name="select_chainA" chains="A" />
		<Neighborhood name="select_near_b53" selector="select_b53" distance="15.0" />
		<And name="select_interface" selectors="select_chainA,select_near_b53" />
		<Not name="select_not_interface" selector="select_interface" />
        </RESIDUE_SELECTORS>
        <TASKOPERATIONS>
		# We set up task operations to prevent design away from the interface:
		<OperateOnResidueSubset name="only_repack_not_interface" selector="select_not_interface" >
			<RestrictToRepackingRLT />
		</OperateOnResidueSubset>
        </TASKOPERATIONS>
        <FILTERS>
        </FILTERS>
        <MOVERS>
                <AddNetChargeConstraintMover name="netcharge_cst" filename="must_be_negative.charge" selector="select_interface" />
                <FastDesign name=fdes1 scorefxn="r15" repeats="3" task_operations="only_repack_not_interface" />
        </MOVERS>
        <APPLY_TO_POSE>
        </APPLY_TO_POSE>
        <PROTOCOLS>
                <Add mover="netcharge_cst" />
                <Add mover="fdes1" />
        </PROTOCOLS>
</ROSETTASCRIPTS>
```

## Use with symmetry
The ```netcharge``` score term should be fully compatible with symmetry, including mirror symmetry.  Note that it counts all residues in the pose or selection, not only those in the asymmetric unit.

## Use with other design-centric score terms
The ```netcharge``` score term should be fully compatible with the [[aa_composition score term|AACompositionEnergy]], the [[hbnet score term|HBNetEnergy]], or any other design-centric score term.  The power of these terms is enhanced when used together.  For example, with a combination of ```netcharge``` and ```aa_composition```, a user could effectively say, "Design both sides of this interface, and give me designs with a 50/50 mix of polar and hydrophobic amino acids on each side of the interface, a maximum of 4 charged residues on each side of the interface, and a net charge of +2 on one side and -2 on the other."  By adding the ```hbnet``` term as well, one could ensure that the designs returned had hydrogen bond networks wherever possible _in addition_.

## Organization of the code

- The scoring term lives in ```core/scoring/netcharge_energy/NetChargeEnergy.cc``` and ```core/scoring/netcharge_energy/NetChargeEnergy.hh```.
- Like any whole-body energy, the **NetChargeEnergy** class implements a ```finalize_total_energy()``` function that takes a pose.  This calculates the score.  Internally, it calls ```calculate_energy()```, which takes a vector of owning pointers to Residues (which can be called directly during packing).
- On initialization, the term creates an internal NetChargeEnergySetup object that stores the user-defined settings for the desired residue type composition.  This class is defined in ```core/scoring/netcharge_energy/NetChargeEnergySetup.cc``` and ```core/scoring/netcharge_energy/NetChargeEnergySetup.hh```.  NetChargeEnergySetup objects can also be stored in NetChargeConstraints associated with a Pose.  At scoring or packing time, the NetChargeEnergy constructs a vector of owning pointers to its internal NetChargeEnergySetup objects and to all those stored in the pose, and uses all of these for scoring.
- The ```.charge``` files are located in ```/database/scoring/score_functions/netcharge/```.

##See Also

* [[Scoring explained]]
* [[Score functions and score types |score-types]]
* [[Adding a new energy method to Rosetta|new-energy-method]]
* [[Design-centric guidance terms|design-guidance-terms]]
* [[AddNetChargeConstraintMover]]
* [[ClearCompositionConstraintsMover]]
* [[AACompositionEnergy]]
* [[AARepeatEnergy|Repeat-stretch-energy]]
* [[BuriedUnsatPenalty]]
* [[HBNetEnergy]]
* [[VoidsPenaltyEnergy]]
