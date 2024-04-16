#Relax application

Purpose
=======

Relax is the main protocol for simple all-atom refinement of structures in the Rosetta force-field. 
Relax does not do extensive refinement and only searches the local conformational space around the starting structure. 
Relax is thus often used in conjunction with more aggressive sampling protocols like fragment assembly (abinitio) and loop modelling. 
To evaluate different conformations based on their Rosetta all-atom score one usually has to apply relax.

It can also read centroid models, in which case it will convert the model into a fullatom model and pack the sidechains. Relax does not carry out any extensive refinement and only searches the local conformational space neighbourhood.

It is further advisable to apply relax only to previously idealized structures. Idealization avoids that score differences arise due to non-ideal geometry (e.g., at the position of former chain-breaks introduced during an aggressive sampling stage and removed by loop closing).

References
==========

Nivón LG, Moretti R, Baker D (2013) A Pareto-Optimal Refinement Method for Protein Design Scaffolds. PLoS ONE 8(4): e59004. [Paper](http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0059004)

P. Conway*, M. Tyka*, F. DiMaio*, D. Konerding and D. Baker (2013). Relaxation of backbone bond geometry improves protein energy landscape modeling.  Protein Science


Firas Khatib,Seth Cooper,Michael D. Tyka,Kefan Xu, Ilya Makedon,Zoran Popović,David Baker, and Foldit Players (2011). Algorithm discovery by protein folding game players PNAS 2011 108 (47) 18949-18953;

Tyka MD, Keedy DA, Andre I, Dimaio F, Song Y, et al. (2011) Alternate
states of proteins revealed by detailed energy landscape mapping.
Journal of molecular biology 405: 607–618.


Input
=====

Relax takes as input one or more structures in silent or PDB format. All JD2 options apply (see JD2 Documentation for more details)

FoldTree output
===============

Relax outputs one or more structures in silent or PDB format. All JD2 output options apply (see JD2 Documentation for more details) As always -nstruct regulates the number of outputs per input structure.

Command Line Options
====================

**Sample command**

```
relax.linuxgccrelease -database /path/to/rosetta/main/database -in:file:s input.pdb -in:file:fullatom -native 1a19.pdb -out:file:silent default.out -relax:quick
```

Relax can take all general file IO options common to all Rosetta applications written with JD2: (see JD2 documentation for details)

```
   -database                 Path to rosetta databases
   -in:file:s                Input pdb file(s)
   -in:file:silent           Input silent file
   -in:file:fullatom         Read as fullatom input structure
   -score:weights            Supply a different weights file from the Rosetta default
   -score:patch              Supply a different patch file from the Rosetta default
   -run:shuffle              Use shuffle mode, treat structures in random order
   -nstruct                  Make how many decoys per input structure ?
```

Options specific to relax

```
   Simple Options:
   -relax:fast               Do a simple, small cycle number (5)  fast relax (DEFAULT)
   -relax:thorough           Do a preset, large cycle number (15) fast relax

   Advanced Options:
   -relax:script <file>      Do custom script relax (you can supply a custom script file or a filename from database)
     -relax:jump_move false    Set all jumps to unmovable during minimization. 
     -relax:bb_move false      Set all backbone torsion angles to unmovable during minimization. 
     -relax:chi_move false     Set all chi torsion angles to unmovable during minimization. 
     -in:file:movemap          Read in custom move map (see **, can be used to specifically define which jumps, bb and chi torsion angles are movable and which ones are not. By default, all are movable. Definitions in the custom movemap override the more general jump_move, bb_move and chi_move commands above. ) If the BB is set to move in the middle of a chain, one may want to add the 'chainbreak' term at a value of 100 to the scorefunction weight set used - or relax may break the backbone.
     -relax:respect_resfile    Respect and use the resfile specified with the general option, -packing:resfile, during the packing step.  Added to allow design during the FastRelax protocol.  Does not work with relax:coord_constrain_sidechains.

   Constraints: If you want constraints on for the entire relax run, set ramp_constraints to false (below) along with the other constraint flags. Constraints can be provided using either the cst_fa_file or cst_file options. If both options are used, priority will be given to the cst_fa_file constraints. Default weights for the constraints are 0. Built in options include backbone coordinate constraints, sidechain coordinate constraints and sidechain pairwise constraints. 
   -constraints:cst_fa_file  <filename>      Add constraints from the fullatom constraint file(*)
     -constraints:cst_fa_weight <weight>       Weight to be used for the constraints in the cst_fa_file.
     -constraints:cst_file  <filename>         Add constraints from the constraint file(*)
     -constraints:cst_weight   <weight>        Weight to be used for the constraints in the cst_file.
   -relax:constrain_relax_to_start_coords    Add coordinate constraints to backbone heavy atoms, based on the input structure.
   -relax:constrain_relax_to_native_coords   Add coordinate constraints to backbone heavy atoms, based on the structure passed to -in:file:native.
   -relax:coord_constrain_sidechains         Also add coordinate constraints to sidechain heavy atoms (requires one of previous two options)
   -relax:coord_cst_stdev    <stdev>         Set the strength of coordinate constraints (smaller=tighter)
   -relax:coord_cst_width    <width>         If set, use flat-bottomed constraints instead of harmonic constraints, with a bottom width of <width>
   -relax:sc_cst_maxdist   <dist>            Add pairwise atom constraints to sidechain atoms up to dist apart from one another.
   -relax:ramp_constraints   false           When explicitly set to false, do not ramp down constraints (does not affect ramping in custom scripts). When true, constraints are ramped down during each simulated annealing cycle.
   -relax:dualspace true                     Use the Dualspace protocol for dihedral and cartesian minimization as described by Conway et al. Do 3 FastRelax cycles of internal coordinate relax followed by two cycles of Cartesian relax - cart_bonded energy term is required, pro_close energy term should be turned off, and use of -relax::minimize_bond_angles is recommended.  The -nonideal flag can be used for this.

   Deprecated Modes (don't use):
   -relax:classic            Do an old old deprecated "classic" relax mode (slow and poor performance)
```

