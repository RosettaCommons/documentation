# Approximate Buried Unsatisfied Penalty (approximate_buried_unsatisfied_penalty) 

<i>Note:  This term is almost exactly the same as the [[buried_unsatisfied_penalty|rosetta_basics/scoring/BuriedUnsatPenalty]]. See that page for the motivation. This page is to describe the usage.</i>
[[_TOC_]]

Author: Brian Coventry (2018)

## Short description

This is a term to penalize buried unsats. 

Burial is defined as XÅ below the molecular surface as defined by the molecular surface. The pose is mutated to poly-leu before this calculation so that the depth is sequence independent.

Satisfaction is defined as having 1-2 hbonds for all buried polar atoms. (2-3 for NH3 groups)

This term performs an N-body pre-calculation step applying simple rules (see How It Works) to generate 1-body and 2-body energy tables. These energy tables are then loaded into the packer such that this term appears to be pairwise decomposable during packing.

This term is not perfect however. See caveats.


## Usage

This is the suggested usage at the time of writing (2018):

```xml
<SCOREFXNS>
    <ScoreFunction name="sfxn" weights="beta_nov16" >
        <Reweight scoretype="approximate_buried_unsat_penalty" weight="5.0" />
        <Set approximate_buried_unsat_penalty_hbond_energy_threshold="-0.5" />
        <Set approximate_buried_unsat_penalty_burial_atomic_depth="4.0" />
        # Set this to false if you don't know where you might want prolines
        <Set approximate_buried_unsat_penalty_assume_const_backbone="true" />
    </ScoreFunction>
</SCOREFXNS>
```

This is the full option list: (Options not listed above were set to default values)
```xml
<SCOREFXNS>
    <ScoreFunction name="sfxn" weights="beta_nov16" >
        <Reweight scoretype="approximate_buried_unsat_penalty" weight="5.0" />
        <Set approximate_buried_unsat_penalty_hbond_energy_threshold="-0.5" />
        <Set approximate_buried_unsat_penalty_burial_atomic_depth="4.0" />
        <Set approximate_buried_unsat_penalty_burial_probe_radius="2.3" />
        <Set approximate_buried_unsat_penalty_burial_resolution="0.5" />
        <Set approximate_buried_unsat_penalty_oversat_penalty="1.0" />
        <Set approximate_buried_unsat_penalty_assume_const_backbone="true" />
    </ScoreFunction>
</SCOREFXNS>
```

The options above may also be set from the commandline with:
-score:approximate_buried_unsat_penalty_\<name_of_option\> value

Additionally, if one is using this term with the intention of eliminating <b>all</b> buried unsats. It would be wise to additionally use the [[PruneBuriedUnsats|scripting_documentation/RosettaScripts/TaskOperations/taskoperations_pages/PruneBuriedUnsatsOperation]] task operation.

## Option definitions

* approximate_buried_unsat_penalty_hbond_energy_threshold - default -0.25 - Energy threshold for a h-bond to be considered satisfying a buried polar. Should be a negative number. (Setting to -0.001 will be much faster than 0 at runtime) 
* approximate_buried_unsat_penalty_burial_atomic_depth - default 4.5 - The atomic depth cutoff to determine whether or not a polar atom is buried. Measured from the Sasa surface.
* approximate_buried_unsat_penalty_burial_probe_radius - default 2.3 - The probe radius for the atomic depth calculation.
* approximate_buried_unsat_penalty_burial_resolution - default 0.5 - The resolution for the atomic depth calculation.
* approximate_buried_unsat_penalty_oversat_penalty - default 1.0 - The penalty between atoms that both satisfy the same atom. If we let X = weight_of_approximate_buried_unsat_penalty. Then in general, a buried unsat is worth X, a satisfied unsat is worth 0, a doubly satisfied unsat is worth X * ( setting-1.0 ), a triply satisfied unsat is worth X * ( -2 + 3 * setting ), a N-ly satisfied unsat is worth X * ( 1 - N + 0.5 * N * (N - 1) ).
* approximate_buried_unsat_penalty_assume_const_backbone - default true - Should we assume that the backbone atoms will not change during a packing trajectory? (i.e. no positions that include normal aa and proline or n-methyl) If set to false, this energy method takes longer to compute. (~ 2X as long)

