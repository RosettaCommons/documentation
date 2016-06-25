An introductory tutorial on protein folding using the Broker can be found [here](https://www.rosettacommons.org/demos/latest/tutorials/advanced_denovo_structure_prediction/folding_tutorial).

If the mover functionality you need for the algorithm you want to make doesn't exist as a broker-compatible mover already, you'll need to do some development work. This ranges from adding a couple of lines of code to your existing mover to developing a completely new mover. Even the latter option doesn't take an expert developer more than an hour unless your mover is really special, so don't worry. It's easy!

The easiest way is to make it work with the ScriptCM framework, but if your mover does something special (and can't accept a MoveMap as it's information on what to move) or is an obligate [[ClientMover|ClientMovers]] (doesn't make any sense outside of a Broker framework), then your best bet is to write a new [[ClientMover|ClientMovers]].

[[_TOC_]]

# Strategies for Broker Compatibility

## MoveMapMovers and ScriptCM

First, take a look at the [[ScriptCM|ClientMovers#ScriptCM]]. Here's how you can make your mover acceptable as a [[ScriptCM|ClientMovers#ScriptCM]] internal mover:

1. Make sure your mover is accessible in RosettaScripts.
2. Make your mover inherit from `MoveMapMover` instead of just `Mover`.
3. Implement your `mover::movemap`
4. Implement your `mover::set_movemap`
5. Make sure your mover obeys the MoveMap that is passed in through `set_movemap`. (For extra credit, throw an exception of degrees of freedom are accessible in the `MoveMap` that your mover doesn't know how to move--e.g. torsion angles for a docking mover)
6. Profit!

Then, put your mover inside a [[ScriptCM|ClientMovers#ScriptCM]] with the appropriate client Mover and Claim subtags. For example,

```
<ScriptCM name="my_mover">
  <[Your Mover] [option1, option2, ...] />
  <TorsionClaim backbone=1 control_strength="CAN_CONTROL" selector="ChainA" />
</ScriptCM>
```

Would create cause a mover "my_mover" whose apply applies your special mover (as created by its own `parse_my_tag` function) with a MoveMap with all the available (i.e. not made unavailable by an `EXCLUSIVE` Claim) torsion angles in the ResidueSelector "ChainA" set to true.

## Developing New ClientMovers

If your mover meets one of the following criteria, you might consider writing a special [[ClientMover|ClientMovers]] just for your class, because it might not fit neatly in the [[ScriptCM|ClientMovers#ScriptCM]]/MoveMapMover pattern.

1. Doesn't make sense outside of an Environment
2. The claiming associated with your mover--either the construction of FoldTree/AtomTree elements or the DoFs that need to be controlled--is best determined dynamically by the code at broker-time or should be read from a file.
3. Your effector move (the code that actually changes the numbers in the AtomTree) cannot handle a MoveMap, and requires instead some other indicator (for example, the UniformRigidBodyMover takes a Jump number, not a MoveMap).

This is a bit more work (but not much!), but can produce some really elegant, flexible, user-friendly objects. Here's what you have to do:

1. **Decide what needs claiming.** There are really only a couple of options that are even theoretically possible, and they fall in to two categories: DoFs and FoldTree elements. FoldTree elements are cuts, jumps, and new virtual residues. DoFs are basically the numbers that the FoldTree elements give rise to: jump RTs and torsional angles (and, in obscure cases, bond lengths and angles). In general, brokering should not add to the physical system represented by the simulation, but only change the way that system is represented (this is the reason only virtual residue addition is currently supported).
2. **Couch your claiming needs as Claims.** Looking at the list of existing [[Claims|ClientMovers#ScriptCM]] both in this article and in protocols/environment/claims to determine which Claims best express those needs.
3. **Implement `ClientMover::yield_claims`** to pass those claims to the Broker.
4. **Implement `ClientMover::passport_updated`.** This method is called whenever the ClientMovers receives a new `DofPassport`, which contains all the information about which DoFs your ClientMovers is allowed to access. Typically this hook is used to process the new passport and configure whichever data structure is used within the ClientMovers to track target DoFs (e.g. Jump number). A particularly useful method is `DofPassport::render`, which produces a MoveMap from a `DofPassport`.
4. **Implement ClientMovers::apply** correctly. Because the consensus Conformation inside the pose runs security checks to ensure your mover is allowed to move the DoFs it is trying to move, every [[ClientMover|ClientMovers]] must first authenticate using a [Resource Acquisition is Initialization](http://en.wikipedia.org/wiki/Resource_Acquisition_Is_Initialization) pattern. The [[ClientMovers]] instantiates an automatic (i.e. stack-allocated) `DofUnlock` as the first step in the apply function. It is almost always sufficient to simply cut and paste the following line (if the incoming Pose's name is "pose"):

    ```
    DofUnlock activation( pose.conformation(), passport() );
    ```

    It is absolutely crucial that the object be _named_, even if it never gets used, as it will be compiled out completely otherwise. This has tripped up the author nearly every time he wrote a new [[ClientMover|ClientMovers]].

5. **Profit!** Add your new mover to an environment, and begin mixing and matching with other [[ClientMover|ClientMovers]].

In general, [[ClientMovers]] are only a few hundred lines (at time of this writing, FragmentCM.cc is 244 lines, UniformRigidBodyCM.cc is 175 lines), especially if they contain an existing mover that is responsible for the heavy-lifting in actually performing the numerical manipulations associated with the move.

### Specialized features

Many special features exist in the Broker system, but are not necessarily "canon" yet. In other words, they're features I'm experimenting with and reserve the right to remove if necessary. These include

- Initialization. Currently, the Broker creates a special phase of broking before control flow is returned back to the protocol, wherein movers that claimed initialization control strengths higher than "DOES_NOT_CONTROL" are given a one-shot chance to set those DoFs. See protocols/abinitio/abscript/RigidChunkCM.cc for an example.
- The ClientMover::broking_finished hook is intended to provide specialized information about the result of the brokering process to interested movers. It provides const access to a BrokerResult object which contains: the final Pose object, a std::map< Size, std::string > giving the position and name of new virtual residues, a fold tree that is stripped of all unphysical jumps (for some legacy loop closers), an std::set< Size > containing the position of all automatically-placed cuts, a WriteableCacheableMapCOP which contains any information placed in there by either the Broker (like automatic cuts) or other ClientMovers (currently only FragmentJumpCM), and a SequenceAnnotationCOP which contains label to pose-numbering information.

# C++ Interface

The Broker architecture is described in a forthcoming paper in the RosettaCon 2014 PLoS ONE collection.

## Symmetry

The broker does not currently support [[symmetry]]. The reason for this is *purely technical*, so it's eminently possible. The major problem is that both symmetry *and* the broker, are implementations of the Conformation object. Since we do not allow multiple inheritance in Rosetta, it's not currently possible to use both functionality sets at the same time.

To solve this, symmetric behavior would need to be implemented for the `ProtectedConformation`. Either `ProtectedConformation` could be made to inherit from `SymmetricConformation` (such that all `ProtectedConformations` are symmetric, just sometimes symmetric with _n_ = 1), or `ProtectedConformation` could implement its own symmetric copying code.

Then, a mechanism for claiming symmetry within the broker framework would need to be constructed. A good idea might be a sort of "symmetric copy-through" `BrokerElement` would need to be defined (i.e. DoF *a* follows DoF *b*). Then an `EnvClaim` could be constructed that builds the appropriate set of `BrokerElements` from a symmetry definition.

Once that is complete the `EnvClaimBroker` would need to be modified to correctly broker these sorts of `BrokerElement`s. That would include attaching a correct `SymmetryInfo` object to the `Pose` and likely other configuration issues.

## Design

The broker does not currently support design. Like symmetry, the reason for this is *purely technical*. The manner in which DoFs are stored in the `DofPassport` relies on Rosetta's low-level `DOF_ID` system, which tracks DoFs by atom number, residue number, and `DOF_Type` (an enum). If the number of residues in the pose changes, the residue number goes out of date. If the number of atoms in a residue changes, the atom number goes out of date. If the atom connectivity changes, a the DoF may no longer exist (*e.g.* torsional angles disappear if downstream atoms disappear).

Fortunately, there is only very rarely an actual need to vary chain lengths *during* sampling. A perfectly valid strategy when multiple lengths of chain need to be evaluated is to vary the length of the chain on a *per decoy* basis. In other words, choose a length once at the beginning of the trajectory and stick with it throughout, and sample the reasonable variance in length over decoy distribution, rather than within each decoy.

Residue design, on the other hand, is less amenable to that strategy. To perform design that involves changes to the atom tree, the `DofPassport` must be updated, or at least be able to handle changing `DOF_IDs`.

There are a couple of ways this could be done. Because most design is side chain-swapping, the easiest way to do this would probably be to construct a way to claim an entire sidechain for design. This would claim `MUST CONTROL` access to the whole sidechain, and store access to all non-backbone atoms as a single entry in the `DofPassport`. For example, the entire backbone could be stored as a single `DOF_ID` with the atom number of the first non-backbone atom in the residue.

##See Also

* [Tutorial on protein folding using the Broker](https://www.rosettacommons.org/demos/latest/tutorials/advanced_denovo_structure_prediction/folding_tutorial)
* [[Topology Broker home page|BrokeredEnvironment]]
* [[Development Documentation]]: Home page for developer documentation
* [[Scripting Documentation]]: Scripting interfaces to Rosetta
* [[RosettaScripts]]: RosettaScripts home page
* [[PyRosetta]]: PyRosetta wiki page
* [[Developer tutorials|devel-tutorials]]
* [[I want to do x]]: Guide for making specific structural perturbations using RosettaScripts
* [[Getting Started]]: A page for people new to Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Rosetta Servers]]: Web-based servers for Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.