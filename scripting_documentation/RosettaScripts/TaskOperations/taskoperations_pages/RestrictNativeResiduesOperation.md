# RestrictNativeResidues
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## RestrictNativeResidues

Restrict or prevent repacking of native residues. Accepts a native pose (reference pose) from the command line (via in:file:native) or via the pdbname tag. Loops over all residues and compares the current amino acid at each position to the amino acid in the same position in the reference pose. If the identity is the same, then the residue is either prevented from repacking (if prevent\_repacking option is set to true) or restricted to repacking. Invert behavior to non-native residues by using flag 'invert'.

     <RestrictNativeResidues name="(&string)" prevent_repacking="(0 &bool)" verbose="(0 &bool)" pdbname="('' &string)" invert="(0 &bool)" />

Example: Only allow design at non-native positions (prevent repacking of all native residues).

     <RestrictNativeResidues name="non_native" prevent_repacking="1" verbose="1" pdbname="input/native.pdb" />

Option list

-   prevent\_repacking ( default = 0 ) : Optional. If set to true, then native residues will be prevented from repacking.
-   verbose ( default = 0 ) : Optional. If set to true, then will output a pymol selection string of all non-native residues to stdout.
-   pdbname ( default = "" ) : Optional. Name of the reference pdb to be used as the "native" structure. May alternatively be specified by the in:file:native flag.
- invert ( default = false ) : Optional, invert behavior to restrict only non-native residues

##See Also

* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta