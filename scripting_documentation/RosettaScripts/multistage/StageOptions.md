#MultistageRosettaScripts Stage Options

[[_TOC_]]

##Overview

TODO

##XML Format

###Skeleton

```
<Stage
    num_runs_per_input_struct=“(uint)”
    total_num_results_to_keep=“(uint)”
    result_cutoff=“(uint)”
    max_num_results_per_instance=“(uint)”
    job_bundle_size=“(uint)”
    merge_results_after_this_stage=“(bool)”
>

    <Add mover=“” filter=“”/>
    <Add mover_name=“” filter_name=“”/>
    <Sort filter=“” negative_score_is_good=“true”/>

</Stage>

```

###num_runs_per_input_struct

This is MRS's equivalent to the `-nstruct` command line option.
For the first stage, the number provided here declares the number of times the stage will run for each `<Job/>` tag.
For example, if `num_runs_per_input_struct=40` and there are 5 `<Job/>` tags, then the stage will end up running a total of 200 times.

For each additional stage, the number provided here declares the number of times the stage will run for each result from the previous stage.
If `num_runs_per_input_struct=5` and `total_num_results_to_keep=10` for the previous stage, then the stage will end up running a total of 50 times.

###total_num_results_to_keep

This number defines the maximum number of job results from the current stage that will survive and go on to the next stage (or to be output, if this is the final stage).
Unlike `num_runs_per_input_struct`, this option is not affected by the number of `<Job/>` tags.
The combination of `num_runs_per_input_struct=40`, `total_num_results_to_keep=10`, and 5 `<Job/>` tags results in 200 jobs - of which only 10 results will survive until the next round.

###result_cutoff

This options allows a stage to stop submitting jobs once a certain number of results have come in.
For example, say you are docking two proteins and you have some idea about how you want these proteins to interact.
You can run your docking mover as normal (with or without constraints) and follow up the docking mover with one or more filters.
The job will not return a result unless it passes all of these filters (including the one in `<Sort/>`).
Now you can set `num_runs_per_input_struct` to a very large number and `result_cutoff` to 1000 and Rosetta will essentially keep sampling until it finds 1000 results that pass all of your filters.


###Sort

TODO

##See Also

* [Introductory RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scripting_with_rosettascripts/scripting_with_rosettascripts)
* [Advanced RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_scripting_with_rosettascripts/advanced_scripting_with_rosettascripts)
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Getting Started]]: A page for people new to Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications

<!-- SEO
scriptvars
-->