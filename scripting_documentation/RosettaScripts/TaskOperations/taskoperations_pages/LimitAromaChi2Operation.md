# LimitAromaChi2
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## LimitAromaChi2

Prevents use the rotamers of PHE, TYR and HIS that have chi2 far from 90.  These rotamers are acceptable to the Dunbrack energy term due to smoothing of the energy landscape but not actually physically common without some other rearrangements Rosetta fails to capture.  For design purposes, it is simpler to just remove these rotamers from consideration when designing, since they are almost never realistic in the situations Rosetta chooses to use them.  

Note that this tool is INCLUSIVE rather than EXCLUSIVE - you are defining the rotamers to keep, not to remove.

[[include:to_LimitAromaChi2_type]]

This tool ignores TRP by default because TRP's energy landscape is more permissive for this particular problem: for some portions of the Ramachandran plot, these rotamers are fine. To also apply the limits to TRP, set `include_trp` to true.

To understand the underlying rotamer distributions, see [the Dunbrack Lab's description](http://dunbrack.fccc.edu/bbdep2010/ImagesMovies.php).

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