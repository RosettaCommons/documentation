#How to add a new scoring term.

Metadata
========

This document was written by Andrew Leaver-Fay on 8/15/2008 and revised on 8/24/2009.

The ScoreFunction class is a container for EnergyMethods. EnergyMethods do all the hard work of evaluating the energies of residues and residue pairs; the ScoreFunction manages the logic for scoring only those residues whose interaction energies need to be recomputed. By dividing the responsibilities between the two classes, we lessen code duplication and make it easier to add new scoring terms.

Step One
========

The first step in adding a new energy method is in deciding where in the energy method hierarchy your new class should live. There are seven energy method base classes that may be derived from. These are:

-   ContextIndependentOneBodyEnergy
-   ContextDependentOneBodyEnergy
-   ContextIndepenedentTwoBodyEnergy
-   ContextDependentTwoBodyEnergy
-   ContextIndependentLRTwoBodyEnergy
-   ContextDependentLRTwoBodyEnergy
-   WholeStructureEnergy

LR above is short for long ranged. Two body energies without LR in their name are short ranged (but lack SR in their name for brevity).

Short ranged two body energies must define an interaction distance: the distance between two heavy atoms beyond which interaction energies are zero. With this interaction distance, the ScoreFunction will construct a sparse graph connecting all neighboring residues. This is the EnergyGraph that is stored in the Poses Energies object. The ScoreFunction computes a single EnergyGraph, using the maximum interaction distance defined by its short-ranged two body energy methods. Caution: if you define a new short-ranged energy method with a very large interaction distance, then the EnergyGraph will become more densely connected. For every pair of adjacent residues in the EnergyGraph, all two body energy methods are called to compute their interaction energy. The longer the interaction distance (for even one energy method), the slower scoring becomes.

Long ranged two body energies must define an energy container and a set of const- and non-const-iterators for that container. This interface allows long ranged energies to control exactly how they are evaluated. Long ranged energies can either be evaluated between all pairs of residues – O(n2) – or can be evaluated for only a subset of residues. For example, constraints in mini are modeled as long ranged energies: the number of pair interactions evaluated depends on the number of pair constraints. If you have only a handful of constraints, then you have to evaluate only a handful of constraint energies. The constraints classes construct a graph with as many edges as there are interacting pairs and the ScoreFunction iterates across that graph.

An energy method is either context dependent or context independent depending on whether the surroundings for a residue (or a residue pair) effect the energy thats computed. Context independent energies may be stored for reuse if the residue (or residue pair) does not move internally (or with respect to each other). The ScoreFunction logic treats energy methods differently depending on whether or not they are context dependent or independent.

Some examples of context dependent energy methods: the environment term for a residue depends on the number of c-betas within 10 angstroms, the hydrogen bonding terms depend 1) on the number of neighbors for the donor and the acceptor and 2) for the case of backbone/sidechain hydrogen bonds, the presence of a backbone/backbone hydrogen bond for the backbone group.

Step Two
========

The second step, after the you have chosen the base class from which to derive is to expand the ScoreType enumeration. The ScoreType enumeration is in src/core/scoring/ScoreType.hh. Each energy method defines one or more score types; each score type corresponds to exactly one energy method. No two energy methods may share a single score type. The score type represents a position in an EnergyMap array to which energy methods may write. EnergyMaps are also used by the ScoreFunction to hold the set of weights. The total energy for a structure may be computed from an EnergyMap holding the sum of the unweighted energies for the structure and an EnergyMap holding the weights for each of the terms by a dot product.

The ScoreType enumeration is divided into two: the first part of the enumeration is reserved for short-ranged two body energies, the second part is for all other energy methods. The n\_shortranged\_2b\_score\_types entry in the enumeration is the divider between the two. If you define either a context dependent or independent short ranged two body energy, add your new score type into the first part of the list, otherwise, add it to the second part of the list.

