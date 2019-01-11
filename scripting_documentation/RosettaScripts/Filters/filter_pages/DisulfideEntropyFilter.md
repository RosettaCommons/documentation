# DisulfideEntropy
*Back to [[Filters|Filters-RosettaScripts]] page.*
## DisulfideEntropy

Computes the change in deltaSconf\_folding caused by formation of the disulfide bonds in a given topology. S\_conf refers to the configurational entropy of the protein chain only.

deltaS\_conf\_folding = S\_conf\_folded - S\_conf\_unfolded

Disulfide formation restricts the conformational freedom of the denatured state, decreasing S\_conf\_unfolded, which increases deltaS\_conf\_folding.

deltaG\_folding = deltaH\_folding - T (deltaS\_conf\_folding + deltaS\_other)

A more positive deltaS\_conf\_folding leads to greater stability of the folded state (a more negative deltaG\_folding).

The change in deltaS\_conf\_folding caused by a particular disulfide configuration is computed based on modeling the denatured state of the protein using random flight configurational statistics according to a Gaussian approximation. For an overview and the equations themselves, see "Analysis and Classification of Disulphide Connectivity in Proteins: The Entropic effect of Cross-Linkage", PM Harrison & MJE Sternberg, [J Mol Biol 1994 244, 448-463](http://www.ncbi.nlm.nih.gov/pubmed/7990133) .

Briefly,

deltaS\_conf\_folding = - ln (Pn)
 P\_n = (deltaV (3/(2\*pi\*(b\^2)))\^(3/2))\^n |A\_n|\^(3/2)

where:

-   n is the number of disulfide bonds
-   P\_n is the probability of all residues that are disulfide-bonded pairs of residues "spontaneously" associating in the denatured state (forming a contact without being constrained by a disulfide bond) deltaV is the spherical shell around a particular residue where, if another residue is present, the two residues are defined as being in contact (29.65 angstroms\^3)
-   b is the distance between monomers in the polymer chain (3.8 angstroms)
-   |A\_n| is the determinant of the n by n matrix A\_n, where the diagonal elements (i,i) are the number of polymer connections within the closed loop formed by each disulfide i (a disulfide connecting residue 3 to residue 12 encloses 9 polymer connections), and the off-diagonal elements (i,j) are the number of polymer connections shared between two different disulfide loops i and j (a 3x12 disulfide and a 7x20 disulfide share 5 polymer connections: 7-8, 8-9, 9-10, 10-11, and 11-12).

Topologies will pass the filter if the change in deltaS\_conf\_folding caused by the disulfide configuration is higher (more positive) than a fixed threshold ( `     lower_bound    ` ), and more positive than a chain length- and number of disulfide-dependent threshold. The chain length- and disulfide-dependent threshold was computed by surveying natural proteins with 3-5 disulfides and 60 or fewer residues, and is computed as:

threshold = (0.1604 \* residues) + (1.7245 \* disulfides) + 5.1477 + `     tightness    `

where `     tightness    ` is user specified. Larger values for tightness lead to a higher (and thus looser) threshold. With a tightness of zero, 61% of natural proteins pass the filter. With a tightness of 1, 82% of natural proteins pass the filter, and with a tightness of -1, only 19% of natural proteins pass the filter.

```xml
<DisulfideEntropy name="&string" tightness="(0 &Real)" lower_bound="(0 &Real)"/>
```

## See also:

* [[DisulfideEntropyFilter]]
* [[DisulfideFilter]]
