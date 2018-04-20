# InitializeByBins
*Back to [[Mover|Movers-RosettaScripts]] page.*
## InitializeByBins

This mover randomizes a stretch of polymer backbone in a biased manner, based on the probability of transitioning from one mainchain torsion bin at position i to another mainchain torsion bin at position i+1.  [[See the documentation on bin probability transitions|Bin-transition-probabilities-file]] for details.  See also the "randomize_backbone_by_bins" [[GeneralizedKICperturber]], which does something similar while enforcing chain closure, permitting this to be a local rather than a global move.  Note that this mover is intended to be usable with any polymeric residue type, provided a bin transition probability file can be generated for the type in question.

```xml
<InitializeByBins name="(&string)" bin_params_file="(&string)" start="(0 &int)" end="(0 &int)" />
```
-   bin_params_file: A [[bin transition probability file|Bin-transition-probabilities-file]] specifying the probabilities of transitioning from a given bin at position i to another given bin at position i+1.
-   start:  The start of the residue range to which the perturbation will be applied.  If zero, then this is set to the first residue in the pose.
-   end:  The end of the residue range to which the perturbation will be applied.  If zero, then this is set to the last residue in the pose.


##See Also

* [[BackrubMover]]
* [[I want to do x]]: Guide to choosing a mover
