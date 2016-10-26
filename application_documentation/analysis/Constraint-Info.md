#Constraint Info

Description of algorithm
========================

[[Rosetta constraints|constraint-file]] are useful for adjusting the energy landscape of a simulation, either to bias the simulation against particular "bad" structures, or to incorporate experimental data into the simulation. However, the standard output of constrained protocols is to give just a final energy value for the constraints, rather than a more specific constraint-by-constraint breakdown of how the structures perform on each constraint.

The cst_info application takes a constraint file and one or more structures, and then outputs in tabular form a summary of how each structure performs on each constraint - both in terms of Rosetta energy, as well as in the raw geometric metric that the constraint is calculated over.

Input
=====

Observes standard input flags (e.g. -in:file:s, -in:file:silent, etc.). Multiple input structures may be specified.

The name of the [[constraint file]] you wish to use is specified with -constraints::cst_file or -constraints::cst_fa_file 

The name of the output file is specified with -out:file:scorefile

Output
===============

A whitespace-separated table with columns for both the *un-weighted* score of each constraint, as well as the geometric metric calculated by each constraint (or zero, if the metric cannot be summarized by a single number). 

Sample Output:

```
SCORE: total_score       score  CstFile1_1_measure CstFile1_1_score CstFile1_2_measure CstFile1_2_score CstFile1_3_measure CstFile1_3_score CstFile1_4_measure CstFile1_4_score CstFile1_5_1_measure CstFile1_5_1_score CstFile1_5_2_measure CstFile1_5_2_score CstFile1_5_3_measure CstFile1_5_3_score  CstFile1_5_measure CstFile1_5_score description 
SCORE:       0.000       0.000              21.366           21.930             13.066            0.284              8.035            0.000              9.106            0.000               15.080              2.371               12.417              0.044                9.134              0.000               0.000            0.044 S_0001_1234
SCORE:       0.000       0.000              16.637            5.376             11.355            0.000              9.118            0.000             12.034            0.000               15.228              2.605               16.347              4.725               12.973              0.237               0.000            1.702 S_0002_0533
```

Each constraint has two corresponding columns, a 'measure' column, which gives the raw geometric measure, and the 'score' column, which gives the (unweighted) score for each constraint. Multi-constraints (e.g. ambiguous constraints, KofN constraints, etc.) will have additional sub-headings (e.g. CstFile1_5_2_measure) corresponding to the individual subconstraints within the multiconstraint. 

In the tracer output (the text printed to the terminal), the definition for each constraint type should be printed

```
protocols.simple_moves.CstInfoMover: ------------ Constraints read for file inputs/file1.cst-------------
protocols.simple_moves.CstInfoMover: # Constraint for 'CstFile1_1' is:
protocols.simple_moves.CstInfoMover: AtomPair  CA    13  CA    23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: # Constraint for 'CstFile1_2' is:
protocols.simple_moves.CstInfoMover: AtomPair  CA    16  CA    23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: # Constraint for 'CstFile1_3' is:
protocols.simple_moves.CstInfoMover: AtomPair  N     18  CA    23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: # Constraint for 'CstFile1_4' is:
protocols.simple_moves.CstInfoMover: AtomPair  CA    19  O     23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: # Constraint for 'CstFile1_5' is:
protocols.simple_moves.CstInfoMover: KofNConstraint 2
protocols.simple_moves.CstInfoMover: AtomPair  CA    33  CA    23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: AtomPair  CA    36  CA    23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: AtomPair  N     38  CA    23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: End_KofNConstraint
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: # Constraint for 'CstFile1_5_1' is:
protocols.simple_moves.CstInfoMover: AtomPair  CA    33  CA    23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: # Constraint for 'CstFile1_5_2' is:
protocols.simple_moves.CstInfoMover: AtomPair  CA    36  CA    23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: # Constraint for 'CstFile1_5_3' is:
protocols.simple_moves.CstInfoMover: AtomPair  N     38  CA    23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: ----------------------------------------------------
```

For example, for this output, the CstFile1_2_measure being 13.066 means that the distance between residue 16 atom CA and residue 23 atom CA (`AtomPair  CA    16  CA    23`) is 13.066 Ang. When converted to a score with the corresponding function, (`FLAT_HARMONIC 8 2 4`) the corresponding (unweighted) score is given by the CstFile1_2_score: 0.284.

Caveats and Notes
=================

The order of the constraints in the output scorefunction should match the order of the constraints in the input constraint file, however it's best to double check the ordering in the tracer output.

The score values given by the table will be for the *unweighted* (unity weighted) score values, and will not be affected by any passed scorefunction option.

Command Lines
====================

Sample command:

```
cst_info.linuxgccrelease -in:file:s input.pdb -constraints:cst_fa_file fullatom.cst -out:file:scorefile cstinfo.sc
```

Example
=======

See the integration test at rosetta/main/tests/integration/tests/cst_info for an example.

##See Also
* [[Constraint File Format|constraint file]]: The documentation for the Rosetta constraint file
* [[CstInfoMover]]: A RosettaScripts interface to this functionality.
* [[Analysis applications | analysis-applications]]: other design applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs

