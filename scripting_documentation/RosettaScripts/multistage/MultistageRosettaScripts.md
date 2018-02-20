#MultistageRosettaScripts

#Multistage Rosetta Scripts

###Description

Traditional Rosetta Scripts does not have a built-in interface
that allows the user to filter trajectories based on their global ranking.
Traditional Rosetta Scripts relies on predetermined filtration cutoffs.
It is often difficult to predict the correct cutoff to use without first
running the script, so these filter cutoffs tend to be conservative in practice.

Multistage Rosetta Scripts (M.R.S.) allows you to filter after each "stage"
based on a trajectory's global rank using the metric of your choice.
For example, you may choose to drop the 80% lowest-scoring structures
after the first mover and then filter out 50% of the remaining structures after the 5th mover.

###[[Description|Description]]

###[[XML Format|XML]]

###[[Stage Options|StageOptions]]

###[[How to Compile and Run M.R.S.|RunningMRS]]

###[[Tools and Utilities|MRSTools]]

##Additional Features

[[Clustering Between Stages|MRSClustering]]

[[Checkpointing|MRSCheckpointing]]

##Examples
[[Batch Relax|BatchRelaxExample]]

[[DataMap Overloading|OverloadExample]]

[[Time Machine|TimeMachineExample]]

##See Also

* [Introductory RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scripting_with_rosettascripts/scripting_with_rosettascripts)
* [Advanced RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_scripting_with_rosettascripts/advanced_scripting_with_rosettascripts)
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Getting Started]]: A page for people new to Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
