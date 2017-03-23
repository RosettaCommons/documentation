**ClientMovers** are the modular components that make up any protocol using the [[Broker framework|BrokeredEnvironment]]. ClientMovers produce [[EnvClaim]]s, which communicate to the broker which resources are required. There are several CMs that have already been implemented, and this page describes them. For information about how to write your own novel components for the Broker, check [[Developing for the Broker]].

By default, the broker is configured not to accept movers that are not ClientMovers. This provides fail-fast (_i.e._ broker-time) feedback to the user that the mover being used is likely not broker-compatible, rather than waiting until the mover makes some illegal move 45 minutes into the protocol before failing. It is not inconceivable, however, that a mover that is not a broker client could have legal behavior. For example, modifying the PDBInfo object is not a broker-secured operation and can be performed freely by any mover. The default broker-time check for non-client movers can be suppressed by setting the `allow_pure_movers` option true in the definition of the brokered environment.

[[_TOC_]]

# UniformRigidBodyCM
The UniformRigidBodyCM is a mover that interfaces between the broker and the UniformRigidBodyMover docking mover. The UniformRigidBodyMover expects a jump number but, for convenience, the UniformRigidBodyCM accepts ResidueSelectors or virtual residue names. For example,

```xml
<UniformRigidBodyCM name="rigid" mobile="com_A" stationary="com_B" />
```

creates a UniformRigidBodyMover named 'rigid' that docks 'com_A' to 'com_B'. If 'com_A' is a defined ResidueSelector, the jump will be constructed to attach to the first residue in that selection. Otherwise, a virtual residue will be created with that name. It behaves identically for 'com_B'. The only difference between the 'mobile' and 'stationary' tags is that the jump is expected to originate at the stationary position, so that the origin of the rotation encoded by the jump is centered there.


# FragmentCM
The FragmentCM does standard fragment insertion in a targeted region. A FragmentCM instantiation looks like:

```xml
<FragmentCM name="chA_large" frag_type="classic" fragments="frags9A" selector="ChainA" initialize=true />
```

Here, the FragmentCM with the name "chA_large" is instantiated using the fragments in the [[fragment file]] "frags9A" and told to insert those fragments using the "classic" policy (_c.f._ "smooth" insertion policy) in the region given by the ResidueSelector 'ChainA'. The option `initialize` can be used to set if the mover inserts a fragment at every position after broking is completed (useful during *ab initio* to start the structure off) or not. The option `nfrags` can be provided if there are a nonstandard number of fragments per position (default is 25). The option `yield_cut_bias` is used to indicate that this CM should use the loop fraction of the fragments to tell the broker which segments should have cuts in them.

The `fragments` and `selector` options are required. The `frag_type` tag defaults to classic.

**Warning:** When assigning fragments to a selection, the first residue of the selection is taken as the position onto which to insert the first fragment in the fragment set. No further logic is used, meaning that if your fragment set is longer than your chain, it will try to insert fragments onto the following chain. Furthermore, there is **no check** to determine that the residue of the fragment matches the residue in the pose, so you want to be *very sure* that you're assigning the fragments to the correct region, or your data will be silently garbage. 

# FragmentJumpCM

The FragmentJumpCM inserts beta-strand/beta-strand rigid-body translations into jumps between (predicted) adjacent beta-strands. An instantiation of this ClientMover looks like:

```xml
<FragmentJumpCM name="jumps" topol_file="beta_sheets.top" /> 
```

The valid option sets for this ClientMover are:

1. `topol_file` specifying a topology file. Such a file can be generated from a pdb file by Oliver Lange's `r_pdb2top` pilot app (`apps/pilot/olli/r_pdb2top.cc` as of this writing). For example:
    `r_pdb2top.linuxgccrelease -in:file:s start.pdb -out:top start.top`
2. `ss_info`, `n_sheets`, and `pairing_file`. These respectively require a PsiPred .ss2 file, a number of sheets to build (usually 1 or 2), and a "pairing file" indicating a list of residue-residue pairings (file format is unfortunately undocumented--see `core::scoring::dssp::read_pairing_list` for the required form of this file).
3. `restart_only`. In this case, the FragmentJumpCM requires the presence of `JumpSampleData` in the Pose's DataCache. Advanced use only.

# LoopCM

The LoopCM builds one of the following four movers: LoopMover_Perturb_KIC, LoopMover_Refine_KIC, LoopMover_Perturb_CCD, LoopMover_Refine_CCD. The algorithm is given by `algorithm` tag ("CCD" or "KIC") the form is given by the "style" tag ("refine" or "perturb"). An example follows.

```xml
<LoopCM name="kic_refine" style="refine" algorithm="kic" selector="loop1" />
```

The `selector` tag references a ResidueSelector, which is used to determine the torsional angles that will be moved in the loop modeling. The selection is expanded by one residue to accommodate certain loop modelers' quirks.

# RigidChunkCM

