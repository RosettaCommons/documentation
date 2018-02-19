#MultistageRosettaScripts

#Clustering

Back To [[Multistage Rosetta Scripts|MultistageRosettaScripts]]

[[_TOC_]]

In order to maintain diversity between trajectories,
you can cluster the results based on a metric of your choice.

##XML Format

```xml
<PROTOCOLS>
	<Stage total_num_results_to_keep="1000">
		<Add mover="my_fast_design_mover"/>
		<Sort filter="my_sfxn_filter"/>
	</Stage>

	<Cluster total_num_results_to_keep="100">
		 <Sequence>
	</Cluster>

	<Stage total_num_results_to_keep="50">
		<Add mover="any_mover"/>
		<Sort filter="any_filter"/>
	</Stage>
<PROTOCOLS>
```

##Metrics

The clustering protocol will not have all of the poses loaded into memory
while clustering. Instead, snapshots of certain features of the pose are saved
and used to define how similar two poses are.
These features are called Cluster Metrics and are chosen by the user.

[[How to make my own cluster metric|HowToMakeClusterMetrics]]

###Sequence

This metric stores the primary sequence of a pose
or subset of the pose if a residue selector is provided.
This measures similarity by counting the number of
positions that have the same one-letter residue name.
This could be useful for clustering assignments that succeed a design stage.

In the future, this might have the option to use the BLOSUM62 matrix
so that not all mutations are counted equally.

```xml
<Sequence selector="&string (optional)">
```

###Jump

This metric stores the 6-dimensions of a given jump and uses them to define its similarity to other poses.
This could be useful for clustering assignments that succeed a docking stage.

```xml
<Jump jump_number="&uint (default is 1)">
```

##See Also

* [[Multistage Rosetta Scripts|MultistageRosettaScripts]]
* [Introductory RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scripting_with_rosettascripts/scripting_with_rosettascripts)
* [Advanced RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_scripting_with_rosettascripts/advanced_scripting_with_rosettascripts)
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Getting Started]]: A page for people new to Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
