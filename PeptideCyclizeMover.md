# PeptideCyclizeMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PeptideCyclizeMover
By Parisa Hosseinzadeh (parisah@uw.edu). Documentation written 20 September 2016.

PeptideCyclizeMover is a mover for closing a pose by declaring a bond between the residues of interest and applying the necessary distance, angle, and torsion constraints to keep the pose closed. 

In its default format, `PeptideCyclizeMover` will close the N and C termini of a user-defined pose via a peptide bond, i.e. it cyclizes the pose. However, it has the options to set any types of constraints between any two residues if defined by the user.

<b>Default Case</b>

The line below will sets up all the necessary constraints to add a peptide bond between two ends of the selection. It will also declares the bond. 

```
<PeptideCyclizeMover name="&string" residue_selector=(&selector_name)/>
```

<b>More Advanced Options</b>

`PeptideCyclizeMover` also offers more complicated constraints and bond declaration options. The mover uses similar format to [[DeclareBond]], [[CreateDistanceConstraint]], [[CreateAngleConstraint]], [[CreateTorsionConstraint]] movers. Below is a list of available options. Please note that you can add as many of each option as you need. However, for each option, you will need to define all the required fields. If you do not define any of the options, the default will be cyclization of first and last residue of the pose via a peptide bond and associated constraints.

<i>Bond</i>

Define the bond between atom1 of residue1 and atom2 of residue2.
```
Bond res1=(&int) res2=(&int) atom1="&string" atom2="&string" add_termini=(&bool) />
```

<i>Distance</i>

atom1 of residue1 and atom2 of residue2 should be kept in a distance that is defined by the cst_func. a constraint function is a string that defines the type of constraints, distance, and allowed deviation; "HARMONIC 1.32865 0.01" is an example.

```
<Distance res1=(&int) res2=(&int) atom1="&string" atom2="&string" cst_func="&string" />
```

<i>Angle</i>

Defines a constraint function between the three given atoms.

```
<Angle res1=(&int) atom1="&string" res_center=(&int) atom_center="&string" res2=(&int) atom2="&string" cst_func="&string" />
```

<i>Torsion</i>

Sets the defined torsion constraints between the given four atoms.

```
<Torsion res1=(&int) res2=(&int) res3=(&int) res4=(&int) atom1="&string" atom2="&string" atom3="&string" atom4="&string" cst_func="&string" />
```

<i>Example</i>

The example below does basically what the default mover will do. It cyclizes the pose (residue 1 to 10) with a peptide bond and sets the corresponding constraints:

```
<PeptideCyclizeMover name="close" >
    <Torsion res1=10 res2=10 res3=1 res4=1 atom1="CA" atom2="C" atom3="N" atom4="CA" cst_func="CIRCULARHARMONIC 3.141592654 0.005" />
    <Angle res1=10 atom1="CA" res_center=10 atom_center="C" res2=1 atom2="N" cst_func="HARMONIC 2.01000000 0.01" />
    <Angle res1=10 atom1="C" res_center=1 atom_center="N" res2=1 atom2="CA" cst_func="HARMONIC 2.14675498 0.01" />
    <Distance res1=10 res2=1 atom1="C" atom2="N" cst_func="HARMONIC 1.32865 0.01" />
    <Bond res1=10 res2=1 atom1="C" atom2="N" add_termini="true" />
</PeptideCyclizeMover>
```

<b>Important Considerations</b>

The `PeptideCyclizeMover` does not minimize the pose, it only declares a bond and set certain constraints. So you will need to relax your pose and you need to do that with : (a) a score function that has constraint terms on; (b) a relax mover that does not ramp down the constraints during relax; (c) you need to re_close the ends after relax or design otherwise your final pose will not have the bond.

Below is an example xml that cyclizes chain A of a pose and does the relax:

```
<ROSETTASCRIPTS>
    <SCOREFXNS>
        <score_cst >
            <Reweight scoretype=coordinate_constraint weight=1 />
            <Reweight scoretype=atom_pair_constraint weight=1 />
            <Reweight scoretype=dihedral_constraint weight=1 />
            <Reweight scoretype=angle_constraint weight=1 />
        </score_cst>
    </SCOREFXNS>
    <RESIDUE_SELECTORS>
        <Chain name="chain_a" chains="A"/>
    </RESIDUE_SELECTORS>
    <TASKOPERATIONS>
    </TASKOPERATIONS>
    <FILTERS>
    </FILTERS>
    <MOVERS>
        <PeptideCyclizeMover name="close" residue_selector="chain_a">
        </PeptideCyclizeMover>
        <FastRelax name="relax" scorefxn="score_cst" ramp_down_constraints=false repeats=1 />
    </MOVERS>
    <APPLY_TO_POSE>
    </APPLY_TO_POSE>
    <PROTOCOLS>
        <Add mover=close/> 
        <Add mover=relax/>
        <Add mover=close/>
    </PROTOCOLS>
    <OUTPUT />
</ROSETTASCRIPTS>
```