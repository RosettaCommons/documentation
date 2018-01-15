#MultistageRosettaScripts

##Overview


##XML Format

###Conversion

This part might be overwhelming, so let's start by mentioning that there is a way to convert a traditional rosetta script to a multistage rosetta script.

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


##See Also

* [Introductory RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scripting_with_rosettascripts/scripting_with_rosettascripts)
* [Advanced RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_scripting_with_rosettascripts/advanced_scripting_with_rosettascripts)
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Getting Started]]: A page for people new to Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications

<!-- SEO
scriptvars
-->