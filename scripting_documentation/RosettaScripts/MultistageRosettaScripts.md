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

  <OUTPUT />

</ROSETTASCRIPTS>
```

Running `multistep_protocol.default.linuxgccrelease -convert -parser:protocol test.xml -job_definition_file msrs.xml`
(make sure `-convert` is the first argument) will create the following in `msrs.xml`:

```
<TODO/>
```


###(Incomplete) Skeleton:
```
<JobDefinitionFile>
    <ROSETTASCRIPTS>
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
    </ROSETTASCRIPTS>
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