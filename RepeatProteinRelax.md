# RepeatProteinRelax
*Back to [[Mover|Movers-RosettaScripts]] page.*
## RepeatProteinRelax

Performs FastRelax on repeat proteins after setting up internal symmetry

    <RepeatProteinRelax name="(&string)" scorefxn="(&string)" numb_repeats="(4 &int)" minimize="(false &bool)" loop_cutpoint_mode="false &bool" relax_iterations="(5 &int)" cartesian="(false &bool)
      min_type="(lbfgs_armijo_nonmonotone &string)" remove_symmetry="(true &bool)" modify_symmetry_and_exit="(false &bool)" 
    </RepeatProteinRelax>

Options include:
-   scorefxn (tag for score function)
-   numb_repeats (default 4 - **NOTE** this is the number of repeats in the protein not the number of repeats in fastrelax
-   minimize (runs minimize rather than relax. Doesn't seem to work very well
-  loop_cutpoint_mode (adds cutpoints to long loops. With anchors and cutpoints more movement will be seen in the loops)
-  relax_iterations ( number of iterations of fastrelax default=5)
-  cartesian (turns on cartesian relax, use with a cartesian score function)
-  remove_symmetry (can get the mover to leave symmetry after completion. 
-  modify_symmetry_and_exit (only sets up symmetry)

NOTE: Be sure to use with these flags:
-  -symmetry_definition stoopid
-  -old_sym_min true
