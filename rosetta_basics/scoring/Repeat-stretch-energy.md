# Repeat stretch energy (aa_repeat_energy)
Documentation by Vikram K. Mulligan (vmullig@uw.edu), Baker Laboratory.
Last modified 4 November 2017.

## Description of score term
The repeat stretch score term (**aa_repeat**) is a wholebody energy that assigns a penalty to a pose based on its sequence.  Specifically, it penalizes long stretches in which the same residue type repeats over and over (e.g. poly-Q sequences).  This is currently only useful for filtering a design after a packing run, but the ultimate goal is to get it working with a modified form of the packer that permits packing with non-pairwise-decomposable scoring terms that can be computed quickly.

## Typical usage
The **aa_repeat_energy** scoring term can be added to any existing scoring function (*e.g.* **ref2015.wts**), and should work "out of the box" with both canonical and noncanonical amino acids.  It imposes a penalty for each stretch of repeating amino acids, with the penalty value depending nonlinearly on the length of the repeating stretch.  By default, 1- or 2-residue stretches incur no penalty, 3-residue stretches incur a penalty of +1, 4-residue stretches incur a penalty of +10, and 5-residue stretches or longer incur a penalty of +100.  Since the term is sequence-based, it is really only useful for design -- that is, it will impose an identical penalty for a fixed-sequence pose, regardless its conformation.  This also means that the term has no conformational derivatives: the minimizer ignores it completely.  The term is not pairwise-decomposible, but has been made packer-compatible, so it can direct the sequence composition during a packer run.

## Controlling the penalty values
The penalty assigned to a stretch of N repeating residues is determined based on a database file.  By default, the file used is:
```
database/scoring/score_functions/aa_repeat_energy/default_repeat_penalty_table.rpt_pen
```
This is what this file looks like:
```
# The series of numbers below indicates the penalty for having 1, 2, 3, etc. of the same residue in a row.
# Zero residues (empty poses) are not penalized.  More than the number of residues listed results in the 
# last penalty being imposed.  (For example, in this file, a repeat stretch of more than five residues will
# be given a penalty of 100).
0.0 0.0 1.0 10.0 100.0
```
The lines starting with a pound sign (**#**) are ignored.  The relevant line is the row of numbers, which represent the penalty for a 1-, 2-, 3-, 4-, or 5-residue stretch.  Stretches longer than 5 residues are assigned the 5-residue stretch penalty.  The user may provide a custom **.rpt_pen** file using the ```-aa_repeat_energy_penalty_file <filename>``` flag.  Custom **.rpt_pen** files may have as many penalty values as the user wishes (*i.e.* 5-residue stretches are not the limit).  Stretches longer than the longest specified will be assigned the penalty given to the longest specified.

## Organization of the code
- The scoring method lives in ```core/scoring/methods/AARepeatEnergy.cc``` and ```core/scoring/methods/AARepeatEnergy.hh```.
- The whole-body energy is evaluated by the ```AARepeatEnergy::finalize_total_energy()``` function, which takes a pose as input.
- This function calls ```AARepeatEnergy::calculate_aa_repeat_energy()```, which takes a vector of const owning pointers to **Residue** objects as input and returns a whole-pose energy value.  This function can be called by external code.
- A unit test is located in ```source/test/core/scoring/methods/AARepeatEnergy.cxxtest.hh```.  This test first scores the trp cage miniprotein, which has a three-proline repeat sequence.  It then adds polyalanine repeat sequences to the end of the trp cage and repeats the scoring, confirming that the expected score value results each time.

## See also
* [[AACompositionEnergy]]
* [[NetChargeEnergy]]
* [[BuriedUnsatPenalty]]
* [[HBNetEnergy]]
* [[VoidsPenaltyEnergy]]
* [[Design-centric guidance terms|design-guidance-terms]]
