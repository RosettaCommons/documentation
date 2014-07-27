The Environment framework, also known as the ToplogyBroker, is a tool for generating larger, more complex simulation systems out of small interchangeable parts. The intent is to make rapid protocol development in RosettaScript easier by allowing sampling strategies to be carried out simultaneously rather than in sequence by constructing a consensus FoldTree that satisfies all movers. Such Movers inherit from the ClaimingMover (CM) class.

**Author's Note:** If anything here doesn't make sense, doesn't work as advertised, or is otherwise demanding of attention, give me (the original developer) a shout at justinrporter at gmail.com. I spent quite a long time on this, and would love to see other folks using it, so if I can help, let me know!

# For the User
There are a few currently available ClaimingMovers (abbreviated CM) that are ready to go:
* UniformRigidBodyCM: perform unbiased, rigid-body docking between two selected regions.
* FragmentCM: perform backbone torsion-angle fragment insertion on a target region.
* FragmentJumpCM: beta-strand/beta-strand pairing fragment insertion
* LoopCM: access to loop closure algorithms KIC and CCD modes refine and perturb
* RigidChunkCM: fix a region to values given in a pdb file and prevent other movers from sampling there
* CoMTrackerCM: generate a virtual residue that tracks the center of mass of a particular region
* AbscriptLoopCloserCM: close loops using the WidthFirstSlidingWindowLoopCloser (used in _ab initio_ to close unphysical chainbreaks)
* ScriptCM: interface with the Broker system for an arbitrary movemap-accepting mover (_i.e._ inherits from MoveMapMover).

## UniformRigidBodyCM
The UniformRigidBodyCM is a mover that interfaces between the broker and the UniformRigidBodyMover docking mover. The UniformRigidBodyMover expects a jump number but, for convenience, the UniformRigidBodyCM accepts ResidueSelectors or virtual residue names. For example,

`<UniformRigidBodyCM name=rigid mobile=com_A stationary=com_B />`

creates a UniformRigidBodyMover named 'rigid' that docks 'com_A' to 'com_B'. If 'com_A' is a defined ResidueSelector, the jump will be constructed to attach to the first residue in that selection. Otherwise, a virtual residue will be created with that name. It behaves identically for 'com_B'. The only difference between the 'mobile' and 'stationary' tags is that the jump is expected to originate at the stationary position, so that the origin of the rotation encoded by the jump is centered there.


## FragmentCM
The FragmentCM does standard fragment insertion in a targeted region. A FragmentCM instantiation looks like:

`<FragmentCM name=chA_large frag_type="classic" fragments="frags9A" selector=ChainA />`

Here, the FragmentCm with the name "chA_large" is instantiated using the fragments in the file "frags9A" and told to insert those fragments using the "classic" policy (_c.f._ "smooth" insertion policy) in the region given by the ResidueSelector 'ChainA'.

The "fragments" and "selector" options are required. The "frag_type" tag defaults to classic.

## FragmentJumpCM

The FragmentJumpCM inserts beta-strand/beta-strand rigid-body translations into jumps between (predicted) adjacent beta-strands. An instantiation of this ClaimingMover looks like:

` <FragmentJumpCM name=jumps topol_file="beta_sheets.top" /> `

The valid option sets for this ClaimingMover are:

1 "topol_file" specifying a topology file. Such a file can be generated from a pdb file by Oliver Lange's "r_pdb2top" pilot app ("apps/pilot/olli/r_pdb2top.cc" as of this writing).

2 "ss_info", "n_sheets", and "pairing_file". These respectively require a PsiPred .ss2 file, a number of sheets to build (usually 1 or 2), and a "pairing file" indicating a list of residue-residue pairings (see core::scoring::dssp::read_pairing_list for the required form of this file).

3 "restart_only". In this case, the FragmentJumpCM requires the presence of JumpSampleData in the Pose's DataCache. Advanced use only.

## LoopCM

The LoopCM builds one of the following four movers: LoopMover_Perturb_KIC, LoopMover_Refine_KIC, LoopMover_Perturb_CCD, LoopMover_Refine_CCD. The algorithm is given by "algorithm" tag ("CCD" or "KIC") the form is given by the "style" tag ("refine" or "perturb"). An example follows.

`<LoopCM name=kic_refine style=refine algorithm=kic selector=loop1 />`

The "selector" tag references a ResidueSelector, which is used to determine the torsional angles that will be moved in the loop modeling. The selection is expanded by one residue to accommodate certain loop modelers' quirks.

## RigidChunkCM

The RigidChunkCM holds a particular region of the pose constant (fixed to the coordinates in a given .pdb file) and prevents those torsional angles from being sampled by other movers. An example use:

`<RigidChunkCM name=chunk region_file="core.rigid" template="template.pdb" />`

makes a rigid chunk claimer called "chunk". The option "template" supplies the PDB file to copy from, or the special value "INPUT" uses the input pose at broker-time. The option region_file specifies a loops file for regions that should be held constant. For example,

`RIGID 1 16 0 0 0`
`RIGID 36 46 0 0 0`
`RIGID 56 63 0 0 0`

would hold the regions 1-16, 26-46, and 56-63 fixed. The additional option 'label' indicates a ResidueSelector for the target region.

## CoMTrackerCM

The CoMTrackerCM creates a virtual residue that tracks a particular set of atoms in space. The only option is "mobile_selector", which indicates the region that is to be tracked. The "name" option is a bit special, as the virtual residue created will bear that name as well. Thus, other ClaimingMovers that need to jump to or from that residue use that name.

## AbscriptLoopCloserCM
The AbscriptLoopCloserCM uses the WidthFirstSlidingWindowLoopCloser (used in _ab initio_ to close unphysical chainbreaks) to fix loops. An example instantiation is

`<AbscriptMover name=abinitio cycles=2 frags="frag9.dat" small_frags="frag3.dat" >`
`  <Fragments large=frag9.dat small=frag3.dat/>`
   `<Stage ids=I-IVb>`
      `<Mover name=[MoverName]/>`
   `</Stage>`
`</AbscriptMover>`

## AbscriptMover

The AbscriptMover is a special mover container that is used to replicate the state of _ab initio_ in early 2014. An example instantiation is

``

## ScriptCM