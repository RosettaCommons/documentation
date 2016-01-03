# Special scoring terms developed for `stepwise`

### `other_pose`
Part-way through building full `stepwise` models, there may be multiple, distinct poses modeling different parts of the overall macromolecule. This score term (see `src/core/scoring/methods/OtherPoseEnergy`) is activated on the primary pose, and carries out scoring on poses held in the `other_pose_list`. The sums are tallied up into the total score for the primary pose.

### `loop_close`
Cost (in k<sub>B</sub>T) of closing loops of uninstantiated residues within pose, or cycles of such loops between pose and other_poses. Assumed a simple Gaussian Chain model, with persistence lengths for RNA/protein based on reasonable guesses.  Code for the model are given in `LoopClosureEnergy.cc` and `LoopGraph.cc` in `src/core/scoring/loop_graph/`.

There is an overall offset to this term that corresponds to the cost of confining one end of the loop within Rosetta precision... the value was set based on empirical values of RNA loop modeling energies, but may be way off. Should be possible to compute more rigorously from specialized Monte Carlo calculations.

More info in `src/core/scoring/GaussianChainFunc.cc`, including following crazy explanation:

```
//////////////////////////////////////////////////////////////////////////
// ---------------------------------
// Closure energies for loop cycles.
// ---------------------------------
//
//          D1
//       ------~
//      ~       | D4
//     ~        |
//    ~         ~
//    |        ~
// D2 |       /
//    |      /  D3
//     ~~~~~/
//
//  D1, D2, D3, D4 mark rigid joints, with lengths D1, ... D4.
//  Squiggles (~~~) mark gaussian chains,
//   with total variance of gaussian_variance.
//
//  In simplest case (one joint D, gaussian variance sigma^2 ):
//
//  P( closure ) = (capture volume) x ( 1 / 2 pi sigma^2 )^(3/2)
//                                  x exp( - D / 2 sigma^2 )
//
//  [For folks used to thinking about mean end-to-end distance L,
//        sigma^2 = L^2 / 3 ].
//
//  Following includes explicit formulae for one, two, three, and four joints.
//  There is also a general formula which would be straightforward to implement,
//  which I have worked out (and is basically implemented in the four-joint
//  function GaussianChainQuadrupleFunc.cc)
//
// See core/scoring/loop_graph/LoopGraph.cc for use case.
//
// More notes at:
//   https://docs.google.com/a/stanford.edu/file/d/0B6gpwdY_Bgd0OHdzVWJGTHBvTzg/edit
//
// Rhiju, Sep. 2013
//
//////////////////////////////////////////////////////////////////////////
```

*Advanced:* The energy function above can handle loops that start and end inside a given pose (a 'normal' loop) as well as loops that connect separate poses in the model into a 'cycle'. However, it fails when seeing cycles that are nested into each other, as can happen in the following:

```
   D1
  --------
  ~    ~  ~
 A~  B ~   ~ C
  ~    ~  ~
  --------
   D2
```
Here D1-A-D2-B-D1 and D1-A-D2-C-D1 could be nested (actually code looks at direction of loops). That means that the penalty for the first cycle (A,B) depends on the influence of C, leading to a complicated integral.  Those kinds of pose collections are avoided in `stepwise` by checking for "complex loop graphs" in StepWiseMoveSelector.cc. If user specifies `-allow_complex_loop_graph`, `loop_close` will be calculated as a simple sum of loop closure penalties over all cycles -- this is generally an underestimate. In principle, should be possible to approximate the integral by finding the optimal loop configuration given the geometry of connection points (requires numerical solution, but to a convex optimization problem) and computing a log-determinant, but that's not in there yet.


### `intermol`
The entropic penalty (in k<sub>B</sub>T) for each intermolecular connection that is instantiated. Computed as:
( 2.30 - log( concentration / 1 M).

Here the number 2.30 represents log of the effective concentration (relative to 1 M) of one strand relative to another when an interaction is formed. It was calibrated separately based on fits to the nearest-neighbor rules for RNA helix formation; it wil probably be updated later. The assumed reference concentration can be changed from the 'standard' value of 1 M with the flag `-score::conc <Real>`; give in units of molar.


### `free_side_chain`, `free_suite`, `free_2HOprime`
Bonuses for virtualizing protein side chains, RNA 5' phosphate, and RNA 2' hydroxyl, respectively. Also stuffing bonuses for virtualizing sugar in `free_suite`. These might all get combined into `free_dof` for simplicity, after further calibration.

---
Go back to [[StepWise Overview|stepwise-classes-overview]].

##See Also

* [[Stepwise options]]: Options classes for Stepwise code
* [[Stepwise]]: The StepWise MonteCarlo application
* [[Score types]]: Score functions and score terms in Rosetta
* [[Scoring explained]]: Explanation of scoring in Rosetta
* Applications for deterministic stepwise assembly:
  * [[Stepwise assembly for protein loops|swa-protein-main]]
    * [[Additional documentation|swa-protein-long-loop]]
  * [[RNA loop modeling with Stepwise Assembly|swa-rna-loop]]
* [[Structure prediction applications]]: Includes links to these and other applications for loop modeling
* [[RosettaScripts]]: The RosettaScripts home page
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
