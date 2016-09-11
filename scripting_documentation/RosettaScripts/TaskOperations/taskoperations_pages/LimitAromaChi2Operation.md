# LimitAromaChi2
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## LimitAromaChi2

Prevent to use the rotamers of PHE, TYR and HIS that have chi2 far from 90.

-   chi2max ( default 110.0 ) : max value of chi2 to be used
-   chi2min ( default 70.0 ): min value of chi2 to be used
-   include_trp ( default false ): also impose chi2 limits for tryptophans

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