# TryDisulfPermuations
*Back to [[Mover|Movers-RosettaScripts]] page.*

Page created 8 January 2016 by Vikram K. Mulligan, Baker laboratory.  Write vmullig@uw.edu for questions.
## TryDisulfPermuations
The TryDisulfPermutations mover will exhaustively try every combination of disulfides between all residues that can form disulfides in a pose (or in a subset of a pose specified by a [[ResidueSelector|ResidueSelectors]]).  A quick repack and side-chain minimization (repacking and minimizing ONLY the disulfide-forming residues) is performed for each permutation, and the permutation with the lowest disulfide energy is returned.  (Note that this could easily be turned into a [[MultiplePoseMover]] if there is interest in this.  Contact the author if you require this feature.)  This mover is intended for use in the context of structure prediction algorithms for poses with two or more disulfide-forming residues.

Note that unlike the [[Disulfidize|DisulfidizeMover]] mover, the TryDisulfPermutations mover does not place any new disulfide-forming residues.  Instead, it only considers permutations of existing disulfide-forming residues.  It works with all disulfide-forming types, and preserves the chirality of D- or L-residues.

## Typical usage:
```xml
<MOVERS>
     <TryDisulfPermutations name="trydisulf" consider_already_bonded="false" />
</MOVERS>
```
The above will consider all disulfide permutations in a pose, disregarding disulfide-forming residues already involved in disulfide bonds.

## Full options:

```xml
<TryDisulfPermutations name="(&string)" consider_already_bonded="(true &bool)" min_type="(dfpmin &string)" min_tolerance="(0.00001 &Real)" selector="(&string)">
```
- consider_already_bonded: If true, all disulfide-forming residues are considered.  If false, those already involved in disulfide bonds are omitted.
- min_type: The flavour of minimization used.  See [[Minimization overview]] for details.
- min_tolerance: The stringency of the minimization.
- selector: The name of a previously-defined [[ResidueSelector|ResidueSelectors]].  If not specified, the mover is applied to the whole pose; if specified, the mover only acts on the subset specified by the ResidueSelector.

##See Also

* [[Disulfidize|DisulfidizeMover]]: Place new disulfides.
* [[I want to do x]]: Guide to choosing a mover