The RigidChunkCM holds a particular region of the pose constant (fixed to the coordinates in a given .pdb file) and prevents those torsional angles from being sampled by other movers. An example use:

```xml
<RigidChunkCM name="chunk" 
              template="1uufA.pdb" region_selector="template_selector"
              selector="simulation_selector" />
```

makes a RigidChunkCM called "chunk". The option "template" supplies the PDB file to copy from, or if you supply the string "INPUT", it will use the state of the pose at broker-time.

The `RigidChunkCM` also requires direction as to which regions of the template structure to take. This is specified in one of several ways. The first way is to use the `region_file` option. It takes a [[loops file]] to specify regions *from the template* that will be used to insert into the simulation. For example,

    RIGID 1 16 0 0 0
    RIGID 36 46 0 0 0
    RIGID 56 63 0 0 0

will take the regions 1-16, 26-46, and 56-63 from the template pose and insert them one-by-one into the residues specified by the `selector` option. Instead of using a [[loops file]], you can use a residue selector with the option `region_selector`, or an actual hard-coded region (*e.g.* "1-16,26-46,56-63") with the option `region`.

An additional selector is used to select specific regions from the simulation for insertion. This is done by providing a ResidueSelector with the option `selector`. Correspondence from the template (`region_selector`, `region_file`, `region`) to the simulation ResidueSelector (`selector`) is simply pairwise starting at the first residue in each selection. So, if the regions are (*a* - *b*) and (*x* - *y*), respectively, then residue *a* from the template will be inserted onto residue *x* in the simulation, residue (*a* + 1) onto (*x* + 1) and so forth, up to inserting residue *b* from the template onto residue *y* from the simulation. If (*b* - *a*) < (*y* - *x*) (*i.e.* there are more residues selected out of the template than in the simulation), the region will simply be truncated such that the last insertion of residue *b* from the template onto residue *x* + (*b* - *a*) in the simulation.

To further complicate matters, regions do not need to be contiguous. A region can be, for example, residues *a*-*b* and (*c* - *d*). If that is the selection from the template and simulation selector selects residues *w*-*x* and (*y* - *z*), *a* will be paired with *w*, (*a* + *i*) will be paired with (*w* + *i*) for *i* [1,*b*-*a*]. If (*b* - *a*) < (*x* - *w*), then *c* will be paired with *w* + (*x* - *b*)--in other words, the pairing continues ignoring the break in residues completely.

Sometimes, it's useful to apply a mover to the template just after it's loaded in. For example, given a full-atom PDB, we'd sometimes like to convert it to a centroid representation for *ab initio*-style simulations (this avoids problems with differing numbers of atoms in the template and simulation). Here, a SwitchResidueTypeSetMover is applied to the template before the template is used to set internal degrees of freedom in the simulation.

```xml
<SwitchResidueTypeSetMover name="centroid" set="centroid" />
<RigidChunkCM name="chunk" region_file="core.rigid" template="template.pdb" apply_to_template="centroid" />
```

Multiple movers can be separated by commas. Thus `apply_to_template="centroid,fullatom,centroid"` would apply the mover `centroid` followed by the mover `fullatom` followed by the mover `centroid` (and hence be equivalent to simply applying `centroid`).

# CoMTrackerCM

```xml
<CoMTrackerCM name=(&string) mobile_selector=(&string) />
```

The CoMTrackerCM creates a virtual residue that tracks a particular set of atoms in space. The only option is "mobile_selector", which indicates the region that is to be tracked. The "name" option is a bit special, as the virtual residue created will bear that name as well. Thus, other ClientMover that need to jump to or from that residue use that name.

# AbscriptLoopCloserCM
The AbscriptLoopCloserCM uses the WidthFirstSlidingWindowLoopCloser (used in _ab initio_ to close unphysical chainbreaks) to fix loops. An example instantiation is:

```xml
<AbscriptLoopCloserCM name="closer" fragments="frag3.dat" />
```

Where the fragfile option indicates a file where the fragments to be used to close the loop can be found.

It can also be supplied a specific score function to use during closure with the `scorefxn` option. If this option is not set, it defaults to `score3`. Any patches supplied by the `-abinitio::stage4_patch` flag will be included, and the `linear_chainbreak` score is controlled by the `-jumps::chainbreak_weight_stage4` flag. The `atom_pair_constraint` term can be controlled with `constraints::cst_weight`.

# AbscriptMover

The AbscriptMover is a special mover container that is used to replicate the state of _ab initio_ in early 2014. An example instantiation is

