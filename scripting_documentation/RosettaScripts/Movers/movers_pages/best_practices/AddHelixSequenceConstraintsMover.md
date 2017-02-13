# AddHelixSequenceConstraints Mover
Page created on 12 February 2017 by Vikram K. Mulligan (vmullig@uw.edu), Baker Laboratory.
*Back to [[Mover|Movers-RosettaScripts]] page.*

[[_TOC_]]

## Mover description

The AddHelixSequenceConstraints mover sets up sequence constraints for each helix in a pose or in a selection.  It can require negative and positive charges at the N- and C-termini, respectively, can limit the number of helix-disfavouring residues in each helix, can require that the helix be a user-specified fraction alanine, and can require a minimum fractional hydrophobic content in each helix.  Note that these constraints remain attached to the pose, and are intended to be used during design with the [[aa_composition|AACompositionEnergy]] score term.  Helices are detected using DSSP when this mover is applied, so if the secondary structure changes between application of this mover and design, the constraints will applied to out-of-date residue indices.  (In such a case, the sequence constraints can be re-applied with this mover after first clearing the old constraints with either the ClearCompositionConstraintsMover, or by setting "reset=true" in this mover's options.)

Note that this mover's defaults have been set so that it can be applied without manually setting anything, and still produce reasonable behaviour.  For advanced users, all settings can be tweaked manually, but this shouldn't be necessary in many cases.

## Typical usage with default options

By default, this mover adds five types of sequence constraints to each alpha helix in the pose.  Any of these behaviours may be disabled or modified by invoking advanced options, but no advanced options need be set in most cases.  The five types of sequence constraints are:
1.  A strong sequence constraint requiring at least two negatively-charged residues in the first (N-terminal) three residues of each alpha-helix.
2.  A strong sequence constraint requiring at least two positively-charged residues in the last (C-terminal) three residues of each alpha-helix.
3.  A weak but strongly ramping sequence constraint penalizing helix-disfavoring residue types (by default, Asn, Asp, Ser, Gly, Thr, and Val) throughout each helix.  (A single such residue is sometimes tolerated, but the penalty for having more than one residue in this category increases quadratically with the count of helix-disfavouring residues.)
4.  A weak sequence constraint coaxing the helix to have 10% alanine.  Because this constraint is weak, deviations from this value are tolerated, but this should prevent an excessive abundance of alanine residues.
5.  A weak sequence constraint coaxing the helix to have at least 25% hydrophobic content.  This constraint is also weak, so slightly less hydrophobic helices will be tolerated to some degree.  Note that alanine is not considered to be "hydrophobic" within Rosetta.

This mover can be used, with default settings, in three easy steps:

1.  Set up a scorefunction that has the [[aa_composition|AACompositionEnergy]] score term's weight set to 1.0.  This can be done by modifying the .wts file that is passed in from the commandline, or by using the `<Reweight ... />` tag when setting up a scorefunction in RosettaScripts.
2.  Add the mover, with no options but the instance name, to the `<MOVERS>` section, and apply it prior to design steps in the `<PROTOCOLS>` section.
3.  Add the modified scorefunction to design steps that occur after applying the AddHelixSequenceConstraints mover.

An example script, using the FastDesign mover, is as follows.  Note that sequence constraints are best used with flexible backbone design, so that the backbone can shift slightly to accommodate the desired amino acid sequence composition.  (Helices that are too close together, for example, can move apart slightly during minimization steps to best fit bulky hydrophobic groups added during design steps.)

```xml
<ROSETTASCRIPTS>
	<SCOREFXNS>
		<ScoreFunction name="tala_comp" weights="talaris2014.wts" >
			<Reweight scoretype="aa_composition" weight="1.0" /> <!-- Step 1: turn on aa_composition. -->
		</ScoreFunction>
	</SCOREFXNS>
	<RESIDUE_SELECTORS>
	</RESIDUE_SELECTORS>
	<TASKOPERATIONS>
		<ReadResfile name="resfile" filename="inputs/resfile.txt" />
	</TASKOPERATIONS>
	<FILTERS>
	</FILTERS>
	<MOVERS>
		<AddHelixSequenceConstraints name="addcomps" /> <!-- Step 2: Add the mover, with no options. -->
		<FastDesign name="fastdes" scorefxn="tala_comp" task_operations="resfile" repeats="2" > <!-- Step 3: Use the modified scorefunction for design. -->
			<MoveMap name="fastdes_mm" >
				<Span begin="1" end="999" bb="true" chi="true" />
			</MoveMap>
		</FastDesign>
	</MOVERS>
	<APPLY_TO_POSE>
	</APPLY_TO_POSE>
	<PROTOCOLS>
		<Add mover="addcomps" /> <!-- Step 2: Add the mover to the PROTOCOLS section. -->
		<Add mover="fastdes" />
	</PROTOCOLS>
	<OUTPUT scorefxn="tala_comp" />
</ROSETTASCRIPTS>
```

## Advanced usage with manual overrides of options

The default usage pattern lets the mover "do the thinking" for the user.  For advanced users, any of the five functions of this mover may be disabled independently, or the behaviour of each may be modified.  The full options list is as follows:

```xml
<AddHelixSequenceConstraints name=(string)
     residue_selector=(string) reset=(bool,"false") min_helix_length=(int,"8")
     add_n_terminal_constraints=(bool,"true") min_n_terminal_charges=(int,"2") n_terminal_residues=(int,"3") n_terminal_constraint_strength=(real,"15.0")
     add_c_terminal_constraints=(bool,"true") min_c_terminal_charges=(int,"2") c_terminal_residues=(int,"3") c_terminal_constraint_strength=(real,"15.0")
     add_overall_constraints=(bool,"true") types_to_avoid=(string,"ASN ASP SER GLY THR VAL") overall_max_count=(int,"0") overall_constraints_strength=(real,"5.0")
     add_alanine_constraints=(bool,"true") desired_alanine_fraction=(real,"0.1") ala_constraint_under_strength=(real,"0.2") ala_constraint_over_strength=(real,"0.2")
     add_hydrophobic_constraints=(bool,"true") desired_min_hydrophobic_fraction=(real,"0.25") hydrophobic_constraint_strength=(real,"0.2")
/>
```
### General options

**residue_selector (string):**  An optional, previously-defined ResidueSelector.  If provided, only helices that contain at least one residue that is selected by the residue selector will have constraints applied.  If not used, constraints are applied to all helices in the pose.

**reset (bool,"false"):**  If true, all sequence constraints in the pose will be cleared (deleted) before this mover is applied.  If false, the mover will append to existing sequence constraints.  False by default.

**min_helix_length (int,"8"):**  The minimum number of residues that a helix must have for this mover to act on it.  By default, helices smaller than 8 residues are ignored since they have negligible helix macrodipoles.

### Options related to N-terminal charges

**add_n_terminal_constraints (bool,"true"):**  If true, this mover will add sequence constraints requiring a user-specified minimum number of negatively-charged residues at the N-terminus of each helix.  True by default.

**min_n_terminal_charges (int,"2"):**  The minimum number of negatively-charged residues required at the N-terminus of helices.  Defaults to 2 residues.

**n_terminal_residues (int,"3"):**  The length of the stretch of residues that must contain negative charges at the N-terminus of a helix.  Defaults to 3 residues.

**n_terminal_constraint_strength (real,"15.0"):**  The strength of the sequence constraint requiring negative charges at the N-termini of helices.  If set to be too weak, Rosetta's packer may sometimes put in too few negative charges.  15.0 by default.
(For advanced users, this is the energetic penalty applied when there is one fewer than the desired number of negatively-charged residues.  The penalty ramps quadratically for two fewer, three fewer, etc.)


## Known limitations

- Since this mover calls DSSP to detect secondary structure, it is currently incompatible with right-handed helices or exotic helix types formed by non-canonical amino acid residues.
- Secondary structure detection with DSSP occurs at the time that the AddHelixSequenceConstraints mover is applied to the pose, and the resulting sequence constraints remain attached to the pose.  This means that, if the user applies the AddHelixSequenceConstraints mover, then applies a subsequent mover that alters backbone conformation prior to design, the helices that were present when DSSP was called may no longer be present, or of the same length.  That is, the sequence constraints may be out of date.  To solve this, the AddHelixSeqeuenceConstraints mover may be re-applied after clearing constraints with the `reset` option or with the [[ClearCompositionConstraintsMover]].
- Sequence constraints add a nonlinear score penalty for deviation from a desired amino acid composition, guiding the packer to good sequences during design.  This means that they cannot overcome sequence restrictions imposed using task operations.  For example, if I have a sequence constraint penalizing the absence of negative charges at the N-terminus of a helix, by my task operation list prohibits negative charges at those positions, I will not obtain any results with negative charges at the N-terminus of that helix.