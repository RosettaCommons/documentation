# PeptideCyclizeMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PeptideCyclizeMover
By Parisa Hosseinzadeh (parisah@uw.edu). Documentation written 20 September 2016.  Last updated 17 May 2017 by Vikram K. Mulligan (vmullig@uw.edu).

PeptideCyclizeMover is a mover for closing a pose by declaring a bond between the residues of interest and applying the necessary distance, angle, and torsion constraints to keep the pose closed. 

In its default format, `PeptideCyclizeMover` will close the N and C termini of a user-defined pose via a peptide bond, i.e. it cyclizes the pose. However, it has the options to set any types of constraints between any two residues if defined by the user.

<b>Default Case</b>

The line below will sets up all the necessary constraints to add a peptide bond between two ends of the selection. It will also declares the bond. 

```xml
<PeptideCyclizeMover name="&string" residue_selector=(&selector_name)/>
```

<b>More Advanced Options</b>

`PeptideCyclizeMover` also offers more complicated constraints and bond declaration options. The mover uses similar format to [[DeclareBond]], [[CreateDistanceConstraint]], [[CreateAngleConstraint]], [[CreateTorsionConstraint]] movers. Below is a list of available options. Please note that you can add as many of each option as you need. However, for each option, you will need to define all the required fields. If you do not define any of the options, the default will be cyclization of first and last residue of the pose via a peptide bond and associated constraints.

<i>Bond</i>

Define the bond between atom1 of residue1 and atom2 of residue2.

```xml
Bond res1=(&int) res2=(&int) atom1="&string" atom2="&string" add_termini=(&bool) />
```

<i>Distance</i>

atom1 of residue1 and atom2 of residue2 should be kept in a distance that is defined by the cst_func. a constraint function is a string that defines the type of constraints, distance, and allowed deviation; "HARMONIC 1.32865 0.01" is an example.

```xml
<Distance res1=(&int) res2=(&int) atom1="&string" atom2="&string" cst_func="&string" />
```

<i>Angle</i>

Defines a constraint function between the three given atoms.

```xml
<Angle res1=(&int) atom1="&string" res_center=(&int) atom_center="&string" res2=(&int) atom2="&string" cst_func="&string" />
```

<i>Torsion</i>

Sets the defined torsion constraints between the given four atoms.

```xml
<Torsion res1=(&int) res2=(&int) res3=(&int) res4=(&int) atom1="&string" atom2="&string" atom3="&string" atom4="&string" cst_func="&string" />
```

<i>Example</i>

The example below does basically what the default mover will do. It cyclizes the pose (residue 1 to 10) with a peptide bond and sets the corresponding constraints:

```xml
<PeptideCyclizeMover name="close" >
    <Torsion res1="10" res2="10" res3="1" res4="1" atom1="CA" atom2="C" atom3="N" atom4="CA" cst_func="CIRCULARHARMONIC 3.141592654 0.005" />
    <Angle res1="10" atom1="CA" res_center="10" atom_center="C" res2="1" atom2="N" cst_func="HARMONIC 2.01000000 0.01" />
    <Angle res1="10" atom1="C" res_center="1" atom_center="N" res2="1" atom2="CA" cst_func="HARMONIC 2.14675498 0.01" />
    <Distance res1="10" res2="1" atom1="C" atom2="N" cst_func="HARMONIC 1.32865 0.01" />
    <Bond res1="10" res2="1" atom1="C" atom2="N" add_termini="true" />
</PeptideCyclizeMover>
```

<b>Important Considerations</b>

The `PeptideCyclizeMover` does not minimize the pose, but only declares a bond and sets certain constraints. Most likely, you will need to relax your pose after applying this mover.  You need to do that with a score function that has constraint terms turned on, and with a relax mover that does not ramp down the constraints during relax.  Note that the Rosetta chemical bond only ensures that no Van der Waals interactions are calculated between the bonded terminal atoms, but does not enforce good bond geometry in any way; the constraints are necessary to preserve good bond geometry.  If you relax without the constraints terms turned on, you will end up with distorted bond geometry after relaxation (though Rosetta will still think that the terminal atoms are bonded).

Below is an example xml that cyclizes chain A of a pose and does the relax:

```xml
<ROSETTASCRIPTS>
    <SCOREFXNS>
        <ScoreFunction name="score_cst" weights="talaris2014" >
            <Reweight scoretype="coordinate_constraint" weight="1" />
            <Reweight scoretype="atom_pair_constraint" weight="1" />
            <Reweight scoretype="dihedral_constraint" weight="1" />
            <Reweight scoretype="angle_constraint" weight="1" />
        </ScoreFunction>
    </SCOREFXNS>
    <RESIDUE_SELECTORS>
        <Chain name="chain_a" chains="A"/>
    </RESIDUE_SELECTORS>
    <TASKOPERATIONS>
    </TASKOPERATIONS>
    <FILTERS>
    </FILTERS>
    <MOVERS>
        <PeptideCyclizeMover name="close" residue_selector="chain_a" />
        <FastRelax name="relax" scorefxn="score_cst" ramp_down_constraints="false" repeats="1" />
    </MOVERS>
    <APPLY_TO_POSE>
    </APPLY_TO_POSE>
    <PROTOCOLS>
        <Add mover="close"/> 
        <Add mover="relax"/>
    </PROTOCOLS>
    <OUTPUT />
</ROSETTASCRIPTS>
```

<b>Distortion of geometry of polymer bond-dependent atoms</b>

Certain atoms, such as the carbonyl oxygen and the amide hydrogen, have positions that are dependent on the geometry of the polymer bond.  During relaxation, these atoms can end up out-of-plane relative to the rest of the bond.  The quick-and-dirty way to correct this is to re-declare the polymer bond between them.  This has no effect on the covalent bonds in the pose (since the bond was already present), but does have the side-effect of updating the positions of atoms dependent on the bond.  While bond re-declaration can be done with the PeptideCyclizeMover, this would also add additional bond constraints (effectively doubling the strength of these constraints).  It is therefore recommended to use the [[DeclareBond|DeclareBondMover]] for this purpose instead.  For example, if chain A were 20 residues long, so that the terminal bond was between residue 20 and residue 1, one could use the following RosettaScripts XML:

```xml
<ROSETTASCRIPTS>
    <SCOREFXNS>
        <ScoreFunction name="score_cst" weights="talaris2014" >
            <Reweight scoretype="coordinate_constraint" weight="1" />
            <Reweight scoretype="atom_pair_constraint" weight="1" />
            <Reweight scoretype="dihedral_constraint" weight="1" />
            <Reweight scoretype="angle_constraint" weight="1" />
        </ScoreFunction>
    </SCOREFXNS>
    <RESIDUE_SELECTORS>
        <Chain name="chain_a" chains="A"/>
    </RESIDUE_SELECTORS>
    <TASKOPERATIONS>
    </TASKOPERATIONS>
    <FILTERS>
    </FILTERS>
    <MOVERS>
        <PeptideCyclizeMover name="close" residue_selector="chain_a" />
        <FastRelax name="relax" scorefxn="score_cst" ramp_down_constraints="false" repeats="1" />
        <DeclareBond name="update_O_and_H" atom1="C" res1="20" atom2="N" res2="1" />
    </MOVERS>
    <APPLY_TO_POSE>
    </APPLY_TO_POSE>
    <PROTOCOLS>
        <Add mover="close"/> 
        <Add mover="relax"/>
        <Add mover="update_O_and_H" />
    </PROTOCOLS>
    <OUTPUT />
</ROSETTASCRIPTS>
```