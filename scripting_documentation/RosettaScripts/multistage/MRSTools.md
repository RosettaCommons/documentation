#MultistageRosettaScripts

#Tools and Utilities

Back To [[Multistage Rosetta Scripts|MultistageRosettaScripts]]

[[_TOC_]]

##Script Converter

You can convert a traditional rosetta script to a multistage rosetta script XML format using the following command.
The converted script will be printed to the console if the `-job_definition_file` option is not provided.
[[See here|XML#conversion]] for more information and an example.

```
multistage_rosetta_scripts.default.linuxgccrelease -convert -parser:protocol existing_script.xml -job_definition_file new_script.xml
```

####Reverse Converter

You can also convert a multistage rosetta script to a traditional rosetta script by using
`-revert` or `-reverse_convert` (both do the same thing).
Rosetta will load in the multistage rosetta script using the `-job_definition_file` option
and will print the conversion to the console or to the filename defined by `parser:protocol`
if that option is provided.
Rosetta will only move the data elements from `<Common/>` to the new script.

##Estimate Memory

(WARNING: This is experimental and currently tends to underestimate by a factor of roughly 2x)

It can be difficult to know how many archive nodes you need to ask for ahead of time.
In order to help, you can run the following command and it will predict the total
amount of RAM needed to be devoted to archive nodes. 
You can divide this total by the amount of RAM per CPU
in your system to calculate the number of archive nodes you should ask for.

Alternatively, you can run with the [[archive on disk|RunningMRS]] option.

##Unarchive

If you use the [[archive on disk|RunningMRS#archive_on_disk]] option,
you can use this feature to convert archive files to pdb files
if you want to take a look at a few results while the job is still running.


Say you are storing your results in a directory called `archives`
and for whatever reason you feel like looking at `result_400_1`
(the result naming convention might change by the time you read this).
You can run the following command and the file `archives/result_400_1.pdb` will be created

```
multistage_rosetta_scripts.default.linuxgccrelease -mrs:unarchive archives/result_400_1
```

##XML Template

`-mrs:xml_template` prints an XML template skeleton to console or to a file if the `-job_definition_file` flag is provided.

```
$> multistage_rosetta_scripts.default.linuxgccrelease -mrs:xml_template

<JobDefinitionFile>

    <Job>
        <Input>
            <PDB filename="TODO"/>
        </Input>
    </Job>
    <Common>

        <SCOREFXNS/>

        <RESIDUE_SELECTORS/>

        <TASKOPERATIONS/>

        <FILTERS/>

        <MOVERS/>

        <PROTOCOLS>
            <Stage num_runs_per_input_struct="TODO" total_num_results_to_keep="TODO">

                <Sort filter="TODO"/>

            </Stage>
        </PROTOCOLS>

    </Common>

</JobDefinitionFile>
```

##Mover/Filter/Residue Selector/Task Operation Info

As with traditional rosetta scripts, you can pass the `-info` flag
followed by a mover, filter, task operation, or residue selector name and Rosetta will
print the XML schema for that element to console.

For example, running:

```
multistage_rosetta_scripts.default.linuxgccrelease -info Idealize
```

gives

```
INFORMATION ABOUT MOVER "Idealize":

DESCRIPTION:

Idealizes the bond lengths and angles of a pose. It then minimizes the pose in a stripped-down energy function in the presence of coordinate constraints

USAGE:

<Idealize atom_pair_constraint_weight=(real,"0.0") coordinate_constraint_weight=(real,"0.01") fast=(bool,"false") chainbreaks=(bool,"false") report_CA_rmsd=(bool,"true") ignore_residues_in_csts=(residue_number_cslist) impose_constraints=(bool,"true") constraints_only=(bool,"false") pos_list=(int_cslist) name=(string)>
</Idealize>

OPTIONS:

"Idealize" tag:

	   atom_pair_constraint_weight (real,"0.0"):  Weight for atom pair constraints

	   coordinate_constraint_weight (real,"0.01"):  Weight for coordinate constraints

	   fast (bool,"false"):  Don't minimize or calculate stats after each idealization

	   chainbreaks (bool,"false"):  Keep chainbreaks if they exist

	   report_CA_rmsd (bool,"true"):  Report CA RMSD?

	   ignore_residues_in_csts (residue_number_cslist):  Ignore these residues when applying constraints

	   impose_constraints (bool,"true"):  Impose constraints on the pose?

	   constraints_only (bool,"false"):  Only impose constraints and don't idealize

	   pos_list (int_cslist):  List of positions to idealize

	   name (string):  The name given to this instance.

```

##See Also

* [[Multistage Rosetta Scripts|MultistageRosettaScripts]]
* [Introductory RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scripting_with_rosettascripts/scripting_with_rosettascripts)
* [Advanced RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_scripting_with_rosettascripts/advanced_scripting_with_rosettascripts)
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Getting Started]]: A page for people new to Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
