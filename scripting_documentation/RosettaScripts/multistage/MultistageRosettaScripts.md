#MultistageRosettaScripts

###Description

Traditional Rosetta Scripts does not have a built-in interface
that allows the user to filter trajectories based on their global ranking.
Traditional Rosetta Script filters rely on predetermined filtration cutoffs.
It is often difficult to predict the correct cutoff to use without first
running the script, so these filter cutoffs tend to be conservative in practice.

Multistage rosetta scripts (MRS) allows you to filter after each "stage"
based on a trajectory's global rank using the metric of your choice.
For example, you may choose to drop the 80% lowest-scoring structures
after the first mover and then filter out 50% of the remaining structures after the 5th mover.

This is especially useful for movers that can be broken up into
individual repeats (see the batch relax example below).

###[[XML Format|XML]]

###[[Stage Options|StageOptions]]

###[[How to Compile and Run MRS|RunningMRS]]

###[[Tools and Utilities|MRSTools]]

##Examples
[[Batch Relax|BatchRelaxExample]]

[[DataMap Overloading|OverloadExample]]

##See Also

* [Introductory RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scripting_with_rosettascripts/scripting_with_rosettascripts)
* [Advanced RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_scripting_with_rosettascripts/advanced_scripting_with_rosettascripts)
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Getting Started]]: A page for people new to Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
