#MultistageRosettaScripts

##Overview


##XML Format

This part might be overwhelming, so let's start by mentioning that there is a way to convert a traditional rosetta script to a multistage rosetta script.
Because of this, you will rarely have to write a multistage script from scratch.

###Conversion

Say we have the following rosetta script saved as `test.xml`:
```
<ROSETTASCRIPTS>

  <SCOREFXNS>
    <ScoreFunciton name="sfxn"/>
  </SCOREFXNS>

  <RESIDUE_SELECTORS>
    <Something name="res_selector"/>
  </RESIDUE_SELECTORS>

  <TASKOPERATIONS>
    <ReadResfile name="read_resfile"/>
  </TASKOPERATIONS>

  <FILTERS>
    <SomeFilter name="hi" selector="res_selector"/>
  </FILTERS>

  <MOVERS>
    <FastRelax name="fr" score_function="sfxn" task_operations="read_resfile"/>
  </MOVERS>

  <PROTOCOLS>
    <Add mover="fr"/>
    <Add filter="hi"/>
  </PROTOCOLS>

</ROSETTASCRIPTS>
```

Running ```multistage_rosetta_scripts.default.linuxgccrelease -convert -parser:protocol test.xml -job_definition_file msrs.xml```
(make sure `-convert` is the first argument) will create the following in `msrs.xml`:


```
<JobDefinitionFile>
    <Common>

        <SCOREFXNS>
            <ScoreFunciton name="sfxn"/>
        </SCOREFXNS>

        <RESIDUE_SELECTORS>
            <Something name="res_selector"/>
        </RESIDUE_SELECTORS>

        <TASKOPERATIONS>
            <ReadResfile name="read_resfile"/>
        </TASKOPERATIONS>

        <FILTERS>
            <SomeFilter name="hi" selector="res_selector"/>
        </FILTERS>

        <MOVERS>
            <FastRelax name="fr" score_function="sfxn" task_operations="read_resfile"/>
        </MOVERS>

        <PROTOCOLS>
            <Stage num_runs_per_input_struct="TODO" total_num_results_to_keep="TODO">

                <Add mover="fr"/>
                <Add filter="hi"/>
                <Sort filter="TODO"/>

            </Stage>
        </PROTOCOLS>

    </Common>

    <Job>
        <Input>
            <PDB filename="TODO"/>
        </Input>
    </Job>

</JobDefinitionFile>
```

Notice that the converter placed TODO's wherever the user still needs to make a decision.
You can replace these TODO's using a text editor, but some of them can be filled in automatically if you give the converter enough information.
For example, running
```multistage_rosetta_scripts.default.linuxgccrelease -convert -parser:protocol test.xml -nstruct 50 -s 3U3B_A.pdb 3U3B_B.pdb -job_definition_file msrs.xml```
creates the following.
Now `num_runs_per_input_struct` is replaced by the command line value for `-nstruct` and a `<Job/>` tag is created for every structure denoted with the `-s` and `-l` flags.
The converter is not currently smart enough to figure out if the input files are PDB files, so it places a TODO comment for you to replace the input format if necessary (see [[JD3 Options|JD3]]).

```
<JobDefinitionFile>
    <Common>

        <SCOREFXNS>
            <ScoreFunciton name="sfxn"/>
        </SCOREFXNS>

        <RESIDUE_SELECTORS>
            <Something name="res_selector"/>
        </RESIDUE_SELECTORS>

        <TASKOPERATIONS>
            <ReadResfile name="read_resfile"/>
        </TASKOPERATIONS>

        <FILTERS>
            <SomeFilter name="hi" selector="res_selector"/>
        </FILTERS>

        <MOVERS>
            <FastRelax name="fr" score_function="sfxn" task_operations="read_resfile"/>
        </MOVERS>

        <PROTOCOLS>
            <Stage num_runs_per_input_struct="50" total_num_results_to_keep="TODO">

                <Add mover="fr"/>
                <Add filter="hi"/>
                <Sort filter="TODO"/>

            </Stage>
        </PROTOCOLS>

    </Common>

    <Job>
        <Input>
            TODO: The script converter is not smart enough to know if this file is actually a pdb file. Please correct this tag if necessary!
            <PDB filename="3U3B_A.pdb"/>
        </Input>
    </Job>

    <Job>
        <Input>
            TODO: The script converter is not smart enough to know if this file is actually a pdb file. Please correct this tag if necessary!
            <PDB filename="3U3B_B.pdb"/>
        </Input>
    </Job>

</JobDefinitionFile>
```

###(Incomplete) Skeleton:

If you really want to write a script from scratch, here is a skeleton.

```
<JobDefinitionFile>
    <Common>
        <SCOREFXNS>
        </SCOREFXNS>
        <RESIDUE_SELECTORS>
        </RESIDUE_SELECTORS>
        <TASKOPERATIONS>
        </TASKOPERATIONS>
        <FILTERS>
        </FILTERS>
        <MOVERS>
        </MOVERS>
        <PROTOCOLS>
            <Stage>
                <Add/>
                <Sort/>
            </Stage>
        </PROTOCOLS>
    </Common>
    <Job>
        <SCOREFXNS>
        </SCOREFXNS>
        <RESIDUE_SELECTORS>
        </RESIDUE_SELECTORS>
        <TASKOPERATIONS>
        </TASKOPERATIONS>
        <FILTERS>
        </FILTERS>
        <MOVERS>
        </MOVERS>
        <Input>
        </Input>
        <Output>
        </Output>
    </Job>
</JobDefinitionFile>
```

##Features and Tricks

##See Also

* [Introductory RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scripting_with_rosettascripts/scripting_with_rosettascripts)
* [Advanced RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_scripting_with_rosettascripts/advanced_scripting_with_rosettascripts)
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Getting Started]]: A page for people new to Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications

<!-- SEO
scriptvars
-->