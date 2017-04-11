# GeneralizedKIC Filters

[[Return to RosettaScripts|RosettaScripts]]

## Overview
[[GeneralizedKIC]] filters are evaluations performed rapidly, at low computational cost, on closed solutions found by the kinematic closure algorithm so that poor solutions may be discarded rapidly before computationally-expensive selectors are applied.

## Use within RosettaScripts
Fully manual invocation of a filter within RosettaScripts is accomplished according to the following template.  In most cases, however, shorthands exist for specific filters.  These are described in the [[shorthands|GeneralizedKICfilter#Shorthands]] section.

```xml
<GeneralizedKIC ...>
     ...
     <AddFilter type="&string">
          <AddFilterParameterString value="&string" name="&string" />
          <AddFilterParameterInteger value="(&int)" name="&string" />
          <AddFilterParameterBoolean value="(&bool)" name="&string" />
          <AddFilterParameterReal value="(&Real)" name="&string" />
     </AddFilter>
     ...
</GeneralizedKIC>
```

## Types of filters

1.  Loop bump check (**type="loop_bump_check"**)<br/>This applies a very simple, low-stringency bump check to each solution found, discarding solutions with obvious clashes.  The check is done in two steps.  First, every atom in the chain of atoms to be closed is checked against every other (with clashes between atoms in the same or adjacent residues ignored).  Second, every atom in the chain of atoms to be closed is checked against every mainchain atom (and, in the case of alpha- and beta-amino acids, beta carbon atoms) in every residue that is _not_ in the loop to be closed. which is _not_ directly connected to the loop to be closed, and which is not a tail residue.  Note that tail residues are never checked for clashes.  This filter takes no parameters, and has no shorthand.

2.  Atom pair distance (**type="atom_pair_distance"**)<br/>This discards any solution in which two specified atoms are not within a distance threshold specified with a Real parameter called **distance**.  The atoms are specified with two string parameters called **atom1** and **atom2**, and two integer-valued parameters called **res1** and **res2**.  If a Boolean parameter called **greater_than** is set to **true**, this filter will discard any solution in which the two specified atoms are not separated by _at least_ the distance specified.  Because this filter takes several parameters, a shorthand exists (see below).

3.  Residue mainchain torsion bin (**type="backbone_bin"**)<br/>This filter checks that a given residue's mainchain torsion values lie within a desired mainchain torsion bin.  This filter takes three additional parameters: a residue number (**residue=(&int)**), a [[bin transition probabilities file|Bin-transition-probabilities-file]] (**bin_params_file=(&string "ABBA.bin_params")**), and a bin name (**bin=(&string)**).

4.  Alpha amino acid Ramachandran score (**type="alpha_aa_rama_check"**)<br/>This filter checks that the Ramachandran energy of a given alpha-amino acid residue is below a set threshold.  This filter takes two additional parameters: a residue number (**residue=(&int)**) and a cutoff energy value (**rama_cutoff_energy=(&Real 0.3)**).  The filter is intended to ensure that each alpha-amino acid in a loop is in a reasonable region of Ramachandran space.

5.  General `rama_prepro` score (**type="rama_prepro_check"**)<br/>This filter checks that the `rama_prepro` energy of a given polymeric residue is below a set threshold.  The `rama_prepro` energy is a mainchain torsion score similar to the older `rama` energy, albeit with several advantages.  First, it can be defined for arbitrary polymeric residue types, and not just for canonical alpha-amino acids.  Second, it is not limited to residue types with two mainchain torsions (_e.g._ alpha-amino acids), but can be applied to arbitrary residue types (beta-amino acids, gamma-amino acids, _etc._), provided that N-dimensional Ramachandran tables exist for them.  Third, a different Ramachandran map is used for a given residue type appearing before a proline residue (or other N-substituted residue type) in lindear sequence, allowing the effects on conformational preferences ofthe N-substitution to be taken into account.  This filter also uses the **rama_cutoff_energy** option to specify the filtering threshold.

## Shorthands

The following shorthands are defined:

1.  **AddAtomPairDistanceFilter**<br/>This adds an **atom_pair_distance** filter and sets all of its parameters in one line:
```xml
<GeneralizedKIC ...>
     ...
     <AddAtomPairDistanceFilter atom1="&string" res1="(&int)" atom2="&string" res2="(&int)" distance="(&Real)" greater_than="(false &bool)"/>
     ...
</GeneralizedKIC>
```
