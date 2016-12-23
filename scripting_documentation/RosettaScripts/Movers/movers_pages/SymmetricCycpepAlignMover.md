# SymmetricCycpepAlignMover

Documentation created by Vikram K. Mulligan (vmullig@uw.edu), Baker laboratory, on 23 December 2016.
*Back to [[Mover|Movers-RosettaScripts]] page.*

## SymmetricCycpepAlignMover

[[_TOC_]]

## Description

Given a quasi-symmetric cyclic peptide, this mover aligns the peptide so that the cyclic symmetry axis lies along the Z-axis and the centre of mass is at the origin.  It then optionally removes all but one symmetry repeat, so that true symmetry may be set up with the [[SetupForSymmetry|SetupForSymmetryMover]] mover.

Note that, if the trimming option is used, all non-protein residues (_e.g._ crosslinkers like 1,3,5-tris(bromomethyl)benzene) are also removed.  A new fold tree is set up with the middle of the symmetry repeat as the root of the tree (which tends to be useful for subsequent symmetric minimization).

## Full options

```
```

## Example

This script operates on a 20-residue c4-symmetric peptide.  A peptide bond connecting the N and C termini is declared with the [[DeclareBond|DeclareBondMover]] mover, and the peptide is then aligned to the Z-axis and trimmed to a single 5-residue symmetry repeat with this mover.  The [[SetupForSymmetry|SetupForSymmetryMover]] mover is then used to set up Rosetta symmetry, and a new bond between the individual symmetry repeats is declared using the [[PeptideCyclizeMover]], which also creates constraints for the peptide bond.  Finally, the peptide is subjected to symmetric relaxation.

```xml
<ROSETTASCRIPTS>
	<SCOREFXNS>
		<ScoreFunction name="bnv" weights="beta_nov15.wts" symmetric="true" />
		<ScoreFunction name="bnv_cst" weights="beta_nov15_cst.wts" symmetric="true" />
	</SCOREFXNS>
	<RESIDUE_SELECTORS>
		<!-- A selector is needed because the SetupForSymmetry mover appends virtual residues, -->
		<!-- and the PeptideCyclizeMover, by default, operates on the first and last residues  -->
		<!-- of the pose or selection.                                                         -->
		<Index name="peptide_selector" resnums="1-20" />
	</RESIDUE_SELECTORS>
	<MOVERS>
	
		<DeclareBond name="bond1" res1="20" res2="1" atom1="C" atom2="N" add_termini="false" />
	
		<SymmetricCycpepAlign name="align" auto_detect_symmetry="true" angle_threshold="15" trim_to_single_repeat="true" invert="true" />
		
		<SetupForSymmetry name="sym" definition="inputs/c4.symm" />

		<PeptideCyclizeMover name="bond2" residue_selector="peptide_selector" />
		
		<FastRelax name="frlx" repeats="3" scorefxn="bnv_cst" >
			<MoveMap name="frlx_mm1" >
				<Span begin="1" end="999" bb="true" chi="true" />
				<Jump number="1" setting="true" />
				<Jump number="2" setting="true" />
				<Jump number="3" setting="true" />
				<Jump number="4" setting="true" />
				<Jump number="5" setting="true" />
				<Jump number="6" setting="true" />
				<Jump number="7" setting="true" />
				<Jump number="8" setting="true" />
				<Jump number="9" setting="true" />
				<Jump number="10" setting="true" />
				<Jump number="11" setting="true" />
				<Jump number="12" setting="true" />
			</MoveMap>
		</FastRelax>
		
	</MOVERS>
	<PROTOCOLS>
		<Add mover="bond1" />
		<Add mover="align" />
		<Add mover="sym" />
		<Add mover="bond2" />
		<Add mover="frlx" />
	</PROTOCOLS>
	<OUTPUT scorefxn="bnv" />
</ROSETTASCRIPTS>

```