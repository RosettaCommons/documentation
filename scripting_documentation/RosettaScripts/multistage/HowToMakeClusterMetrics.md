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
You should end up with the following files:

- `protocols/multistage_rosetta_scripts/cluster/x.fwd.hh`
- `protocols/multistage_rosetta_scripts/cluster/x.hh`
- `protocols/multistage_rosetta_scripts/cluster/x.cc`
- `protocols/multistage_rosetta_scripts/cluster/xCreator.hh`

Your classes should also be added to `src/protocols_e.6.src.settings`
so they get compiled.

##Step 2: Implement virtual functions for cluster metric

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

##Step 3: Implement virtual functions for cluster metric creator

Feel free to check out the cluster metric classes that have already been created to see how these methods behave.

```c++
// Return a new metric.
ClusterMetricOP create_metric() const override;

// Return the tag name associated with this factory.
std::string keyname() const override;

// Describe the schema for the Cluster Metric that this Creator is responsible for
void provide_xml_schema( utility::tag::XMLSchemaDefinition & xsd ) const override;
```

##Step 4: Register class with ClusterMetricFactory

Add the appropriate lines to `src/protocols/init/init.ClusterMetricCreators.ihh`
and `src/protocols/init/init.ClusterMetricRegistrators.ihh`.
If you do not know what to do, just match the pattern of the existing lines there.

##See Also

* [[Multistage Rosetta Scripts|MultistageRosettaScripts]]
* [Introductory RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scripting_with_rosettascripts/scripting_with_rosettascripts)
* [Advanced RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_scripting_with_rosettascripts/advanced_scripting_with_rosettascripts)
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Getting Started]]: A page for people new to Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
