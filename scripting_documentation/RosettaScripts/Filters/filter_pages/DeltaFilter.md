# Delta
*Back to [[Filters|Filters-RosettaScripts]] page.*
## Delta

Computes the difference in a filter's value compared to the input structure

```xml
<Delta name="(&string)" upper="(1 &bool)" lower="(0 &bool)" range="(0 &Real)" filter="(&string)" unbound="(0 &bool)" jump="(see below &Int)" relax_mover="(null &string)"/>
```

-   upper/lower: the threshold is upper/lower? Use both if the threshold is an exact value.
-   range: how much above/below the baseline to allow?
-   filter: the name of a predefined filter for evaluation.
-   unbound: translates the partners by 10000A before evaluating the baseline and the filters. Allows evaluation of the unbound pose.
-   jump: if unbound is set, this can be used to set the jump along which to translate.
-   relax\_mover: called at parse-time before setting the baseline. Useful to get the energies as low as possible (repack/min?)
-   relax_unbound: relax the unbound state w/ relax mover?
-   reference\_name: use reference pose from earlier in script named in XML file
-   reference\_pdb: use reference pose from disk
-   changing_baseline: reset baseline value to current value after every accept

The filter is evaluated at parse time and its internal value (through report\_sm) is saved. At apply time, the filter's report\_sm is called again, and the delta is evaluated.

## See also

* [[BindingStrainFilter]]
* [[DeltaFilter]]
* [[GreedyOptMutationMover]]