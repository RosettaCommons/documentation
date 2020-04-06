#Updating RosettaScripts

[[_TOC_]]

RosettaScripts is a system under continual development. While the developers try to keep the format of the RosettaScript XML somewhat consistent between versions of Rosetta, occasionally there are significant changes which cause existing RosettaScript XMLs to break or work sub-optimally.

## XML Modernization.

RosettaScripts started with something that was almost-but-not-quite XML. In late 2016 (Rosetta 3.8 and later) we converted the XML loading code in Rosetta to require properly formatted XML. The two most obvious changes in the syntax were the new requirement for quotation marks around tag attributes/options as well as the requirement that the subtags in the <SCOREFXNS> section now look like `<ScoreFunction name="sfxname" ...>` rather than the previous `<sfxname ...>`. 

If you feed RosettaScripts a file in the old format (for example, an XML from the Supporting Information from an older paper), you're likely to get error messages along the lines of "Input rosetta scripts XML file "fname" failed to validate against the rosetta scripts schema." This should also print out a number of options to try. If you are encountering this error due to an old RosettaScript XML, you can use the `tools/xsd_xrw/rewrite_rosetta_script.py` script distributed with Rosetta to rewrite the XML from the old format to the new format. (Run the script with the `-h` option to get a description of how to use it.)

Note that the same error message will be printed if you make a typo in an XML or use a no-longer supported option. In those cases, the rewrite_rosetta_script.py script won't be of use.

## Input pose as a reference pose.

Certain Movers and Filters (e.g. ones which calculated RMSD) were written to be able to use the input pose as a reference pose. As RosettaScripts has become more complex, the mechanism by which they do so is no longer supported. If you get an error message like "<Object name> is improperly trying to access the input pose during setup!" or a warning message like "<Object name> is (implicitly) attempting to get the input pose during setup. You should likely use the SavePoseMover to save the pose at the beginning of the PROTOCOL block, and then use the reference_name attribute to explicitly set the reference structure." then you're likely running into this issue. 

The way to fix that is to be more explicit about the reference structure. The [[SavePoseMover]] is able to capture the state of the Pose at a certain point in the protocol, and allow other movers and filters to use that reference pose state. If you wish to use the input pose as a reference pose, simply add a SavePoseMover call to the beginning of the PROTOCOLS block.

For example you can convert the following implicit usage of the input pose

```
    ...
    <FILTERS>
        <Rmsd name="rmsd" chains="A" />
    </FILTERS>
    ...
    <PROTOCOLS>
        ...
        <Add filter_name="rmsd" />
        ...
    </PROTOCOLS>
    ...
```

to the following to be explicit about using the input pose as a reference pose:

```
    ...
    <MOVERS>
        <SavePoseMover name="save_input" restore_pose="false" reference_name="input_pose" />
    </MOVERS>
    <FILTERS>
        <Rmsd name="rmsd" chains="A" />
    </FILTERS>

    ...
    <PROTOCOLS>
        <Add mover_name="save_input" />  # The very first mover in the PROTOCOLS block.
        ...
        <Add filter_name="rmsd" />
        ...
    </PROTOCOLS>
    ...
```

## Removal of the APPLY_TO_POSE section.

The APPLY_TO_POSE section was a mechanism to apply movers to a pose prior to the "start" of the XML. With more complex RosettaScripts being supported, this mechanism no longer works well, and has been removed. If you encounter this issue, you'll see an error message along the lines of "The APPLY_TO_POSE section is no longer valid. Please remove it from your XML." (Note that an empty APPLY_TO_POSE section is still allowed, it's only a non-empty one which will cause the error message.)


The equivalent functionality is obtainable by simply placing the movers from the APPLY_TO_POSE section into the PROTOCOLS section, at the start. For example, if you have the following XML:

```
    ...
    <APPLY_TO_POSE>
        <SetupHotspotConstraints stubfile="all_native_stubs.pdb" cb_force="0.5"/>
        <profile weight="0.2" file_name="input.sequence_profile"/>
    </APPLY_TO_POSE>
    <PROTOCOLS>
        ... 
        <Add mover_name="dock" />
        ...
    </PROTOCOLS>
    ...
```

You can transform it like so (note the move of the APPLY_TO_POSE subtags to a MOVERS section, and the addition of the `name` attribute to each.):

```
    ...
    <MOVERS>
        <SetupHotspotConstraints name="setup_hotspots" stubfile="all_native_stubs.pdb" cb_force="0.5"/>
        <profile name="setup_profile" weight="0.2" file_name="input.sequence_profile"/>
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="setup_hotspots" />
        <Add mover_name="setup_profile" />
        ... 
        <Add mover_name="dock" />
        ...
    </PROTOCOLS>
    ...
```

Note that if you're combining this transformation with that of the "Input pose as a reference pose." section above, the addition of the SavePoseMover should (likely) come after the movers of the APPLY_TO_POSE section, though depending on the particular layout of the XML, it may be that a different order may be more appropriate.