## Justification for suggested usage parameters
This is pretty hand-wavy. But I think more information is better than less information!

* approximate_buried_unsat_penalty_hbond_energy_threshold - suggested -0.5 - Below this cutoff, Rosetta will allow hbonds that really stretch the definition of an hbond. One would prefer the method return good hbonds
* approximate_buried_unsat_penalty_burial_atomic_depth - suggested 4.0 - With the new VBUNS definition set to 5.5 (see BuriedUnsatFilter), one needs a buffer region such that if the pose moves during minimization, new unsats to not appear
* approximate_buried_unsat_penalty_burial_probe_radius - suggested 2.3 - Found through trial and error. With the poly-leucine pose, this is the number that still enters shallow pockets but doesn't infiltrate the core
* approximate_buried_unsat_penalty_burial_resolution - suggested 0.5 - The atomic depth gets recalculated for every scorefunction invocation. Give up a bit of resolution (compared to 0.25) for speed.
* approximate_buried_unsat_penalty_oversat_penalty - suggested 1.0 - Changing this has weird behavior.
* approximate_buried_unsat_penalty_assume_const_backbone - suggested true - This is the suggested default because in many cases, people aren't designing with prolines and setting this to false makes the energy term take twice as long.

## How it works

(Tell Brian to fix this section)

Brian ran out of time to write this. The following is an excerpt from github. The basic idea however is that this term does not explicitly model the satisfaction of buried atoms but rather infers it through a set of rules. These rules must be calculated in the context of all rotamers (before packing), but can suprisingly be broken down into one-body and two-body terms. These one and two-body terms have the emergent property that the number of hbonds to a buried unsat leaves a quadratic fit to satisfaction as given by the following table:

```
hbonds:  0     1      2      3      4      5      6      7
score:   1     0      0      1      3      6      10     15
```

Github:

Although the term can be broken down into a pair-wise decomposable score term. It is not calculated as such. It is actually calculated in an N-body context (during prepare_for_packing_with_rotsets()), but the scores that are calculated can be applied in a pairwise manner. This will become very evident in the Failure Case below.

