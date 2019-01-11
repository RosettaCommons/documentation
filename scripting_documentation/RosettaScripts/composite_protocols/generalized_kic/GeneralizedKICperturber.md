# GeneralizedKIC Perturbers

[[Return to RosettaScripts|RosettaScripts]]

## Overview
[[GeneralizedKIC]] perturbers alter the chain to be closed in some way prior to kinematic closure.  They can _only_ act on the chain to be closed, and have no effect on tail residues or on any other part of the input structure.  Perturbers are applied in the order that they are defined.  Different perturbers may alter the same degrees of freedom, sequentially.

## Use within RosettaScripts

Certain types of perturbers operate on residues, and require a list of one or more residues to be specified with **AddResidue** tags.  Other perturbers operate on degrees of freedom defined by sets of atoms, and require that these degrees of freedom be defined with **AddAtoms** tags, which can contain lists of 1, 2, 3, or 4 atoms, depending on the type of degree of freedom.  In both cases, some perturbers also require that one or more values be specified with **AddValues** tags.  Details for particular perturbers are below.  Note that [[shorthands|GeneralizedKICperturber#Shorthands]] exist for certain perturbers or common perturber combinations (see below).  Examples for residue-based and atom-based perturbers are shown here:

```xml
<GeneralizedKIC ...>
     ...
     #A residue-based perturber:
     <AddPerturber effect="&string">
          <AddResidue index="(&int)" />
          <AddResidue index="(&int)" />
          <AddResidue index="(&int)" />
          ...
          <AddValue value="(&Real)" />
          <AddValue value="(&Real)" />
          <AddValue value="(&Real)" />
          ...
     </AddPerturber>
     #An atom-based perturber taking four atoms per degree of freedom:
     <AddPerturber effect="&string">
          <AddAtoms res1="(&int)" atom1="&string" res2="(&int)" atom2="&string" res3="(&int)" atom3="&string" res4="(&int)" atom4="&string" />
          <AddAtoms res1="(&int)" atom1="&string" res2="(&int)" atom2="&string" res3="(&int)" atom3="&string" res4="(&int)" atom4="&string" />
          <AddAtoms res1="(&int)" atom1="&string" res2="(&int)" atom2="&string" res3="(&int)" atom3="&string" res4="(&int)" atom4="&string" />
          ...
          <AddValue value="(&Real)" />
          <AddValue value="(&Real)" />
          <AddValue value="(&Real)" />
          ...
     </AddPerturber>
     ...
</GeneralizedKIC>
```

## Types of perturbers
1. Set dihedral/bondangle/bondlength (**effect="set_dihedral"**, **effect="set_bondangle"**, **effect="set_bondlength"**)<br/>These perturbers allow the user to set a desired dihedral angle, bond angle, or bond length.  The set_dihedral perturber takes four or two atoms within each **AddAtoms** block; if two atoms are specified, they will be assumed to be the middle two atoms in the set of four defining the dihedral angle and the other two will be inferred.  Similarly, the set_bondangle perturber takes three or one atoms within each **AddAtoms** block.  The set_bondlength perturber always takes two atoms within each **AddAtoms** block.  For each degree of freedom specified with an **AddAtoms** block, the user can specify a value with **AddValue**.  Alternatively, a single value can be specified for multiple degrees of freedom, in which case all are set to the specified value.
2.  Randomize dihedral (**effect="randomize_dihedral"**)<br/>This perturber assigns each specified dihedral angle a uniformly-distributed random value between -180 degrees and 180 degrees.  The value from the input structure is discarded.  Dihedral angles are specified with **AddAtoms** blocks, and are defined by either two or four atoms.  This perturber takes no values.
3.  Randomize backbone dihedral angles, biased by the Ramachandran plot (**effect="randomize_alpha_backbone_by_rama"**)<br/>This perturber operates on residues specified with **AddResidue** blocks.  It randomizes backbone phi and psi angles biased by each residue's preferred regions within the Ramachandran plot.  It works on alpha-L and alpha-D amino acids.  At least one of the backbone dihedral angles must be part of the chain to be closed.  Optionally, the user may specify a custom Ramachandran plot for sampling using the **custom_rama_table=\<string\>** option within the **AddPerturber** block.  Currently-supported custom Ramachandran plots include: flat_l_aa_ramatable, flat_d_aa_ramatable, flat_symm_dl_aa_ramatable, flat_symm_gly_ramatable, flat_symm_pro_ramatable, flat_l_aa_ramatable_stringent, flat_d_aa_ramatable_stringent, flat_symm_dl_aa_ramatable_stringent, flat_symm_gly_ramatable_stringent, and flat_symm_pro_ramatable_stringent.
4.  Randomize backbone dihedral angles, biased by the new Ramachandran plots that the `rama_prepro` energy term uses (**effect="randomize_backbone_by_rama_prepro"**)<br/>This perturber operates on residues specified with **AddResidue** blocks.  Like the **randomize_alpha_backbone_by_rama** perturber, it randomizes mainchain torsion angles biased by Ramachandran maps in the database.  However, it has several advantages over **randomize_alpha_backbone_by_rama**.  First, it is not limited to canonical alpha-amion acids, but can work with any polymer type for which Ramachandran maps are available.  Second, it works with residue types with any number of rotatable mainchain torsions (_i.e._ it is not limited to two-dimensional Ramachandran maps).  Third, it uses a different Ramachandran map at positions preceding N-substitued positions (L-proline, D-proline, N-methylated amino acids, peptoids, _etc._), better capturing the steric effects of the next residue's N-substitution on conformation.
5.  Perturb dihedral (**effect="perturb_dihedral"**)<br/>This perturber adds a small, Gaussian-distributed value to each dihedral value specified.  Backbone dihedral values are specified using **AddAtoms** blocks, with two or four atoms listed in each.  At least one **AddValue** block is required, with the value specifying the width of the Gaussian (in degrees).  If more than one **AddValue** block is specified, one must be listed for each **AddAtoms** block; this permits different perturbation sizes for different dihedral angles.  Unlike the **randomize_dihedral** perturber, the input dihedral values are preserved by this perturber, with a small random value added or subtracted to each.
6.  Perturb dihedral -- backbone Gaussian version (**effect="perturb_dihedral_bbg"**)<br/>This perturber uses the backbone Gaussian mover to perturb the loop.  The backbone Gaussian mover introduces larger backbone motions, then uses some rapid minimization to minimize the distance that the last residue moves.  This results in a large perturbation to the middle of the loop, and a small gap that GeneralizedKIC must subsequently close.  Residues are specified with **AddResidue** tags; no values are required.
7.  Sample _cis_ peptide bond (**effect="sample_cis_peptide_bond"**)<br/>This perturber allows _cis_-peptide bonds to be sampled for residues listed with **AddResidue** tags, with some probability specified with one or more **AddValue** tags.  This can be useful for positions preceding a proline residue.  Note that a shorthand exists for this perturber (see below).
8.  Randomize mainchain torsions based on torsion bin transition probabilities (**effect="randomize_backbone_by_bins"**)<br/>This perturber will take a contiguous stretch of heteropolymer backbone and randomize it in a biased manner, based on the relative probabilities of transitioning from one torsion bin to another.  This requires an additional input option: a [[bin transitions probability file|Bin-transition-probabilities-file]] (**bin_params_file="filename.bin_params"**).
9.  Perturb mainchain torsions based on torsion bin transition probabilities (**effect="perturb_backbone_by_bins"**)<br/>This perturber will take a contiguous stretch of heteropolymer backbone and perturb the mainchain torsion angles of one residue at a time in a biased manner, based on the mainchain torsion bins of that residue's neighbour and the relative probabilities of transitioning from one torsion bin to another.  This perturber has three additional input options: a [[bin transitions probability file|Bin-transition-probabilities-file]] (**bin_params_file="filename.bin_params"**), a number of iterations (**iterations=(1 &int)**), and a Boolean switch for forcing transitions to different bins (**must_switch_bins=(false &bool)**).  If the number of iterations is set to 1, only one residue, randomly chosen from the list provided, will have its mainchain torsions perturbed.  If it is set higher, the algorithm iteratively picks a residue at random and perturbs it.  If **must_switch_bins** is set to true, the chosen residue is forced into a different torsion bin; if false, it has some probability of remaining in the same torson bin, in which case its mainchain torsion values will be chosen randomly (in a biased manner, if possible) from within that bin.
10.  Randomly select mainchain torsions from within a mainchain torsion bin (**effect="set_backbone_bin"**)<br/>This perturber takes a user-specified bin and bin transitions probability file, and randomly chooses mainchain torsions for specified residues from within that bin.  The perturber has two additional input options: a [[bin transitions probability file|Bin-transition-probabilities-file]] (**bin_params_file="filename.bin_params"**) and a bin (**bin="binname"**), where the bin must match a bin named in the bin transitions probability file.  Note that the selection of torsion angles from within a bin is based on the sub-bin distribution specified in the bin transitions probability file; it can be uniform or based on the Ramachandran distribution for an alpha-amino acid.  (See the [[file type documentation|Bin-transition-probabilities-file]] for details on this.)
11.  Copy mainchain torsion values from another residue (**effect="copy_backbone_dihedrals"**)<br/>This perturber will copy all mainchain torsion values from one residue in the loop to be closed (in which case, previous perturbers may have altered _that_ residue's dihedral values) or in the rest of the pose to the current loop residue.  Subsequent perturbers may then alter this residue's torsions.  This is useful for quasi-symmetric sampling.  This perturber takes a list of residue indices, where the first residue is the residue from which torsion values will be copied, and the second, third, fourth, _etc._ are the residues to which values will be copied.  All residues listed must have the same number of mainchain torsions.
12.  Mirror another residue's mainchain torsion values (**effect="mirror_backbone_dihedrals"**)<br/>This is just like the **"copy_backbone_dihedrals"** effect, but mainchain torsion values will be inverted in the process.  This is useful for quasi-symmetric sampling with mirror symmetry.  Like the **"copy_backbone_dihedrals"** perturber, this one takes a list of residues, where the torsions of the first are mirrored and the inverted values are used to set the torsions of the second, third, fourth, _etc._

## Shorthands

Certain perturbers or perturber combinations have convenient shorthands.  For example, a common operation is to set a bond length and two flanking bond angles in order to close an open bond.  Currently-defined shorthands include:

1.  **CloseBond**<br/>This combines two **set_bondangle** and one **set_bondlength** perturbers, as well as an optional pair of **randomize_dihedral** perturbers for the flanking dihedral angles.  A **set_torsion** perturber also sets the torsion angle of the connection based on the user-specified **torsion** value; if this is not specified, a **randomize_torsion** perturber is substituted.  The **prioratom**, **prioratom_res**, **followingatom**, and **followingatom_res** options need only be specified if **randomize_flanking_torsions** is set to **true**.
```xml
<GeneralizedKIC ...>
     ...
     <CloseBond prioratom=&string" prioratom_res="(&int)" atom1="&string" res1="(&int)" atom2="&string" res2="(&int)" followingatom="&string" followingatom_res="(&int)" bondlength="(&Real)" angle1="(&Real)" angle2="(&Real)" torsion="(&Real)" randomze_flanking_torsions="(false, &bool)" />
     ...
</GeneralizedKIC>
```
2.  **SampleCisPeptideBond**<br/>This is a shorthand for the **sample_cis_peptide_bond** perturber.
```xml
<GeneralizedKIC ...>
     ...
     <SampleCisPeptideBond cis_prob="(&Real)">
          <AddResidue index="(&int)" />
          <AddResidue index="(&int)" />
          <AddResidue index="(&int)" />
          ...
     </SampleCisPeptideBond>
     ...
</GeneralizedKIC>
```