The EnergyMap object is an array that holds one entry for each element of the ScoreType enumeration. There is also a second, related class, the TwoBodyEnergyMap. The TwoBodyEnergyMap holds entries for those elements in the ScoreType enumeration up to the n\_shortranged\_2b\_score\_types position. The two body energy map is a little smaller than a full energy map. (Before a recent change to the EnergyGraph reduced it's memory overhead, each Edge (an EnergyEdge) in the EnergyGraph held a TwoBodyEnergyMap object. After the change, each EnergyEdge holds only a small array with enough space to store the active two-body components. The importance of a distinct TwoBodyEnergyMap has disappeared following this recent change.)

The two main advantages are that writing to and reading from energy maps is an O(1) operation (an STL map is O(ln n) with a very large constant for small n) and the size of an energy map is compile-time known so they may be allocated on the stack (without calling new or delete). The O(1) access to the contents of the EnergyMap is very important, since EnergyMethods return their results of every interaction energy calculation in an EnergyMap.

When you expand the ScoreType enumeration, you must also update the ScoreTypeManager.cc file which defines a mapping from strings to score types.

The final step toward incorporating your new EnergyMethod into scoring is to create an EnergyMethodCreator class that will create a new instance of your EnergyMethod class in response to a call to its virtual "create\_energy\_method" function. The Creator must also return a list of the ScoreTypes that your EnergyMethod is responsible for in its "score\_types\_for\_method" function. The ScoringManager will invoke the "create\_energy\_method" function to create a new instance of your EnergyMethod whenever a ScoreFunction needs an instance of your class.

The reason the ScoringManager is responsible for creating EnergyMethods is to make the interface to the ScoreFunction as intuitive as possible: an energy method is active in a ScoreFunction if it has a non-zero weight for one of the score types it defines. The method set\_weight of the ScoreFunction class fetches a new instance of the EnergyMethod from the ScoringManager if that methods weights were previously zero. All that the user has to do to ensure that a particular term in the ScoreFunction is evaluated is to set its weight to a non-zero value; the user does not also have to instantiate the EnergyMethod which is responsible for that term. Instead that instantiation happens behind the scenes.

Your EnergyMethodCreator class must register itself with the ScoringManager so that it is ready to respond to EnergyMethod-creation requests. This registration step should happen at load time – the period of time between the program beginning to be loaded into memory and the beginning of main(). Believe it or not, lots of work happens before main() begins! At load time, the OS will initialize all (reachable\*) static data. The registration system takes advantage of this static-data initialization. You should add a new EnergyMethodCreator instance to the init.cc file for the library your new class will live in (e.g. core/init.cc if your EnergyMethod lives in core). At load time, the default constructor for your class will be invoked as the instance that lives in init.cc gets initialized. Use this construction event to register your class with the ScoringManager. Your class must invoke the ScoringManager's "factory\_register" method, passing in a new instance of your class. Careful: you will need to make sure the second instance of your class (the one passed to in the call to factory\_register) does not try to create a third instance, or you will have an infinite regresion.

(\*"Reachable static data" are pieces of global data held in the .cc files that have at least one function be encountered on a depth-first traversal of all functions reachable from main(). Any .cc file that is not reached from main will be trimmed away by the linker in static builds.)

Since all registration happens at load time, there is no worry that a ScoreFunction will request an instance of any EnergyMethod before the ScoringManager is ready to create it. It also means that your new EnergyMethod will be accessible in any protocol without having to change any code elsewhere; there's no need to inject ScoringManager initialization calls into the top of each main() in each executable (which would be required if factory registration were delayed until after load time).

You must be careful that your EnergyMethodCreator lists all of the ScoreTypes that your EnergyMethod is responsible for computing. If you should list only some of them, or if you add new ones to your EnergyMethod later, but not to the EnergyMethodCreator, then the ScoringManager may fail to correctly instantiate your EnergyMethod when a ScoreFunction requests it at runtime.

Your EnergyMethodCreator class should be declared in a .hh file and implemented in the .cc file. You should \#include only a single header in your .hh file: core/scoring/methods/EnergyMethodCreator.hh. Do not under any circumstances \#include any other header. Do not under any circumstances implement any functions within the .hh file.

Step Three
==========

The third step in defining a new energy method is to implement the interface for your new EnergyMethod class. You should read carefully the documentation describing the way in which the interface should be implemented. Look in the base class .hh files, all the way up through the inheritance hierarchy for the @brief doxygen tags. Not all methods need to be overridden by your derived class. For two body energies, it is necessary to implement residue\_pair\_energy, but unnecessary to implement the evaluate\_rotamer\_pair\_energies method; the base class implementation of that method is often sufficient. Pure virtual functions (ones without base class implementations) must be implemented. Regular virtual functions (ones with base class implementations) do not always have to be overridden.

Your derived class must implement a constructor (not necessarily a default constructor with no arguments) and a destructor. In the constructor, your class must invoke the base class method add\_score\_type for each of the score types your class defines. If you implement a copy constructor, invoke the base-class copy constructor as well or make sure your copy constructor calls add\_score\_type. The ScoreFunction requires that each energy method own up to the score types it intends to define.

Data based scoring terms
========================
Suppose you have a rich set of data that correlates to some structural feature.
A good example is dimethylsulfate (DMS) reactivity, which responds to structural features of adenosine residues, in particular around the N1 atom.
One might imagine a log-odds potential that compares the observed values for particular residues to that simulated for your model, or an inverse-Boltzmann style scoring function that compares the values simulated for your model against the typical distribution in the PDB.
Whatever the case, it'd be a shame if your only option were a discrete grid of observations.
Historically, Rosetta has had interpolation facilities to handle this issue for rotamer libraries (in particular, bicubic interpolation for recent Dunbrack rotamer libraries).
Recent efforts have created templated versions of Rosetta's interpolation code: the MathNTensor, PolycubicSpline, and a general InterpolatedPotential container. 
If you've got some data and a desire for smooth derivatives, consider modeling your work off the RNA_DMS_Potential. 


##See Also

* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Score functions and score terms|score-types]]
* [[Additional score terms|score-types-additional]]
* [[Scoring explained]]
* [[Units in Rosetta]]: Gives a description of Rosetta energy units
* [[Hydrogen bond energy term|hbonds]]
* [[Scorefunctions for noncanonical residues and molecules|NC-scorefunction-info]]
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Glossary]]: Defines key Rosetta terms
