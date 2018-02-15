#MultistageRosettaScripts

#Clustering

Back To [[Multistage Rosetta Scripts|MultistageRosettaScripts]]

[[_TOC_]]

UNDER CONSTRUCTION

##Skeleton

```xml
<Stage
    num_runs_per_input_struct=“(uint)”
    total_num_results_to_keep=“(uint)”
    result_cutoff=“(uint)”
    max_num_results_to_keep_per_instance=“(uint)”
    max_num_results_to_keep_per_input_struct=“(uint)”
    merge_results_after_this_stage=“(bool)”
>

    <Add mover=“” filter=“”/>
    <Add mover_name=“” filter_name=“”/>
    <Sort filter=“” negative_score_is_good=“true”/>

</Stage>

```

##Runtime

[[/images/multistage_rosetta_scripts/ClusterRuntime.png]]

##Memory Usage

[[/images/multistage_rosetta_scripts/ClusterMemoryUsage.png]]

##See Also

* [[Multistage Rosetta Scripts|MultistageRosettaScripts]]
* [Introductory RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scripting_with_rosettascripts/scripting_with_rosettascripts)
* [Advanced RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_scripting_with_rosettascripts/advanced_scripting_with_rosettascripts)
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Getting Started]]: A page for people new to Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
