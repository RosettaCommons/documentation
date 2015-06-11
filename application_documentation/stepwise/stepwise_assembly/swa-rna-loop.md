#RNA loop modeling (lock-and-key problem) with Stepwise Assembly

Metadata
========

Author: Parin Sripakdeevong, Rhiju Das

March 2012 by Parin Sripakdeevong (sripakpa [at] stanford.edu) and Rhiju Das (rhiju [at] stanford.edu).

Code and Demo
=============

This code builds single-stranded RNA loops using a deterministic, enumerative sampling method called Stepwise Assembly. A demo example for building the first (5' most) nucleotide of a 6-nucleotide loop is given in `       rosetta/demos/public/SWA_RNA_Loop/      ` . The same protocol can then be recursively applied to build the remaining nucleotides in the loop, one individual nucleotide at a time.

(Note: the Stepwise Assembly method constructs full-length RNA loops through the recursive building of each individual RNA nucleotides over multiple steps. The enumerative nature of the method makes the full-calculation computationally expensive, requiring for example 15,000 CPU hours to build a single 6-nucleotide RNA loop. While this full-calculation is now feasible on a high-performance computer clusters, perform the full-calculation in the demo would be too excessive.)

The central codes are located in the `       src/protocols/swa_rna/      ` folder. The applications are in *apps/public/swa\_rna\_main* and *apps/public/swa\_rna\_util*

References
==========

Sripakdeevong, P., Kladwang, W. & Das, R. (2012), “An enumerative stepwise ansatz enables atomic-accuracy RNA loop modeling”, Proc Natl Acad Sci USA. doi:10.1073/pnas.1106516108

Application purpose
===========================================

This method builds single-stranded RNA loops using a deterministic, enumerative sampling method called Stepwise Assembly. The modeling situation considered here is the lock-and-key problem. Given a template PDB that contains nucleotides surrounding a missing RNA loop, the Stepwise Assembly method finds the loop conformation (the key) that best fits the surrounding structure (the lock).

Limitations
===========

-   The enumerative nature of the method makes the full-calculation quite computationally expensive, requiring for example 15,000 CPU hours to build a single 6-nucleotides RNA loop. Is is therfore infeasible to perform the full-calculation on a single desktop/laptop computer. Instead the full-calculation is feasible only on a high-performance computer clusters.

-   The missing RNA loop needs to be single-stranded. The longest loop successfully tested thus far is 10 nucleotides in length (see referenced paper for details).

-   Currently, the method only optimize the conformation of the missing RNA loop. The coordinates of the surrounding nucleotides inherited from [template\_PDB](#Required-file) are fixed during the entire modeling process.

-   Due to memory limitations, the full-length structure should not exceed 100 nucleotides [this includes the surrounding nucleotides inherited from [template\_PDB](#Required-file).

Modes
=====

There is only one mode to run SWA\_RNA\_Loop at present.

Input Files
===========

Required file
-------------

You need two files:

-   The template\_PDB file: A PDB file containing the coordinates of surrounding nucleotides in the vicinity of the missing RNA loop to be build. We recommend including all surrounding nucleotides within a 10-Angstrom vicinity of the missing RNA loop. An example is available at rosetta/demos/SWA\_RNA\_loop/rosetta\_inputs/template.pdb. Supplied PDB file must be in Rosetta RNA PDB format (see Note on PDB format for RNA).

-   The [[fasta file]]: this is the sequence file of the full-length RNA. The fasta file has the RNA name on the first line (after \>), and the sequence on the second line. Valid letters are a, c, g and u. An example fasta file is available at rosetta/demos/SWA\_RNA\_loop/rosetta\_inputs/fasta.

additional files:
-----------------

-   The native\_PDB file: A PDB file containing the 'native' crystallographic or NMR structure. This PDB file should contain the coordinates of the coordinates of the native loop nucleotides plus the surrounding nucleotides inherited from [template\_PDB](#Required-file). The supplied native\_PDB file is not used to guide the modeling process and only used for reporting the RMSD of the generated rosetta models to the native loop. An example is available at rosetta/demos/SWA\_RNA\_loop/rosetta\_inputs/native.pdb. Supplied PDB file must be in Rosetta RNA PDB format (see Note on PDB format for RNA).

Preprocessing of input files
============================

Input PDB file can be converted into the Rosetta RNA PDB format using the following command:

```
    rosetta/tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_make_rna_rosetta_ready.py IN_PDB.pdb -output_pdb OUT_PDB.pdb
```

Replace 'IN\_PDB.pdb' with your input PDB filename. Replace 'OUT\_PDB.pdb' with the filename you want the converted PDB to be outputted to.

How to run the job
==================

The SWA\_RNA\_python package located at rosetta/tools/SWA\_RNA\_python/ contains the scripts necessary to setup and run the Stepwise Assembly protocol. Instructions are provided in steps 1)-4) below:

1) Specify the location of the rosetta bin folder and rosetta database folder by editing your .bashrc or .bash\_profile with a line like:

```
export ROSETTA='~/rosetta/'
```

2) Add the SWA\_RNA\_python package location to the PYTHON path. For bash shell users, the location can be directly added to the \~/.bashrc file:

```
    export PYTHONPATH=$PYTHONPATH:~/rosetta/tools/SWA_RNA_python/
```

3) After the paths are correctly specified, the following command is used to setup everything needed run the Stepwise Assembly job:

