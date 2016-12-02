# SelectResiduesWithinChain
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## SelectResiduesWithinChain

Selects a list of residues within a chain for design/repacking according to internal chain numbering. If modify\_unselected\_residues is true all other residues are set to norepack.

    <SelectResiduesWithinChain name="(&string)" chain="(1&Integer)" resid="(&comma-separated integer list)" allow_design="(1&bool)" allow_repacking="(1&bool)" modify_unselected_residues="(1&bool)"/>

-   chain: which chain. Use only sequential numbering: 1, 2..
-   resid: which residues within the chain. Again, only numbering (24,35)
-   allow\_design: if true, allows design at selected positions.
-   allow\_repacking: if true, allows repacking at selected positions.
-   modify\_unselected\_residues: if true, set non-selected residues to norepacking.

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