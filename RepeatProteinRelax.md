# RepeatProteinRelax
*Back to [[Mover|Movers-RosettaScripts]] page.*
## RepeatProteinRelax

Performs FastRelax on repeat proteins after setting up internal symmetry
<RepeatProteinRelax name="(&string)" scorefxn="(&string)" numb_repeats="(4 &int)" minimize="(false &bool)" loop_cutpoint_mode="false &bool" relax_iterations="(5 &int)" cartesian="(false &bool)
      min_type="(lbfgs_armijo_nonmonotone &string)" remove_symmetry="(true &bool)" modify_symmetry_and_exit="(false &bool)" 
    </FastRelax>

Options include:
-   scorefxn (tag for score function)
-   numb_repeats (default 4 - **NOTE** this is the number of repeats in the protein not the number of repeats in fastrelax
-   minimize (runs minimize rather than relax. Doesn't seem to work very well
-  loop_cutpoint_mode (adds cutpoints 
