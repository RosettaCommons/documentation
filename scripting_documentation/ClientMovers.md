ClientMover are the modular components that make up any protocol using the Broker framework. There are several CMs that have already been implemented, and this page describes them. For information about how to write your own novel components for the Broker, check the [BrokeredEnvironment](/docs/wiki/scripting_documentation/BrokeredEnvironment) page.

By default, the broker is configured not to accept movers that are not ClientMovers. This provides fail-fast (_i.e._ broker-time) feedback to the user that the mover being used is likely not broker-compatible, rather than waiting until the mover makes some illegal move 45 minutes into the protocol before failing. It is not inconceivable, however, that a mover that is not a broker client could have legal behavior. For example, modifying the PDBInfo object is not a broker-secured operation and can be performed freely by any mover. The default broker-time check for non-client movers can be suppressed by setting the `allow_pure_movers` option true in the definition of the brokered environment.

[[_TOC_]]

# UniformRigidBodyCM
The UniformRigidBodyCM is a mover that interfaces between the broker and the UniformRigidBodyMover docking mover. The UniformRigidBodyMover expects a jump number but, for convenience, the UniformRigidBodyCM accepts ResidueSelectors or virtual residue names. For example,

```
<UniformRigidBodyCM name="rigid" mobile="com_A" stationary="com_B" />
```

creates a UniformRigidBodyMover named 'rigid' that docks 'com_A' to 'com_B'. If 'com_A' is a defined ResidueSelector, the jump will be constructed to attach to the first residue in that selection. Otherwise, a virtual residue will be created with that name. It behaves identically for 'com_B'. The only difference between the 'mobile' and 'stationary' tags is that the jump is expected to originate at the stationary position, so that the origin of the rotation encoded by the jump is centered there.


# FragmentCM
The FragmentCM does standard fragment insertion in a targeted region. A FragmentCM instantiation looks like:

```
<FragmentCM name="chA_large" frag_type="classic" fragments="frags9A" selector="ChainA" />
```

Here, the FragmentCM with the name "chA_large" is instantiated using the fragments in the file "frags9A" and told to insert those fragments using the "classic" policy (_c.f._ "smooth" insertion policy) in the region given by the ResidueSelector 'ChainA'. The option "initialize" can be used to set if the mover inserts a fragment at every position after broking is completed (useful during abinitio to start the structure off) or not. The option "nfrags" can be provided if there are a nonstandard number of fragments per position (default is 25)

The "fragments" and "selector" options are required. The "frag_type" tag defaults to classic.

# FragmentJumpCM

The FragmentJumpCM inserts beta-strand/beta-strand rigid-body translations into jumps between (predicted) adjacent beta-strands. An instantiation of this ClientMover looks like:

```
<FragmentJumpCM name="jumps" topol_file="beta_sheets.top" /> 
```

The valid option sets for this ClientMover are:

1. "topol_file" specifying a topology file. Such a file can be generated from a pdb file by Oliver Lange's "r_pdb2top" pilot app ("apps/pilot/olli/r_pdb2top.cc" as of this writing). For example:
    `r_pdb2top.linuxgccrelease -in:file:s start.pdb -out:top start.top`
2. "ss_info", "n_sheets", and "pairing_file". These respectively require a PsiPred .ss2 file, a number of sheets to build (usually 1 or 2), and a "pairing file" indicating a list of residue-residue pairings (see core::scoring::dssp::read_pairing_list for the required form of this file).
3. "restart_only". In this case, the FragmentJumpCM requires the presence of JumpSampleData in the Pose's DataCache. Advanced use only.

# LoopCM

The LoopCM builds one of the following four movers: LoopMover_Perturb_KIC, LoopMover_Refine_KIC, LoopMover_Perturb_CCD, LoopMover_Refine_CCD. The algorithm is given by "algorithm" tag ("CCD" or "KIC") the form is given by the "style" tag ("refine" or "perturb"). An example follows.

```
<LoopCM name="kic_refine" style="refine" algorithm="kic" selector="loop1" />
```

The "selector" tag references a ResidueSelector, which is used to determine the torsional angles that will be moved in the loop modeling. The selection is expanded by one residue to accommodate certain loop modelers' quirks.

# RigidChunkCM

The RigidChunkCM holds a particular region of the pose constant (fixed to the coordinates in a given .pdb file) and prevents those torsional angles from being sampled by other movers. An example use:

```
<RigidChunkCM name="chunk" 
              template="1uufA.pdb" region_selector="template_selector"
              selector="simulation_selector" />
```

makes a rigid chunk claimer called "chunk". The option "template" supplies the PDB file to copy from, or if you supply the string "INPUT", it will use the state of the pose at broker-time.

The `RigidChunkCM` also requires direction as to which regions of the template structure to take. This is specified in one of several ways. The first way is to use the `region_file` option. It takes a [[loops file]] to specify regions *from the template* that will be used to insert into the simulation. For example,

    RIGID 1 16 0 0 0
    RIGID 36 46 0 0 0
    RIGID 56 63 0 0 0

