# FastRelax
*Back to [[Mover|Movers-RosettaScripts]] page.*
## FastRelax

Performs the fast relax protocol.

    <FastRelax name="&string" scorefxn="(&string)" repeats="(5 &int)" task_operations="(&string, &string, &string)"
      batch="(false &bool)" ramp_down_constraints="(false &bool)" 
      cartesian="(false &bool)" bondangle="(false &bool)" bondlength="(false &bool)"
      min_type="(dfpmin_armijo_nonmonotone &string)" relaxscript="('' &string)" >
       <MoveMap name="(''&string)">
          <Chain number="(&integer)" chi="(&bool)" bb="(&bool)"/>
          <Jump number="(&integer)" setting="(&bool)"/>
          <Span begin="(&integer)" end="(&integer)" chi="(&bool)" bb="(&bool)"/>
       </MoveMap>
    </FastRelax>

Options include:

-   scorefxn (tag for score function if you need something different than the Rosetta default.)
-   repeats (default 5 - Same as cmd-linde FR)
-   relaxscript (a filename for a relax script, as described in the [[documentation for the Relax application|relax]]; the default relax script is used if not specified)
-   sc\_cst\_maxdist &integer. Sets up sidechain-sidechain constraints between atoms up to maxdist, at neighboring sidechains. Need to also call ramp\_constraints = false, otherwise these will be turned off in the later rounds of relax.
-   task\_operations FastRelax will now respect any TaskOps passed to it. However, the default behavior is now to add RestrictToRepacking operation unless <code>disable_design=false</code> is set.
-   disable_design (default true) Disable design if TaskOps are passed?  Needs to be false if purposefully designing.
-   MoveMap name: this is optional and would actually not work with all movers. The name allows the user to specify a movemap that can later be called by another mover without specifying all of the options. Movers that do not support this functionality will exit with an error message.
-   jumps, bb torsions and chi angles are set to true (1) by default

The MoveMap (for FastRelax) is initially set to minimize all degrees of freedom. The movemap lines are read in the order in which they are written in the xml file, and can be used to turn on or off dofs. The movemap is parsed only at apply time, so that the foldtree and the kinematic structure of the pose at the time of activation will be respected.


##See Also

* [[FastDesignMover]]
* [[Relax]]: The relax application
* [[Preparing structures]]: Page on preparing structures for use in Rosetta using relax.
* [[I want to do x]]: Guide to chosing a mover