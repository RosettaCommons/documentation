# Recommended TaskOperations for Design
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## Recommended TaskOperations for Design

When designing, there are certain recommended TaskOperations that one will typically want to use.  The table below provides advice from experienced designers on which TaskOperations to include by default, and why you would want to make sure that you include them.

| TaskOperation and Person Recommending (designer name(s) and e-mail address(es)) | Best-use options | Reason(s) to Include this TaskOperation, and Caveats |
| ---- | ---- | --------------------------- |
| [[ExtraRotamersGeneric|ExtraRotamersGenericOperation]], recommended by Vikram K. Mulligan (vmullig@uw.edu) and Chris Bahl (cdbahl@uw.edu) | **ex1="true"** **ex2="true"** | The default set of rotamers considered for each designable residue is often not perfectly suited for design.  Often, you'll want rotamers that deviate slightly from those that the packer is considering.  The **ex1** and **ex2** options allow a user to specify that for each rotamer, additional samples of chi1 and chi2 should be added.  For example, default sampling for leucine considers three values for chi1 and three values for chi2 (approximately -60, 60, and 180 degrees for each), for a combinatorial total of 9 rotamers per leucine residue. The **ex1** and **ex2** options add additional samples to each side of the existing samples, increasing the number of rotamers in the leucine case to 81, and possibly allowing additional well-packed configurations to be found. Note though that activating additional rotamers increases the computational cost of a packer run, both in terms of memory and computational time, since many more rotamer combinations must be evaluated, so for the largest design tasks, one may wish to omit this TaskOperation, but if considerations of computation time allow it, it should be included. |
| [[LimitAromaChi2|LimitAromaChi2Operation]], recommended by Chris Bahl (cdbahl@uw.edu) | **include_trp="True"** | Disallow unrealistic chi2 angles in aromatic amino acid side chains.  (Note: this is currently untested for noncanonical design, but is recommended for canonical design.) |
| [[IncludeCurrent|IncludeCurrentOperation]], recommended by Chris Bahl (cdbahl@uw.edu) |  | Don't throw away the rotamers from the input model.  Typically, this is the behaviour that one wants. |
| [[ConsensusLoopDesign|ConsensusLoopDesignOperation]], recommended by Chris Bahl (cdbahl@uw.edu) | **include_adjacent_residues="True"** | This restricts amino acid identities in loops based on the ABEGO torsion bins of the loop residues and the common sequence profiles from native proteins for loops with the same ABEGO bins.  (Note: this calls DSSP to identify loops, which will not work with noncanonical secondary structures.  It will also fail to disallow added noncanonical residue types -- _i.e._ this is primarily intended for canonical design only.) |
| | `-nblist_autoupdate` | |


## See also
* [[ExtraRotamersGeneric|ExtraRotamersGenericOperation]] Task Operation.
* Extra rotamers options on the [[resfile syntax and conventions|resfiles]] page.