#RosettaScripts

**RosettaScripts: A Scripting Language Interface to the Rosetta Macromolecular Modeling Suite** 
Fleishman SJ, Leaver-Fay A, Corn JE, Strauch EM, Khare SD, et al. (2011) RosettaScripts: A Scripting Language Interface to the Rosetta Macromolecular Modeling Suite. PLOS ONE 6(6): e20161. [[https://doi.org/10.1371/journal.pone.0020161]]

===

-   [[Using RosettaScripts with VSCode|Using-RosettaScripts-with-VSCode]]
-   [Introductory Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scripting_with_rosettascripts/scripting_with_rosettascripts)
-   [Advanced Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_scripting_with_rosettascripts/advanced_scripting_with_rosettascripts)

---------------------

-   [[Movers (RosettaScripts)|Movers-RosettaScripts]]
-   [[Filters|Filters-RosettaScripts]]
-   [[TaskOperations (RosettaScripts)|TaskOperations-RosettaScripts]]
-   [[MoveMapFactories (RosettaScripts)|MoveMapFactories-RosettaScripts]]
-   [[ResidueSelectors (RosettaScripts)|ResidueSelectors]]
-   [[JumpSelectors |JumpSelectors]]
-   [[PackerPalettes|PackerPalette]]
-   [[SimpleMetrics]]

---------------------

-   [[Composite protocols with RosettaScripts interfaces|Composite-protocols]]
-   [[Multistage Rosetta Scripts|MultistageRosettaScripts]]
-   [[SymmetryAndRosettaScripts]]
-   [[RosettaScripts Formatting Conventions|RosettaScripts-Conventions]]
-   [[RosettaScripts database connection options|RosettaScripts-database-connection-options]]
-   [[Overview of the Features Reporter framework|Features-reporter-overview]]
-   [[RosettaScripts Developer Guide|RosettaScripts-Developer-Guide]]


This page documents the RosettaScripts syntax and common methods by which you can use RosettaScripts to combine Rosetta movers.

[[_TOC_]]

<!--- BEGIN_INTERNAL -->
##Locations for RosettaScripts XML Files

It is **strongly recommended** that all Rosetta developers version control their RosettaScripts. Private scripts should be placed in `main/source/scripts/rosetta_scripts/pilot/<user_name>`. Public scripts should go in `main/source/scripts/rosetta_scripts/public/`. Any public scripts should also have accompanying integration tests. 


<!--- END_INTERNAL -->
"Skeleton" XML format
---------------------

Copy, paste, fill in, and enjoy
```xml
<ROSETTASCRIPTS>
    <SCOREFXNS>
    </SCOREFXNS>
    <RESIDUE_SELECTORS>
    </RESIDUE_SELECTORS>
    <TASKOPERATIONS>
    </TASKOPERATIONS>
    <SIMPLE_METRICS>
    </SIMPLE_METRICS>
    <FILTERS>
    </FILTERS>
    <MOVERS>
    </MOVERS>
    <PROTOCOLS>
    </PROTOCOLS>
    <OUTPUT />
</ROSETTASCRIPTS>
```
Anything outside of the \< \> notation is ignored and can be used to comment the xml file

<b>Handy tip:</b> To get the empty template script above, you can run the rosetta_scripts application and omit the ```-parser:protocol``` flag.  If this flag is omitted (<i>i.e.</i> no input script is provided), then the application prints the template script and exits.  This is very useful when one is sitting down to write a new script.

General Description and Purpose
-------------------------------

RosettaScripts is meant to provide an xml-scriptable interface for conducting all of the tasks that interface design developers produce. With such a scriptable interface, it is hoped, it will be possible for non-programmers to 'mix-and-match' different design strategies and apply them to their own needs. It is also hoped that through a common interface, code-sharing between different people will be smoother. Note that at this point, the only movers and filters that are implemented in this application are the ones described below. More will be made available in future releases. At this point these include protocols from the protein-interface design, protein docking, enzyme-design, ligand-docking and -design, monomer design, and DNA-interface design groups. General movers for loop modeling and structure relaxation are also available.

A paper describing RosettaScripts is available at: Fleishman et al. (2011) PLoS 1 6:e20161
(http://www.plosone.org/article/fetchObject.action?uri=info%3Adoi%2F10.1371%2Fjournal.pone.0020161&representation=PDF)

At the most abstract level, all of the computations that are needed in interface design fall into two categories: Movers and Filters. Movers change the conformation of the complex by acting on it, e.g., docking/design/minimization, and filters decide whether a given conformation should go on to the subsequent steps. Filters are meant to reduce the amount of computation that is conducted on conformations that show no promise. Then, a RosettaScript is merely a sequence of movers and filters.

The implementation for this behaviour is done by the following components:

-   **ParsedProtocol** , **Filter** , and **Mover**
ParsedProtocol maintains a vector of pairs of movers and their associated filters. By using the TrueFilter or the NullMover, filters and movers can be essentially decoupled by any protocol. The setup of having pairs of movers and filters is used simply because in most contexts filters will be conceptually associated with a mover and vice versa.
-   **DockDesignParser.cc** This function parses an xml file and populates DockDesignMover with pairs of Movers and Filters. All of the movers and filters that are supported should also be defined in this function.

Check out an [introductory tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scripting_with_rosettascripts/scripting_with_rosettascripts) and an [advanced tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_scripting_with_rosettascripts/advanced_scripting_with_rosettascripts) on RosettaScripts.


Example XML file
----------------

The following modern example uses :`in:file:native`, and minimizes a CDR loop of a protein, calculating various metrics before and after minimization.
The metrics will all be output to the scorefile with the given prefix/suffix and the names of each metric.

```xml
<ROSETTASCRIPTS>
	<SCOREFXNS>
	</SCOREFXNS>
	<RESIDUE_SELECTORS>
		<CDR name="L1" cdrs="L1"/>
	</RESIDUE_SELECTORS>
	<MOVE_MAP_FACTORIES>
		<MoveMapFactory name="movemap_L1" bb="0" chi="0">
			<Backbone residue_selector="L1" />
			<Chi residue_selector="L1" />
		</MoveMapFactory>
	</MOVE_MAP_FACTORIES>
	<SIMPLE_METRICS>
		<TimingProfileMetric name="timing" />
		<RMSDMetric name="rmsd" rmsd_type="rmsd_protein_bb_heavy" residue_selector="L1" use_native="1"/>
		<SelectedResiduesMetric name="rosetta_sele" residue_selector="L1" rosetta_numbering="1"/>
		<SelectedResiduesPyMOLMetric name="pymol_selection" residue_selector="L1" />
		<SequenceMetric name="sequence" residue_selector="L1" />
		<SecondaryStructureMetric name="ss" residue_selector="L1" />
	</SIMPLE_METRICS>
	<MOVERS>
		<MinMover name="min_mover" movemap_factory="movemap_L1" tolerance=".1" /> 
		<RunSimpleMetrics name="run_metrics1" metrics="pymol_selection,sequence,ss,rosetta_sele" prefix="m1_" />
		<RunSimpleMetrics name="run_metrics2" metrics="rmsd,timing,ss" prefix="m2_" />
	</MOVERS>
	<PROTOCOLS>
		<Add mover_name="run_metrics1"/>
		<Add mover_name="min_mover" />
		<Add mover_name="run_metrics2" />
	</PROTOCOLS>
</ROSETTASCRIPTS>
```

Rosetta will carry out the order of operations specified in PROTOCOLS.  An important point is that SimpleMetrics and Filters never change the sequence or conformation of the structure.

The movers do change the pose, and the output file will be the result of sequentially applying the movers in the protocols section. The standard scores of the output will be carried over from any protocol doing scoring, unless the OUTPUT tag is specified, in which case the corresponding score function from the SCOREFXNS block will be used.  You may use the name "commandline" as a score function in the OUPUT tag.  Note that this means if your pose is not scored during the protocol, your output will not have scoring information in it!

Additional example xml scripts, including examples for docking, protein interface design, and prepacking a protein complex, amongst others, can be found in the Rosetta/demos/public/rosetta\_scripts/ directory. 

Example commandline
-------------------

The following command line would run the above protocol, given that the protocol file name is ala\_scan.xml

```
Rosetta/main/source/bin/rosetta_scripts.linuxgccrelease -s < INPUT PDB FILE NAME > -use_input_sc -nstruct 20 -ex1 -ex2 -parser:protocol ala_scan.xml -parser:view
```
Note that, for most command-line options to be actually considered by RosettaScripts, you need to use the <InitializeFromCommandLine> taskoperation.

The parser:view flag may be used with rosetta executables that have been compiled using the extras=graphics switch in the following way (from the Rosetta root directory):

```
scons mode=release -j3 bin extras=graphics
```

When running with -parser:view a graphical viewer will open that shows many of the steps in a trajectory. This is extremely useful for making sure that sampling is following the intended trajecotry.

Input and Output Files
----------------------

Running a typical protocol requires input of an xml file and a starting pdb file, as in the example commandline above. Alternatively, to run the protocol on many structures, save a simple list of the pdb files to be used and replace the flag -s \<INPUT PDB FILE NAME\> in the commandline with -l \<INPUT LIST FILE NAME\>. Some movers and filters require specific input files (for example, a pdb file containing stub residues for hot-spot residue placement for PlaceStub or PlaceSimultaneously movers), and in such cases the required input file/s are described below and are generally called via the xml script.

During a run, if any defined filters are not satisfied then the trajectory will be killed and no output files returned, and Rosetta will continue on to the next ntrial (or if all ntrials have been attempted and failed, Rosetta will continue with any remaining nstructs as defined in the commandline). For a successful run in which all filters are satisfied, the output will include a pdb file and a score.sc file. The output pdb name is identical to the input pdb file name with a suffix denoting the nstruct number.

The score.sc file tabulates the energy terms and filter values for every successful nstruct. The pdb file ends with an energy table for all residues and lists the values of any filters in the same order they are used in the xml protocol. By default, the scorefunction used in the score file and the PDB energy table is "commandline" (the score function specified by commandline options). To change this to a different scorefunction, see the [OUTPUT tag](#OUTPUT) .

Using an IntelliSense editor to help with generating RosettaScripts
-------------------------------------------------------------------

An xml-schema was generated for us by Avner Aharoni (Microsoft) using Visual Studio. Using this schema in a compatible editor provides a specific editor for writing RosettaScripts, complete with word completion, grammatical error warnings and help with options. We are currently aware of two editors that are fully compatible with this schema

### Editing RosettaScripts in emacs

The nXML emacs add-on is compatible with the RosettaScripts.rnc schema (found in src/apps/public/rosetta\_scripts/RosettaScripts.rnc).

1.  Download nXML from [http://www.thaiopensource.com/nxml-mode/](http://www.thaiopensource.com/nxml-mode/)
2.  Read the nXML portion of the emacsWiki at [http://www.emacswiki.org/cgi-bin/wiki/NxmlMode](http://www.emacswiki.org/cgi-bin/wiki/NxmlMode)
3.  Load the RosettaScripts.rnc file into emacs+nXML
4.  Load your protocol
5.  Have fun!

### Editing RosettaScripts in VisualStudio

MS-Windows users can download Visual Studio Express (free of charge) which provides an xml editor that is compatible with the RosettaScripts.xsd schema (found in src/apps/public/rosetta\_scripts/RosettaScripts.xsd). The following instructions were provided by Avner Aharoni:

1.  Download VB express from [http://www.microsoft.com/express/download/](http://www.microsoft.com/express/download/)
2.  Save the schema in the following folder C:\\Program Files\\Microsoft Visual Studio 9.0\\Xml\\Schemas
3.  Create empty xml file on disk (a file with the .xml suffix)
4.  Open it in the Visual Studio Express, go to its properties (view =-\> property window F4) and set the RosettaScripts.xsd schema for use.

RosettaScripts Conventions
--------------------------

### General Comments

This file lists the Movers, Filters, their defaults, meanings and uses as recognized by RosettaScripts. It is written in an xml format and using many free viewers (e.g., vi) will highlight key xml notations, so long as the file has extension .xml

Whenever an xml statement is shown, the following convention will be used:

<...> to define a branch statement (a statement that has more leaves)
<.../> a leaf statement.
"" defines input expected from the user with ampersand (&) defining the type that is expected (string, float, etc.)
() defines the default value that the parser will use if that is not provided by the protocol.

### Specifying Residues

There are two residue numbering conventions that are used in Rosetta - "pose numbering" and "pdb numbering". Pose numbering assigns a value of 1 to the first residue of the first chain, and then sequentially numbers from there, ignoring the start of new chains and missing residues. Pdb numbering uses the chain/residue/insertion code designation that is present in the input pdb file. Generally, whenever a residue identifier is given with a chain, it's PDB numbered, and without a chain is the pose number.

For example, if you have a PDB file which has two chains, with residues 12-62 for chain A and residues 5-20 and 32 to 70 for chain B, the pose number for pdb residue 12 of chain A would be 1, and pdb residue 62 of chain A would be pose numbered 51. Pdb chain B residue 5 would be pose numbered 52, and chain B residue 32 would be pose number 68.

In many of the RosettaScripts tags that take a residue identifier, there is a joint option to specify it in either pose numbering or PDB numbering, notated as something like res\_num/pdb\_num. For tags which have this option, you can specify *either* res\_num= or pdb\_num=, but not both. The res\_num option takes a pose numbered residue designation, and the pdb\_num option takes a pdb numberd designation in the form of "42.A" or "42A" where A specifies the chain and 42 is the pdb residue number. At this time it is not possible to specify an insertion code with the pdb\_num option.

Care must be exercised when using PDB numbering with protocols that change the length of the pose. Insertion of residues can invalidate the PDB information associated with the pose, resulting in errors when the pdb numbering is decoded. Additionally, some RosettaScripts objects will convert the pdb number to a pose number based on the input structure numbering, resulting in potential mis-alignment if residues are added/deleted.

### Getting Help

Although this documentation is intended to be the primary users' manual for RosettaScripts, there is also in-application help available.  To get an empty template script, simply run the rosetta_scripts application with no input flags.  For example:

```
> ./bin/rosetta_scripts.default.linuxgccrelease
```

This produces the following output:

```
core.init: USEFUL TIP: Type -help to get the options for this Rosetta executable.
apps.public.rosetta_scripts.rosetta_scripts: No XML file was specified with the "-parser:protocol <filename>" commandline option.  In order for RosettaScripts to do something, it must be provided with a script.
apps.public.rosetta_scripts.rosetta_scripts: The following is an empty (template) RosettaScripts XML file:

<ROSETTASCRIPTS>
	<SCOREFXNS>
	</SCOREFXNS>
	<RESIDUE_SELECTORS>
	</RESIDUE_SELECTORS>
	<TASKOPERATIONS>
	</TASKOPERATIONS>
	<SIMPLE_METRICS>
	</SIMPLE_METRICS>
	<FILTERS>
	</FILTERS>
	<MOVERS>
	</MOVERS>
	<PROTOCOLS>
	</PROTOCOLS>
	<OUTPUT />
</ROSETTASCRIPTS>

At any point in a script, you can include text from another file using <xi:include href="filename.xml" />.
apps.public.rosetta_scripts.rosetta_scripts: Variable substituion is possible from the commandline using the -"parser:script_vars varname=value" flag.  Any string of the pattern "%%varname%%" will be replaced with "value" in the script.
apps.public.rosetta_scripts.rosetta_scripts:
apps.public.rosetta_scripts.rosetta_scripts: The rosetta_scripts application will now exit.
```

You can also get help on the syntax of any mover, filter, task operation, or residue selector using the `-parser:info <name1> <name2> <name3> ...` flag.  For example, the following commandline will provide information on the [[MutateResidue|MutateResidueMover]] mover and the [[HbondsToAtom|HbondsToAtomFilter]] filter:

```
./bin/rosetta_scripts.default.linuxgccrelease -info MutateResidue HbondsToAtom
```

The output is as follows:

```
The rosetta_scripts application was used with the -parser:info flag.
Writing options for the indicated movers/filters/task operations/residue selectors:
--------------------------------------------------------------------------------
INFORMATION ABOUT MOVER "MutateResidue":

DESCRIPTION:

Change a single residue or a given subset of residues to a different type. For instance, mutate Arg31 to an Asp, or mutate all Prolines to Alanine

USAGE:

<MutateResidue target=(string) new_res=(string) mutate_self=(bool,"false") perserve_atom_coords=(bool,"false") update_polymer_bond_dependent=(bool) preserve_atom_coords=(bool) residue_selector=(string) name=(string)>
</MutateResidue>

OPTIONS:

"MutateResidue" tag:

	target (string):  The location to mutate. This can be a PDB number (e.g. 31A), a Rosetta index (e.g. 177), or an index in a reference pose or snapshot stored at a point in a protocol before residue numbering changed in some way (e.g. refpose(snapshot1,23)). See the convention on residue indices in the RosettaScripts Conventions documentation for details

	new_res (string):  The name of the residue to introduce. This string should correspond to the ResidueType::name() function (eg ASP).

	mutate_self (bool,"false"):  If true, will mutate the selected residue to itself, regardless of what new_res is set to (although new_res is still required). This is useful to "clean" residues when there are Rosetta residue incompatibilities (such as terminal residues) with movers and filters.

	perserve_atom_coords (bool,"false"):  If true, then atoms in the new residue that have names matching atoms in the old residue will be placed at the coordinates of the atoms in the old residue, with other atoms rebuilt based on ideal coordinates. If false, then only the mainchain heavyatoms are placed based on the old atom's mainchain heavyatoms; the sidechain is built from ideal coordinates, and sidechain torsion values are then set to the sidechain torsion values from the old residue. False if unspecified.

	update_polymer_bond_dependent (bool):  Update the coordinates of atoms that depend on polymer bonds

	preserve_atom_coords (bool):  Preserve atomic coords as much as possible

	residue_selector (string):  name of a residue selector that specifies the subset to be mutated

	name (string):  The name given to this instance

--------------------------------------------------------------------------------
INFORMATION ABOUT FILTER "HbondsToAtom":

DESCRIPTION:

This filter counts the number of residues that form sufficiently energetically favorable H-bonds to a selected atom

USAGE:

<HbondsToAtom partners=(int) energy_cutoff=(real,"-0.5") bb_bb=(bool,"0") backbone=(bool,"0") sidechain=(bool,"1") pdb_num=(refpose_enabled_residue_number) atomname=(string) res_num=(int) name=(string) confidence=(real,"1.0")>
</HbondsToAtom>

OPTIONS:

"HbondsToAtom" tag:

	partners (int):  H-bonding partner expectation, below which counts as failure

	energy_cutoff (real,"-0.5"):  Energy below which a H-bond counts

	bb_bb (bool,"0"):  Count backbone-backbone H-bonds

	backbone (bool,"0"):  Count backbone H-bonds

	sidechain (bool,"1"):  Count sidechain H-bonds

	pdb_num (refpose_enabled_residue_number):  Particular residue of interest

	atomname (string):  Atom name to which to examine H-bonds

	res_num (int):  Residue number in Rosetta numbering (sequentially with the first residue in the pose being 1

	name (string):  The name given to this instance

	confidence (real,"1.0"):  Probability that the pose will be filtered out if it does not pass this Filter

--------------------------------------------------------------------------------

The rosetta_scripts application will now exit.
```

Options Available in the XML Protocol File
------------------------------------------

### Variable Substitution

Occasionally it is desirable to run a series of different runs with slightly different parameters. Instead of creating a number of slightly different XML files, one can use script variables to do the job.

If the -parser:script\_vars option is set on the command line, every time a string like "%%variable\_name%%", is encountered in the XML file, it is replaced with the corresponding value from the command line.

For example, a line in the XML like
```xml
<AlaScan name="scan" partner1="1" partner2="1" scorefxn="interface" interface_distance_cutoff="%%cutoff%%" repeats="%%repeat%%"/>
```
can be turned into
```xml
<AlaScan name="scan" partner1="1" partner2="1" scorefxn="interface" interface_distance_cutoff="10.0" repeats="5"/>
```
with the command line option
```
-parser:script_vars repeat=5 cutoff=10.0
```

These values can be changed at will for different runs, for example:
```
-parser:script_vars repeat=5 cutoff=15.0
-parser:script_vars repeat=2 cutoff=10.0
-parser:script_vars repeat=1 cutoff=9.0
```

Multiple instances of the "%%var%%" string will all be substituted, as well as in any [[subroutine|Movers-RosettaScripts#Subroutine]] XML files. Note that while currently script\_vars are implemented as pure macro text substitution, this may change in the future, and any use aside from substituting tag values may not work. Particularly, any use of script variables to change the parsing structure of the XML file itself is explicitly \*not\* supported, and you have a devious mind for even considering it.

### XML File Inclusion

It can be convenient to put commonly-used pieces of XML scripts in their own files, and to direct a script to load some XML code from a preexisting file so that the user does not need to copy and paste pieces of XML code manually.  The XML ```xi:include``` command may be used for this purpose, with the file to be included specified using "href=filename".

```xml
<xi:include href="(&filename_string)" />
```

The ```xi:include``` block is naïvely replaced with the contents of the file specified with "href=filename".  The following is an example of the use of ```xi:include```, in which we suppose that the user frequently uses the AlaScan and Ddg filters and wishes to put their setup in a separate file that he/she can include any time he/she writes a new RosettaScripts XML file:

<b>file1.xml</b>:
```xml
<ROSETTASCRIPTS>
  <SCOREFXNS>
    <ScoreFunction name="interface" weights="interface"/>
  </SCOREFXNS>
  <FILTERS>
    <xi:include href="file2.xml"/>
    <Sasa name="sasa" confidence="0"/>
  </FILTERS>
  <MOVERS>
    <Docking name="dock" fullatom="1" local_refine="1" score_high="soft_rep"/>
  </MOVERS>
  <PROTOCOLS>
    <Add mover_name="dock" filter_name="scan"/>
    <Add filter_name="ddg"/>
    <Add filter_name="sasa"/>
  </PROTOCOLS>
  <OUTPUT scorefxn="interface"/>
</ROSETTASCRIPTS>
```

<b>file2.xml</b>:
```xml
    <AlaScan name="scan" partner1="1" partner2="1" scorefxn="interface" interface_distance_cutoff="10.0" repeats="5"/>
    <Ddg name="ddg" confidence="0"/>
```

Note that file inclusion occurs recursively, so that included files may include other files.  Circular dependencies (<i>e.g.</i> file1.xml includes file2.xml includes file3.xml includes file1.xml) are prohibited, and will result in an error.  Multiple inclusions of the same file are permitted, however (though this would rarely be advisable). There is a limit to the number of files that can be included in this way. The recursion limit is 8 and the value can be changed by using the `-parser:inclusion_recursion_limit` command line option. In some cases you may wish to prevent the recursive search (e.g. if the file being included is very large), and an optional parameter "prevent_recursion" can be used in the inclusion tag to achieve this as follows:

```xml
<xi:include href="(&filename_string)" prevent_recursion="True"/>
```

Variable substitution occurs after file inclusion, which means that ```%%variable%%``` statements may occur in included files; however, this also means that ```xi:include``` blocks cannot contain ```%%variable%%``` statements. 

## Predefined RosettaScripts Objects

For convenience, certain RosettaScripts objects are can be used without making a definition tag for them.

### Predefined Movers

The following are defined internally in the parser, and the protocol can use them without defining them explicitly.

#### NullMover

Has an empty apply. Will be used as the default mover in \<PROTOCOLS\> if no mover\_name is specified. Can be explicitly specified, with the name "null".

### Predefined Filters

#### TrueFilter

Always returns true. Useful for defining a mover without using a filter. Can be explicitly specified with the name "true\_filter".

#### FalseFilter

Always returns false. Can be explicitly specified with the name "false\_filter".

### Predefined Scorefunctions

-   talaris2014: The default all-atom scorefunction used by Rosetta structure prediction and design
-   talaris2013: The previous version of talaris2014
-   score12: The default scorefunction prior to talaris2013 (Requires -restore_pre_talaris_2013_behavior option on the command line.)
-   score\_docking: high resolution docking scorefxn (pre_talaris_2013_standard+docking\_patch)
-   score\_docking\_low: low resolution docking scorefxn (interchain\_cen)
-   soft\_rep: soft\_rep\_design weights.
-   score4L: low resolution scorefunction used for loop remodeling (chainbreak weight on)
-   commandline: the scorefunction specified by the commandline options (Note: not recommended for general use.)

#RosettaScript Sections

##PROTOCOLS

The PROTOCOLS section is the "main" section of the XML which actually specifies how the protocol will be run. Internally, it's implemented with the [[ParsedProtocolMover]], so more details of the subtag syntax can be found there.

Generally, the PROTOCOLS section will be a series of `<Add ../>` tags. Each tag will specify a mover, filter and/or simple metric to apply. The RosettaScript protocol steps through each subtag in order, applying each entry.

Typical parameters for each Add tag:

-  `mover` or `mover_name` -- Specify a [[mover|Movers-RosettaScripts]] (defined previously in the MOVERS section) to apply at this stage of the protocol. The current pose (structure) being simulated will be modified by that mover and become the input structure to the next mover/filter/metric/etc. in the list.
-  `filter` or `filter_name` -- Specify a [[filter|Filters-RosettaScripts]] (defined previously in the FILTERS section) to applied to the pose being simulated. Filters will not modify the pose, but will produce a pass/fail result. If the pose passes, it moves on to the next step. If the pose fails, the current simulation will be discarded, and the simulation will be restarted from the top of the PROTOCOLS section. Most filters will also calculate an associated value, and filters specified in the PROTOCOLS section will report that value to the scorefile (under the name of the filter). NOTE: By default the score thus reported is recalculated for the structure being output. You can change this to be for the evaluation mid-protocol by setting the option `report_at_end="false"` in the Add tag for that filer. (Though for reporting purposes, the metrics option is preferred.)
-  `metrics` -- (Post 15-Oct-2020 releases) Specify a comma-separated list of [[SimpleMetrics]] to calculate at this stage of the protocol and add to the scorefile. By default, the metrics will be added to the scorefile under the name of the metric, as specified in the `metrics` option. You can change this with the `labels` option, which takes a comma-separated list of names. The label `-` is special cased to give you the same name as you would have typically gotten withthe RunSimpleMetrics mover. (The [[RunSimpleMetrics]] mover provides more options in running SimpleMetrics.)

##SCOREFUNCTIONS

The SCOREFXNS section defines scorefunctions that will be used in Filters and Movers. This can be used to define any of the scores defined in the path/to/rosetta/main/database

```xml
<ScoreFunction name="scorefxn_name" weights="("empty" &string)" patch="(&string)">
  <Reweight scoretype="(&string)" weight="(&Real)"/>
  <Set (option name)="(value)"/>
</ScoreFunction>
```

where the ```name``` attribute will be used in the Movers and Filters sections to use the scorefunction. The name should therefore be unique and not repeat the predefined score names. One or more Reweight tag is optional and allows you to change/add the weight for a given scoretype.  For example:

```xml
<ScoreFunction name="scorefxn1" weights="fldsgn_cen">
  <Reweight scoretype="env" weight="1.0"/>
</ScoreFunction>
```

The Set tag is optional and allows you to change certain scorefunction options, as discussed in the next section.

### Scorefunction Options

One or more option can be specified per Set tag:

-   aa\_composition\_setup\_file=(&string &string &string...) - One or more setup files for the aa_composition score term defining the desired amino acid composition.  (For more about this score term, see [[the aa_composition score term documentation|AACompositionEnergy]]).
-   decompose\_bb\_hb\_into\_pair\_energies=(&bool) - Store backbone hydrogen bonds in the energy graph on a per-residue basis (this doubles the number of calculations, so is off by default)
-   exclude\_protein\_protein\_fa\_elec=(&bool) - If true, disables fa_elec calculations between protein atoms.  (Equivalent to the -ligand::old\_estat command line option for ligand\_dock/enzyme\_design.)
-   exclude\_DNA\_DNA=(&bool)
-   fa\_elec\_min\_dist=(&Real), fa\_elec\_max\_dist=(&Real) - Minimum and maximum distances for the fa_elec Coulomb potential.
-   fa\_elec\_dielectric=(&Real) - Dielectric constant for the fa_elec score term.
-   fa\_elec\_no\_dis\_dep\_die=(&bool) - If true, disables the distance dependence of the dielectric constant for the fa_elec score term.
-   pb\_bound\_tag=(&string)
-   pb\_unbound\_tag=(&string)
-   scale\_sc\_dens=(&Real) - Rescale electron density weighting for side-chains.
-   scale\_sc\_dens\_byres=(&string) - Rescale electron density weighting for side-chains on a per-residue basis.  There is syntax for this, but whoever implemented it didn't bother to document it, so it's pretty useless.
-   smooth\_hb\_env\_dep=(&bool)
-   softrep\_etable=(&bool) - Use softer repulsion for the Lennard-Jones potential.  (Spongier atoms -- useful for packing early in a design trajectory, for example.)
-   use\_hb\_env\_dep\_DNA=(&bool)
-   use\_hb\_env\_dep=(&bool)

### Global Scorefunction modifiers

The apply\_to\_pose section may set up constraints, in which case it becomes necessary to set the weights in all of the scorefunctions that are defined. The default weights for all the scorefunctions are defined globally in the apply\_to\_pose section, but each scorefunction definition may change this weight. For example, to set the HotspotConstraint (backbone\_stub\_constraint) value to 6.0

```xml
<ScoreFunction name="my_spiffy_score" weights="soft_rep_design" patch="dock" hs_hash="6.0"/>
```

The following modifiers are recognized:

#### HotspotConstraints modifications

```
hs_hash="(the value set by apply_to_pose for hotspot_hash &float)"
```

### Symmetric Scorefunctions

Previously, to properly score symmetric poses, they needed to be scored with a symmetric score function, as shown below.  As of November 2018, scorefunctions became "symmetry agnostic," meaning that the same scorefunction can be used with symmetric or asymmetric poses.  The ```symmetric=1``` tag no longer has any effect.

Previously, to declare a scorefunction symmetric, simply add the tag:

```
symmetric="1"
```

For example, symmetric score12:

```xml
<ScoreFunction name="score12_symm" weights="score12_full" symmetric="1"/>
```

> **segmentation fault**
>
> If you run into a segfault, you might need to add a \<OUTPUT\> section with a symmetric scorefunction.

```
    ...
    </PROTOCOLS>
    <OUTPUT scorefxn="my_sym_scorefxn"/>
</ROSETTASCRIPTS>
```
### Design-centric guidance scoreterms

Certain specialized scoreterms exist that can be appended to the default energy function to guide design.  These can be useful to impose prior information (e.g. lots of prolines help to stabilize loop conformations; too many alanines in a core hinder folding), to add features desired for function (e.g. I want my protein to have a net negative charge but my binding interface to have a net positive charge), or to add features needed for protein production (I want to avoid too many methionines since extra AUG sequences result in alternative start sites, hindering expression) or experimental characterization (e.g. I want exactly one tryptophan in the core for fluorescence experimeents).  For more information about these scoreterms, see the page on [[design-centric guidance scoreterms|design-guidance-terms]].

### A utility scoreterm for trajectory visualization

When debugging a protocol, or when preparing an animation for a presentation, it is highly desirable to have a means of visualizing a series of steps in a trajectory.  One way to do this is to dump a structure to disk whenever a pose is scored.  In order to do this, a sepecial scoreterm called `dump_trajectory` was added.  This scoreterm contributes nothing to the score, but writes a structure out to disk whenever it is invoked.  (This of course comes with a major performance cost, and should not be done routinely).  It can be used when a structure is scored, at each step in a minimization trajectory, or at each step in a packing trajectory.  To use this scoreterm, simply add it to the scorefunction used for the steps that one wishes to visualize.  The following options can be set to alter the output filename, output format, or frequency with which structures are written:

```xml
	<ScoreFunction name="scorefxn" weights="ref2015" >

		# Turns on the dump_trajectory scoreterm:
		<Reweight scoretype="dump_trajectory" weight="1" />

		# Sets the prefix for the file written to "my_prefix":
		<Set dump_trajectory_prefix="my_prefix" />

		# Sets the output format to gzipped PDB.  "False" by default (no compression):
		<Set dump_trajectory_gz="true" />

		# Sets the scorefunction to dump a structure on every SECOND scoring attempt, or every SECOND
		# step in a minimization or packing trajectory.  Default is 1 (dumps on EVERY scoring attempt,
		# or EVERY step in a minimization or packing trajectory):
		<Set dump_trajectory_stride="2" />

	</ScoreFunction>
```

## RESIDUE_SELECTORS

[[ResidueSelectors|ResidueSelectors]] are used by movers, filters and task operations to dynamically select residues at run-time. They are used to specify sets of residues based on multiple different properties.

### Available ResidueSelectors

See [[ResidueSelectors (RosettaScripts)|ResidueSelectors]]



## TASKOPERATIONS

TaskOperations are used by movers to tell the "packer" which residues/rotamers to use in reorganizing/mutating sidechains. When used by certain Movers, the TaskOperations control what happens during packing, usually by restriction "masks". TaskOperations can also be used by movers to specify sets of residues to act upon in non-packer contexts.

### Available TaskOperations

See [[TaskOperations (RosettaScripts)|TaskOperations-RosettaScripts]]


## RESIDUE_LEVEL_TASK_OPERATIONS

Residue-Level-TaskOperations are used by a few specific TaskOperations control the packer task, such as [[DesignRestrictions|DesignRestrictionsOperation]].

Example:

```
<ROSETTASCRIPTS>
	<RESIDUE_LEVEL_TASK_OPERATIONS>
	        <PreventRepackingRLT name="PreventRepacking" />
	        <RestrictToRepackingRLT name="RestrictToRepacking" />
	</RESIDUE_LEVEL_TASK_OPERATIONS>
</ROSETTASCRIPTS>
```

### Available Residue-Level-TaskOperations

See [[Residue-Level-TaskOperations|Residue-Level-TaskOperations]]



## MOVE_MAP_FACTORIES

This section dictates how to construct a move map for use in many protocols, such as MinMover and FastRelax.  The benefit to a MoveMapFactory is the ability to use ResidueSelectors to construct a move map on-the-fly. 

### Syntax

Example use in `FastRelax`:

```
<RosettaScripts>

	<RESIDUE_SELECTORS>
		<Glycan name="glycans"/>
	</RESIDUE_SELECTORS>
	<MOVE_MAP_FACTORIES>
		<MoveMapFactory name="fr_mm_factory">
			<Backbone residue_selector="glycans" />
			<Chi residue_selector="glycans" />
		</MoveMapFactory>
	</MOVE_MAP_FACTORIES>
	<MOVERS>
		<FastRelax name="fast_relax"  movemap_factory="fr_mm_factory"/>
	</MOVERS>
	<PROTOCOLS>
		<Add mover_name=fast_relax>
	</PROTOCOLS>

</RosettaScripts>

```


Here, we use the MoveMapFactory to only run fast relax on all of the glycans in a pose.  
By default, the movemap is constructed with all kinematics turned on (bb, chi, jump).  By default, everything is off in the MoveMap first. The attributes `bb="0"`, `chi="0"`, `jump="0"` can optionally turn on specific components first when constructing the MoveMap.  

### MoveMapFactory Operations

Sub-tags of the MoveMapFactory tag are used to enable specific DOFs of the pose.  They require a `residue_selector`

```
	<MOVE_MAP_FACTORIES>
		<MoveMapFactory name="fr_mm_factory" enable="0">
			<Backbone residue_selector="my_first_residue_selector"/>
			<Chi residue_selector="my_second_residue_selecotor" />
			<Jump jump_selector="my_jump_selector"/>
		</MoveMapFactory>
	</MOVE_MAP_FACTORIES>

```

* `<Backbone/>`

 These are the backbone residues of the pose. (Phi/Psi for protein).  For noncanonicals, these may be different torsions than you would think, so be careful with this.  For the MoveMapFactory, Glycan BB and CHI torsions are special cased to be  treated as IUPAC defined 

* `<Chi/>`

 These are the sidechain torsions of the pose.  For Glycans, these are the OH groups. 

* `<Jumps/>`

 In dihedral space, these are the relative orientations between sets of residues.  Jumps are determined by the `foldtree` and are typically between chains.  

* `<Nu/>`

* `<Branches/>`

 These are specific torsions coming off the mainchain.  Typically, you do not need to worry about this unless you are using a complicated non-cannonical or modification.  Glycan branch torsions are treated as IUPAC BB torsions within the MoveMapFactory machinery.

See [[MoveMapFactories |MoveMapFactories-RosettaScripts]]

##SIMPLE_METRICS

This section defines any [[SimpleMetrics]] that you wish to use in your protocol.  SimpleMetrics can be used to run analysis and output the data in the resulting scorefile using the [[RunSimpleMetrics]] mover, filter data using the [[SimpleMetricFilter]], or calculate and dump data into relational databases using the [[SimpleMetricFeatures]] reporter.    

Simple Metrics are available in Rosetta version after April 10th, 2018, and are a long-term solution for calculating data and running arbitrary filters (Core filter calculations will slowly be replaced with SimpleMetrics as they are much more versitile.)

Please see [[SimpleMetrics]] and [[Effective Use of SimpleMetrics | SimpleMetrics#effective-use-of-simplemetrics]] for more.

Here is a simple example, running a few metrics for analysis with the `-in:file:native` flag set. 
```xml
<ROSETTASCRIPTS>
	<SCOREFXNS>
	</SCOREFXNS>
	<RESIDUE_SELECTORS>
		<CDR name="L1" cdrs="L1"/>
	</RESIDUE_SELECTORS>
	<MOVE_MAP_FACTORIES>
		<MoveMapFactory name="movemap_L1" bb="0" chi="0">
			<Backbone residue_selector="L1" />
			<Chi residue_selector="L1" />
		</MoveMapFactory>
	</MOVE_MAP_FACTORIES>
	<SIMPLE_METRICS>
		<RMSDMetric name="rmsd" rmsd_type="rmsd_protein_bb_heavy" residue_selector="L1" use_native="1"/>
		<SasaMetric name="sasa" residue_selector="L1"/>
		<SecondaryStructureMetric name="ss" residue_selector="L1" />
		<TotalEnergyMetric name="total_energy" residue_selector="L1" use_native="0"/>
		<CompositeEnergyMetric name="composite_energy" residue_selector="L1" use_native="0"/>
	</SIMPLE_METRICS>
	<MOVERS>
		<MinMover name="min_mover" movemap_factory="movemap_L1" tolerance=".1" /> 
		<RunSimpleMetrics name="run_metrics1" metrics="sasa,ss, total_energy="m1_" />
		<RunSimpleMetrics name="run_metrics2" metrics="sasa,ss,rmsd,composite_energy" prefix="m2_" />
	</MOVERS>
	<PROTOCOLS>
		<Add mover_name="run_metrics1"/>
		<Add mover_name="min_mover" />
		<Add mover_name="run_metrics2" />
	</PROTOCOLS>
</ROSETTASCRIPTS>
```


MOVERS
------

Each mover definition has the following structure

```xml
<MOVERNAME mover_name="&string" name="&string" />
```

where mover\_name belongs to a predefined set of possible movers that the parser recognizes and are listed below, name is a unique identifier for this mover definition and then any number of parameters that the mover needs to be defined.

### Available Movers

See [[Movers (RosettaScripts)|Movers-RosettaScripts]]

FILTERS
-------

Each filter definition has the following format:

```xml
<FILTERNAME filter_name="&string" confidence="1"/>
```

where filter\_name belongs to a predefined set of possible filters that the parser recognizes and are listed below, name is a unique identifier for this mover definition and then any number of parameters that the filter needs to be defined.

If confidence is 1.0, then the filter is evaluated as in predicate logic (T/F). If the value is less than 0.999, then the filter is evaluated as fuzzy, so that it will return True in (1.0 - confidence) fraction of times it is probed. This should be useful for cases in which experimental data are ambiguous or uncertain.

### Available Filters

See [[Filters (RosettaScripts)|Filters-RosettaScripts]]

LOOP\_DEFINITIONS
-----------------

A loop definition is used by movers that preform loop modeling. A loops definition consists of a set of loops where each loop describes the start residue, the stop residue, and optionally specifies a fold-tree cutpoint, a skip-rate and whether the loop should be extended.

### Available Loop Definers

#### Loops

Explicitly specify a set of loops:

<Loops name="(&string)">
<loop start="(&Size)" stop="(&Size)" cut="0" skip_rate="0.0" extended="0"/>
....
</Loops>

#### LoopsFile

Load a loops specification from a loops file

<LoopsFile name="(&string)" filename="(&string)">

#### LoopsDatabase

Load a set of loops from a database with a table having the following schema, defining a single loop per row

CREATE TABLE loops (
tag TEXT,
start INTEGER,
stop INTEGER,
cut INTEGER,
skip_rate REAL,
extended BOOLEAN);

The LoopsDatabase builder return all loops associated with the job distributor input tag

Note: you can specify a different table using the 'database\_table' field

Note: if you would like to query the database for loops differently, you can either pre-query the table and store it, or extend, subclass, or create a different LoopsDefiner class.

Note: If the database configuration information is not specified, the relevant options in the option system are used.

```xml
<LoopsDatabase name="(&string)" database_mode="sqlite3" database_name="(&string)" database_separate_db_per_mpi_process="0" database_read_only="0" database_table="loops"/>
<LoopsDatabase name="(&string)" database_mode="['mysql', 'postgres']" database_name="(&string)" database_host="(-mysql:host &string)" database_user="(-mysql:user &string)" database_password="(-mysql:password &string)" database_port="(-mysql:port &string)" database_table="loops"/> 
```

##Ligands

These RosettaScript sections are specifically for working with and scoring ligands in specialized protocols.

###LIGAND\_AREAS


```xml
<LIGAND_AREAS>
<LigandArea name="[name_of_this_ligand_area]" chain="[string]" cutoff="[float]" add_nbr_radius="[true|false]" all_atom_mode="[true|false]" minimize_ligand="[float]" Calpha_restraints="[float]" high_res_angstroms="[float]" high_res_degrees="[float]" tether_ligand="[float]" />
</LIGAND_AREAS>
```

LIGAND\_AREAS describe parameters specific to each ligand, useful for multiple ligand docking studies. "cutoff" is the distance in angstroms from the ligand an amino-acid's C-beta atom can be and that residue still be part of the interface. "all\_atom\_mode" can be true or false. If all atom mode is true than if the C-beta atom of a protein residue is within "cutoff" of *any* ligand atom, the protein residue becomes part of the interface. If false, the C-beta atom of the protein residue must be within "cutoff" of the the ligand neighbor atom. If "add\_nbr\_radius" is true, the cutoff is increased by the size of the protein residue's neighbor radius. The neighbor radius is an estimate of the range of movement of the residue when repacked, and adding it can compensate for movement of the protein sidechains when repacking.

Ligand minimization can be turned on by specifying a minimize\_ligand value greater than 0. This value represents the size of one standard deviation of ligand torsion angle rotation (in degrees). By setting Calpha\_restraints greater than 0, backbone flexibility is enabled. This value represents the size of one standard deviation of Calpha movement, in angstroms.

During high resolution docking, small amounts of ligand translation and rotation are coupled with cycles of rotamer trials or repacking. These values can be controlled by the 'high\_res\_angstrom' and 'high\_res\_degrees' values respectively. A tether\_ligand value (in angstroms) will constrain the ligand so that multiple cycles of small translations don't add up to a large translation.

###INTERFACE\_BUILDERS

```xml
<INTERFACE_BUILDERS>
<InterfaceBuilder name="[name_of_this_interface_builder]" ligand_areas="(comma separated list of predefined ligand_areas)" extension_window="(int)"/>
</INTERFACE_BUILDERS>
```

An interface builder describes how to choose residues that will be part of a protein-ligand interface. These residues are chosen for repacking, rotamer trials, and backbone minimization during ligand docking. The initial XML parameter is the name of the interface\_builder (for later reference). "ligand\_areas" is a comma separated list of strings matching LIGAND\_AREAS described previously. Finally 'extension\_window' surrounds interface residues with residues labeled as 'near interface'. This is important for backbone minimization, because a residue's backbone can't really move unless it is part of a stretch of residues that are flexible.

###MOVEMAP\_BUILDERS


```xml
<MOVEMAP_BUILDERS>
<MoveMapBuilder name="[name_of_this_movemap_builder]" sc_interface="(string)" bb_interface="(string)" minimize_water="[true|false]"/>
</MOVEMAP_BUILDERS>
```

A movemap builder constructs a movemap. A movemap is a 2xN table of true/false values, where N is the number of residues your protein/ligand complex. The two columns are for backbone and side-chain movements. The MovemapBuilder combines previously constructed backbone and side-chain interfaces (see previous section). Leave out bb\_interface if you do not want to minimize the backbone. The minimize\_water option is a global option. If you are docking water molecules as separate ligands (multi-ligand docking) these should be described through LIGAND\_AREAS and INTERFACE\_BUILDERS.

###SCORINGGRIDS

```xml
<SCORINGGRIDS ligand_chain="(string)" width="(real)" name="(string, optional)" resolution="(real, optional)" normalize_mode="(string, optional)" >
<[scoring grid type name] grid_name="(string)" weight="(real)"/>
</SCORINGGRIDS>
```

The SCORINGGRIDS block is used to define ligand scoring grids (currently used only by the Transform mover). The grids will initially be created centered at the ligand chain specified, and will be cubical with the specified width in angstroms. Rosetta automatically decides whether or not a grid needs to be recalculated. Grids are recalculated if any non-ligand atoms change position. The weight specified for each grid is multiplied by the ligand score for that grid. The following grid\_types can currently be specified:

-   ClassicGrid: The scoring grids originally used in The Davis, 2009 implementation of RosettaLigand.
-   AtrGrid: An attractive potential grid.
-   ChargeGrid: An approximation of the electric field.
-   HbdGrid: A knowledge-based potential derived grid approximating protein hydrogen bond donor interactions.
-   HbaGrid: A knowledge-based potential derived grid approximating protein hydrogen bond acceptor interactions.
-   LigandPropertyScore: ? (Currently undocumented).
-   RepGrid: A repulsive potential grid.
-   ShapeGrid: A knowledge-based potential derived grid approximating shape complementarity.
-   SiteGrid: ? (Currently undocumented).
-   SolvationGrid: A solvation potential grid.

The top-level "name" parameter is used to specify the GridSet name, which can be used with the Transform mover to select which set of grids are being used. (If no name is given, the grid set will be loaded under the name "default".) 

OUTPUT
------

The top-level OUTPUT tag allows for setting certain output options.

The OUTPUT tag must be the very last tag before the closing `</ROSETTASCRIPTS>` tag.

### scorefxn

```xml
<OUTPUT scorefxn="(name &string)"/>
```
The scorefunction specified by the OUTPUT tag will be used to score the pose prior to output. It is the score function which will be represented in the scores reported in the scorefile and the output PDB of the run.  You may use the name "commandline", which will instruct RosettaScripts to use whatever command line scoring function was set or the DEFAULT Rosetta scorefunction.

Note that as of April, 2019, the `OUTPUT` tag is required for RosettaScripts to re-score your pose. If you are missing the OUTPUT tag, whatever scoring information is present from your protocol will be output.  This is because many movers do their own scoring and may add scoring terms that are useful to have in the output pose. This means that if you use MinMover, PackMinMover, or any other mover that uses a scorefunction, your scoring information will be left in-tact.  This brings RosettaScripts in-line with how the rest of Rosetta behaves.   


APPLY\_TO\_POSE (Deprecated)
---------------

This is a section that was used to change the input structure. This is much better handled by applying the corresponding mover with the PROTOCOLS section. See the page [[Updating RosettaScripts]] for more info on how to adjust XMLs to remove this section.

## Troubleshooting RosettaScripts

RosettaScripts is under continuing development. In conjuction with this, there are occasionally changes which cause older scripts to break. Sometimes this will be a small change in required options for a particular RosettaScripts object. These should (hopefully) be documented on the documentation pages for the individual movers. See [[Updating RosettaScripts]] for information about changes which are more far reaching and affect multiple RosettaScripts objects. 

### Troubleshooting hints.

The first thing to do when getting an error with RosettaScripts is to check the documentation for each of the RosettaScripts objects which you are using. Pay particular attention to those options and settings which the object mentions as being required. Often times it's not just an in-XML parameter which will need to be changed in order to address the error. You may also need to add various command line parameters to your RosettaScript runs in order to get the results you're expecting.

Another good troubleshooting tool is to simplify your XML. Try creating a stripped-down verison of your XML with only a handful of Movers. Test that and make sure it's behaving as you expect. Slowly reenable your movers and other RosettaScripts objects a few at a time, checking at each stage that the behavior is as you expect it to be. Also try simplifying the settings to your movers, using the defaults as much as possible. Check to make sure that each additional change to the defaults is causing the behavioral change you would expect it to. This progressive approach can often help you narrow down where the exact cause of your issues lie.

##See Also

* [Introductory RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scripting_with_rosettascripts/scripting_with_rosettascripts)
* [Advanced RosettaScripting Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/advanced_scripting_with_rosettascripts/advanced_scripting_with_rosettascripts)
* [[RosettaDiagrams (external link)|http://www.rosettadiagrams.org/]]: Provides a graphical interactive service to produce RosettaScripts XML files, with some ability to run the scripts as well.
* [[I want to do x]]: Guide for making specific structural perturbations using RosettaScripts
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Getting Started]]: A page for people new to Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
* [[Rosetta Servers]]: Web-based servers for Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.

<!-- SEO
scriptvars
-->