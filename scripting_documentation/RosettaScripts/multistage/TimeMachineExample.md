#MultistageRosettaScripts

#Time Machine

Back To [[Multistage Rosetta Scripts|MultistageRosettaScripts]]

- Written by Jack Maguire, send questions to jackmaguire1444@gmail.com
- All information here is valid as of Feb 2, 2018

[[_TOC_]]

One of the consequences of
[[archiving job results on disk|RunningMRS#running-multistage-rosetta-scripts_relevant-commandline-flags_archive_on_disk]]
is that the results still exist when the program completes.
Sure, this usually just means that you have to do the extra chore of
deleting these binaries when you are done running,
but there are benefits too:

###Anecdote

Suppose your final results have some trait that you did not expect
and you would like to track down how this trait was introduced.
For example, I once ran a protocol with 1 stage of DockingProtocol
followed by 5 stages of FastRelax (similar to the [[batch relax example|BatchRelaxExample]]).
The final structures were completely unfolded
and I wanted to figure out where things went wrong.
I loaded up the 5 intermediate states from their archives
and was able to look at each structure in PyMOL.
The protein was folded after the docking stage
but was unfolded after the first FastRelax stage.
Further inspection showed that the product of the DockingProtocol
had many side chain clashes that were not present in the input structure.
The use of this time machine feature allowed me to quickly figure out that
I was not using the [[SaveAndRetrieveSidechainsMover|SaveAndRetrieveSidechainsMover]]
correctly.

###Toy Example

Let's play with a 3-stage protocol that does Docking, PackRotamersMover, and MinMover:

```xml
<JobDefinitionFile>
    <Job>
        <Input>
            <PDB filename="3U3B.pdb"/>
        </Input>
    </Job>

    <Common>

        <TASKOPERATIONS>
            <RestrictToRepacking name="rtr"/>
        </TASKOPERATIONS>

        <SCOREFXNS>
            <ScoreFunction name="sfxn" weights="ref2015_cart.wts"/>
            <ScoreFunction name="sfxn_lowres" weights="interchain_cen.wts"/>
        </SCOREFXNS>

        <FILTERS>
            <ScoreType name="sfxn_filter" score_type="total_score" scorefxn="sfxn" threshold="999999" />
        </FILTERS>

        <MOVERS>
            <DockingProtocol docking_score_low="sfxn_lowres" partners="A_B" low_res_protocol_only="true" name="dock" />
            <SwitchResidueTypeSetMover name="to_fa" set="fa_standard" />
            <SaveAndRetrieveSidechains allsc="1" multi_use="0" name="save_retrieve" two_step="1" />

            <PackRotamersMover scorefxn="sfxn" name="pack_rot" task_operations="rtr"/>

            <MinMover scorefxn="sfxn" name="min_mover" chi="1" bb="0"/>
        </MOVERS>

        <PROTOCOLS>
            <Stage num_runs_per_input_struct="100" total_num_results_to_keep="5">
                <Add mover_name="save_retrieve"/>
                <Add mover_name="dock"/>
                <Add mover_name="to_fa"/>
                <Add mover_name="save_retrieve"/>
                <Sort filter_name="sfxn_filter"/>
            </Stage>

            <Stage num_runs_per_input_struct="2" total_num_results_to_keep="5">
                <Add mover_name="pack_rot"/>
                <Sort filter_name="sfxn_filter"/>
            </Stage>

            <Stage num_runs_per_input_struct="1" total_num_results_to_keep="3">
                <Add mover_name="min_mover"/>
                <Sort filter_name="sfxn_filter"/>
            </Stage>

        </PROTOCOLS>

    </Common>
</JobDefinitionFile>
```

If you are following along, I am using the 3U3B
file directly from RCSB ([[link|https://files.rcsb.org/view/3U3B.pdb]]).
My execution command looked like this:

####Executing Rosetta

```sh
$ ls
3U3B.pdb  job_def.xml
$ mkdir archives
$ mpirun -n 12 multistage_rosetta_scripts.mpiserialization.linuxgccrelease -job_definition_file job_def.xml -archive_on_disk archives -n_archive_nodes 1 -mpi_tracer_to_file mpi
$ ls
3U3B_0111_0001.pdb  3U3B_0112_0001.pdb  3U3B_0114_0001.pdb  3U3B.pdb  archives  job_def.xml  mpi_0  mpi_1  mpi_10  mpi_11  mpi_2  mpi_3  mpi_4  mpi_5  mpi_6  mpi_7  mpi_8  mpi_9  score.sc.1  score.sc.2
```

####Finding Intermediate States

We have 3 output files as expected.
Let's pretend we have looked at all 3 and 3U3B_0112_0001.pdb has some special trait we are interested in.
We want to look at the snapshots of the trajectory that created that file,
but first we need to figure out which archives we need to look at.
To do so, look at the end of the output for the head node as follows:

```sh
$ tail mpi_0 
protocols.multistage_rosetta_scripts.MRSJobQueen: (0) Job Genealogy:
protocols.multistage_rosetta_scripts.MRSJobQueen: (0) ((((JR_113_1)JR_107_1,(JR_114_1)JR_108_1)JR_54_1,((JR_111_1)JR_101_1,(JR_112_1)JR_102_1)JR_77_1,(JR_105_1)JR_97_1)input_source_1)all
protocols.jd3.job_distributors.MPIWorkPoolJobDistributor: (0) Sending output to archive 1
protocols.jd3.job_distributors.MPIWorkPoolJobDistributor: (0) Pushing back output into queue for archive 1
protocols.jd3.job_distributors.MPIWorkPoolJobDistributor: (0) Sending output spec for 112 1 with output_id 112 1 to node 2
protocols.jd3.job_distributors.MPIWorkPoolJobDistributor: (0) Remote 1 has completed an output
protocols.jd3.job_distributors.MPIWorkPoolJobDistributor: (0) Sending remote 1 an output archived on another node, if available.
protocols.jd3.job_distributors.MPIWorkPoolJobDistributor: (0) ... output work was NOT available
protocols.jd3.job_distributors.MPIWorkPoolJobDistributor: (0) Exiting go_master
```

or

```sh
$ grep ')all' mpi_0
protocols.multistage_rosetta_scripts.MRSJobQueen: (0) ((((JR_113_1)JR_107_1,(JR_114_1)JR_108_1)JR_54_1,((JR_111_1)JR_101_1,(JR_112_1)JR_102_1)JR_77_1,(JR_105_1)JR_97_1)input_source_1)all
```

This gives us the lineage of the archives in
[[newick tree format|https://en.wikipedia.org/wiki/Newick_format]].
We want to find the leaf JR_112_1 (numbers match pdb filename 3U3B_0112_0001.pdb)
and note the upstream branches.
It is a little hard to do this straight from the text,
so you may want to use a phylogenic tree viewer of some kind
(or the tool described in the next section).
The tree looks like this:

```
input_source_1 - | JR_54_1 - | JR_107_1 - | JR_113_1
	         | 	     | 		  
	         |	     | JR_108_1 - | JR_114_1
	         |	     
		 | JR_77_1 - | JR_101_1 - | JR_111_1
		 | 	     |
		 |	     | JR_102_1 - | JR_112_1
		 |
		 | JR_97_1 - | JR_105_1
```

You can see from this tree that JR_102_1 and JR_77_1 are the two immediate ancestors to JR_112_1.
Now let's look for archives that have matching numbers (both the first and second number should match;
the second number is not always 1) and unarchive them using the following command:

####Explanation of how to read the Newick Tree labels
Unfortunately, the filenames of the archives and output files
are not available to the class that creates the Newick Tree.
This is an avoidable handicap, but I wanted to wait until JD3
was more solidified before implementing the name-matching process.
This is why 3U3B_0112_0001.pdb had to be labeled JR_112_1
and 3U3B.pdb had to be labeled input_source_1.

The first and second numbers of the
output file (112 and 1 for 3U3B_0112_0001.pdb) and
archive file (102 and 1 for archive.102.1) will always match
the numbers for the job result listed in the newick tree
(JR_112_1 and JR_102_1 respectively).

The input sources are numbered based on the order in which
they appear in the job_definition_file.
You may have two `<Job/>` tags each defining PDBLists of length 10,
giving you 20 input sources.

####Tree Parsing Tool

This Newick tree format can be somewhat unreadable for human eyes,
especially for a production-run sized tree.
I added a few helper scripts in tools/rosetta_scripts (you may need to pull from master).

If you provide the script with the target you want to trace and a copy-paste of the tree,
it will print out the lineage of that job from end to beginning.

`extract_path_from_newick_tree.py`:
```sh
$ python extract_path_from_newick_tree.py JR_112_1 '((((JR_113_1)JR_107_1,(JR_114_1)JR_108_1)JR_54_1,((JR_111_1)JR_101_1,(JR_112_1)JR_102_1)JR_77_1,(JR_105_1)JR_97_1)input_source_1)all'
JR_112_1
JR_102_1
JR_77_1
input_source_1
```

Use `extract_path_from_newick_tree_python3.py` if you have already upgraded to Python 3:
```sh
$ python3 extract_path_from_newick_tree_python3.py JR_112_1 '((((JR_113_1)JR_107_1,(JR_114_1)JR_108_1)JR_54_1,((JR_111_1)JR_101_1,(JR_112_1)JR_102_1)JR_77_1,(JR_105_1)JR_97_1)input_source_1)all'
JR_112_1
JR_102_1
JR_77_1
input_source_1
```

####Final Output

```sh
$ ls archives/
archive.101.1  archive.102.1  archive.108.1  archive.54.1  archive.77.1
$ multistage_rosetta_scripts.mpiserialization.linuxgccrelease -unarchive archives/archive.77.1 archives/archive.102.1
...
$ ls archives/
archive.101.1  archive.102.1  archive.102.1.pdb  archive.108.1  archive.54.1  archive.77.1  archive.77.1.pdb
```

Now we have the following .pdb files:

| Filename           | State                                                |
| ------------------ | ---------------------------------------------------- |
| 3U3B.pdb           | input file                                           |
| archive.77.1.pdb   | intermediate state after DockingProtocol (stage 1)   |
| archive.102.1.pdb  | intermediate state after PackRotamersMover (stage 2) |
| 3U3B_0112_0001.pdb | final state after MinMover (stage 3)                 |


####Fine Print
You may be noticing that the tree has extra elements that were not output.
The reason for this is not obvious to me.
My guess is that the final "bad" element is not deleted until after the tree is printed.
I do not think that this bug will result in an absent element that should be present.
