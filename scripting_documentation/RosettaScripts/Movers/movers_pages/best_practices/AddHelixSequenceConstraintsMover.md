# AddHelixSequenceConstraints Mover
Page created on 12 February 2017 by Vikram K. Mulligan (vmullig@uw.edu), Baker Laboratory.
*Back to [[Mover|Movers-RosettaScripts]] page.*

[[_TOC_]]

## Mover description

The AddHelixSequenceConstraints mover sets up sequence constraints for each helix in a pose or in a selection.  It can require negative and positive charges at the N- and C-termini, respectively, can limit the number of helix-disfavouring residues in each helix, can require that the helix be a user-specified fraction alanine, and can require a minimum fractional hydrophobic content in each helix.  Note that these constraints remain attached to the pose, and are intended to be used during design with the [[aa_composition|AACompositionEnergy]] score term.  Helices are detected using DSSP when this mover is applied, so if the secondary structure changes between application of this mover and design, the constraints will applied to out-of-date residue indices.  (In such a case, the sequence constraints can be re-applied with this mover after first clearing the old constraints with either the ClearCompositionConstraintsMover, or by setting "reset=true" in this mover's options.)

Note that this mover's defaults have been set so that it can be applied without manually setting anything, and still produce reasonable behaviour.  For advanced users, all settings can be tweaked manually, but this shouldn't be necessary in many cases.

## Typical usage

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
			<Reweight scoretype="aa_composition" weight="1.0" />
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
		<AddHelixSequenceConstraints name="addcomps" />
		<FastDesign name="fastdes" scorefxn="tala_comp" task_operations="resfile" repeats="2" >
			<MoveMap name="fastdes_mm" >
				<Span begin="1" end="999" bb="true" chi="true" />
			</MoveMap>
		</FastDesign>
	</MOVERS>
	<APPLY_TO_POSE>
	</APPLY_TO_POSE>
	<PROTOCOLS>
		<Add mover="addcomps" />
		<Add mover="fastdes" />
	</PROTOCOLS>
	<OUTPUT scorefxn="tala_comp" />
</ROSETTASCRIPTS>
```