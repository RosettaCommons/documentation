# IteratedConvergence
*Back to [[Mover|Movers-RosettaScripts]] page.*
## IteratedConvergence

Repeatedly applies a sub-mover until the given filter returns a value within the given delta for the given number of cycles

```xml
<IteratedConvergence name="(&string)" mover="(&string)" filter="(&string)" delta="(0.1 &real)" cycles="(1 &integer)" maxcycles="(1000 &integer)" />
```

-   mover - the mover to repeatedly apply
-   filter - the filter to use when assaying for convergence (should return a reasonable value from report\_sm())
-   delta - how close do the filter values have to be to count as converged
-   cycles - for how many mover applications does the filter value have to fall within `      delta     ` of the reference value before counting as converged. If the filter is outside of the range, the reference value is reset to the new filter value.
-   maxcycles - exit regardless if filter doesn't converge within this many applications of the mover - intended mainly as a safety check to prevent infinite recursion.


##See Also

* [[GenericSimulatedAnnealerMover]]
* [[GenericMonteCarloMover]]
* [[ContingentAcceptMover]]
* [[IfMover]]
* [[LoopOverMover]]
* [[RandomMover]]
