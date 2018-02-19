#MultistageRosettaScripts

#How To Create A Cluster Metric

Back To [[Multistage Rosetta Scripts|MultistageRosettaScripts]]

Back To [[MRS Clustering|MRSClustering]]

[[_TOC_]]

##Step 1: Create a new class

You will want to create a new class in
`protocols/multistage_rosetta_scripts/cluster/metrics`
that derives from ClusterMetric in
`protocols/multistage_rosetta_scripts/cluster/ClusterMetric.hh`.

##Step 2: Implement Virtual Funcitons

ClusterMetric requires the following overrides
(in addition to the destructor, of course):

###distance()

This method takes in another metric and returns the distance between the two.
A large distance means that the two values are very different
and a small distance means that the two are very similar.

You can assume that the other metric is of the same type as `this`.
In other words, you can immediately cast `other` to be an instance of your class.

```c++
platform::Real
distance( ClusterMetric const & other ) const override;
```

###parse_my_tag()

This method is a little different than the `parse_my_tag()`'s in other classes.
For that reason, the name might be different by the time you read this
(if so, please update this page).

This is called when the pose is ready to be measured.
By the end of this function, the desired metric should
be stored in your class so that it will be available when `distance()` is called.

```c++
void
parse_my_tag (
	     core::pose::Pose const & pose,
	     utility::tag::TagCOP tag,
	     basic::datacache::DataMap & datacache
) override;
```

##See Also

* [[Multistage Rosetta Scripts|MultistageRosettaScripts]]
* [Introductory RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scripting_with_rosettascripts/scripting_with_rosettascripts)
* [Advanced RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_scripting_with_rosettascripts/advanced_scripting_with_rosettascripts)
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Getting Started]]: A page for people new to Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
