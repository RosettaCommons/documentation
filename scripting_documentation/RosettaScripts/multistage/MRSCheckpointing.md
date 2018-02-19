#MultistageRosettaScripts

#Checkpointing

Back To [[Multistage Rosetta Scripts|MultistageRosettaScripts]]

[[_TOC_]]

One of the great things about traditional rosetta scripts
is that there is very little penalty for crashing.
If the program crashes 80% of the way through, you still get 80% of the results
and you can just re-submit the job to get the final 20%.

Multistage Rosetta Scripts is not like that!
If the program dies for any reason before
the structures are output, you get NOTHING!

To counter this, we plan on implementing a checkpointing system that
allows progress to be saved and loaded in the event of job failure.

#Not Yet Implemented!

Everything below this point is pure speculation.

```xml
<PROTOCOLS>
	<Stage total_num_results_to_keep="1000">
		<Add mover="my_fast_design_mover"/>
		<Sort filter="my_sfxn_filter"/>
	</Stage>

	<Checkpoint filename="cp1"/>

	<Stage total_num_results_to_keep="50">
		<Add mover="any_mover"/>
		<Sort filter="any_filter"/>
	</Stage>

	<Stage total_num_results_to_keep="30">
		<Add mover="any_mover"/>
		<Sort filter="any_filter"/>
	</Stage>

	<Checkpoint filename="cp2" old_filename_to_delete="cp1"/>

	<Stage total_num_results_to_keep="10">
		<Add mover="any_mover"/>
		<Sort filter="any_filter"/>
	</Stage>
<PROTOCOLS>
```

##Changing the protocol when loading

TODO write about this

```diff
<PROTOCOLS>
-	<Stage total_num_results_to_keep="1000">
+		<Add mover="my_fast_design_mover"/>
+		<Sort filter="my_sfxn_filter"/>
	</Stage>

-	<Cluster total_num_results_to_keep="60">
+		 <Sequence/>
-	</Cluster>

-	<Checkpoint filename="cp1"/>

-	<Stage total_num_results_to_keep="50">
+		<Add mover="any_mover"/>
+		<Sort filter="any_filter"/>
	</Stage>

-	<Stage total_num_results_to_keep="30">
+		<Add mover="any_mover"/>
+		<Sort filter="any_filter"/>
	</Stage>

-	<Checkpoint filename="cp2" old_filename_to_delete="cp1"/>

-	<Stage total_num_results_to_keep="10">
+		<Add mover="any_mover"/>
+		<Sort filter="any_filter"/>
-	</Stage>

<PROTOCOLS>
```

##See Also

* [[Multistage Rosetta Scripts|MultistageRosettaScripts]]
* [Introductory RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scripting_with_rosettascripts/scripting_with_rosettascripts)
* [Advanced RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_scripting_with_rosettascripts/advanced_scripting_with_rosettascripts)
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Getting Started]]: A page for people new to Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