```xml
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

Here, the cycles tag is equivalent to the `-run:increase_cycles` flag in standard _ab initio_, multiplying the number of _ab initio_ cycles by that factor. This is important to think about because the number of fragment insertions is a fixed number, and will not automatically increase with increasing protein size. Values between 2 and 10 are recommended depending upon the difficulty of the protein and availability of processor time.

The `Stage` subtag is used to add movers to particular substages of *ab initio*, which given by the "id" option. Legal values are `I`, `II`, `IIIa`, `IIIb`, `IVa`, and `IVb`, and ranges are possible. Multiple Stage subtags are also possible. Stage III alternates between IIIa and IIIb and stage IV alternates between IVa and IVb. The "Mover" subtag of "Stage" names a mover with the "name" option (previously defined) to add.

Stages can be skipped by providing the "skip_stages" option with values "1", "2", "3", or "4" (or multiple stages separated by commas). 

Scoring at each of the four stages is modified by the `-abinitio::stage1_patch`, `-abinitio::stage2_patch`, `-abinitio::stage3_patch`, and `-abinitio::stage4_patch` flags.


### Fragments Subtag

The `Fragments` subtag is a macro used to add the appropriate ClassicFragmentMovers. Because three such movers exist (large fragments, normal insertion of small fragments, smooth insertion of small fragments) it is laborious to define all of these movers individually and add them to the appropriate stages using the usual API. This macro has the options `large` for 9-mer fragment files, `small` for 3-mer fragment files, and allows `selector` to set the ResidueSelector used to define the region of insertion. The 3-mer fragments loop fractions are also used to set cut biases used by the Broker to automatically place cuts (if necessary).

In other words, the code
```xml
<AbscriptMover name="abinitio" cycles="2" >
    <Fragments large_frags="frag9.dat" small_frags="frag3.dat" />
</AbscriptMover>
```

is roughly equivalent to the following:

```xml
<FragmentCM name="frag-large" frag_type="classic" fragments="frag9.dat" />
<FragmentCM name="frag-small" frag_type="classic" fragments="frag3.dat" yield_cut_bias=true />
<FragmentCM name="frag-smooth" frag_type="smooth" fragments="frag3.dat" />

<AbscriptMover name="abinitio" cycles="2" >
  <Stage ids="I-IIIb">
    <Mover name="frag-large" />
  </Stage>
  <Stage ids="IVa">
    <Mover name="frag-small" />
  </Stage>
  <Stage ids="IVb" >
    <Mover name="frag-smooth" />
  </Stage>
</AbscriptMover>
```

The macro is implemented in `AbscriptMover::add_frags`.

# ScriptCM

The ScriptCM is the most flexible of the ClientMover. It operates by dynamically instantiating ClientMovers and [[EnvClaim]]s as the user describes in the RosettaScript. The following example creates a mover that minimizes a jump between two residue selections built by ResidueSelectors named "ChainA" and one named "ChainB":

```xml
<ScriptCM name="SideChainMin" >
  <MinMover />
  <JumpClaim position1="ChainA" position2="ChainB" control_strength="MUST_CONTROL" />
</ScriptCM>
```

The only option taken by the top-level ScriptCM tag is name, which has no special meaning.

There are two types of allowed subtags for the ScriptCM. The first is the mover-instantiation subtag. If the tag's name (in the above example, "MinMover") is not an [[EnvClaim]] (more on these later), then the ScriptCM tries to interpret it as a mover to be instantiated. This works just like mover instantiation in the rest of [[RosettaScripts|RosettaScripts Documentation]] works, except that the mover must inherit from MoveMapMover, which requires implementation of the methods movemap and set_movemap. Only one such "client mover" is allowed, and the ScriptCM's apply simply calls the client's apply.

The second type of ScriptCM subtag is the Claim subtag. At the time of this writing, the available claims are: [[JumpClaim|EnvClaim#JumpClaim]], [[TorsionClaim|EnvClaim#TorsionClaim]], [[XYZClaim|EnvClaim#XYZClaim]], [[VirtResClaim|EnvClaim#VirtResClaim]], and [[CutBiasClaim|EnvClaim#CutBiasClaim]]. I don't expect this list to grow much, as there really aren't that many different kinds of DoFs available (only jump translations, jump rotations, torsions, bond length, and bond angles are represented in the atom tree), so think twice about writing your own. I (the author) would be happy to chat about this if you're thinking about it! Each of these Claims is used for selecting, and in some cases instantiating, certain DoFs within the nascent AtomTree during broking for movement by this ScriptCM. An arbitrary number of `Claim` subtags is permitted.

After broking is completed, the ScriptCM passes a MoveMap based on what the claim(s) allow the ScriptCM access to in the consensus Conformation. This MoveMap is then passed to the client mover via the required set_movemap method.


##See Also

* [[TopologyBroker home page|BrokeredEnvironment]]
* [[List of RosettaScripts movers|Movers-RosettaScripts]]
* [[Scripting Documentation]]: Scripting interfaces to Rosetta
* [[RosettaScripts]]: RosettaScripts home page
* [[Writing an app]]: Tutorial for writing a C++ app
* [[Development Documentation]]: Home page for developer documentation
* [[I want to do x]]: Guide for making specific structural perturbations using RosettaScripts
* [[Getting Started]]: A page for people new to Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Rosetta Servers]]: Web-based servers for Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.