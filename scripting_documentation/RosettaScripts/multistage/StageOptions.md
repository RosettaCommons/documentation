#MultistageRosettaScripts Stage Options

[[_TOC_]]

##Overview

TODO

##XML Format

###Skeleton

```
<Stage
    num_runs_per_input_struct=“(uint)”

    max_num_results_per_instance=“(uint)”

    result_cutoff=“(uint)”

    job_bundle_size=“(uint)”

    total_num_results_to_keep=“(uint)”

    merge_results_after_this_stage=“(bool)”
>

    <Add mover=“” filter=“”/>
    <Add mover_name=“” filter_name=“”/>
    <Sort filter=“” negative_score_is_good=“true”/>

</Stage>

```

##Features and Tricks

##See Also

* [Introductory RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scripting_with_rosettascripts/scripting_with_rosettascripts)
* [Advanced RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_scripting_with_rosettascripts/advanced_scripting_with_rosettascripts)
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Getting Started]]: A page for people new to Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications

<!-- SEO
scriptvars
-->