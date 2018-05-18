# BindingStrain
*Back to [[Filters|Filters-RosettaScripts]] page.*
## BindingStrain

Computes the energetic strain in a bound monomer. Automatically respects symmetry

```xml
<BindingStrain name="(&string)" threshold="(3.0 &Real)" task_operations="(comma-delimited list of operations &string)" scorefxn="(score12 &string)" relax_mover="(null &string)" jump="(1 &Int)"/>
```

-   threshold: how much strain to allow.
-   task\_operations: define the repacked region. Whatever you choose, the filter will make sure you don't design and that the packer task is initialized from the commandline.
-   scorefxn: what scorefxn to use for repacking and total-score evaluations.
-   relax\_mover: after repacking in the unbound state, what mover (if at all) to use to further relax the structure (MinMover?)
-   jump: along which jump to dissociate the complex?

Dissociates the complex and takes the unbound energy. Then, repacks and calls the relax mover, and measures the unbound relaxed energy. Reports the strain as unbound - unbound\_relaxed. Potentially useful to relieve strain in binding.

## See Also

* [[Protein-protein docking|docking-protocol]]
* [[ResInInterfaceFilter]]
* [[SpecificResiduesNearInterfaceFilter]]