will take the regions 1-16, 26-46, and 56-63 from the template pose and insert them one-by-one into the residues specified by the `selector` option. Instead of using a [[loops file]], you can use a residue selector with the option `region_selector`, or an actual hard-coded region (*e.g.* "1-16,26-46,56-63") with the option `region`.

An additional selector is used to select specific regions from the simulation for insertion. This is done by providing a ResidueSelector with the option `selector`. Correspondence from the template (`region_selector`, `region_file`, `region`) to the simulation ResidueSelector (`selector`) is simply pairwise starting at the first residue in each selection. So, if the regions are *a*-*b* and *x*-*y*, respectively, then residue *a* from the template will be inserted onto residue *x* in the simulation, residue *a* + 1 onto *x* + 1 and so forth, up to inserting residue *b* from the template onto residue *y* from the simulation. If *b*-*a* < *y*-*x* (*i.e.* there are more residues selected out of the template than in the simulation), the region will simply be truncated such that the last insertion of residue *b* from the template onto residue *x* + *b* - *a* in the simulation.

To further complicate matters, regions do not need to be contiguous. A region can be, for example, residues *a*-*b* and *c*-*d*. If that is the selection from the template and simulation selector selects residues *w*-*x* and *y*-*z*, *a* will be paired with w, *a*+*i* will be paired with *w*+*i* for *i* [1,*b*-*a*]. If *b*-*a* < *x*-*w*, then *c* will be paired with *w* + (*x* - *b*)--in other words, the pairing continues ignoring the break in residues completely.

Sometimes, it's useful to apply a mover to the template just after it's loaded in. For example, given a full-atom PDB, we'd sometimes like to convert it to a centroid representation for abinitio-style simulations (this avoids problems with differing numbers of atoms in the template and simulation). Here, a SwitchResidueTypeSetMover is applied to the template before the template is used to set internal degrees of freedom in the simulation.

```
<SwitchResidueTypeSetMover name="centroid" set="centroid" />
<RigidChunkCM name="chunk" region_file="core.rigid" template="template.pdb" apply_to_template="centroid" />
```

Multiple movers can be separated by commas. Thus `apply_to_template="centroid,fullatom,centroid"` would apply the mover `centroid` followed by the mover `fullatom` followed by the mover `centroid` (and hence be equivalent to simply applying `centroid`).

# CoMTrackerCM

```
<CoMTrackerCM name=(&string) selector=(&string) />
```

The CoMTrackerCM creates a virtual residue that tracks a particular set of atoms in space. The only option is "mobile_selector", which indicates the region that is to be tracked. The "name" option is a bit special, as the virtual residue created will bear that name as well. Thus, other ClientMover that need to jump to or from that residue use that name.

# AbscriptLoopCloserCM
The AbscriptLoopCloserCM uses the WidthFirstSlidingWindowLoopCloser (used in _ab initio_ to close unphysical chainbreaks) to fix loops. An example instantiation is:

```
<AbscriptLoopCloserCM name="closer" fragments="frag3.dat" />
```

Where the fragfile option indicates a file where the fragments to be used to close the loop can be found.

It can also be supplied a specific score function to use during closure with the `scorefxn` option. If this option is not set, it defaults to `score3`. Any patches supplied by the `-abinitio::stage4_patch` flag will be included, and the `linear_chainbreak` score is controlled by the `-jumps::chainbreak_weight_stage4` flag. The `atom_pair_constraint` term can be controlled with `constraints::cst_weight`.

# AbscriptMover

The AbscriptMover is a special mover container that is used to replicate the state of _ab initio_ in early 2014. An example instantiation is

```
<AbscriptMover name="abinitio" cycles=2 >
 <Fragments large_frags="frag9.dat" small_frags="frag3.dat" />
 <Stage ids="I-IVb" >
   <Mover name=[MoverName1]/>
 </Stage>
 <Stage ids="II">
   <Mover name=[MoverName2]/>
 </Stage>
</AbscriptMover>
```

Here, the cycles tag is equivalent to the "-run:increase_cycles" flag in standard _ab initio_, multiplying the number of _ab initio_ cycles by that factor. This is important to think about because the number of fragment insertions is a fixed number, and will not automatically increase with increasing protein size. Values between 2 and 10 are recommended depending upon the difficulty of the protein and availability of processor time.

The "Stage" subtag is used to add movers to particular substages of abinitio, which given by the "id" option. Legal values are I, II, IIIa, IIIb, IVa, and IVb, and ranges are possible. Multiple Stage subtags are also possible. Stage III alternates between IIIa and IIIb and stage IV alternates between IVa and IVb. The "Mover" subtag of "Stage" names a mover with the "name" option (previously defined) to add.

Stages can be skipped by providing the "skip_stages" option with values "1", "2", "3", or "4" (or multiple stages separated by commas). 

The "Fragments" subtag is a macro used to add the appropriate ClassicFragmentMovers. Because three such movers exist (large fragments, normal insertion of small fragments, smooth insertion of small fragments) it is laborious to define all of these movers individually and add them to the appropriate stages using the usual API. This macro has the options "large" for 9-mer fragment files, "small" for 3-mer fragment files, and allows "selector" to set the ResidueSelector used to define the region of insertion. The 3-mer fragments loop fractions are also used to set cut biases used by the Broker to automatically place cuts (if necessary).

