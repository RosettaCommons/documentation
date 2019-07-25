#Writing a New SimpleMetric

As of RosettaCon 2019, no new filters should be added to Rosetta (with few exceptions)

So - what is replacing them?  SimpleMetrics.  SimpleMetrics are a tool that allows you to calculate some property of a pose, store it, and output the data into a scorefile.  These SimpleMetrics can also be used for filters and FeaturesReporters, greatly expanding their use across Rosetta. 

For a good description of their use, see the [[SimpleMetric | SimpleMetrics ]] documentation.  Here, we will focus on the RealMetric for writing, but any metric can be used as a filter through the [[SimpleMetricFilter]].

[[_TOC_]]

##Template Generation

In order to write a SimpleMetric, the easiest way to start off is to use the [[code template generators | code_templates]].  For each SimpleMetric, there is a type associated with it.  For now, we use a real metric and have the generator place the files in the main SimpleMetric directory: `core/simple_metrics/metrics`.

First, lets take a look at how to use the templates:
```
cd main/source/code_templates
./generate_templates.py --help
```

Ok, here is an example of a new RealMetric we will be writing
```

./generate_templates.py --type metric_real --class_name RadiusOfGyrationMetric --brief "A metric to report the radius of gyration of a complex or individual chain within a pose" --namespace core simple_metrics metrics 
```

Open up the hh and cc file of our metric. 

##Coding

These are the functions you will need to code.  Don't worry - there are only a few!


### `.calculate(pose)`

All SimpleMetrics do their main calculations in the `calculate` method. It is analogous to a mover's apply method. For our real metric, the calculate method takes a const pose and returns a real.  Go ahead and fill this out in your calculate method. 


### `.name()` 

This is the name of the class - it should be filled in for you through the template generation.


### `.metric()`

This is the label of the metric.  For example `rmsd` for the RMSDMetric, `sasa` for the SasaMetric, etc.  This is what will be the label in the scorefile and will be used to store the data within the pose (See `SimpleMetricData` if you want to see internally how this is done.  If you are going with our example, `radius_of_gyration` would work here - it's explicit and doesn't clash with the 'rg' score term. 

### XML Interface: `.parse_my_tag` and `.provide_xml_schema`

You have probably seen these before.  These are the interface to the XML interface that you will want to fill out.  See an already-written SimpleMetric, like the SASAMetric for a good example.  

`.provide_xml_schema` is essentially the documentation of the metric.  This is automatically parsed for you to create a documentation page on the documentation wiki.  You will probably want to add a blank page with your name and include this later.  We will get to that soon. 

`.parse_my_tag` is where you actually pull the options defined in a user's XML into the class.  Here is where you read and set the variables.  However, you will want to use code-level functions to SET private variables.  Don't forget - your code should be able to be used within XML or within base C++/Python code!  For each private variable that you are setting here, you should have an associated setter function to go with it.  Your code can use residue selectors, and other XML objects that are stored in the data map.  take a look at other code for how to do this.   See the RMSDSelector for some code on how to do this.  

That's it!   Everything has been filled out for you using the generators.  Cheers!

##Finalize - Add your SimpleMetric to the factory

Finally, you will need to add your new metric to the appropriate factory. Follow other metrics in this file in alphabetical order. The two files you will need to edit are: `source/src/core/protocols/init.SimpleMetricCreators.ihh and `source/src/core/protocols/init.SimpleMetricRegistrators.ihh`

##Document

Documentation of your SimpleMetric is extremely important and you WILL need it for the reviewer of your Pull Request.  

First, make sure that your provide_xml_schema function is as detailed as it can be.  Instead of writing a whole lot of docs, this function will make it so that your docs change as the code changes and can be as up-to-date as possible.  

Second, Go ahead and edit this page: [[SimpleMetrics]]
Follow other metrics and add your metric to the table for your appropriate metric type.  For this example, we use a RealMetric.  Use the `[[MyNewMetric]]` syntax.  Hit save.  Click the link.  This will make a new page for you.  Make sure to add 'see other' at the end as in other metrics.  The syntax for auto adding your auto-generated documentation from the provide_xml_schema page is this:
`[[include:simple_metric_MyNewMetric_type]]` where `MyNewMetric` is the name of the class you just wrote

##Conclusion

By now, this should have shown you everything you need to write a new SimpleMetric and use it within Rosetta.  You'll also want to write a unit test for your new metric. You can write a new unit test file using the code generator, or add your simple metric test as a new function within `source/test/protocols/analysis/simple_metrics/SimpleMetricProtocols.cxxtest.hh`  Your code will need a unit test for review - so its a great way to test to make sure your code works properly. 

With that - you should be good to go to use your new SimpleMetric in whatever way you desire.  Cheers!