(\*) See [[Constraint File Format|constraint-file]]

(\*\*) See [[Movemap File Format|movemap-file]]

Example
=======

The example above with input files can be found in demo/relax/ Just execute the run.sh script.

Results
=======

Relax returns full-atom relaxed structures. Relax is a general purpose protocol and used in many different applications where fullatom structures are required at the end. In most cases relax is the last step in a larger protocol and the lowest energy structures are of interest to the user.

Description of algorithm
========================

For virtually all situations it should be sufficient to use either -relax:quick or -relax:thorough and not worry about all the options.

The fast relax modes work by running many sidechain repack and minimisation cycles ramping up and down the repulsive weight of the forcefield. This sort of "pulses" the structure in successive collapse and expansion phases which "wiggles" the atoms into a low energy state. No explicit moves are done (this was found not to be useful as most moves are rejected and dont help lowering the energy). Not that despite that fact, the structure can change up to 2-3 A from the starting conformation during the minimisation cycles.

The basic principle of the relax protocol is to interlace packing of sidechains with gradient based minimization of torsional degrees of freedom.
A typical relax cycle consist of 4 rounds of repacking followed by gradient base minimization in torsion space. 
The repulsive contribution to the total energy is scaled to 2%, 25%, 55% and 100% in the 1st, 2nd, 3rd and last round, respectively. Relax can be run with a different number of cycles (default is 5) and from all cycles performed the best scoring pose is selected.

FastRelax is a more modern version of the initial fast relax algotihm which is more flexible and allows definition of a specific script of relax events (how exactly the repack and minimisation cycles are interlaced and what paramters they should take). This is defined in a script file. An example script file looks like this:

```
repeat 5
ramp_repack_min 0.02  0.01
ramp_repack_min 0.250 0.01
ramp_repack_min 0.550 0.01
ramp_repack_min 1     0.00001
accept_to_best
endrepeat
```

The above command chain would do 5 repeats of a ramp-profile of 0.02, 0.25, 0.550 and 1.0 of the repulsive weight. At each step a repack is followed by a minimisation with a tolerance of 0.01,0.01,0.01 and 0.00001 respectively. Over all the weight would pulse in this order 0.02, 0.25, 0.550, 1.0, 0.02, 0.25, 0.550, 1.0, 0.02, 0.25, 0.550, 1.0, 0.02, 0.25, 0.550, 1.0 ... The lowest energy structure encountered at the full weight is reported back at the end.

The above command was the default script until Aug 13, 2019,
when it then switched to this:

```
repeat 5
coord_cst_weight 1.0
scale:fa_rep 0.040
repack
scale:fa_rep 0.051
min 0.01
coord_cst_weight 0.5
scale:fa_rep 0.265
repack
scale:fa_rep 0.280
min 0.01
coord_cst_weight 0.0
scale:fa_rep 0.559
repack
scale:fa_rep 0.581
min 0.01
coord_cst_weight 0.0
scale:fa_rep 1
repack
min 0.00001
accept_to_best
endrepeat
```

NOTE: It should virtually never be necessary to mess with the preset script or parameters! Dont touch unless you know what you're doing!

