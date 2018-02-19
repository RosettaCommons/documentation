#MultistageRosettaScripts

#Checkpointing

Back To [[Multistage Rosetta Scripts|MultistageRosettaScripts]]

[[_TOC_]]

Not Yet Implemented! Everything below this point is pure speculation.

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

	<Checkpoint filename="cp2" old_filename_to_delete="cp1"/>

	<Stage total_num_results_to_keep="10">
		<Add mover="any_mover"/>
		<Sort filter="any_filter"/>
	</Stage>
<PROTOCOLS>
```

##See Also

* [[Multistage Rosetta Scripts|MultistageRosettaScripts]]
* [Introductory RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scripting_with_rosettascripts/scripting_with_rosettascripts)
* [Advanced RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_scripting_with_rosettascripts/advanced_scripting_with_rosettascripts)
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Getting Started]]: A page for people new to Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
