# RestrictIdentities
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## RestrictIdentities

Used to specify a set of amino acid identities that are either restricted to repacking, or prevented from repacking altogether. Useful if you don't want to design away, for instance, prolines and glycines.

      <RestrictIdentities name="(&string)" identities="(comma-delimited list of strings)" prevent_repacking="(0 &bool)" />

-   identities - A comma-delimited list of the amino acid types that you'd like to prevent from being designed or repacked (e.g., "PRO,GLY").
-   prevent\_repacking - Whether you want those identities to be prevented from repacking altogether (pass true) or just from being designed (pass false).

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