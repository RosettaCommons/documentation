#Docking Protocol (RosettaDock)

Metadata
========

Authors:
Brian Weitzner (brian.weitzner@jhu.edu), Monica Berrondo (mberron1@jhu.edu), Krishna Kilambi (kkpraneeth@jhu.edu), Robin Thottungal (raugust1@jhu.edu), Sidhartha Chaudhury (sidc@jhu.edu), Chu Wang (chuwang@gmail.com), Jeffrey Gray (jgray@jhu.edu)

Last edited 7/17/2017 by Nick Marze. Corresponding PI Jeffrey Gray (jgray@jhu.edu).

An introductory tutorial of protein-protein docking can be found [here](https://www.rosettacommons.org/demos/latest/tutorials/Protein-Protein-Docking/Protein-Protein-Docking).

[[_TOC_]]

Code and Demo
=============

-   Application source code: `        rosetta/main/source/src/apps/public/docking/docking_protocol.cc       `
-   Main mover source code: `        rosetta/main/source/src/protocols/docking/DockingProtocol.cc       `
-   To see demos of some different use cases see integration tests located in `        rosetta/main/tests/integration/tests/docking*       ` (docking\_full\_protocol, docking\_local\_refine, docking\_local\_refine\_min, docking\_low\_res, docking\_distance\_constraint, docking\_site\_constraint).

To run docking, type the following in a commandline:

```
[path to executable]/docking_protocol.[platform|linux/mac][compile|gcc/ixx]release –database [path to database] @options
```

Note: these demos will only generate one decoy. To generate a large number of decoys you will need to add –nstruct N (where N is the number of decoys to build) to the list of flags.

References
==========

We recommend the following articles for further studies of RosettaDock methodology and applications:

-   Gray, J. J.; Moughon, S.; Wang, C.; Schueler-Furman, O.; Kuhlman, B.; Rohl, C. A.; Baker, D., Protein-protein docking with simultaneous optimization of rigid-body displacement and side-chain conformations. Journal of Molecular Biology 2003, 331, (1), 281-299.
-   Wang, C., Schueler-Furman, O., Baker, D. (2005). Improved side-chain modeling for protein-protein docking Protein Sci 14, 1328-1339.
-   Wang, C., Bradley, P. and Baker, D. (2007) Protein-protein docking with backbone flexibility. Journal of Molecular Biology, 2007 Oct 19;373(2):503-19. Epub 2007 Aug 2.
-   S. Chaudhury & J. J. Gray, "Conformer selection and induced fit in flexible backbone protein-protein docking using computational and NMR ensembles," J. Mol. Biol. 381(4), 1068-1087 (2008). [[Online|http://dx.doi.org/10.1016/j.jmb.2008.05.042]]
-   Chaudhury, S., Berrondo, M., Weitzner, B. D., Muthu, P., Bergman, H., Gray, J. J.; (2011) Benchmarking and analysis of protein docking performance in RosettaDock v3.2. PLoS One, Accepted for Publication
-   Marze, N. A., Jeliazkov, J. R., Roy Burman, S. S., Boyken, S. E., DiMaio, F., Gray, J. J.; (2016) Modeling oblong proteins and water-mediated interfaces with RosettaDock in CAPRI rounds 28-35. Proteins, 2016 Oct 24;85(3):479-486.


Application purpose
===========================================

Determine the structure of protein-protein complexes by using rigid body perturbations of the protein chains.

Algorithm
=========

**The following description has been adapted from Chaudhury, et al., 2011, PLoS One:**

RosettaDock is a Monte Carlo (MC) based multi-scale docking algorithm that incorporates both a low-resolution, centroid-mode, coarse-grain stage and a high-resolution, all-atom refinement stage that optimizes both rigid-body orientation and side-chain conformation. The algorithm roughly follows the biophysical theory of an encounter complex formation followed by a transition to a bound state. Typically the algorithm starts from either a random initial orientation of the two partners (global docking), or an initial orientation that is randomly perturbed from a user-defined starting pose (local perturbation). From there, the partner proteins are represented coarsely, where side chains are replaced by a single unified pseudo-atom, or centroid. During this phase, a 500-step Monte Carlo search is made with adaptive rotation and translational steps adjusted dynamically to achieve an acceptance rate of 25%. The ScoreFunction used in this stage primarily consists of a ‘bump’ term, a contact term, and docking-specific statistical residue environment and residue-residue pair-wise potentials.

Once the centroid-mode stage is complete, the lowest energy structure accessed during that stage is selected for high-resolution refinement. During high-resolution refinement, centroid pseudo-atoms are replaced with the side-chain atoms at their initial unbound conformations. Then 50 Monte Carlo+Minimization (MCM) steps are made in which:

1.  The rigid-body position is perturbed by a random direction and magnitude specified by a Gaussian distribution around 0.1 Å and 3.0˚
2.  The rigid-body orientation is energy-minimized
3.  The side-chain conformations are optimized with RotamerTrials, followed by a test of the Metropolis criteria.

Every eight steps, an additional combinatorial side-chain optimization is carried out using the full side-chain packing algorithm, followed by an additional Metropolis criteria check. To reduce the time devoted to the computationally expensive energy-minimization for unproductive rigid-body moves, minimization is skipped if a rigid-body move results in a change in score of greater than +15. The all-atom score function used in this stage primarily consists of Van der Waals attractive and repulsive terms, a solvation term, an explicit hydrogen bonding term, a statistical residue-residue pair-wise interaction term, an internal side-chain conformational energy term, and an electrostatic term.

For particular targets, a variety of RosettaDock sampling strategies are often used to improve the chance of achieving an accurate structure prediction. If no prior structural or biochemical information is known about the protein interaction of interest, global docking is used to randomize the initial docking poses. From there, score filters and clustering are used to identify clusters of acceptable low-energy structures for further docking and refinement. In most cases, there is some known information about the complex, either in the form of related protein complexes or in biochemical or bioinformatics data which identify probable regions of interaction on the protein partners. In these cases users manually arrange the starting docking pose to a configuration that is compatible with the information and carry out a local docking perturbation. Additionally, users can set distance-based filters that bias sampling towards those docking poses that are compatible with specified constraints.

Modes
-----

-   **Full protocol** - The full protocol involved first exploring the conformational space of the partners through a low resolution search followed by all-atom local refinement through a Monte Carlo+Minimization algorithm.
-   **Low Resolution Docking Only** - The protein is represented as backbone plus centroid representation of sidechains, i.e. the sidechain is represented as one giant atom to save CPU time. In this stage RosettaDock attempts to find the rough orientation of the docking partners for the high-resolution search.
-   **High Resolution Docking Only (Local Refinement)** - All atoms in the protein are represented, and the position found in the low-resolution search is optimized. Rigid body MCM is alternated with sidechain repacking so that the sidechains can adjust to a new, more favorable orientation and vice versa. The high-resolution stage uses up the most CPU time of Rosetta.
-   **Local High Resolution Minimization** - Similar to Local refinement, all atoms in the protein are represented. A single run of minimization, as opposed to a series of Monte Carlo+Minimization cycles, is done to minimize the energy of the rigid body position. Minimization is followed by side-chain packing.
-   **Global or local docking** can be achieved by using different starting perturbation flags to generate a starting structure from the input structure.
    - Global docking entails randomizing the initial partner positions followed by a low-resolution phase, high-resolution phase, and minimization phase (i.e. the full protocol).
    - Local docking should not randomize the initial protein positions, but should include a low-resolution phase, high-resolution phase, and minimization phase.

Input Files
===========

The only required input file is a [[prepacked pdb file|docking-prepack-protocol]] containing two proteins with different chain IDs. Starting structures must be prepacked because the side chains are only packed at the interface during docking. Running docking prepack protocol ensures that the side chains outside of the docking interface have a low energy conformation which provides a better reference state for scoring. For more information on prepacking, see the [[Docking Prepack protocol documentation.|docking-prepack-protocol]]

**Note:** The following flags should be given to every docking simulation: -ex1 -ex2aro.

If you are using a starting structure with more than two polypeptide chains, you should include the -partners flag. If this flag is omitted, docking will dock the first two polypeptide chains in the strucutre.

**Note:** An ensemble of input structures can be given using the follow flags: `-ensemble1 [partner_1_pdb_list]` or/and `-ensemble2 [partner_2_pdb_list]`. This ensemble file should be generated using docking_prepack_protocol. It contains a list of prepacked pdbs followed by the probabilities of swapping them.

Standard Docking options
========================


Basic protocol options
-------------------------

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-partners [P1\_P2]|Defines docking partners by chain ID for multichain docking. For example, "-partners LH\_A" moves chain A around the dimer of chains L and H.|String|

Starting Perturbation Flags
---------------------------

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-randomize1|Randomize the orientation of the first docking partner. (Only works with 2 partner docking). (Global).|Boolean|
|-randomize2|Randomize the orientation of the second docking partner. (Only works with 2 partner docking). (Global).|Boolean|
|-spin|Spin a second docking partner around axes from center of mass of the first partner to the second partner. (Global).|Boolean|
|-dock\_pert [T] [R]|To create a starting strucutre from the input structure, randomly perturb the input structure using a gaussian for translation and rotation with standard deviations [T] and [R]. Recommended usage is "-dock\_pert 3 8". (Global and Local).|RealVector|
|-uniform\_trans [R]|Uniform random repositioning of the second partner about the first partner within a sphere of the given radius, [R].|Real|
|-use\_ellipsoidal\_randomization true|Randomizes docking partners about ellipsoids rather than spheres. Recommended in all cases, but especially when docking partners are elongated or flattened. To be used in concert with -randomize1 and/or -randomize2. (Global)|Boolean|

Packing Flags
-------------

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-norepack1|Do not repack the sidechains on the first docking partner. (Only works with 2 partner docking).|Boolean|
|-norepack2|Do not repack the sidechains on the second docking partner.|Boolean|
|-sc\_min|Perform extra side chain minimization steps during packing steps.|Boolean|

Full Protocol Flags
-------------------

Default mode of docking. No additional flags necessary.

Low Resolution Docking Only Flags
---------------------------------

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-low\_res\_protocol\_only|Only run the low resolution part of the protocol (skips all high resolution steps and only outputs low resolution structure).|Boolean|

High Resolution Docking Only Flags
----------------------------------

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-docking\_local\_refine|Refine the docking position in high resolution only (skips all low resolution steps of the protocol). Uses small perturbations of the positions, no large moves.|Boolean|

Local High Resolution Minimization Flags
----------------------------------------

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-docking\_local\_refine|Refine the docking position in high resolution only (skips all low resolution steps of the protocol). Uses small perturbations of the positions, no large moves.|Boolean|
|-dock\_min|Does a single round of minimization in high resolution, skipping the mcm protocol.|Boolean|

Relevant common Rosetta Flags
-----------------------------

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-s [S] OR -silent [S]|Specify the file name of the starting structure, [S] (in:file:s for PDB format, in:file:silent for silent file format).|String|
|-native [S]|Specify the file name of the native structure, [S], for which to compare in RMSD calculations. If a native file is not passed in, all calculations are done using the starting structure as native.|String|
|-nstruct [I]|Specify the number of decoys, [I], to generate.|Integer|
|-database [P]|The path to the Rosetta database (e.g. /path/to/rosetta/main/database).|String|
|-use\_input\_sc|Use accepted rotamers from the input structure between Monte Carlo+Minimization (MCM) cycles. Unlike the -unboundrot flag from Rosetta++, not all rotamers from the input structure are added each time to the rotamer library, but only those accepted at the end of each round the remaining conformations are lost.|Boolean|
|-ex1/-ex1aro -ex2/-ex2aro -ex3 -ex4|Adding extra side-chain rotamers (highly recommended). The -ex1 and -ex2aro flags were used in our own tests, and therefore are recommended as default values.|Boolean/Integer|
|-constraints:cst\_file [S]|Specify the name of the [[constraint file]], [S]. |String|

Expert Flags
------------

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-dock\_mcm\_trans\_magnitude [T]|The magnitude of the translational perturbation during MCM steps in docking in Angstroms. Defaults to 0.7 Å |Real|
|-dock\_mcm\_rot\_magnitude [R]|The magnitude of the rotational perturbation during MCM steps in docking in degress. Defaults to 5.0º |Real|
|-docking\_centroid\_outer\_cycles [C]|Number of cycles to use in outer loop of docking low resolution protocol. Defaults to 10. |Integer|
|-docking\_centroid\_inner\_cycles [C]|Number of cycles to use in inner loop of docking low resolution protocol. Defaults to 50. |Integer|

Tips
====

-   The docking run can take two forms. Sometimes biochemical and genetic information can be used to localize the binding site to a small region on one or both partners. In this case, one performs a perturbation run, exploring only a small region of space around the suspected binding site. For predictions where there is no biological information about the interface, one usually performs a global search, exploring all the conformational space of both partners.

-   Global docking gives best results when there are less than 450 residues in the complex. (see [Daily, 2005](http://onlinelibrary.wiley.com/doi/10.1002/prot.20555/abstract) )

-   The most commonly used options are -dock\_pert 3 8, which will create starting structures using 3 Angstrom translations and rotations within 8 degrees.

-   Note that one should always run the [[Docking Prepack application|docking-prepack-protocol]] on the starting structure in order to remove high-energy rotamers that could cause erroneous decoy ranking.

-   There are two scores that one should inspect:
    1.  total: The total score is an overall measure of the energy of the complex
    2.  I\_sc (interface score): I\_sc is the total score of the complex minus the total score of each partner in isolation. Typcial values for I\_sc of good decoys are in the range of -5 to -10.

-   Always use the -ex1 and -ex2aro options to allow more fine grained rotamer selection.

-   For perturbation runs, generate at least 1,000 decoys. For global runs, generate between 10,000 and 100,000 (we know this requires a lot of cpu time and disk space).

-   If the interface score doesn't show up in the scorefile and you want to add it, you can use the flag ```-score:docking_interface_score 1 ```

-   You can use the docking protocol to calculate interface RMSDs:
```
/path/to/docking_protocol.linuxgccrelease -l input_pdbs.list \
-native native.pdb \
-docking_local_refine \
-dock_min \
-out:file:score_only recalc_rmsd.sc \
-nstruct 1
```

Constraints
===========

Docking now supports AtomPairConstraint, AmbiguousConstraint and SiteConstraint. To use a constraint with docking, you only need to add the option -constraints:cst\_file [[constraint_file|constraint-file]] . See the docking\_distance\_constraint and docking\_site\_constraint integration tests for examples. A SiteConstraint allows you to specify that a particular residue should be in contact with a particular chain. An example of a SiteConstraint is:

    ```
    SiteConstraint CA 4A D FLAT_HARMONIC 0 1 5
    ```

This will add a FLAT\_HARMONIC potential with the parameters 0 1 5 (recommended; see [[this page|constraint-file]] for more on constraint files) around the distance between the CA of residue 4 (PDB numbering) on chain A and the closest CA on chain D to the ScoreFunction. The FLAT\_HARMONIC function with these parameters is centered on 0, with a spring constant of 1 and a window of 5. That is, there's no penalty for 5 around zero, and then starting at 5 the penalty goes up as d^2 for every d units past 5 you go.  

If you are looking to have SiteContraints for any Atom of a particular residue to any atom of the chain specified, checkout the AmbiguousContraints

If you want to dissallow certain residues, look into the SIGMOID function.  As Rocco Moretti explains from a forum post:I might recommend trying a SIGMOID function( (1/(1+exp(-slope*( x-x0 ))) - 0.5). This is set up to give a favorable value near zero (and for negative numbers) when the slope is positive, but you could try a negative slope to give a favorable value further away from zero. e.g.
    
    ```
    SiteConstraint CA 16B A SIGMOID 5.0 -2.0
    ```

Would give a sigmoid constraint centered around 5 with values being disfavorable near zero and favorable greater than 5 (slope -4). You will likely need to play around with the slope and cutoff to get things the way you want. Also keep in mind that a sigmoid never quite reaches zero, so the constraint will always want to push things apart, but with a steep enough slope the effect will be negligible.


Expected Outputs
================

One PDB file for each candidate docked model generated and a 1 scorefile for each run summarizing all generated models.

Post Processing
===============

Sort scorefile by score using commandline sort function. For global docking simualations, one should generate at least 10,000 decoys and ideally 100,000 decoys should be produced. Sort by score (pay attention to I\_sc and total!) and cluster the top 200 decoys by pairwise RMSD. Since global docking in Rosetta 3 has not been thoroughly tested, we do not have scripts available to automate this process. We recommend using the scripts as mentioned in our [Rosetta++ tutorial](http://graylab.jhu.edu/~mdaily/tutorial/postprocess.html) . Some scripts may require some modification.

New things since last release
=============================

-   Supports the modern job distributor [[jd2]].
-   Support for complex foldtrees including poses that have ligands.
-   Support for [[constraints|constraint-file]] .

##See Also

* [Protein-protein Docking Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/Protein-Protein-Docking/Protein-Protein-Docking): Getting started with docking
* [[Docking Applications]]: Home page for docking applications
* [[Preparing structures]]: Notes on preparing structures for use in Rosetta
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[RosettaScripts]]: Homepage for the RosettaScripts interface to Rosetta
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
* [[Motif Dock Score]]: Efficient low-resolution protein-protein docking.