```
    rosetta/tools/SWA_RNA_python/SWA_dagman_python/SWA_DAG/setup_SWA_RNA_dag_job_files.py -s template.pdb -fasta fasta -sample_res 3-8 -single_stranded_loop_mode True -local_demo True -native_pdb native.pdb
```

```
    The "-s" flag specifies the template_PDB file
    The "-fasta" flag specifies the @ref fasta file
    The "-sample_res" flag specifies the sequence number of nucleotides in the missing loop. For example, 3-8 means that the missing loop nucleotides are located at sequence position 3 4 5 6 7 and 8.
    The "-single_stranded_loop_mode" flag specifies that the job involve modeling a single-stranded loop (i.e. the lock-and-key problem).
    The "-local_demo" flag indicate that this is demo to be run on a local laptop or desktop. The calculation perform here is to only build the first (5' most) nucleotide of the 6-nucleotides RNA loop.
    The "-native_pdb" flag specifies the native_PDB file and is optional.
```

4) Type "source LOCAL\_DEMO" to execute the Rosetta protocol.

The provided instruction will allow the user to build the first (5' most) nucleotide of a N-nucleotide loop. As previously stated, the full-calculation to build full-length RNA loops is quite computationally expensive and is beyond the scope of this documentation. The SWA\_RNA\_python package is, however, equipped to run this recursive full-calculation on a high-performance computer clusters. The package utilize concept familiar from the Map/Reduce Direct Acyclic Graph framework to order the calculation steps and allocate resources to recursive build the full-length RNA loop over multiple steps, one individual RNA nucleotide at a time. If any user is interested, please contact Parin Sripakdeevong (sripakpa [at] stanford.edu) and we will be happy to provide additional instructions.

Expected Outputs
================

The expected outputs are two silent\_files:

```
    A) region_0_1_sample.out: This silent_file contain 108 structures, corresponding to the 108 lowest energy conformations.
    B) region_0_1_sample.cluster.out: Same as A) but after clustering of the models to remove redundant conformations.
```

Post Processing
===============

In both silent\_files, the total energy score is found under the 'score' column. If the "native\_pdb" flag was included, then the RMSD (in angstrom units) between the native\_pdb and each Rosetta model is found under the 'NAT\_rmsd' column.

Finally, use the following command to extract the top 5 energy cluster centers:

```
    rosetta/tools/SWA_RNA_python/SWA_dagman_python/misc/SWA_extract_pdb.py -tag S_0 S_1 S_2 S_3 S_4  -silent_file region_0_1_sample.cluster.out
```

After running the command, the extracted PDB files should appear in the pose\_region\_0\_1\_sample.cluster.out/ subfolder.

New things since last release
=============================

This application is new as of Rosetta 3.4.

* [[Protein loop modeling with Stepwise Assembly|swa-protein-main]]
  * [[Further information on this application's workflow|swa-protein-long-loop]]
* [[Stepwise MonteCarlo application|stepwise]]
* [[Overview of Stepwise classes|stepwise-classes-overview]]
* [[Structure prediction applications]]: Includes links to these and other applications for loop modeling
* [[RNA applications]]: Applications to be used with RNA or RNA and proteins
* [[RNA]]: More information on working with RNA in Rosetta
* [[RosettaScripts]]: The RosettaScripts home page
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files