For the moment, we'll pretend that all atoms I'm going to talk about are on rotamers that can repack. Things get a bit more complicated if some of the atoms are on non-packable residues or on the backbone (which I'll explain at the end).

---------------------------------------------------------------------------

There are three types of scores that can be applied:

1. Buried polar

2. H-bond to buried polar

3. Oversat between two h-bonders to a buried polar



Additionally, there are three ways a score can be applied:

1. Twobody -- the term is applied only if two rotamers exist at the same time

2. Onebody -- the term is applied if this rotamer exists

3. Zerobody -- the term is always applied (because the rotamer isn't packable)

How are the bonuses and penalties applied?

1. Buried polar

* Every single atom that can participate in h-bonding and is buried applies a Onebody penalty of +1 to the rotamer that contains the atom.

2. H-bond to polar atom

* Every single atom that can participate in an h-bond to a buried polar atom adds a Twobody bonus of -1 to the edge of the two h-bonders (the buried rotamer and the satisfying rotamer)

3. Oversat between two h-bonders to a buried polar

* For a given buried polar, pairs of atoms that h-bond to it receive a Twobody penalty of +1 on their edge.

-----------------------------------------------------------------

Let's see how this plays out in the 1 buried acceptor with 10 residues around it.

-----------------------------------------------------------------

Case 0: 0 h-bonds

BuriedA  --             10 unused residues

Case 0 scoring:

1. Buried polar -- there is 1 buried polar so +1

2. H-bonds to buried polar -- there are no h-bonds to the buried polar -0

3. Oversats -- There were no-hbonds so no oversats +0

Case 0 score: +1

-----------------------------------------------------------------

Case 1:

BuriedA  --  HB            9 unused residues

Case 1 scoring:

1. Buried polar -- there is 1 buried polar so +1

2. H-bonds to buried polar -- there is 1 h-bond to the buried polar -1

3. Oversats -- There was 1 h-bonder (0 oversat pairs) so oversats +0

Case 1 score: + 0

-----------------------------------------------------------------

Case 2:

BuriedA  --  HB  HB           8 unused residues

Case 2 scoring:

1. Buried polar -- there is 1 buried polar so +1

2. H-bonds to buried polar -- there are 2 h-bonds to the buried polar -2

3. Oversats -- There were 2 h-bonders (1 oversat pair) so oversats +1

Case 2 score: + 0

------------------------------------------------------------------------

Case 3:

BuriedA  --  HB  HB           8 unused residues

Case 3 scoring:

1. Buried polar -- there is 1 buried polar so +1

2. H-bonds to buried polar -- there are 3 h-bonds to the buried polar -3

3. Oversats -- There were 3 h-bonders (3 oversat pairs) so oversats +3

Case 3 score: + 1

-----------------------------------------------------------------------------

Case 10:

BuriedA  --  HB  HB  HB  HB  HB  HB  HB  HB  HB  HB           0 unused residues

Case 10 scoring:

1. Buried polar -- there is 1 buried polar so +1

2. H-bonds to buried polar -- there are 10 h-bonds to the buried polar -10

3. Oversats -- There were 10 h-bonders (45 oversat pairs) so oversats +45

Case 10 score: + 36

-----------------------------------------------------------------------------

Failure case: -- This is case 2, but the packer decided to pack only the two h-bonders and *not* the buried acceptor

( nothing ) -- HB  HB      8 unused residues

Failure case scoring:

1. Buried polar -- there are 0 buried polars so +0

2. H-bonds to buried polar -- there are 0 h-bonds to the buried polar -0

3. Oversats -- There were 2 h-bonders (1 oversat pairs) so oversats +1

Failure case score: + 1

The failure case demonstrates that:

1. This truly is a Twobody term (The oversat penalty is still applied even though the buried polar isn't there and the h-bonds don't actually exist.)

2. The ScoreTerm is an approximation (Clearly it came to the wrong conclusion here)

----------------------------------------------------------------------------------

What if some of the atoms are part of the backbone/non-packable?

There is a relatively straightforward way to handle this. One simply reduces the order of the *Body term and applies the penalty/bonus to the repackable residue.

Example -- the buried polar atom is part of the backbone and everything else is packable

1. It's burial penalty is converted from OneBody to ZeroBody and the penalty is applied to the total score

2. H-bonders to this polar atom have their edges converted from TwoBody to OneBody and they receive the total bonus as a OneBody energy.

3. Oversats to this polar atom are all still packable, so they get the penalty applied on their TwoBody edges

And then one can imagine where this entire scoring scheme happens in non-packable territory. In this situation, all penalties and bonuses are converted to ZeroBody energies and applied to the total score.


## Caveats

(Tell Brian to fix this section)

Serines, which may accept 3 hbonds in nature, are forced to accept 1-2 hbonds here.

The oversaturation penalty is applied even if the buried atom is not present. (The situation is not as bad as one might imagine though. Suppose that two rotamers A and B satisfy a buried serine. The serine will have at least 10 rotamers that are all satisfied by A and B. If this score term were naively coded, A and B would have an oversaturation penalty of 10+ because they do not check for the existence of the serine. The code is smart enough however to count this as a penalty of 1. (It takes the max oversaturation penalty that occurs because of a rotamer at each sequence position))

## Visualizing the burial region

The following python code may be used to visualize the burial region:

```python
import pyrosetta
pyrosetta.init()

pose = pyrosetta.pose_from_file("my_pose.pdb")

probe_radius = 2.3
depth = 5.5
resolution = 0.5

atomic_depth = pyrosetta.rosetta.core.scoring.atomic_depth.AtomicDepth( pose, probe_radius, True, resolution )

atomic_depth.visualize_at_depth( depth, "my_atomic_depth.pdb.gz" )

```
