#Sample around nucleobase
========

Author: Rhiju Das

Dec. 2014 by Rhiju Das (rhiju [at] stanford.edu).

Developed in summer 2012, Das Lab hackathon -- Kyle Beauchamp, Fang-Chieh Chou, Rhiju Das, Parin Sripakdeevong. 
Extended to include phosphate by Rhiju Das in Dec. 2014.

### Scan methyl probe in base plane
![Scan xy]( https://cloud.githubusercontent.com/assets/1672331/5621802/c6cf4f38-94ee-11e4-8df0-3658b67b8092.png "Scan methyl probe in base plane")

### Scan methyl probe 4.0 Å displaced from base plane
![Scan xy, displaced by 4.0 Å]( https://cloud.githubusercontent.com/assets/1672331/5621812/e36f4a08-94ee-11e4-94d8-29a6d65ced53.png "Scan methyl probe 4.0 Å displaced from base plane")

Purpose
========

We wanted to compare potentials of mean force of various atoms like a single methyl probe, water, adenosine, etc. around a fixed adenosine to explicit molecular dynamics solutions.


Code and Demo
=============

The code is in

` apps/public/rna_util/nucleobase_sample_around.cc`

with lots of helper functions in

` protocols/toolbox/sample_around/util.cc`

Demo files are in

`       Rosetta/demos/public/nucleobase_sample_around      `

References
==========
Unpublished.

Application purpose
===========================================

Make tables of interaction energies between an adenosine nucleobase and, say, 
 a simple carbon atom or phosphate as a probe.


Modes
=====
To sample a 'carbon' probe atom:

```
 nucleobase_sample_around   [-s a_RNA.pdb]
```

To sample a water (sampling all possible orientations and outputting Boltzmann summed free energies)

```
 nucleobase_sample_around   [-s a_RNA.pdb]  -sample_water  [ -extra_res /path/to/rosetta/main/database/chemical/residue_type_sets/fa_standard/residue_types/water/TP3.params ]
```

To sample a nucleobase

```
 nucleobase_sample_around   [-s a_RNA.pdb]  -sample_another_nucleobase   -copy_nucleobase_nucleobase_file double_A_ready_set.pdb
```

To sample an nucleobase, reading in a starting nucleobase-nucleobase pairing conformation.

```
 nucleobase_sample_around   [-s a_RNA.pdb]  -sample_another_nucleobase   -copy_nucleobase_nucleobase_file double_A_ready_set.pdb
```

Can now sample phosphates with the flags

```
 nucleobase_sample_around -sample_phosphate [-center_on_OP2]
```

The phosphate center is on the phosphorus atom, unless user specifies -center_on_OP2 . 
Note that due to some silliness in available variant types and the desire to use a phosphate from an actual nucleotide residue_type, the probe phosphate also has a floating C1'.

Recently added option

```
 -nucleobase g [or a,c,u]
```

which will use something other than adenosine as the central nucleotide to sample around


Plotting
=====


The plotting script is available in `Rosetta/tools/rna_tools/pdb_util/plot_contour.py`
```
plot_contour.py score_xy_0.table score_xy_0.png
plot_contour.py score_xy_1.5.table score_xy_1.5.png
plot_contour.py score_xy_3.table score_xy_3.png
plot_contour.py score_xy_4.table score_xy_4.png
```

Additional Information
======================
The previous hackathon results are summarized in the following slides
https://drive.google.com/file/d/0By0BpYZBGuK-R2dhcEpKN0E4d28/view?usp=sharing 


##See Also

* [[RNA applications]]: List of RNA applications
* [[Utilities Applications]]: List of utilities applications
* [[Tools]]: Python-based tools for use in Rosetta
* [[Application Documentation]]: Home page for application documentation
* [[RNA]]: Guide to working with RNA in Rosetta
* [[Fixbb]]: App commonly used for design and/or threading with proteins
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
