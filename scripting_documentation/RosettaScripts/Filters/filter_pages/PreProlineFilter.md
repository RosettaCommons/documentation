    <PreProline name="prepro" use_statistical_potential="(&bool)" residue_selector="(&residue selector)" />

Helical space (ABEGO type A) is strongly disfavored before a proline, and Rosetta energy may not capture this effect.

In the default mode, the filter simply checks the ABEGO of all residues before prolines and counts the residues that have non-B, non-E abego types (lower = better). With the "use_statistical_potential" option, the filter uses a bicubic spline fit to the data attached to guess at the favorability of a preproline residue with the given phi/psi angles -- this favorability is then returned as the filter score (lower = better).

**Options**
* residue_selector - If a residue selector is provided, the filter will check the residue before all prolines in the selection (default = all prolines)
* use_statistical_potential - If true, the bicublic spline fit to the statistical potential of Ramachandran space will be used to evaluate the torsions. If false, residues in potentially bad torsion bins will be counted. (default = false)

**Example**

    <PreProline name="prepro" use_statistical_potential="0" />

##See Also

* [[SecondaryStructureFilter]]
* [[FoldabilityFilter]]
* [[BluePrintBDRMover]]
* [[ABEGO definition|Glossary#abego]]


