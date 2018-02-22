#MultistageRosettaScripts

#Multistage Rosetta Scripts

[[_TOC_]]

###Description

Traditional Rosetta Scripts does not have a built-in interface
that allows the user to filter trajectories based on their global ranking.
Traditional Rosetta Scripts relies on predetermined filtration cutoffs.
It is often difficult to predict the correct cutoff to use without first
running the script, so these filter cutoffs tend to be conservative in practice.
Multistage Rosetta Scripts (M.R.S.) allows you to filter after each "stage"
based on a trajectory's global rank using the metric of your choice.

Instead of running each rosetta script trajectory in isolation,
M.R.S. breaks the trajectory up into stages as shown below.
Rosetta runs each stage for all of the trajectories and
filters out some trajectories based on their global rank
before moving on to the next stage.

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
[[Batch Relax|BatchRelaxExample]]

[[PDBList Example|PDBListExample]]: How to submit structures using a pdblist instead of have a bunch of seperate `<Job>` tags.

[[DataMap Overloading|OverloadExample]]

[[Time Machine|TimeMachineExample]]

##See Also

* [Introductory RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scripting_with_rosettascripts/scripting_with_rosettascripts)
* [Advanced RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_scripting_with_rosettascripts/advanced_scripting_with_rosettascripts)
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Getting Started]]: A page for people new to Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications