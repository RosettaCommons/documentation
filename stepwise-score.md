# Special scoring Terms for stepwise

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

### `intermol`
The entropic penalty (in k<sub>B</sub>T) for each intermolecular connection that is instantiated. Computed as:
( 2.30 - log( concentration / 1 M).

Here the number 2.30 represents log of the effective concentration (relative to 1 M) of one strand relative to another when an interaction is formed. It was calibrated separately based on fits to the nearest-neighbor rules for RNA helix formation; it wil probably be updated later. The assumed reference concentration can be changed from the 'standard' value of 1 M with the flag `-score::conc <Real>`; give in units of molar.


### `free_side_chain`, `free_suite`, `free_2HOprime`
Bonuses for virtualizing protein side chains, RNA 5' phosphate, and RNA 2' hydroxyl, respectively. Also stuffing bonuses for virtualizing sugar in `free_suite`. These might all get combined into `ref` for simplicity, after further calibration.

---
Go back to [[StepWise Overview|stepwise-classes-overview]].

