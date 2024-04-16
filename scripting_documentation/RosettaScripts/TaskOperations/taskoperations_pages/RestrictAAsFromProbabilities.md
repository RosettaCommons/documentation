# RestrictAAsFromProbabilities
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*

`TaskOperation` to restrict designable amino acids depending on the probabilities from a PerResidueProbabilitiesMetric. Does not modify which positions are designable.

[[include:to_RestrictAAsFromProbabilities_type]]
 
## Example
Load probabilities from a weights file and restrict to amino acids that have at least a probability of 0.0001 and a delta probability of 0 (meaning at least as likely as the current amino acid at that position).
```xml
<ROSETTASCRIPTS>
    <RESIDUE_SELECTORS>
    </RESIDUE_SELECTORS>
    <SIMPLE_METRICS>
        <LoadedProbabilitiesMetric name="loaded_probs" filename="probs.weights"/>
    </SIMPLE_METRICS>
    <TASKOPERATIONS>
        <RestrictAAsFromProbabilities name="restrict_to_probs" metric="loaded_probs" prob_cutoff="0.0001" delta_prob_cutoff="0.0" use_cached_data="true"/>
    </TASKOPERATIONS>
    <FILTERS>
    </FILTERS>
    <MOVERS>
        <PackRotamersMover name="design" scorefxn="beta" task_operations="restrict_to_probs" />
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="load"/>
        <Add mover_name="design"/>
    </PROTOCOLS>
</ROSETTASCRIPTS>
```

##See Also
* [[ProhibitResidueProperties]]
* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
