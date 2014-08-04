The Environment framework, also known as the ToplogyBroker 2.0, is a tool for generating larger, more complex simulation systems out of small interchangeable parts. The intent is to make rapid protocol development in RosettaScript easier by allowing sampling strategies to be carried out simultaneously rather than in sequence by constructing a consensus FoldTree that satisfies all movers. Such Movers inherit from the ClaimingMover (CM) class.

**Author's Note:** If anything here doesn't make sense, doesn't work as advertised, or is otherwise demanding of attention, give me (the original developer) a shout at justinrporter at gmail.com. I spent quite a long time on this, and would love to see other folks using it, so if I can help, let me know!

[[_TOC_]]

# Available ClaimingMovers

There are a few currently available ClaimingMovers (abbreviated CM) that are ready to go:
* [UniformRigidBodyCM](#UniformRigidBodyCM): perform unbiased, rigid-body docking between two selected regions.
* [FragmentCM](#FragmentCM): perform backbone torsion-angle fragment insertion on a target region.
* [FragmentJumpCM](#FragmentCM): beta-strand/beta-strand pairing fragment insertion
* [LoopCM](#LoopCM): access to loop closure algorithms KIC and CCD modes refine and perturb
* [RigidChunkCM](#RigidChunkCM): fix a region to values given in a pdb file and prevent other movers from sampling there
* [CoMTrackerCM](#CoMTrackerCM): generate a virtual residue that tracks the center of mass of a particular region
* [AbscriptLoopCloserCM](#AbscriptLoopCloserCM): close loops using the WidthFirstSlidingWindowLoopCloser (used in _ab initio_ to close unphysical chainbreaks)
* [ScriptCM](#ScriptCM): interface with the Broker system for an arbitrary movemap-accepting mover (_i.e._ inherits from MoveMapMover).

## UniformRigidBodyCM
The UniformRigidBodyCM is a mover that interfaces between the broker and the UniformRigidBodyMover docking mover. The UniformRigidBodyMover expects a jump number but, for convenience, the UniformRigidBodyCM accepts ResidueSelectors or virtual residue names. For example,

```
<UniformRigidBodyCM name="rigid" mobile="com_A" stationary="com_B" />
```

creates a UniformRigidBodyMover named 'rigid' that docks 'com_A' to 'com_B'. If 'com_A' is a defined ResidueSelector, the jump will be constructed to attach to the first residue in that selection. Otherwise, a virtual residue will be created with that name. It behaves identically for 'com_B'. The only difference between the 'mobile' and 'stationary' tags is that the jump is expected to originate at the stationary position, so that the origin of the rotation encoded by the jump is centered there.


## FragmentCM
The FragmentCM does standard fragment insertion in a targeted region. A FragmentCM instantiation looks like:

```
<FragmentCM name="chA_large" frag_type="classic" fragments="frags9A" selector="ChainA" />
```

Here, the FragmentCm with the name "chA_large" is instantiated using the fragments in the file "frags9A" and told to insert those fragments using the "classic" policy (_c.f._ "smooth" insertion policy) in the region given by the ResidueSelector 'ChainA'.

The "fragments" and "selector" options are required. The "frag_type" tag defaults to classic.

## FragmentJumpCM

The FragmentJumpCM inserts beta-strand/beta-strand rigid-body translations into jumps between (predicted) adjacent beta-strands. An instantiation of this ClaimingMover looks like:

```
<FragmentJumpCM name="jumps" topol_file="beta_sheets.top" /> 
```

The valid option sets for this ClaimingMover are:

1. "topol_file" specifying a topology file. Such a file can be generated from a pdb file by Oliver Lange's "r_pdb2top" pilot app ("apps/pilot/olli/r_pdb2top.cc" as of this writing).
2. "ss_info", "n_sheets", and "pairing_file". These respectively require a PsiPred .ss2 file, a number of sheets to build (usually 1 or 2), and a "pairing file" indicating a list of residue-residue pairings (see core::scoring::dssp::read_pairing_list for the required form of this file).
3. "restart_only". In this case, the FragmentJumpCM requires the presence of JumpSampleData in the Pose's DataCache. Advanced use only.

## LoopCM

The LoopCM builds one of the following four movers: LoopMover_Perturb_KIC, LoopMover_Refine_KIC, LoopMover_Perturb_CCD, LoopMover_Refine_CCD. The algorithm is given by "algorithm" tag ("CCD" or "KIC") the form is given by the "style" tag ("refine" or "perturb"). An example follows.

```
<LoopCM name="kic_refine" style="refine" algorithm="kic" selector="loop1" />
```

The "selector" tag references a ResidueSelector, which is used to determine the torsional angles that will be moved in the loop modeling. The selection is expanded by one residue to accommodate certain loop modelers' quirks.

## RigidChunkCM

The RigidChunkCM holds a particular region of the pose constant (fixed to the coordinates in a given .pdb file) and prevents those torsional angles from being sampled by other movers. An example use:

```
<RigidChunkCM name="chunk" region_file="core.rigid" template="template.pdb" />
```

makes a rigid chunk claimer called "chunk". The option "template" supplies the PDB file to copy from, or the special value "INPUT" uses the input pose at broker-time. The option region_file specifies a loops file for regions that should be held constant. For example,

    RIGID 1 16 0 0 0
    RIGID 36 46 0 0 0
    RIGID 56 63 0 0 0

would hold the regions 1-16, 26-46, and 56-63 fixed. The additional option 'label' indicates a ResidueSelector for the target region.

## CoMTrackerCM

```
<CoMTrackerCM name=(&string) selector=(&string) />
```

The CoMTrackerCM creates a virtual residue that tracks a particular set of atoms in space. The only option is "mobile_selector", which indicates the region that is to be tracked. The "name" option is a bit special, as the virtual residue created will bear that name as well. Thus, other ClaimingMovers that need to jump to or from that residue use that name.

## AbscriptLoopCloserCM
The AbscriptLoopCloserCM uses the WidthFirstSlidingWindowLoopCloser (used in _ab initio_ to close unphysical chainbreaks) to fix loops. An example instantiation is:

```
<AbscriptLoopCloserCM name="closer" fragfile="frag3.dat" />
```

Where the fragfile option indicates a file where the fragments to be used to close the loop can be found.

## AbscriptMover

The AbscriptMover is a special mover container that is used to replicate the state of _ab initio_ in early 2014. An example instantiation is

```
<AbscriptMover name="abinitio" cycles=2 >
 <Fragments large="frag9.dat" small="frag3.dat" />
 <Stage ids="I-IVb" >
   <Mover name=[MoverName1]/>
 </Stage>
 <Stage ids="II">
   <Mover name=[MoverName2]/>
 </Stage>
</AbscriptMover>
```

Here, the cycles tag is equivalent to the "-run:increase_cycles" flag in standard _ab initio_, multiplying the number of _ab initio_ cycles by that factor.

The "Stage" subtag is used to add movers to particular substages of abinitio, which given by the "id" option. Legal values are I, II, IIIa, IIIb, IVa, and IVb, and ranges are possible. Multiple Stage subtags are also possible. Stage III alternates between IIIa and IIIb and stage IV alternates between IVa and IVb. The "Mover" subtag of "Stage" names a mover with the "name" option (previously defined) to add.

The "Fragments" subtag is a macro used to add the appropriate ClassicFragmentMovers. Because three such movers exist (large fragments, normal insertion of small fragments, smooth insertion of small fragments) it is laborious to define all of these movers individually and add them to the appropriate stages using the usual API. This macro has the options "large" for 9-mer fragment files, "small" for 3-mer fragment files, and allows "selector" to set the ResidueSelector used to define the region of insertion. The 3-mer fragments loop fractions are also used to set cut biases used by the Broker to automatically place cuts (if necessary).

## ScriptCM

The ScriptCM is the most flexible of the ClaimingMovers. It operates by dynamically instantiating movers and claims as the user describes in the RosettaScript. The following example creates a mover that minimizes a jump between two residue selections built by ResidueSelectors named "ChainA" and one named "ChainB":

```
<ScriptCM name="SideChainMin" >
  <MinMover />
  <JumpClaim position1="ChainA" position2="ChainB" control_strength="MUST_CONTROL" />
</ScriptCM>
```

The only option taken by the top-level ScriptCM tag is name, which has no special meaning.

There are two types of allowed subtags for the ScriptCM. The first is the mover-instantiation subtag. If the tag's name---in the above example, "MinMover"---is not a Claim (more on these later), then the ScriptCM tries to interpret it as a mover to be instantiated. This works just like mover instantiation in the rest of RosettaScripts works, except that the mover must inherit from MoveMapMover, which requires implementation of the methods movemap and set_movemap. Only one such "client mover" is allowed, and the ScriptCM's apply simply calls the client's apply.

The second type of ScriptCM subtag is the Claim subtag. At the time of this writing, the available claims are: JumpClaim, TorsionClaim, XYZClaim, VirtResClaim, and CutBiasClaim. I don't expect this list to grow much, as there really aren't that many different kinds of DoFs available (only jump translations, jump rotations, torsions, bond length, and bond angles are represented in the atom tree), so think twice about writing your own. I (the author) would be happy to chat about this if you're thinking about it! Each of these Claims is used for selecting, and in some cases instantiating, certain DoFs within the nascent AtomTree during broking for movement by this ScriptCM. An arbitrary number of Claim subtags is permitted.

After broking is completed, the ScriptCM passes a MoveMap based on what the claim(s) allow the ScriptCM access to in the consensus Conformation. This MoveMap is then passed to the client mover via the required set_movemap method.

###JumpClaim

As shown in the example, the JumpClaim simultaneously creates and claims access to a Jump between to arbitrary regions in the consensus Conformation. The position1 option takes either a label (usually a virtual residue) or a ResidueSelector and places one end of the jump-to-be there. If the selection or label refers to more than one residue, the first one is chosen. The position2 option is the same. If the given label does not exist, a virtual residue will be created with that name.

The control_strength option sets the [ControlStrength](#ControlStrength) for the created jump RT. The "cut" option is the same as the position1 and position2 options, except that it sets the position of the cut built be the jump. It need not be between position1 and position2 but, if not specified, is chosen from the range between position1 and position2. The "atom1" and "atom2" options (must be supplied together) choose the atoms to and from (respectively) the jump is to be created. The default is "CA" if "physical_cut" is set to true or is placed such that the stub is within the residue--either "C" or "N" depending on folding direction--if "physical_cut" is false. In addition, the option "physical_cut" determines whether or not the upper and lower cut residues are scored as an artificial chainbreaks (false) or not (true). The jump must also be assigned a name via the "jump_label" option. At the moment, however, this name is only used as an internal unique identifier.

###TorsionClaim

The TorsionClaim claims access to a stretch of torsional angles. For example,

```
<TorsionClaim backbone=1 sidechain=0 selector="ChainA" control_strength="CAN_CONTROL" />
```
 
claims all backbone residues in the region selected by the ResidueSelector with the name "ChainA" with the strength "CAN_CONTROL". The "backbone" and "sidechain" boolean options determine, respectively, if backbone and sidechain angles are to be claimed. The "control_strength" option sets the [ControlStrength](#ControlStrength) with which these residues are to be claimed. 

###XYZClaim

The XYZClaim claims access to all degrees of freedom buidling a particular set of residues. This includes all bond lengths, angles, torisons as well as any applicable jump rotation and translation DoFs. For example,

```
<XYZClaim selection="known_loop1" control_strength="EXCLUSIVE"/>
```

Asserts EXCLUSIVE control (see ControlStrengths) over all degrees of freedom building the residues in the ResidueSelection "known_loop1".

###VirtResClaim

The VirtResClaim creates a virtual residue and a jump from some base position to build that virtual residue. A cut is also created to ensure the new virtual residue is not attached to any chain.

The "vrt_name" option sets the name of the virtual residue. If this virtual residue is to be used by other ClaimingMovers or claims, this is the name by which is should be referred. Note, however, that two VirtResClaims with the same name are not allowed--JumpClaims should be used to jump to and from the virtual residue when it does not need to be created. This is an intentional choice to allow the system to catch errors of accidental virtual residue duplication. An example demonstrating the importance of this feature is CoMTrackerCMs _really do_ need their own virtual residues--other Claims using that virtual residue are, in some sense, just guests.

Other options include "parent", a ResidueSelector or label indicating where the other end of the jump building the virtual residue should be and "jump_control_strength" setting the control strength of the built jump.

###CutBiasClaim

The CutBiasClaim adjusts the chance that an automatic cut is placed at the selected residues by the value of the option "bias" (required). Also required are "range_start" and "range_end", which indicate the beginning and end of the region within the selection given by the option "label" are to be modified with that bias. For example,

````
<CutBiasClaim bias=0.0 region_start=1 region_end=3 label="ChainA" />
```

would modify the cut bias of the first three residues in the selection ChainA to be zero (i.e. automatic cuts are forbidden). 

### ControlStrength

The available ControlStrengths are: DOES_NOT_CONTROL, CAN_CONTROL, MUST_CONTROL, and EXCLUSIVE. Their names are more or less self-explanatory. DOES_NOT_CONTROL does not (and hence cannot) control the DoF of interest. EXCLUSIVE is always granted access unless another EXCLUSIVE claim for the same DoF exists, in which case an exception is thrown. CAN_CONTROL is granted access if and only if there are no EXCLUSIVE claims. If such access cannot be granted however, nothing happens. MUST_CONTROL is as CAN_CONTROL, but an exception is thrown if an EXCLUSIVE claim prevents this Claim from being granted access to the claim. In almost all cases, CAN_CONTROL is the most appropriate choice.


# Using the Environment in RosettaScripts

Using an Environment in your RosettaScripts is as easy as

1. Defining your ClaimingMovers
2. Creating an Environment block in the PROTOCOL section
3. Adding your movers to the block.

## A simple example:

In the following example, a ChainResidueSelector selecting chains named "A" and "B" are used to build a [UniformRigidBodyCM](#UniformRigidBodyCM) that docks those two chains to one another. 

```
<RESIDUE_SELECTORS>
  <Chain name="ChainA" chains="A" />
  <Chain name="ChainB" chains="B" />
</RESIDUE_SELECTORS>
<MOVERS>
  <UniformRigidBodyCM name="dock" mobile="ChainA" stationary="ChainB" />
</MOVERS>
<PROTOCOL>
  <Add mover="SideChainMin"/>
</PROTOCOL>
```

## _Ab initio_ Example

The following example replicates an _ab initio_ run. The file "beta_sheets.top" contains a predicted beta-strand pairing topology, and the 9-mer and 3-mer fragments are in files called "frag9.dat" and "frag3.dat", respectively. Loops are closed after the [AbscriptMover](#AbscriptMover] runs all stages of abinitio by the [AbscriptLoopCloserCM], and then FastRelax refines the structure in full atom mode. The assumption is made here that the input pose is in centroid mode.

```
<MOVERS>
  <FragmentJumpCM name="jumps" topol_file="beta_sheets.top" />

  <AbscriptMover name="abinitio" cycles=2 frags="frag9.dat" small_frags="frag3.dat" >
    <Fragments large="frag9.dat" small="frag3.dat" />
    <Stage ids="I-IVb" >
      <Mover name="jumps" />
    </Stage>
  </AbscriptMover>

  <AbscriptLoopCloserCM name="closer" fragfile="frag3.dat" />

  <ResidueTypeSetSwitchMover name="fullatom" set="fa_standard" />
  <FastRelax name="relax" repeats=5 />
</MOVERS>

<PROTOCOLS>
  <Environment name="env" >
    <Add mover="abinitio" />
    <Add mover="closer" />
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
  <CoMTrackerCM name="com_A" selector="ChainA" />
  <CoMTrackerCM name="com_B" selector="ChainB" />
  <CoMTrackerCM name="com_C" selector="ChainC" />

  <UniformRigidBodyCM name="rigidA" mobile="com_A" stationary="star_center" />
  <UniformRigidBodyCM name="rigidB" mobile="com_B" stationary="star_center" />
  <UniformRigidBodyCM name="rigidC" mobile="com_C" stationary="star_center" />

  <TrialMover name="multidock" movers="rigidA,rigidB,rigidC" trials=1000 [...] />
</MOVERS>
<PROTOCOLS>
  <Environment name=multidock >
    <Apply name=multidock/>
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

  <ResidueTypeSetSwitchMover name=fullatom set=fa_standard />
  <FastRelax name=relax repeats=5 />
</MOVERS>
<PROTOCOLS>
  <Environment name=fold_and_dock >
    <Apply name=abintio />
  </Environment>
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