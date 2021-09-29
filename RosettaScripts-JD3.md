## RosettaScripts JD3

This app uses a file called the `job_definition_file` to run a RosettaScript with different inputs or settings in a single job.  It is extremely useful for benchmarking. 

## Reference


**Growing Glycans in Rosetta: Accurate de novo glycan modeling, density fitting, and rational sequon design**
Jared Adolf-Bryfogle, J. W Labonte, J. C Kraft, M. Shapavolov, S. Raemisch, T. Lutteke, F. Dimaio, C. D Bahl, J. Pallesen, N. P King, J. J Gray, D. W Kulp, W. R Schief
_bioRxiv_ 2021.09.27.462000; [[https://doi.org/10.1101/2021.09.27.462000]]


[[_TOC_]]

## Example Command


`rosetta_scripts_jd3.macosclangrelease -job_definition_file my_job_definition_file.xml`


## Job Definition File


This file lists the per-job settings and xml files used.  You can mix and match.  Only certain global options are allowed to change.  If you wish to try different settings, use the script_vars option for the XML to control different jobs. 

Here is an example with different PDBs, script vars, etc. 
In general, you should have Input and Output for each job as well as the parser protocol listed. 

Note that double underscores, `__` are used to denote namespaces of global options used for each job, for example `parser__protocol` and `parser__script_vars`.

### Example

```xml
<JobDefinitionFile>
   <Job>
      <Input>
         <PDB filename="pdbs/pareto/1gai_refined.pdb.gz"/>
      </Input>
      <Output>
         <PDB filename_pattern="glycan-build_100_hybrid-build-two_171A/glycan-build_100_hybrid-build-two_171A_$"/>
      </Output>
      <Options>
         <parser__protocol value="xmls/glycan_tree_relax.xml"/>
         <parser__script_vars value="branch=171A cartmin=0 layer_size=2 window_size=0 glycan_sampler_rounds=100 quench_mode=0 map=maps/1gai_2mFo-DFc_map.ccp4 symmdef=pdbs/symmetrized_structures/1gai_crys.symm shear=1 rounds=1 conformer_probs=0 gaussian_sampling=1 hybrid_protocol=1 exp=hybrid-conformer-build-two match=1"/>
         <in__file__native value="pdbs/pareto/1gai_refined.pdb.gz" />
      </Options>
   </Job>
   <Job>
      <Input>
         <PDB filename="pdbs/pareto/1gai_refined.pdb.gz"/>
      </Input>
      <Output>
         <PDB filename_pattern="glycan-build_100_hybrid-build-one_171A/glycan-build_100_hybrid-build-one_171A_$"/>
      </Output>
      <Options>
         <parser__protocol value="xmls/glycan_tree_relax.xml"/>
         <parser__script_vars value="branch=171A cartmin=0 layer_size=1 window_size=0 glycan_sampler_rounds=100 quench_mode=0 map=maps/1gai_2mFo-DFc_map.ccp4 symmdef=pdbs/symmetrized_structures/1gai_crys.symm shear=1 rounds=1 conformer_probs=0 gaussian_sampling=1 hybrid_protocol=1 exp=hybrid-conformer-build-one match=1"/>
         <in__file__native value="pdbs/pareto/1gai_refined.pdb.gz" />
      </Options>
   </Job>
   <Job>
      <Input>
         <PDB filename="pdbs/pareto/1jnd_refined.pdb.gz"/>
      </Input>
      <Output>
         <PDB filename_pattern="glycan-build_100_gs-final_200A/glycan-build_100_gs2_200A_$"/>
      </Output>
      <Options>
         <parser__protocol value="xmls/gs.xml"/>
         <parser__script_vars value="branch=200A cartmin=0 layer_size=2 window_size=1 glycan_sampler_rounds=100 quench_mode=0 map=maps/1jnd_2mFo-DFc_map.ccp4 symmdef=pdbs/symmetrized_structures/1jnd_crys.symm shear=1 rounds=1 conformer_probs=0 gaussian_sampling=1 exp=gs-final"/>
         <in__file__native value="pdbs/pareto/1jnd_refined.pdb.gz" />
      </Options>
   </Job>
   <Job>
      <Input>
         <PDB filename="pdbs/pareto/1jnd_refined.pdb.gz"/>
      </Input>
      <Output>
         <PDB filename_pattern="glycan-build_50_hybrid-gs-even-final_200A/glycan-build_50_hybrid-gs-even2_200A_$"/>
      </Output>
      <Options>
         <parser__protocol value="xmls/gtm_gs.xml"/>
         <parser__script_vars value="branch=200A cartmin=0 layer_size=2 window_size=1 glycan_sampler_rounds=50 quench_mode=0 map=maps/1jnd_2mFo-DFc_map.ccp4 symmdef=pdbs/symmetrized_structures/1jnd_crys.symm shear=1 rounds=1 conformer_probs=0 gaussian_sampling=1 exp=hybrid-gs-even-final"/>
         <in__file__native value="pdbs/pareto/1jnd_refined.pdb.gz" />
      </Options>
   </Job>
</JobDefinitionFile>
```

------------------------------

### Input

#### RCSB (PDB files)
The PDB Inputter accepts ANY RCSB file type: `.pdb`, `.cif`, and `.mmtf`

_Example for Single PDB_:

```xml
      <Input>
         <PDB filename="pdbs/pareto/1gai_refined.pdb.gz"/>
      </Input>
```

_Example for Multiple PDBs (PDBLIST)_ 
- Note: one pdb file per line - just as with the `-l` option for all other apps-

```xml
      <Input>
         <PDB listfile="my_pdb_list.txt"/>
      </Input>
```

##### Options
Option | Description
------------ | -------------
`listfile` | Give the path to a list file of pdbs
`filename` | Give the path to a single pdb. 
`path` | Give the path to the PDB or the path for each PDB listed in list file

------------------------------

#### Rosetta Silent Files

Example:
```xml
      <Input>
         <Silent silent_files="silent1,silent2"/>
      </Input>
```

##### Options

Option | Description
------------ | -------------
`silent_files` | Comma-separated list of silent files.
`tags` | Comma-separated list of tags specifying the subset of Poses that should be processed from the input silent file(s). If neither this attribute, nor the 'tagfile' attribute are used, then all Poses in the input silent file(s) are used.
`tagfile`| File name whose contents lists a set of whitespace-separated tags specifying the subset of Poses that should be processed from the input silent file(s). If neither this attribute, nor the 'tags' attribute are used, then all Poses in the input silent file(s) are used.
`skip_failed_simulations` | Skip processing of input Poses if the tag starts with 'W_'

------------------------------

### Output

#### PDB Files
Output classic PDB files using either `filename` or `filename_pattern`

```xml
      <Output>
         <PDB filename_pattern="glycan-build_50_hybrid-gs-even-final_200A/glycan-build_50_hybrid-gs-even2_200A_$"/>
      </Output>
```

##### Options
Option | Description
------------ | -------------
`filename` | The name of the file to write the output structure to -- only works correctly so long as there is only one input structure, otherwise the output structures would pile up on top of each other. Cannot be combined with the 'filename_pattern' attribute, which is typically preferable to this one.
`filename_pattern` | If you want to name the output pdb files for a job with some permutation on the input tag (i.e. the input pdb name) and then something that identifies something particular about the job (e.g. '1abc_steal_native_frags_0001.pdb') then use the filename_pattern string. The original job tag will be substituted for the dolar sign. E.g. '$_steal_native_frags' would produce pdbs named '1abc_steal_native_frags_0001.pdb'. Prefix and Suffix options will be added to these.
`path` | Give the directory to which the output .pdb file should be written. Note that the output path does not become part of the job name, so if you have two jobs with the same job name written to different directories, then your log file and your score file (and any other secondary pose outputter) will not distinguish between which of the two jobs it is writing output for
`overwrite` | If this is set to 'true', then the job(s) will run even if an output file with the name that this job would produce exists, and that previously-existing output file will be overwritten with the new output file.
`pdb_gz` | Should the output PDB file be written as a .gz?
`prefix`| Set output PDB Prefix. Can be combined with the 'filename_pattern' attribute. Overrides any cmd-line prefix option set.
`suffix` | Set output PDB Suffix. Can be combined with the 'filename_pattern' attribute. Overrides any cmd-line prefix option set."

------------------------------

#### mmTF files

Example:
      <Output>
         <mmTF filename_pattern="glycan-build_50_hybrid-gs-even-final_200A/glycan-build_50_hybrid-gs-even2_200A_$"/>
      </Output>

##### Options
Option | Description
------------ | -------------
`filename` | The name of the file to write the output structure to -- only works correctly so long as there is only one input structure, otherwise the output structures would pile up on top of each other. Cannot be combined with the 'filename_pattern' attribute, which is typically preferable to this one.
`filename_pattern` | If you want to name the output mmtf files for a job with some permutation on the input tag (i.e. the input pdb name) and then something that identifies something particular about the job (e.g. '1abc_steal_native_frags_0001.mmtf') then use the filename_pattern string. The original job tag will be substituted for the dolar sign. E.g. '$_steal_native_frags' would produce pdbs named '1abc_steal_native_frags_0001.mmtf'. Prefix and Suffix options will be added to these.
`path` | Give the directory to which the output .pdb file should be written. Note that the output path does not become part of the job name, so if you have two jobs with the same job name written to different directories, then your log file and your score file (and any other secondary pose outputter) will not distinguish between which of the two jobs it is writing output for
`overwrite` | If this is set to 'true', then the job(s) will run even if an output file with the name that this job would produce exists, and that previously-existing output file will be overwritten with the new output file.
`mmtf_gz` | Should the output mmtf file be written as a .gz?
`prefix`| Set output mmtf Prefix. Can be combined with the 'filename_pattern' attribute. Overrides any cmd-line prefix option set.
`suffix` | Set output mmtf Suffix. Can be combined with the 'filename_pattern' attribute. Overrides any cmd-line prefix option set."

------------------------------

#### Rosetta Silent files

A PoseOutputter that writes structures out in a rosetta-specific format; a single silent file can hold hundreds or thousands of output structures, lessening the load on file systems, and making output management easier. Note that if two different Jobs defined in the Job-definition file intend to write their outputs to the same file, then the settings for the first Job will take precedence over the settings for the second Job. This situation is complicated further if using MPI and multiple output/archive nodes: in this scenario, multiple silent files will be written (one per output node) and the first Job to be written to a silent file will determine which settings take precedence but that it is not knowable which of the two Jobs will be written first. To avoid confusion, it is recommended that either each Job write their outputs to a different file, or that the same options are used for all Jobs writing to the same file."

Example:
```xml
      <Output>
         <SilentFile filename="my_silent_file"/>
      </Output>
```

##### Options
Option | Description
------------ | -------------
`filename` | The name of the output silent file that should be written to.
`buffer_limit` | The number of Poses that should be held in memory between each write to disk
`path` | Give the directory to which the output silent file should be written. Note that the output path does not become part of the job name, so if you have two jobs with the same job name written to different directories, then your log file and your score file (and any other secondary pose outputter) will not distinguish between which of the two jobs it is writing output for

------------------------------

## Global Command Line Options Accepted per-job

### Parser Options
```
parser__protocol
parser__script_vars
parser__inclusion_recursion_limit
corrections__restore_talaris_behavior
mistakes__restore_pre_talaris_2013_behavior
in__file__native;

### ScoreFunction Options

```
score__empty
score__weights
score__patch
corrections__correct
corrections__hbond_sp2_correction
corrections__score__dun10
corrections__score__score12prime
in__auto_setup_metals
in__include_sugars
score__force_sugar_bb_zero;
```

## Useful SimpleMetrics for Benchmarking

The [[ProtocolSettingsMetric]] is designed to be combined with RosettaScripts JD3 to make benchmarking and more complex protocols easier to write, run, and analyze in downstream scripts. 

Use the `job_tag` Option with script_vars job option to separate specific experiments. This will be shown in the scorefile (and in the PDB) as `opt_job_tag`. Really useful when combined with pandas.  Use the options `get_script_vars` and `get_user_options` to report set script_vars and set per-job/global options in the scorefile to use for plotting and analysis.  Finally, use `limit_to_options` to only write specific options out to the score file.  