# CstInfoMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## CstInfoMover

[[include:mover_CstInfoMover_type]]

### Expected outputs.

Example scorefile output
```
SCORE: total_score CST_1_measure CST_1_score CST_2_measure CST_2_score CST_3_measure CST_3_score CST_4_measure CST_4_score CST_5_1_measure CST_5_1_score CST_5_2_measure CST_5_2_score CST_5_3_measure CST_5_3_score CST_5_4_1_measure CST_5_4_1_score CST_5_4_2_measure CST_5_4_2_score CST_5_4_3_measure CST_5_4_3_score CST_5_4_measure CST_5_4_score CST_5_5_measure CST_5_5_score CST_5_6_measure CST_5_6_score CST_5_measure CST_5_score description 
SCORE:       0.000        15.292       2.710        10.358       0.000         9.196       0.000         8.190       0.000          15.569         3.184          15.079         2.369          14.456         1.508            10.733           3.002             9.453           0.528             8.175           0.345           0.000         0.345          15.598         3.236          15.574         3.194         0.000       4.222 1a19_0001
```

The CstInfoMover will add additional score terms to the pose and scorefile. There will be two columns per score term. The 'measure' column for each term will report on what the geometric measurement of the constraint is, whereas the 'score' column will report on what the *unweighted* scoring for the constraint is, after function application.

Each scoreterm gets a unique label, depending on the position in the constraint file. For example CST_5_4_2_measure and CST_5_4_2_score are the two terms for a constraint in the constraint file which was given the prefix "CST". In this case, recursive was true, and it's a sub-sub constraint of a nested multi-constraint. Specifically, it's the fifth constraint in the file (which is a multi-constraint), and the fourth sub-constraint in the multi-constraint (a nested multi-constraint), and the second constraint in that nested multiconstraint. Further details will be printed to the tracer output.

Example tracer output:
```
protocols.simple_moves.CstInfoMover: ------------ Constraints read for file inputs/file1.cst-------------
protocols.simple_moves.CstInfoMover: # Constraint for 'CST_1' is:
protocols.simple_moves.CstInfoMover: AtomPair  CA    13  CA    23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: # Constraint for 'CST_2' is:
protocols.simple_moves.CstInfoMover: AtomPair  CA    16  CA    23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: # Constraint for 'CST_3' is:
protocols.simple_moves.CstInfoMover: AtomPair  N     18  CA    23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: # Constraint for 'CST_4' is:
protocols.simple_moves.CstInfoMover: AtomPair  CA    19  O     23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: # Constraint for 'CST_5' is:
protocols.simple_moves.CstInfoMover: KofNConstraint 3
protocols.simple_moves.CstInfoMover: AtomPair  CA    33  CA    23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: AtomPair  CA    36  CA    23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: AtomPair  N     38  CA    23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: AmbiguousConstraint
protocols.simple_moves.CstInfoMover: AtomPair  CA    36  CA    43 FLAT_HARMONIC 7 1 2
protocols.simple_moves.CstInfoMover: AtomPair  N     38  CA    43 FLAT_HARMONIC 4 2 4
protocols.simple_moves.CstInfoMover: AtomPair  CA    39  O     43 FLAT_HARMONIC 6 2 1
protocols.simple_moves.CstInfoMover: End_AmbiguousConstraint
protocols.simple_moves.CstInfoMover: AtomPair  CA    39  O     23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: AtomPair  CA    33  CA    43 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: End_KofNConstraint
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: # Constraint for 'CST_5_1' is:
protocols.simple_moves.CstInfoMover: AtomPair  CA    33  CA    23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: # Constraint for 'CST_5_2' is:
protocols.simple_moves.CstInfoMover: AtomPair  CA    36  CA    23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: # Constraint for 'CST_5_3' is:
protocols.simple_moves.CstInfoMover: AtomPair  N     38  CA    23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: # Constraint for 'CST_5_4' is:
protocols.simple_moves.CstInfoMover: AmbiguousConstraint
protocols.simple_moves.CstInfoMover: AtomPair  CA    36  CA    43 FLAT_HARMONIC 7 1 2
protocols.simple_moves.CstInfoMover: AtomPair  N     38  CA    43 FLAT_HARMONIC 4 2 4
protocols.simple_moves.CstInfoMover: AtomPair  CA    39  O     43 FLAT_HARMONIC 6 2 1
protocols.simple_moves.CstInfoMover: End_AmbiguousConstraint
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: # Constraint for 'CST_5_4_1' is:
protocols.simple_moves.CstInfoMover: AtomPair  CA    36  CA    43 FLAT_HARMONIC 7 1 2
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: # Constraint for 'CST_5_4_2' is:
protocols.simple_moves.CstInfoMover: AtomPair  N     38  CA    43 FLAT_HARMONIC 4 2 4
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: # Constraint for 'CST_5_4_3' is:
protocols.simple_moves.CstInfoMover: AtomPair  CA    39  O     43 FLAT_HARMONIC 6 2 1
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: # Constraint for 'CST_5_5' is:
protocols.simple_moves.CstInfoMover: AtomPair  CA    39  O     23 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: # Constraint for 'CST_5_6' is:
protocols.simple_moves.CstInfoMover: AtomPair  CA    33  CA    43 FLAT_HARMONIC 8 2 4
protocols.simple_moves.CstInfoMover: 
protocols.simple_moves.CstInfoMover: ----------------------------------------------------
```

Note that if you don't provide a constraint file (that is, you report on the in-pose constraints), you will need to refer to the tracer output for the definitions of each term, as there is no ordering guarantees for in-pose constraints. Additionally, if it's likely that there might be a different number of constraints for each structure, you may want to add the option `-out:file:scorefile_format json` to the commandline to get a JSON-formatted (rather than tabular text-formatted) scorefile, which performs better when each structure has a differing numbers of scoreterms.

##See Also

* [[Constraint Info]] - a command line version of the same functionality.
* [[PoseInfoFilter]] - another way in RosettaScripts to get constraint information - reports constraint details to the tracer.
* [[I want to do x]]: Guide to choosing a mover