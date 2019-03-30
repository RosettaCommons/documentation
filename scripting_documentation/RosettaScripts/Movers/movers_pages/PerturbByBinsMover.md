# PerturbByBins
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PerturbByBins

This mover perturbs one or more residues in a stretch of polymer backbone in a biased manner, based on the torsion bins of the flanking two residues and on the probability of transitioning from one mainchain torsion bin at position i to another mainchain torsion bin at position i+1.  [[See the documentation on bin probability transitions|Bin-transition-probabilities-file]] for details.  See also the "perturb_backbone_by_bins" [[GeneralizedKICperturber]], which does something similar while enforcing chain closure, permitting this to be a local rather than a global move.  Note that this mover is intended to be usable with any polymeric residue type, provided a bin transition probability file can be generated for the type in question.

```xml
<PerturbByBins name="(&string)" bin_params_file="(&string)" start="(0 &int)" end="(0 &int)" must_switch_bins="(false &bool)" repeats="(1 &int)" />
```
-   bin_params_file: A [[bin transition probability file|Bin-transition-probabilities-file]] specifying the probabilities of transitioning from a given bin at position i to another given bin at position i+1.
-   start:  The start of the residue range to which the perturbation will be applied.  If zero, then this is set to the first residue in the pose.
-   end:  The end of the residue range to which the perturbation will be applied.  If zero, then this is set to the last residue in the pose.
-   must_switch_bins:  If true, then the residue on which this mover is operating will be forced to switch to a different mainchain torsion bin.  If false, then the residue has some probability of remaining in the same mainchain torsion bin, in which case its mainchain torsion angles will be chosen randomly (based on the distribution within the bin, if that information is available).  False by default.
-   repeats:  The number of times a move is applied, where a move consists of picking a single residue in the range and randomizing its mainchain torsion bin based on the transition probabilities with its neighbours.  Set to 1 by default, meaning that only one residue in the range will have its mainchain torsion values altered.


