#MRS: Tools and Utilities

[[Multistage Rosetta Scripts|MultistageRosettaScripts]]

[[_TOC_]]

##Script Converter

##Estimate Memory

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

Prints an XML template skeleton to console or to a file if the `-job_definition_file` flag is provided.

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

##Info

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
