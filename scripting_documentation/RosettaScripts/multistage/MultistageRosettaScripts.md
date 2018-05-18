#MultistageRosettaScripts

#Multistage Rosetta Scripts

[[_TOC_]]

###Description

Traditional Rosetta Scripts does not have a built-in interface
that allows the user to filter trajectories based on their global ranking.
It instead relies on predetermined filtration cutoffs.
Predicting the correct cutoff to use without first running the script can be difficult,
so these filter cutoffs tend to be conservative in practice.
Multistage Rosetta Scripts (M.R.S.) allows you to filter after each "stage"
based on a trajectory's global rank using the metric of your choice.

Instead of running each rosetta script trajectory in isolation,
M.R.S. breaks the trajectory up into stages as shown below.
Each stage is run to completion for all trajectories before the next stage is started.
This gives Rosetta the ability to sort the results by a user-defined score
and filter based on global position.

![MRS Movie](https://www.rosettacommons.org/docs/wiki/images/multistage_rosetta_scripts/MRSMovieFast.gif)

###[[Jargon|Jargon]]

###[[XML Format|XML]]

###[[Stage Options|StageOptions]]

###[[How to Compile and Run M.R.S.|RunningMRS]]

###[[Tools and Utilities|MRSTools]]

##Additional Features

[[Clustering Between Stages|MRSClustering]]

[[Checkpointing|MRSCheckpointing]]

##Examples
[[PDBList Example|PDBListExample]]:
How to submit structures using a pdblist instead of
having a bunch of seperate `<Job>` tags.

[[Batch Relax|BatchRelaxExample]]:
Save time by splitting FastRelax up into several stages.

[[DataMap Overloading|OverloadExample]]:
How to declare a default object in `<Common>` and
replace it for certain trajectories by defining another object in `<Job>`

[[Time Machine|TimeMachineExample]]:
How to look at intermediate structures of your run
after it has completed.

##See Also

* [Introductory RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scripting_with_rosettascripts/scripting_with_rosettascripts)
* [Advanced RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_scripting_with_rosettascripts/advanced_scripting_with_rosettascripts)
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Getting Started]]: A page for people new to Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications