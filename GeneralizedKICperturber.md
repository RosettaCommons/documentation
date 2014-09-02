# GeneralizedKIC Perturbers

## Overview
[[GeneralizedKIC]] perturbers alter the chain to be closed in some way prior to kinematic closure.  They can _only_ act on the chain to be closed, and have no effect on tail residues or on any other part of the input structure.  Perturbers are applied in the order that they are defined.  Different perturbers may alter the same degrees of freedom, sequentially.

## Use within RosettaScripts

Certain types of perturbers operate on residues, and require a list of one or more residues to be specified with **AddResidue** tags.  Other perturbers operate on degrees of freedom defined by sets of atoms, and require that these degrees of freedom be defined with **AddAtoms** tags, which can contain lists of 1, 2, 3, or 4 atoms, depending on the type of degree of freedom.  In both cases, some perturbers also require that one or more values be specified with **AddValues** tags.  Details for particular perturbers are below.  Examples for residue-based and atom-based perturbers are shown here:
```
<GeneralizedKIC ...>
     ...
     #A residue-based perturber:
     <AddPerturber effect="&string">
          <AddResidue index=(&int) />
          <AddResidue index=(&int) />
          <AddResidue index=(&int) />
          ...
          <AddValue value=(&Real) />
          <AddValue value=(&Real) />
          <AddValue value=(&Real) />
          ...
     </AddPerturber>
     #An atom-based perturber taking four atoms per degree of freedom:
     <AddPerturber effect="&string">
          <AddAtoms res1=(&int) atom1="&string" res2=(&int) atom2="&string" res3=(&int) atom3="&string" res4=(&int) atom4="&string" />
          <AddAtoms res1=(&int) atom1="&string" res2=(&int) atom2="&string" res3=(&int) atom3="&string" res4=(&int) atom4="&string" />
          <AddAtoms res1=(&int) atom1="&string" res2=(&int) atom2="&string" res3=(&int) atom3="&string" res4=(&int) atom4="&string" />
          ...
          <AddValue value=(&Real) />
          <AddValue value=(&Real) />
          <AddValue value=(&Real) />
          ...
     </AddPerturber>
     ...
</GeneralizedKIC>
```

## Types of perturbers
1. Set dihedral/bondangle/bondlength (**effect="set_dihedral"**, **effect="set_bondangle"**, **effect="set_bondlength"**)<br>These perturbers allow the user to set a desired dihedral angle, bond angle, or bond length.  The set_dihedral perturber takes four or two atoms within each **AddAtoms** block; if two atoms are specified, they will be assumed to be the middle two atoms in the set of four defining the dihedral angle and the other two will be inferred.  Similarly, the set_bondangle perturber takes three or one atoms within each **AddAtoms** block.  The set_bondlength perturber always takes two atoms within each **AddAtoms** block.  For each degree of freedom specified with an **AddAtoms** block, the user can specify a value with **AddValue**.  Alternatively, a single value can be specified for multiple degrees of freedom, in which case all are set to the specified value.
2.  Randomize dihedral (**effect="randomize_dihedral"**)<br>This perturber assigns each specified dihedral angle a uniformly-distributed random value between -180 degrees and 180 degrees.  The value from the input structure is discarded.  Dihedral angles are specified with **AddAtoms** blocks, and are defined by either two or four atoms.  This perturber takes no values.
3.  Randomize backbone dihedral angles, biased by the Ramachandran plot (**effect="randomize_alpha_backbone_by_rama"**)<br>This perturber operates on residues specified with **AddResidue** blocks, and takes no additional values.  It randomizes backbone phi and psi angles biased by each residue's preferred regions within the Ramachandran plot.  It works on alpha-L and alpha-D amino acids.  At least one of the backbone dihedral angles must be part of the chain to be closed.
4.  Perturb dihedral (**effect="perturb_dihedral"**)<br>This perturber adds a small, Gaussian-distributed value to each dihedral value specified.  Backbone dihedral values are specified using **AddAtoms** blocks, with two or four atoms listed in each.  At least one **AddValue** block is required, with the value specifying the width of the Gaussian (in degrees).  If more than one **AddValue** block is specified, one must be listed for each **AddAtoms** block; this permits different perturbation sizes for different dihedral angles.  Unlike the **randomize_dihedral** perturber, the input dihedral values are preserved by this perturber, with a small random value added or subtracted to each.
5.  Perturb dihedral -- backbone Gaussian version (**effect="perturb_dihedral_bbg"**)<br>This perturber uses the backbone Gaussian mover to perturb the loop.  The backbone Gaussian mover introduces larger backbone motions, then uses some rapid minimization to minimize the distance that the last residue moves.  This results in a large perturbation to the middle of the loop, and a small gap that GeneralizedKIC must subsequently close.  Residues are specified with **AddResidue** tags; no values are required.
6.  Sample _cis_ peptide bond (**effect="sample_cis_peptide_bond"**)<br>This perturber allows _cis_-peptide bonds to be sampled for residues listed with **AddResidue** tags, with some probability specified with one or more **AddValue** tags.  This can be useful for positions preceding a proline residue.  Note that a shorthand exists for this perturber (see below).

## Shorthands

Certain perturbers or perturber combinations have convenient shorthands.  For example, a common operation is to set a bond length and two flanking bond angles in order to close an open bond.  Currently-defined shorthands include:

1.  **CloseBond**<br>This combines two **set_bondangle** and one **set_bondlength** perturbers, as well as an optional pair of **randomize_dihedral** perturbers for the flanking dihedral angles.  A **set_torsion** perturber also sets the torsion angle of the connection based on the user-specified **torsion** value; if this is not specified, a **randomize_torsion** perturber is substituted.  The **prioratom**, **prioratom_res**, **followingatom**, and **followingatom_res** options need only be specified if **randomize_flanking_torsions** is set to **true**.
```
<GeneralizedKIC ...>
     ...
     <CloseBond prioratom=&string" prioratom_res=(&int) atom1="&string" res1=(&int) atom2="&string" res2=(&int) followingatom="&string" followingatom_res=(&int) bondlength=(&Real) bondangle1=(&Real) bondangle2=(&Real) torsion=(&Real) randomze_flanking_torsions=(false, &bool) />
     ...
</GeneralizedKIC>
```
2.  **SampleCisPeptideBond**<br>This is a shorthand for the **sample_cis_peptide_bond** perturber.
```
<GeneralizedKIC ...>
     ...
     <SampleCisPeptideBond cis_prob=(&Real)>
          <AddResidue index=(&int) />
          <AddResidue index=(&int) />
          <AddResidue index=(&int) />
          ...
     </SampleCisPeptideBond>
     ...
</GeneralizedKIC>
```