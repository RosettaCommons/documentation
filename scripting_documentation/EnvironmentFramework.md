The Environment framework, also known as the ToplogyBroker 2.0, is a tool for generating larger, more complex simulation systems out of small interchangeable parts. The intent is to make rapid protocol development in RosettaScript easier by allowing sampling strategies to be carried out simultaneously rather than in sequence by constructing a consensus FoldTree that satisfies all movers. Such Movers inherit from the ClaimingMover (CM) class.

**Author's Note:** If anything here doesn't make sense, doesn't work as advertised, or is otherwise demanding of attention, give me (the original developer) a shout at justinrporter at gmail.com. I spent quite a long time on this, and would love to see other folks using it, so if I can help, let me know!

[[_TOC_]]

# Using the Environment in RosettaScripts

Using an Environment in your RosettaScripts is as easy as

1. Defining your ClaimingMovers
2. Creating an Environment block in the PROTOCOL section
3. Adding your movers to the block.

## A simple example

In the following example, a ChainResidueSelector selecting chains named "A" and "B" are used to build a [UniformRigidBodyCM](#UniformRigidBodyCM) that docks those two chains to one another. 

```
<ROSETTASCRIPTS>
  <RESIDUE_SELECTORS>
    <Chain name="ChainA" chains="A" />
    <Chain name="ChainB" chains="B" />
  </RESIDUE_SELECTORS>
  <MOVERS>
    <UniformRigidBodyCM name="dock" mobile="ChainA" stationary="ChainB" />
    <Environment name="dockenv">
      <Mover name="dock"/>
    <Environment/>
  </MOVERS>
  <PROTOCOLS>
    <Add mover="dockenv"/>
  </PROTOCOLS>
</ROSETTASCRIPTS>
```

## _Ab initio_ Example

The following example replicates an _ab initio_ run. The file "beta_sheets.top" contains a predicted beta-strand pairing topology, and the 9-mer and 3-mer fragments are in files called "frag9.dat" and "frag3.dat", respectively. Loops are closed after the [AbscriptMover](#AbscriptMover] runs all stages of abinitio by the [AbscriptLoopCloserCM], and then FastRelax refines the structure in full atom mode. The assumption is made here that the input pose is in centroid mode.

```
<MOVERS>
  <FragmentJumpCM name="jumps" topol_file="beta_sheets.top" />

  <AbscriptMover name="abinitio" cycles=2 >
    <Fragments large_frags="frag9.dat" small_frags="frag3.dat" />
    <Stage ids="I-IVb" >
      <Mover name="jumps" weight=1.0 />
    </Stage>
  </AbscriptMover>

  <AbscriptLoopCloserCM name="closer" fragfile="frag3.dat" />

  <SwitchResidueTypeSetMover name="fullatom" set="fa_standard" />
  <FastRelax name="relax" repeats=5 />
</MOVERS>

<PROTOCOLS>
  <Environment name="env" auto_cut=1 >
    <Apply mover="abinitio" />
    <Apply mover="closer" />
  </Environment>
  <Add mover="fullatom" />
  <Add mover="relax" />
</PROTOCOLS>
```

## Multi-body Docking Example

This example docks three chains (A, B, and C) to one another using a "star" FoldTree using [UniformRigidBodyCMs](#UniformRigidBodyCM). In other words, all three chains are docked to a central virtual residue. This is in contrast to a two-to-one docking scheme. A TrialMover is used to run 1000 cycles of docking. [CoMTrackerCMs](#CoMTrackerCM) create virtual residues centered at the center of mass of each chain, which are used as the other base of the jump building each chain.

```
<RESIDUE_SELECTORS>
  <Chain chains="A" name="ChainA" />
  <Chain chains="B" name="ChainB" />
  <Chain chains="C" name="ChainC" />
</RESIDUE_SELECTORS>
<MOVERS>
  <CoMTrackerCM name="com_A" mobile_selector="ChainA" />
  <CoMTrackerCM name="com_B" mobile_selector="ChainB" />
  <CoMTrackerCM name="com_C" mobile_selector="ChainC" />

  <UniformRigidBodyCM name="rigidA" mobile="com_A" stationary="star_center" />
  <UniformRigidBodyCM name="rigidB" mobile="com_B" stationary="star_center" />
  <UniformRigidBodyCM name="rigidC" mobile="com_C" stationary="star_center" />

  <RandomMover name="dock_bag" movers="rigidA,rigidB,rigidC,com_A,com_B,com_C" />
  <GenericMonteCarlo name="dock" scorefxn_name=[your scorefn] mover_name="dock_bag" temperature=2.0 trials=1000/>
</MOVERS>
<PROTOCOLS>
  <Environment name=multidock >
    <Apply name=dock/>
  </Environment>
</PROTOCOLS>
```

## (Asymmetric) Fold and Dock Example

```
<RESIDUE_SELECTORS>
<Chain chains="A" name=ChainA />
<Chain chains="B" name=ChainB />
</RESIDUE_SELECTORS>

<MOVERS>
  <CoMTrackerCM name=com_A selector=ChainA />
  <CoMTrackerCM name=com_B selector=ChainB />

  <UniformRigidBodyCM name=rigid mobile=com_A stationary=com_B />

  <AbscriptMover name=abinitio >
    <Fragments small_frags=frags3A.txt large_frags=frags9A.txt selector=ChainA />
    <Fragments small_frags=frags3B.txt large_frags=frags9B.txt selector=ChainB />
    <Stage ids=I-IVb>
      <Mover name=rigid />
      <Mover name=com_A />
      <Mover name=com_B />
    </Stage>
  </AbscriptMover>

  <AbscriptLoopCloserCM name=closerA fragments="frags3A" selector=ChainA />
  <AbscriptLoopCloserCM name=closerB fragments="frags3B" selector=ChainB />

  <ResidueTypeSetSwitchMover name=fullatom set=fa_standard />
  <FastRelax name=relax repeats=5 />

  <Environment name=fold_and_dock auto_cut=true >
    <Apply name=abintio />
    <Apply name=closerA />
    <Apply name=closerB />
  </Environment>
</MOVERS>
<PROTOCOLS>
  <Add mover=fold_and_dock />
  <Add mover=fullatom />
  <Add mover=relax />
</PROTOCOLS>
```

# Using the Environment in C++ code

Making a brokered Environment in your C++ code is as easy as

1. **Make an Environment**. There are a couple of options to set in the constructor (*e.g.* should the Environment look at the old FoldTree to resolve FoldTree cycles), but in most cases all you need to do is give it a name.
2. **Register your ClaimingMovers** with the environment. This lets the Broker know that it needs to ask this mover for claims during broking.
3. **Apply your movers.** Environment::start returns a pose which has a ProtectedConformation built in. This is the Pose with the consensus FoldTree and all the DoF protections attached. Apply your protocol to this object.
4. **Close your environment.** Once you've executed your protocol (or want to move on to the next stage, either run by a different broker or not brokered), you need to clean up. Environment::end does this.

For a protocol with only one ClaimingMover (called MyClaimingMover), it might look like this.

```
  protocols::environment::Environment env( "env" );
  MyClaimingMoverOP my_mover = new MyClaimingMover( arg1, arg2, ... );

  env.register_mover( my_mover );

  core::pose::Pose prot_pose = prot_pose = env.start( pose );

  my_mover->apply( prot_pose );

  core::pose::Pose final_pose = env.end( prot_pose );
```

Many further examples are available as unit tests in test/protocols/environment/*.

# How do I get my mover to work with the Environment?

I'm so glad you asked! The easiest way is to make it work with the ScriptCM framework, but if your mover does something special (and can't accept a MoveMap as it's information on what to move) or is an obligate ClaimingMover (doesn't make any sense outside of a Broker framework), then your best bet is to write a new ClaimingMover.

## MoveMapMovers and ScriptCM

First, take a look at the [ScriptCM](#ScriptCM) section above to see what it's all about. Here's how you can make your mover acceptable as a ScriptCM client mover:

1. Make sure your mover is accessible in RosettaScripts.
2. Make your mover inherit from MoveMapMover instead of just Mover.
3. Implement your mover::movemap
4. Implement your mover::set_movemap
5. Make sure your mover obeys the MoveMap that is passed in through set_movemap. (For extra credit, throw an exception of degrees of freedom are accessible in the MoveMap that your mover doesn't know how to move--e.g. torsion angles for a docking mover)
6. Profit!

Then, put your mover inside a ScriptCM with the appropriate client Mover and Claim subtags. For example,

```
<ScriptCM name="my_mover">
  <[Your Mover] [option1, option2, ...] />
  <TorsionClaim backbone=1 control_strength="CAN_CONTROL" selector="ChainA" />
</ScriptCM>
```

Would create cause a mover "my_mover" whose apply applies your special mover (as created by its own parse_my_tag) with a MoveMap with all the available (i.e. not made unavailable by an EXCLUSIVE Claim) torsion angles in the ResidueSelector "ChainA" set to true.

## Developing New ClaimingMovers

If your mover meets one of the following criteria, you might consider writing a special ClaimingMover just for your class, because it might not fit neatly in the ScriptCM/MoveMapMover pattern.

1. Doesn't make sense outside of a brokered Environment
2. The claiming associated with your mover--either the construction of FoldTree/AtomTree elements or the DoFs that need to be controlled--is best determined dynamically by the code at broker-time or should be read from a file.
3. Your effector move (the code that actually changes the numbers in the AtomTree) cannot handle a MoveMap, and requires instead some other indicator (for example, the UniformRigidBodyMover likes a Jump number, not a MoveMap).

This is a bit more work (but not much!), but can produce some really elegant, flexible, user-friendly objects. Here's what you have to do:

1. **Decide what needs claiming.** There are really only a couple of options that are even theoretically possible, and they fall in to two categories: DoFs and FoldTree elements. FoldTree elements are cuts, jumps, and new virtual residues. DoFs are basically the numbers that the FoldTree elements give rise to: jump RTs and torsional angles (and, in obscure cases, bond lengths and angles). In general, brokering should not add to the physical system represented by the simulation, but only change the way that system is represented (this is the reason only virtual residue addition is currently supported).
2. **Couch your claiming needs as Claims.** Looking at the list of existing [Claims](#ScriptCM) both in this article and in protocols/environment/claims to determine which Claims best express those needs.
3. **Implement ClaimingMover::yield_claims** to pass those claims to the Broker.
4. **Implement ClaimingMover::passport_updated.** This method is called whenever the ClaimingMover receives a new DofPassport, which contains all the information about which DoFs your ClaimingMover is allowed to access. Typically this hook is used to process the new passport and configure whichever data structure is used within the ClaimingMover to track target DoFs (e.g. Jump number). A particularly useful method is DofPassport::render, which produces a MoveMap from a DofPassport.
4. **Implement ClaimingMover::apply** correctly. Because the consensus Conformation inside the pose runs security checks to ensure your mover is allowed to move the DoFs it is trying to move, every ClaimingMover must first authenticate using a [Resource Acquisition is Initialization](http://en.wikipedia.org/wiki/Resource_Acquisition_Is_Initialization) pattern. The ClaimingMover instantiates an automatic (i.e. stack-allocated) DofUnlock as the first step in the apply function. It is almost always sufficient to simply cut and paste the following line (if the incoming Pose's name is "pose"):

    ```
    DofUnlock activation( pose.conformation(), passport() );
    ```

    It is absolutely crucial that the object be _named_, even if it never gets used, as it will be compiled out completely otherwise. This has tripped up the author nearly every time he wrote a new ClaimingMover.

5. **Profit!** Add your new mover to an environment, and begin mixing and matching with other ClaimingMovers.

In general, ClaimingMovers are only a few hundred lines (at time of this writing, FragmentCM.cc is 244 lines, UniformRigidBodyCM is 175 lines), especially if they contain an existing mover that is responsible for the heavy-lifting in actually performing the numerical manipulations associated with the move.

### Specialized features

Many special features exist in the Broker system, but are not necessarily "canon" yet. In other words, they're features I'm experimenting with and reserve the right to remove if necessary. These include

- Initialization. Currently, the Broker creates a special phase of broking before control flow is returned back to the protocol, wherein movers that claimed initialization control strengths higher than "DOES_NOT_CONTROL" are given a one-shot chance to set those DoFs. See protocols/abinitio/abscript/RigidChunkCM.cc for an example.
- The ClaimingMover::broking_finished hook is intended to provide specialized information about the result of the brokering process to interested movers. It provides const access to a BrokerResult object which contains: the final Pose object, a std::map< Size, std::string > giving the position and name of new virtual residues, a fold tree that is stripped of all unphysical jumps (for some legacy loop closers), an std::set< Size > containing the position of all automatically-placed cuts, a WriteableCacheableMapCOP which contains any information placed in there by either the Broker (like automatic cuts) or other ClaimingMovers (currently only FragmentJumpCM), and a SequenceAnnotationCOP which contains label to pose-numbering information.