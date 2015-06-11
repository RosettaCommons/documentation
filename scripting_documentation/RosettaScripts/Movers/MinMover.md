# MinMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MinMover

Does minimization over sidechain and/or backbone

```
<MinMover name="&string" scorefxn=(score12 &string) chi=(&bool) bb=(&bool) jump=(&string) cartesian=(&bool) type=(dfpmin_armijo_nonmonotone &string) tolerance=(0.01&Real)>
  <MoveMap>
    ...
  </MoveMap>
</MinMover>
```

Note that defaults are as for the MinMover class! Check MinMover.cc for the default constructor.

-   MinMover is also sensitive to a MoveMap block, just like FastRelax.
-   scorefxn: scorefunction to use during minimization
-   chi: minimize sidechains?
-   bb: minimize backbone?
-   jump: comma-separated list of jumps to minimize over (be sure this jump exists!). If set to "ALL", all jumps will be set to minimize. If set to "0", jumps will be set not to minimize.
-   type: minimizer type. linmin, dfpmin, dfpmin\_armijo, dfpmin\_armijo\_nomonotone. dfpmin minimzers can also be used with absolute tolerance (add "atol" to the minimizer type). See the [[Minimization overview]] for details.
-   tolerance: criteria for convergence of minimization. **The default is very loose, it's recommended to specify something less than 0.01.**
-   MoveMap: The movemap can be programmed down to individual degrees of freedom. See FastRelax for more details.


