<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Reaction-based and similarity guided analoging in a given chemical library

```xml
<ReactionBasedAnalogSampler name="(&string;)" dir="(N/A &string;)"
        reactions="(&string;)" reagents="(N/A &string;)"
        sampling_ratio="(0.001 &real;)"
        minCandidates="(20 &non_negative_integer;)" >
    <DynamicSampling min="(0.0001 &real;)" max="(0.001 &real;)"
            step="(0.00002 &real;)" OFF_after_n_step="(-1 &real;)"
            base="(0.0001 &real;)" />
</ReactionBasedAnalogSampler>
```

-   **dir**: The directory containing the SMARTS-based reactions file and corresponding reagent files.
-   **reactions**: (REQUIRED) The filename of the SMARTS-based reactions file.
-   **reagents**: The filename of the SMILES-based reacgents file.
-   **sampling_ratio**: Sampling ratio for geometric sampler when picking fragments. Assumption invalid when exceeds 0.25.
-   **minCandidates**: The minimum number of candidates required in the sampling set before the output is drawn from each MC cycle. Increasing this will slightly increase runtime. At minimum 20 candidates.


Subtag **DynamicSampling**:   

-   **min**: min sampling ratio for reset.
-   **max**: max sampling ratio limit.
-   **step**: step sampling ratio to increase every MC cycle
-   **OFF_after_n_step**: reset to base ratio and turn off dynamic sampling after n MC cycles
-   **base**: baseline sampling ratio.

---