Scoring at each of the four stages is modified by the `-abinitio::stage1_patch`, `-abinitio::stage2_patch`, `-abinitio::stage3_patch`, and `-abinitio::stage4_patch` flags.

# ScriptCM

The ScriptCM is the most flexible of the ClientMover. It operates by dynamically instantiating movers and claims as the user describes in the RosettaScript. The following example creates a mover that minimizes a jump between two residue selections built by ResidueSelectors named "ChainA" and one named "ChainB":

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

##JumpClaim

As shown in the example, the JumpClaim simultaneously creates and claims access to a Jump between to arbitrary regions in the consensus Conformation. The position1 option takes either a label (usually a virtual residue) or a ResidueSelector and places one end of the jump-to-be there. If the selection or label refers to more than one residue, the first one is chosen. The position2 option is the same. If the given label does not exist, a virtual residue will be created with that name.

The control_strength option sets the [ControlStrength](#ControlStrength) for the created jump RT. The "cut" option is the same as the position1 and position2 options, except that it sets the position of the cut built be the jump. It need not be between position1 and position2 but, if not specified, is chosen from the range between position1 and position2. The "atom1" and "atom2" options (must be supplied together) choose the atoms to and from (respectively) the jump is to be created. The default is "CA" if "physical_cut" is set to true or is placed such that the stub is within the residue--either "C" or "N" depending on folding direction--if "physical_cut" is false. In addition, the option "physical_cut" determines whether or not the upper and lower cut residues are scored as an artificial chainbreaks (false) or not (true). The jump must also be assigned a name via the "jump_label" option. At the moment, however, this name is only used as an internal unique identifier.

##TorsionClaim

The TorsionClaim claims access to a stretch of torsional angles. For example,

```
<TorsionClaim backbone=1 sidechain=0 selector="ChainA" control_strength="CAN_CONTROL" />
```
 
claims all backbone residues in the region selected by the ResidueSelector with the name "ChainA" with the strength "CAN_CONTROL". The "backbone" and "sidechain" boolean options determine, respectively, if backbone and sidechain angles are to be claimed. The "control_strength" option sets the [ControlStrength](#ControlStrength) with which these residues are to be claimed. 

##XYZClaim

The XYZClaim claims access to all degrees of freedom buidling a particular set of residues. This includes all bond lengths, angles, torisons as well as any applicable jump rotation and translation DoFs. For example,

```
<XYZClaim selection="known_loop1" control_strength="EXCLUSIVE" relative="false" />
```

Asserts EXCLUSIVE control (see ControlStrengths) over all degrees of freedom building the residues in the ResidueSelection "known_loop1".

An important option for this claim is "relative." This option determines if the XYZClaim is intended to claim the XYZ position of the selection *relative* to itself or absolutely in space. This most often determines if the jump building the XYZClaim selection is claimed or not (although it could just as easily be a peptide bond as well).

##VirtResClaim

The VirtResClaim creates a virtual residue and a jump from some base position to build that virtual residue. A cut is also created to ensure the new virtual residue is not attached to any chain.

The "vrt_name" option sets the name of the virtual residue. If this virtual residue is to be used by other ClientMover or claims, this is the name by which is should be referred. Note, however, that two VirtResClaims with the same name are not allowed--JumpClaims should be used to jump to and from the virtual residue when it does not need to be created. This is an intentional choice to allow the system to catch errors of accidental virtual residue duplication. An example demonstrating the importance of this feature is CoMTrackerCMs _really do_ need their own virtual residues--other Claims using that virtual residue are, in some sense, just guests.

Other options include "parent", a ResidueSelector or label indicating where the other end of the jump building the virtual residue should be and "jump_control_strength" setting the control strength of the built jump.

##CutBiasClaim

The CutBiasClaim adjusts the chance that an automatic cut is placed at the selected residues by the value of the option "bias" (required). Also required are "range_start" and "range_end", which indicate the beginning and end of the region within the selection given by the option "label" are to be modified with that bias. For example,

````
<CutBiasClaim bias=0.0 region_start=1 region_end=3 label="ChainA" />
```

would modify the cut bias of the first three residues in the selection ChainA to be zero (i.e. automatic cuts are forbidden). 

## ControlStrength

The available ControlStrengths are: DOES_NOT_CONTROL, CAN_CONTROL, MUST_CONTROL, and EXCLUSIVE. Their names are more or less self-explanatory. DOES_NOT_CONTROL does not (and hence cannot) control the DoF of interest. EXCLUSIVE is always granted access unless another EXCLUSIVE claim for the same DoF exists, in which case an exception is thrown. CAN_CONTROL is granted access if and only if there are no EXCLUSIVE claims. If such access cannot be granted however, nothing happens. MUST_CONTROL is as CAN_CONTROL, but an exception is thrown if an EXCLUSIVE claim prevents this Claim from being granted access to the claim. In almost all cases, CAN_CONTROL is the most appropriate choice.
