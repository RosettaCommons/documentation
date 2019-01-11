# EnzRepackMinimize
*Back to [[Mover|Movers-RosettaScripts]] page.*
## EnzRepackMinimize

EnzRepackMinimize, similar in spirit to [[RepackMinimizeMover]], does the design/repack followed by minimization of a protein-ligand (or TS model) interface with enzyme design style constraints (if present, see [[AddOrRemoveMatchCstsMover]]) using specified score functions and minimization dofs. Only design/repack or minimization can be done by setting appropriate tags. A shell of residues around the ligand are repacked/designed and/or minimized. If constrained optimization or cst\_opt is specified, ligand neighbors are converted to Ala, minimization performed, and original neighbor sidechains are placed back.

```xml
<EnzRepackMinimize name="&string" scorefxn_repack="(score12 &string)" scorefxn_minimize="(score12 &string)" cst_opt="(0 &bool)" design="(0 &bool)" repack_only="(0 &bool)" fix_catalytic="(0 &bool)" minimize_rb="(1 &bool)" rb_min_jumps="('' &comma-delimited list of jumps)" minimize_bb="(0 &bool)" minimize_sc="(1 &bool)" minimize_lig="(0 & bool)" min_in_stages="(0 &bool)" backrub="(0 &bool)" cycles="(1 &integer)" task_operations="(comma separated string list)"/>
```

-   scorefxn\_repack: scorefunction to use for repack/design (defined in the SCOREFXNS section, default=score12)
-   scorefxn\_minimize: similarly, scorefunction to use for minimization (default=score12)
-   cst\_opt: perform minimization of enzdes constraints with a reduced scorefunction and in a polyAla background. (default= 0)
-   design: optimize sequence of residues spatially around the ligand (detection of neighbors need to be specified in the flagfile or resfile, default=0)
-   repack\_only: if true, only repack sidechains without changing sequence. (default =0) If both design and repack\_only are false, don't repack at all, only minimize.
-   minimize\_bb: minimize back bone conformation of backbone segments that surround the ligand (contiguous neighbor segments of \>3 residues are automatically chosen, default=0)
-   minimize\_sc: minimize sidechains (default=1)
-   minimize\_rb: minimize rigid body orientation of ligand (default=1)
-   rb\_min\_jumps: specify which jumps to minimize. If this is specified it takes precedence over minimize\_rb above. Useful if you have more than one ligand in the system and you only want to optimize one of the ligands, e.g., rb\_min\_jumps=1,2 would minimize only across jumps 1&2.
-   minimize\_lig: minimize ligand internal torsion degrees of freedom (allowed deviation needs to be specified by flag, default =0)
-   min\_in\_stages: first minimize non-backbone dofs, followed by backbone dofs only, and then everything together (default=0)
-   fix\_catalytic: fix catalytic residues during repack/minimization (default =0)
-   cycles: number of cycles of repack-minimize (default=1 cycle) (Note: In contrast to the enzyme\_design application, all cycles use the provided scorefunction.)
-   backrub:use backrub to minimize (default=0).
-   task\_operations: list of task operations to define the packable/designable residues, as well as the minimizable residues (the minimizable resiudes will the packable residues as well as such surrounding residues as needed to allow for efficient minimization). If explicit task\_operations are given, the design/repack\_only flags will not change them. (So it is possible to have design happen with the repack\_only flag set.) -- If task\_operations are not given, the default (command line controlled) enzyme\_design task will be used. Keep in mind that the default flags are to design everything and not to do interface detection, so being explicit with flags is recommended.


##See Also

* [[Match constraints file format|match-cstfile-format]]
* [[AddOrRemoveMatchCstsMover]]
* [[Match]]: The match command line application