You can run non-default relax scripts using the `-relax:script` option:

```sh
relax.linuxgccrelease -relax:script ./my_relax_script # local file

relax.linuxgccrelease -relax:script KillA2019 # database file (see below)
```

Relax Script Format description:
================================

Valid commands include:

```
repeat <loopcount>
```

starts a section to be repeated \<loopcount\> times - end the block with "endrepeat". Nested loop are NOT supported.

```
endrepeat
```

is the end marker of a loop. loops may *NOT* be nested! (this is not a programming language. well it is. but a very simple one.)

```
accept_to_best
```

compares the energy of the current pose and the best\_pose and replaces the best pose with the current pose if it's energy is lower.

```
load_best
```

Load the best\_pose into the current working pose, replacing it.

```
load_start
```

Load the starting pose into the current working pose, replacing it.

Sets the best\_pose to the current pose whatever the energy of the current pose.

```
dump <number>
```

Dumps a pdbfile called dump\_\<number\>.pdb

```
scale:<scoretype> <scale>
```

Scales the scoretype's default value by whatever the scale number is. For ex, scale:fa\_rep 0.1 will take the original fa\_rep weight and set it to 0.1 \* original weight.

```
weight:<scoretype> <weight>
```

Sets the weight of the scoretype to whatever the weight number is. ALSO CHANGES DEFAULT WEIGHT. This is so in weight, scale, scale routines the scale will be using the user-defined weight, which seems to make more sense. For ex, weight:fa\_rep 0.2 will take set fa\_rep to 0.2

```
show_weights
```

Outputs the current weights. If a parameter is not outputted, then its weight is 0. Most useful when redirecting stdout to a file, and only one input structure.

```
coord_cst_weight <scale>
```

Sets the coordinate\_constraint weight to \<scale\>\*start\_weight. This is used when using the commandline options -constrain\_relax\_to\_native\_coords and -constrain\_relax\_to\_start\_coords.

```
repack
```

Triggers a full repack

```
min <tolerance>
```

Triggers a dfp minimization with a given tolernace (0.001 is a decent value)

```
ramp_repack_min <scale:fa_rep> <min_tolerance> [ <coord_cst_weight = 0.0> ]
```

Causes a typical ramp, then repack then minimize cycle - i.e. bascially combines the three commands scale:fa\_rep, repack and min (and possible coord\_cst\_weight)

These two scripts are equivalent:

```
scale:fa_rep 0.5
repack
min 0.001
```

and

```
ramp_repack_min 0.5 0.001
```

```
batch_shave <keep_proportion>
```

Valid for batchrelax only - ignored in normal FastRelax In Batchrelax it will remove the worst structures from the current pool and leave only \<keep\_proportion\>. I.e. the command

```
batch_shave 0.75
```

Will remove the worst 75% of structures from the current working pool.

```
exit
```

will quit with immediate effect

A typical FastRelax script is:

```
repeat 5
ramp_repack_min 0.02  0.01     1.0
ramp_repack_min 0.250 0.01     0.5
ramp_repack_min 0.550 0.01     0.0
ramp_repack_min 1     0.00001  0.0
accept_to_best
endrepeat
```

Relax Scripts In Rosetta's Database
===================================

For a list of relax scripts in the database,
[click here](https://www.rosettacommons.org/docs/latest/scripting_documentation/RosettaScripts/Movers/movers_pages/RelaxScript).


Special Notes on BatchRelax
===========================

-   The -l flag (list of input PDBs) is treated differently by BatchRelax than most Rosetta applications. Instead of processing each entry in -l sequentially, all are pooled into one big batch. This has the advantage that BatchRelax can trim the pool irrespective of PDB input source, but the disadvantage that -l for sequential input is no longer available. If all PDB inputs to -l do not match in sequence or length, you will get strange crashes in PackRotamersMover due to invalid PackerTasks.

For developers only:
====================

For development and optimization, these options are also present. These are provided on a as-is basis with no guarantee of functionality or purpose. Use with care.

```
  Options specific to the fast relax mode (normally you don't need to meddle with these!)

   -relax:script                Script file
   -relax:script_max_accept     Limit number of best accepts, default = 10000000
```

##See Also

* [[Preparing structures]]: Page on preparing structures for use in Rosetta using relax.
* [[Structure prediction applications]]: A list of other applications to be used for structure prediction
* [[Design applications]]: A list of other applications that can be used for design.
* [[FastRelaxMover]]: Using relax with RosettaScripts
* [[FastDesignMover]]: Using relax (with extra design options) with RosettaScripts
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
