<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
A class to save the probabilities from a PerResidueProbabilitiesMetric in a weights file.

References and author information for the SaveProbabilitiesMetricMover mover:

SaveProbabilitiesMetricMover Mover's author(s):
Moritz Ertelt, University of Leipzig [moritz.ertelt@gmail.com]  (Wrote the SaveProbabilitiesMetricMover.)

```xml
<SaveProbabilitiesMetricMover name="(&string;)" metric="(&string;)"
        filename="(&string;)" filetype="(weights &string;)"
        use_cached_data="(false &bool;)" cache_prefix="(&string;)"
        cache_suffix="(&string;)" fail_on_missing_cache="(true &bool;)" />
```

-   **metric**: (REQUIRED) A PerResidueProbabilitiesMetric to calculate the pseudo-perplexity from.
-   **filename**: (REQUIRED) The name of the output weights file storing the probabilities.
-   **filetype**: The output filetype, either psi-blast pssm (pssm), weights (weights) file or both (both) (default is weights)
-   **use_cached_data**: Use any data stored in the datacache that matches the set metrics name (and any prefix/suffix.)  Data is stored during a SimpleMetric's apply function, which is called during RunSimpleMetrics
-   **cache_prefix**: Any prefix used during apply (RunSimpleMetrics), that we will match on if use_cache is true
-   **cache_suffix**: Any suffix used during apply (RunSimpleMetrics), that we will match on if use_cache is true
-   **fail_on_missing_cache**: If use_cached_data is True and cache is not found, should we fail?

---
