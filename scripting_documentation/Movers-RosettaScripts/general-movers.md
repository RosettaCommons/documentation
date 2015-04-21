[[_TOC_]]

These movers are general and should work in most cases. They are usually not aware of things like interfaces, so may be most appropriate for monomers or basic tasks.

# Packing/Minimization

## ForceDisulfides

Set a list of cysteine pairs to form disulfides and repack their surroundings. Useful for cases where the disulfides aren't recognized by Rosetta. The disulfide fixing uses Rosetta's standard, Conformation.fix\_disulfides( .. ), which only sets the residue type to disulfide. The repacking step is necessary to realize the disulfide bond geometry.

```
<ForceDisulfides name="&string" scorefxn=(score12 &string) disulfides=(&list of residue pairs)/>
```

-   scorefxn: scorefunction to use for repacking. Repacking takes place in 6A shells around each affected cystein.
-   disulfides: For instance: 23A:88A,22B:91B. Can also take regular Rosetta numbering as in: 24:88,23:91.

## PackRotamersMover

Repacks sidechains with user-supplied options, including TaskOperations

```
<PackRotamersMover name="&string" scorefxn=(score12 &string) task_operations=(&string,&string,&string)/>
```

-   scorefxn: scorefunction to use for repacking (NOTE: the error "Scorefunction not set up for nonideal/Cartesian scoring" can be fixed by adding 'Reweight scoretype="pro_close" weight="0.0"' under the talaris2013_cart scorefxn in the SCOREFXNS section)
-   taskoperations: comma-separated list of task operations. These must have been previously defined in the TaskOperations section.

## PackRotamersMoverPartGreedy

Greedily optimizes around a set of target residues, then repacks sidechains with user-supplied options, including TaskOperations. Given a task and a set of target residues, this mover will first greedily choose the neighbors of these residues, and then perform the usual simulated annealing on the rest (while maintaining the identity of the greedily chosen sidechains). The greedy choices are made one by one, i.e. first convert every neighbor of a given target sidechain to Ala, choose the lowest energy neighbor rotamer and minimize, then look at the rest of the neighbors and choose the best for interacting with the two chosen so far, and so on, until you're out of neighbor positions. If more than one target residues are specified, a random permutation of this list is used in each run of the mover.

```
<PackRotamersMoverPartGreedy name="&string" scorefxn_repack=(score12 &string) scorefxn_repack_greedy=(score12 &string) scorefxn_minimize=(score12 &string) distance_threshold=(8.0 &Real) task_operations=(&string,&string,&string) target_residues= (&string,&string) target_cstids=(&string,&string) choose_best_n=(0 &int)/>
```

-   scorefxn\_repack: scorefunction to use for repacking (for sim annealing)
-   scorefxn\_repack\_greedy: scorefunction to use for greedy design
-   scorefxn\_minimize: scorefunction to use for minimizing in greedy optimizaiton
-   taskoperations: comma-separated list of task operations
-   target\_residues: comma-separated list of target residues
-   target\_cstids: comma-separated list of target cstids (e.g. 1B,2B,3B etc)
-   choose\_best\_n: number of lowest scoring residues on a protein-ligand interface to use as targets
-   distance\_threshold: distance between residues to be considered neighbors (of target residue)

## MinMover

Does minimization over sidechain and/or backbone

```
<MinMover name="&string" scorefxn=(score12 &string) chi=(&bool) bb=(&bool) jump=(&string) cartesian=(&bool) type=(dfpmin_armijo_nonmonotone &string) tolerance=(0.01&Real)>
  <MoveMap>
    ...
  </MoveMap>
</MinMover>
```

Note that defaults are as for the MinMover class! Check MinMover.cc for the default constructor.

-   MinMover is also sensitive to a MoveMap block, just like FastRelax.
-   scorefxn: scorefunction to use during minimization
-   chi: minimize sidechains?
-   bb: minimize backbone?
-   jump: comma-separated list of jumps to minimize over (be sure this jump exists!). If set to "ALL", all jumps will be set to minimize. If set to "0", jumps will be set not to minimize.
-   type: minimizer type. linmin, dfpmin, dfpmin\_armijo, dfpmin\_armijo\_nomonotone. dfpmin minimzers can also be used with absolute tolerance (add "atol" to the minimizer type). See the [[Minimization overview]] for details.
-   tolerance: criteria for convergence of minimization. **The default is very loose, it's recommended to specify something less than 0.01.**
-   MoveMap: The movemap can be programmed down to individual degrees of freedom. See FastRelax for more details.

## CutOutDomain

Cuts a pose based on a template pdb. The two structures have to be aligned. The user supplies a start res num and an end res num of the domain on the **template pose** and the mover cuts the corresponding domain from the input PDB.

```
<CutOutDomain name="&string" start_res=(&int) end_res=(&int) suffix="&string" source_pdb="&string"/>
```

-   start\_res/end\_res: begin and end residues on the template pdb (e.g -s template.pdb)
-   suffix: suffix of outputted structure
-   source\_pdb: name of pdb to be cut

## TaskAwareMinMover

Performs minimization. Accepts TaskOperations via the task\_operations option e.g.

    task_operations=(&string,&string,&string)

to configure which positions are minimized. Options

    chi=(&bool) and bb=(&bool) jump=(0 &bool) scorefxn=(score12 &string)

control jump, sidechain or backbone freedom. Defaults to sidechain minimization. Options type, and tolerance are passed to the underlying MinMover.

To allow backbone minimization, the residue has to be designable. If the residue is only packable only the side chain will be minimized.

## MinPackMover

Packs then minimizes a sidechain before calling MonteCarlo on the change. It can be modified with user supplied ScoreFunction or TaskOperation. It does not do backbone, ridged body minimization.

```
<MinPackMover name="&string" scorefxn=("score12" &string) task_operations=(&string,&string,&string) nonideal=(0 &bool) cartesian=(0 &bool) off_rotamer_pack=(0 &bool)/>
```

It is reccomended to change the weights you are using to the **score12minpack** weights. These are the standard score12 weights with the reference energies refit for sequence recovery profile when using the MinPackMover. Without these weights you will see a lot of Tryptophan residues on the surface of a protein.

-   Tags:
-   **scorefxn** : scorefunction to use for packing and minimization, default is score12. It is reccomended to change this to **score12minpack** .
-   **task\_operations** : comma-separated list of task operations. These must have been previously defined in the TaskOperations section. Default is to design all residues.
-   **nonideal** : open up the bond-angle- and bond-length DOFs to minimization
-   **cartesian** : use cartesian minimization
-   **off_rotamer_pack** : instead of using core::pack::min_pack, use core::pack::off_rotamer_pack
-   What is the input FoldTree, what is the output FoldTree.
    -   The mover itself is not FoldTree sensitive, however the TaskOperations might be. This mover does not modify the fold tree.
    -   Does it take and output a default FoldTree or does it need/output a modified fold tree.
-   Does it take a pose with a certain chemical or topological property?
    -   Does not require a special type of Pose.
-   Does it change the length of the Pose?
    -   No.
-   Does it change the ConstraintSet?
    -   No.
-   When given some particular piece of data (mover? fragment set? scorefunction), does it keep a copy of it or a pointer to it?
    -   It does not modify the ScoreFunction.

## Sidechain

The "off rotamer" sidechain-only moves. The *SidechainMover* is a *[[ThermodynamicMover|MetropolisHastings-Documentation]]* .

```
<Sidechain name=(&string) preserve_detailed_balance=(1 &bool) task_operations=(&string,&string,&string) prob_uniform=(0.0 &real) prob_withinrot=(0.0 &real) prob_random_pert_current=(0.0 &real)/>
```

-   preserve\_detailed\_balance: balance acceptance criterion with proposal density ratio
-   task\_operations: list of operations for generating a PackerTask
-   prob\_uniform: probability of a "uniform" move - all sidechain chis are uniformly randomized between -180° and 180°
-   prob\_withinrot: "within rotamer" - sidechain chis are picked from the Dunbrack distribution for the current rotamer
-   prob\_random\_pert\_current: "random perturbation of current position" - the current sidechain chis are perturbed ±10° from their current positions, biased by the resulting Dunbrack energy. Note that if your score function contains a Dunbrack energy term, this will result in double counting issues.
-   If the previous three probabilities do not add to 1.0, the remainder is assigned to a "between rotamer" move - a random rotamer of the current amino acid is chosen, and chi angles for that rotamer are selected from the Dunbrack distribution

## SidechainMC

The "off rotamer" sidechain-only Monte Carlo sampler. For a rather large setup cost, individual moves can be made efficiently.

The underlying mover is still under development/benchmarking, so it may or may not work with backbone flexibility or amino acid identity changes.

```
<SidechainMC name=(&string) ntrials=(10000 &int) scorefxn=(score12 &string) temperature=(1.0 &real) inherit_scorefxn_temperature=(0 &bool) preserve_detailed_balance=(1 &bool) task_operations=(&string,&string,&string) prob_uniform=(0.0 &real) prob_withinrot=(0.0 &real) prob_random_pert_current=(0.0 &real)/>
```

-   ntrials: number of Monte Carlo trials to make per mover application - should be at least several thousand
-   scorefxn: score function used for acceptance
-   temperature: Boltzmann acceptance temperature - usually around 1.0
-   inherit\_scorefxn\_temperature: override scorefxn and temperature with values from [MetropolisHastings](#MetropolisHastings)
-   preserve\_detailed\_balance: balance acceptance criterion with proposal density ratio
-   task\_operations: list of operations for generating a PackerTask
-   prob\_uniform: probability of a "uniform" move - all sidechain chis are uniformly randomized between -180° and 180°
-   prob\_withinrot: "within rotamer" - sidechain chis are picked from the Dunbrack distribution for the current rotamer
-   prob\_random\_pert\_current: "random perturbation of current position" - the current sidechain chis are perturbed ±10° from their current positions, biased by the resulting Dunbrack energy. Note that if your score function contains a Dunbrack energy term, this will result in double counting issues.
-   - If the previous three probabilities do not add to 1.0, the remainder is assigned to a "between rotamer" move - a random rotamer of the current amino acid is chosen, and chi angles for that rotamer are selected from the Dunbrack distribution

## RotamerTrialsMover

This mover goes through each repackable/redesignable position in the pose, taking every permitted rotamer in turn, and evaluating the energy. Each position is then updated to the lowest energy rotamer. It does not consider coordinated changes at multiple residues, and may need several invocations to reach convergence.

In addition to the score function, the mover takes a list of task operations to specify which residues to consider. (See [[TaskOperations (RosettaScripts)|TaskOperations-RosettaScripts]] .)

```
<RotamerTrialsMover name="&string" scorefxn=(&string) task_operations=(&string,&string,&string) show_packer_task=(0 &bool) />
```

## RotamerTrialsMinMover

This mover goes through each repackable/redesignable position in the pose, taking every permitted rotamer in turn, minimizing it in the context of the current pose, and evaluating the energy. Each position is then updated to the lowest energy minimized rotamer. It does not consider coordinated changes at multiple residues, and may need several invocations to reach convergence.

In addition to the score function, the mover takes a list of task operations to specify which residues to consider. (See [[TaskOperations (RosettaScripts)|TaskOperations-RosettaScripts]] .)

```
<RotamerTrialsMinMover name="&string" scorefxn=(&string) task_operations=(&string,&string,&string) nonideal=(&bool)/>
```

## ConsensusDesignMover

This mover will mutate residues to the most-frequently occuring residues in a multiple sequence alignment, while making sure that the new residue scores well in rosetta. It takes a position specific scoring matrix (pssm) as input to determine the most frequently occuring residues at each position. The user defines a packer task of the residues which will be designed. At each of these positions only residues which appear as often or more often (same pssm score or higher) will be allowed in subsequent design. Design is then carried out with the desired score function, optionally adding a residues identity constraint proportional to the pssm score (more frequent residues get a better energy).

```
<ConsensusDesignMover name="&string" scorefxn=(&string) invert_task=(&bool) sasa_cutoff=(&float) use_seqprof_constraints=(&bool) task_operations=(&string)/>
```

-   scorefxn: Set the desired score function (defined in a the \<SCOREFXNS\> block)
-   taskoperations: Hand in a task operation defining the residues you want to design (or their inverse). Without a task\_operation and with invert\_task=0 everything will be designed.
-   use\_seqprof\_constraints: Only residues which appear more often in the pssm than the wild-type residue at position i are allowed in the packer task as position i. If use\_seqprof\_constraints = 0 all of those are allowed with equal probability -- that is, no extra constraint energy is added. If use\_seqprof\_constraints = 1 the more frequent residues are added to the packer task at residue i and each is granted a sequence constraint roughly proportional to the pssm score. In effect the more-frequent residues are included in proportion to their frequency of occurence in the pssm.
-   sasa\_cutoff: Buried residues (with sasa \< sasa\_cutoff) will not be designed. Surface residues (with sasa \> sasa\_cutoff) will be designed. To carry out consensus design on all residues in the task simply don't enter a sasa\_cutoff or set it to 0.
-   invert\_task: A common usage case is to take an interface/ligand packer task and then do consensus design for everything outside of that design (which is presumably optimized by rosetta for binding). That use requires a task that is the opposite of the original task. This flag turns on that inverted task.

# Idealize/Relax

## Idealize

Some protocols (LoopHashing) require the pose to have ideal bond lengths and angles. Idealize forces these values and then minimizes the pose in a stripped-down energy function (rama, disulf, and proline closure) and in the presence of coordinate constraints. Typically causes movements of 0.1A from original pose, but the scores deteriorate. It is therefore recommended to follow idealization with some refinement.

```
<Idealize name=(&string) atom_pair_constraint_weight=(0.0&Real) coordinate_constraint_weight=(0.01&Real) fast=(0 &bool) report_CA_rmsd=(1 &bool) ignore_residues_in_csts=(&comma delimited residue list) impose_constraints=(1&bool) constraints_only=(0&bool)/>
```

-   ignore\_residues\_in\_csts: set certain residues to not have coordinate constraints applied to them during idealization, meaning that they're free to move in order to form completely ideal bonds. Useful when, e.g., changing loop length and quickly making a chemically sensible chain.
-   impose\_constraints: impose the coordinate and pair constraints on the current pose?
-   constraints\_only: jump out of idealize after imposing the constraints without doing the actual idealization run?

impose\_constraints & constraints\_only can be used intermittently to break the idealize process into two stages: first impose the constraints on a 'realistic' pose without idealizing (constraints\_only=1), then mangle the pose and apply idealize again (impose\_constraints=0).

## FastRelax

Performs the fast relax protocol.

    <FastRelax name="&string" scorefxn=(score12 &string) repeats=(8 &int) task_operations=(&string, &string, &string)
      batch=(false &bool) ramp_down_constraints=(false &bool) 
      cartesian=(false &bool) bondangle=(false &bool) bondlength=(false &bool)
      min_type=(dfpmin_armijo_nonmonotone &string) relaxscript=("" &string) >
       <MoveMap name=(""&string)>
          <Chain number=(&integer) chi=(&bool) bb=(&bool)/>
          <Jump number=(&integer) setting=(&bool)/>
          <Span begin=(&integer) end=(&integer) chi=(&bool) bb=(&bool)/>
       </MoveMap>
    </FastRelax>

Options include:

-   scorefxn (default "score12")
-   repeats (default 8)
-   relaxscript (a filename for a relax script, as described in the [[documentation for the Relax application|relax]]; the default relax script is used if not specified)
-   sc\_cst\_maxdist &integer. Sets up sidechain-sidechain constraints between atoms up to maxdist, at neighboring sidechains. Need to also call ramp\_constraints = false, otherwise these will be turned off in the later rounds of relax.
-   task\_operations FastRelax will now respect any TaskOps passed to it. However, the default behavior is now to add RestrictToRepacking operation unless <code>disable_design=false</code> is set.
-   disable_design (default true) Disable design if TaskOps are passed?  Needs to be false if purposefully designing.
-   MoveMap name: this is optional and would actually not work with all movers. The name allows the user to specify a movemap that can later be called by another mover without specifying all of the options. Movers that do not support this functionality will exit with an error message.
-   jumps, bb torsions and chi angles are set to true (1) by default

The MoveMap is initially set to minimize all degrees of freedom. The movemap lines are read in the order in which they are written in the xml file, and can be used to turn on or off dofs. The movemap is parsed only at apply time, so that the foldtree and the kinematic structure of the pose at the time of activation will be respected.

## FastDesign

Performs a FastRelax with design enabled. By default, each repeat of FastDesign involves four repack/minimize cycles in which the repulsive energy term is initially very low and is increased during each cycle. Optionally, constraint weights can also be decreased during each cycle. This enables improved packing and scoring. This mover can use all FastRelax options, and in addition contains design-centric features.

    <FastDesign name="&string" scorefxn=(talaris2013 &string) clear_designable_residues=(false &bool) ramp_down_constraints=(false &bool) />

In addition to all options supported by FastRelax, FastDesign supports:

-   clear\_designable\_residues (default false): If set, all residues set to designable by the task operations will be mutated to alanine prior to design.
-   ramp\_down\_constraints (default false): If set, constraints will be ramped during the FastDesign process according to the relax script. By default, each repeat of FastDesign will use constraint weight multipliers of [ 1.0, 0.5, 0.0, 0.0 ] for the four design/minimize cycles. The constraints ramped are coordinate\_constraint, atom\_pair\_constraint, angle\_constraint and dihedral\_constraint.

# Docking/Assembly

## DockingProtocol

Runs the full (post refactoring) docking protocol with the defaults currently in trunk. This mover is not currently sensitive to symmetry.

```
<DockingProtocol name="&string" docking_score_low=(interchain_cen &string) docking_score_high=(docking &string) low_res_protocol_only=(0 &bool) docking_local_refine(0 &bool) dock_min=(0 &bool) ignore_default_docking_task=(0 &bool) task_operations=("" comma-separated list) partners=(&string)>
```

-   docking\_score\_low: score function used in centroid mode of the docking steps
-   docking\_score\_high: score function used in full atom mode of docking
-   low\_res\_protocol\_only: if true, only do centroid level docking
-   docking\_local\_refine: if true skip the centroid level and only do full atom docking
-   dock\_min: if true minimize the final full atom structure
-   partners: allows fold tree modifications to dock across multiple chains (example: docking chains L+H with A is partners="LH\_A")
-   ignore\_default\_docking\_task: allows you to ignore the default DockingTaskFactory set by docking and give it your own definition of an interface. Not suggested.
-   task\_operations: comma separated list of TaskOperations, these will be appended onto that defined by DockingTaskFactory, unless ignore\_default\_docking\_task is turned on.
-   partners: \_ separated list of chains to dock.

## FlexPepDock

Flexible peptide docking protocol. This tag encompasses 2 closely related protocols:

-   The **Refinement protocol** is intended for cases where an approximate, coarse-grain model of the interaction is available, as described in Raveh, London et al., Proteins 2010. The protocol iteratively optimizes the peptide backbone and its rigid-body orientation relative to the receptor protein, in addition to on-the-fly side-chain optimization. The pep\_refine option invokes the refinement protocol.
-   The **ab-initio protocol** extends the refinement protocol considerably, and is intended for cases where no information is available about the peptide backbone conformation, as described in Raveh et al., PLoS ONE Rosetta Special Collection, 2011. FlexPepDock ab-initio simultaneously folds and docks the peptide over the receptor surface, starting from any arbitrary (e.g., extended) backbone conformation. It is assumed that the peptide is initially positioned close to the correct binding site, but the protocol is robust to the exact starting orientation. The protocol is invoked by the lowres\_abinitio option, usually in combination with the pep\_refine option, for refinement of the resulting coarse model. It is recommended to also supply the protocol with fragment files of 3-mers, 5-mers (and 9-mers for peptides of length 9 or more).

**Basic options:**

-   min\_only (boolean) - Apply just a minimization step
-   pep\_refine (boolean) - Invoke the refinement protocol
-   lowres\_abinitio (boolean) - Invoke the ab-initio protocol
-   peptide\_chain (string) - Manually specify the peptide chain (default is the 2nd chain)
-   receptor\_chain (string) - Manually specify the receptor (protein) chain. (default is the 1st chain)
-   ppk\_only (boolean) - Just prepacking
-   scorefxn (string) - the score function to use
-   extra\_scoring (boolean) - scoring only mode

Note that only one of the 5 can exist in a tag: extra\_scoring,ppk\_only,pep\_refine,lowres\_abinitio,min\_only.

    <FlexPepDock name=(&string) min_only=(&boolean) pep_refine=(&boolean)
     lowres_abinitio=(&boolean) peptide_chain=(&string) receptor_chain=(&string) 
    ppk_only=(&boolean) scorefxn=(&string) extra_scoring=(&boolean)/>

# Backbone Design

## ConnectJumps

Given a pose with a jump, this mover uses a fragment insertion monte carlo to connect the specified termini. The new fragment will connect the C-terminal residue of jump1 to the N-terminal residue of jump2, and will have secondary structure and ramachandran space given by "motif." This mover uses the VarLengthBuild code. The input pose must have at least two chains (jumps) to connect, or it will fail. 

```
<ConnectJumps name=(&string) motif=("" &string) jump1=(1 &int) jump2=(2 &int) overlap=(3 &int) scorefxn=(&string) />
```

-   motif: The secondary structure + abego to be used for the backbone region to be rebuilt. Taken from input pose if not specified. The format of this string is:

    ```
    <Length><SS><ABEGO>-<Length2><SS2><ABEGO2>-...-<LengthN><SSN><ABEGON>
    ```

    For example, "1LX-5HA-1LB-1LA-1LB-6EB" will build a one residue loop of any abego, followed by a 5-residue helix, followed by a 3-residue loop of ABEGO BAB, followed by a 6-residue strand.

-   jump1: Indicates the jump which is to be located at the N-terminal end of the new fragment. Building will begin at the C-terminal residue of the jump.
-   jump2: Indicates the jump which is to be located at the C-terminal end of the new fragment.
-   overlap: Indicates the number of residues to rebuild before and after the new fragment. A value of 3 indicates that residues +/- 3 from the inserted segment will be rebuilt. This enable a smooth, continuous peptide chain.
-   scorefxn: **Required** The scorefunction to be used in the fragment insertion.

**Example**
 The following example connects the first jump in the protein with a 3-residue loop, a 10 residue helix and a 3-residue loop, and rebuilds residues that are +/- 4 positions from the inserted segment.

```
<SCOREFXNS>
    <SFXN name="SFXN" weights="fldsgn_cen" />
</SCOREFXNS>
<MOVERS>
    <ConnectJumps name="connect" jump1="1" jump2="2" motif="3LX-10HA-3LX" scorefxn="SFXN" overlap="4" />
</MOVERS>
<PROTOCOLS>
    <Add mover_name="connect" />
</PROTOCOLS>
```

# Backbone Movement

## SetTorsion

Sets a given torsion to a specified value.

```
<SetTorsion name="&string" resnum=(pdb/rosetta numbering) torsion_name=(&string) angle=(&real)/>
```

-   resnum: which residue? either rosetta numbering or pdb (25A)
-   torsion\_name: phi/psi.

## Shear

Shear style backbone-torsion moves that minimize downstream propagation.

```
<Shear name="&string" temperature=(0.5 &Real) nmoves=(1 &Integer) angle_max=(6.0 &Real) preserve_detailed_balance=(0 &bool)/>
```

-   temperature: what MC acceptance temperature to use (tests only the rama score, so not a full MC).
-   nmoves: how many consecutive moves to make.
-   angle\_max: by how much to perturb the backbone.
-   preserve\_detailed\_balance: If set to true, does not test the MC acceptance criterion, and instead always accepts.

See Rohl CA, et al. (2004) Methods Enzymol. Protein structure prediction using Rosetta, 383:66

## Small

Small-move style backbone-torsion moves that, unlike shear, do not minimize downstream propagation.

```
<Small name="&string" temperature=(0.5 &Real) nmoves=(1 &Integer) angle_max=(6.0 &Real) preserve_detailed_balance=(0 &bool)/>
```

-   temperature: what MC acceptance temperature to use (tests only the rama score, so not a full MC).
-   nmoves: how many consecutive moves to make.
-   angle\_max: by how much to perturb the backbone.
-   preserve\_detailed\_balance: If set to true, does not test the MC acceptance criterion, and instead always accepts.

See Rohl CA, et al. (2004) Methods Enzymol. Protein structure prediction using Rosetta, 383:66

## Backrub

Purely local moves using rotations around axes defined by two backbone atoms.

```
<Backrub name=(&string) pivot_residues=(all residues &string) pivot_atoms=(CA &string) min_atoms=(3 &Size) max_atoms=(34 &Size) max_angle_disp_4=(40/180*pi &Real) max_angle_disp_7=(20/180*pi &Real) max_angle_disp_slope=(-1/3/180*pi &Real) preserve_detailed_balance=(0 &bool) require_mm_bend=(1 &bool)/>
```

-   pivot\_residues: residues for which contiguous stretches can contain segments (comma separated) can use PDB numbers (\<resnum\>\<chain\>) or absolute Rosetta numbers (integer)
-   pivot\_atoms: main chain atoms usable as pivots (comma separated)
-   min\_atoms: minimum backrub segment size (atoms)
-   max\_atoms: maximum backrub segment size (atoms)
-   max\_angle\_disp\_4: maximum angular displacement for 4 atom segments (radians)
-   max\_angle\_disp\_7: maximum angular displacement for 7 atom segments (radians)
-   max\_angle\_disp\_slope: maximum angular displacement slope for other atom segments (radians)
-   preserve\_detailed\_balance: if set to true, does not change branching atom angles during apply and sets ideal branch angles during initialization if used with MetropolisHastings
-   require\_mm\_bend: if true and used with MetropolisHastings, will exit if mm\_bend is not in the score function

## InitializeByBins

This mover randomizes a stretch of polymer backbone in a biased manner, based on the probability of transitioning from one mainchain torsion bin at position i to another mainchain torsion bin at position i+1.  [[See the documentation on bin probability transitions|Bin-transition-probabilities-file]] for details.  See also the "randomize_backbone_by_bins" [[GeneralizedKICperturber]], which does something similar while enforcing chain closure, permitting this to be a local rather than a global move.  Note that this mover is intended to be usable with any polymeric residue type, provided a bin transition probability file can be generated for the type in question.

```
<InitializeByBins name=(&string) bin_params_file=(&string) start=(0 &int) end=(0 &int) / >
```
-   bin_params_file: A [[bin transition probability file|Bin-transition-probabilities-file]] specifying the probabilities of transitioning from a given bin at position i to another given bin at position i+1.
-   start:  The start of the residue range to which the perturbation will be applied.  If zero, then this is set to the first residue in the pose.
-   end:  The end of the residue range to which the perturbation will be applied.  If zero, then this is set to the last residue in the pose.

## PerturbByBins

This mover perturbs one or more residues in a stretch of polymer backbone in a biased manner, based on the torsion bins of the flanking two residues and on the probability of transitioning from one mainchain torsion bin at position i to another mainchain torsion bin at position i+1.  [[See the documentation on bin probability transitions|Bin-transition-probabilities-file]] for details.  See also the "perturb_backbone_by_bins" [[GeneralizedKICperturber]], which does something similar while enforcing chain closure, permitting this to be a local rather than a global move.  Note that this mover is intended to be usable with any polymeric residue type, provided a bin transition probability file can be generated for the type in question.

```
<PerturbByBins name=(&string) bin_params_file=(&string) start=(0 &int) end=(0 &int) must_switch_bins=(false &bool) repeats=(1 &int) / >
```
-   bin_params_file: A [[bin transition probability file|Bin-transition-probabilities-file]] specifying the probabilities of transitioning from a given bin at position i to another given bin at position i+1.
-   start:  The start of the residue range to which the perturbation will be applied.  If zero, then this is set to the first residue in the pose.
-   end:  The end of the residue range to which the perturbation will be applied.  If zero, then this is set to the last residue in the pose.
-   must_switch_bins:  If true, then the residue on which this mover is operating will be forced to switch to a different mainchain torsion bin.  If false, then the residue has some probability of remaining in the same mainchain torsion bin, in which case its mainchain torsion angles will be chosen randomly (based on the distribution within the bin, if that information is available).  False by default.
-   repeats:  The number of times a move is applied, where a move consists of picking a single residue in the range and randomizing its mainchain torsion bin based on the transition probabilities with its neighbours.  Set to 1 by default, meaning that only one residue in the range will have its mainchain torsion values altered.

## BackboneGridSampler
Generates a chain of identical residues and samples sets of mainchain torsion values, setting all residues to have the same set of mainchain torsion values.  This is useful for identifying secondary structures (particularly internally hydrogen-bonded, helical secondary structures) of novel heteropolymers.  Note that this mover discards any input geometry.

```
<BackboneGridSampler name=(&string) residue_name=("ALA" &string) scorefxn=(&string) max_samples=(10000 &int) selection_type=("low" &string) pre_scoring_mover=(&string) pre_scoring_filter=(&string) dump_pdbs=(false &bool) pdb_prefix=("bgs_out" &string) nstruct_mode=(false &bool) nstruct_repeats=(1 &int) residue_count=(12 &int) cap_ends=(false &bool)>
     <MainchainTorsion index=(&int) (value=(&Real) | start=(&Real) end=(&Real) samples=(&int) />
     <MainchainTorsion ... />
     <MainchainTorsion ... />
</BackboneGridSampler>
```

Options for this mover include:
-  **residue_name**:  The residue type that the polymer will be built from.  Default alanine.
-  **scorefxn**:  The scoring function used to pick the lowest-energy conformation (or highest-energy, if selection_type="high").  Required option.
-  **max_samples**:  The maximum number of grid-points sampled.  If the total number of grid-points exceeds this number, an error will be thrown and Rosetta will terminate.  This is to prevent unrealistically vast grids from being attempted inadvertently, though the user can always raise this number to allow larger grids to be sampled.
-  **selection_type**:  This is "low" by default, meaning that the lowest-energy conformation sampled (that passes pre-scoring movers and filters) will be the output pose.  Setting this to "high" results in the highest-energy conformation being selected.
-  **pre_scoring_mover**:  An optional mover that can be applied to the sampled poses before they are scored.  Sidechain-packing movers can be useful, here.  Mover exit status is respected, and failed movers result in discarded samples.
-  **pre_scoring_filter**:  An optional filter that can be applied to the sampled poses before they are scored.  Failed poses are discarded, and will not be selected even if they are the lowest in energy.
-  **dump_pdbs**:  If true, a PDB file is written for every conformation sampled that passes pre-scoring movers and filters.  False by default.
-  **pdb_prefix**:  If dump_pdbs is true, this is the prefix for the PDB files that are written.  A number is appended.  The default is for the prefix to be "bgs_out" (i.e. so that the PDB files are "bgs_out_0001.pdb", "bgs_out_0002.pdb", etc.).
-  **nstruct_mode**:  If true, then each job samples a different set of mainchain torsion values (with just one set of mainchain torsion values sampled per job).  This is useful for automatically splitting the sampling over many processors (assuming the MPI compilation of rosetta_scripts, which automatically splits jobs over processors, is used).  False by default, which means that every job samples every set of mainchain torsion values.
-  **nstruct_repeats**:  If set to a value N greater than 1, N consecutive jobs will sample the same set of mainchain torsion values.  This is useful for repeat sampling -- if, for example, you want to apply a stochastic mover to each grid-point sampled.
-  **residue_count**:  The number of residues in the generated chain.  Twelve (12) by default.
-  **cap_ends**:  If true, the lower terminus is acetylated and the upper terminus is aminomethylated.  This can be a good idea for backbones linked by peptide bonds, to avoid charges at the ends of the helix.  False by default.

**MainchainTorsion** blocks are used to define mainchain torsions to sample, or to hold fixed.  If a mainchain torsion is not specified, it is held fixed at its default value (based on the residue params file).  Each **MainchainTorsion** tag has the following options:

-  **index**:  The index of the mainchain torsion.  (e.g.  For alpha-amino acids, **index=1** is phi, **index=2** is psi, **index=3** is omega).
-  **value**:  A fixed value to which this mainchain torsion should be set.  This prevents sampling, and cannot be used in conjunction with the **start**, **end**, or **samples** options.
-  **start**:  The start value of a range to be sampled.  Cannot be used in conjunction with the **value** option.
-  **end**:  The end value of a range to be sampled.  Cannot be used in conjunction with the **value** option.
-  **samples**:  The number of samples within a range to be sampled.  Cannot be used in conjunction with the **value** option.  The total number of samples will be the product of all of the **samples** options.

# Constraints

## ClearConstraintsMover

Remove any constraints from the pose.

    <ClearConstraintsMover name=(&string) />

## ConstraintSetMover

Adds or replaces constraints in the pose using the constraints' read-from-file functionality.

```
<ConstraintSetMover name=(&string) add_constraints=(false &bool) cst_file=(&string)/>
```

cst\_file: the file containing the constraint data. e.g.,:

    ...
    CoordinateConstraint CA 380 CA 1   27.514  34.934  50.283 HARMONIC 0 1
    CoordinateConstraint CA 381 CA 1   24.211  36.849  50.154 HARMONIC 0 1
    ...
The format for Coordinate constraint files is:
CoordinateConstraint target_res anchor_res x y z function

To remove constraints from the pose create a mover with cst\_file=none.

-  add_constraints: if set to true, the constraints will be added to the current pose, otherwise, the constraints read from the disk will replace the current constraints in the pose. (this is tricky and confusing so beware!)

## ResidueTypeConstraintMover

Adds ResidueTypeConstraint to the pose using ResidueTypeConstraint
(gives preferential bonus point to selected residues)

```
<ResidueTypeConstraintMover name="&string" AA_name3="&string" favor_bonus=(0.5 &real)/>
```

For example,

```
<ROSETTASCRIPTS>
        <TASKOPERATIONS>
             <ReadResfile name=resfile filename=c.0.0_resfile_for_ideal_distance_between_sheets.txt/>
        </TASKOPERATIONS>
        <SCOREFXNS>
                <cart_score weights=talaris2013_cart>
                  <Reweight scoretype=res_type_constraint weight=1/>
                </cart_score>
        </SCOREFXNS>
        <FILTERS>
        </FILTERS>
        <MOVERS>
		<SwitchResidueTypeSetMover name=to_fa set=fa_standard/>
                <ResidueTypeConstraintMover name=favor_residue AA_name3=ASP,GLU favor_bonus=0.5/>
                <FastRelax name=RelaxDesign scorefxn=cart_score task_operations=resfile/>
        </MOVERS>
        <APPLY_TO_POSE>
        </APPLY_TO_POSE>
        <PROTOCOLS>
           <Add mover=to_fa/>
           <Add mover=favor_residue/>
           <Add mover=RelaxDesign/>
       </PROTOCOLS>
</ROSETTASCRIPTS>
```



## TaskAwareCsts

Add coordinate constraints to all residues that are considered designable by the task\_operations. Mean and SD are hardwired to 0,1 at present. If you want to use this, don't forget to make downstream movers aware of coordinate constraints by changing their scorefxn's coordinate\_constraint weight.

```
<TaskAwareCsts name=(&string) anchor_resnum=("" &string) task_operations=(&comma-delimited list of task operations)/>
```
-  anchor_resnum: which residue to use as anchor for the coordinate constraints? Since Rosetta conformation sampling is done in torsion space coordinate constraints are relative to a position. If this option is not set the anchor is set to the first designable residue defined in the task_operations. Use general pose numbering here: 3 means 3rd residue in the pose, whereas 3B means residue 3 in chain b. The residue number is parsed at apply time.
-  task_operations: residues defined as designable have coordinate restraints placed on their CAs.


## AddConstraintsToCurrentConformationMover

Add constraints to the pose based on the current conformation. It can either apply coordinate constraints to protein Calpha and DNA heavy atoms (the default) or atom pair distance constraints between protein Calpha pairs. The functional form for the coordinate constraints can either be harmonic or bounded (flat-bottom), whereas atom pair distance constraints are currently only gaussian in form.

    <AddConstraintsToCurrentConformationMover name=(&string) 
    use_distance_cst=(&bool 0) coord_dev=($Real 1.0) bound_width=(&Real 0) 
    min_seq_sep=(&Real 8) max_distance=(&Real 12.0) cst_weight=(&Real 1.0) 
    task_operations=(&comma-delimited list of taskoperations) CA_only=(&bool 1) bb_only=(&bool 0)
     />

-   use\_distance\_cst - if true, use atom-atom pair distance constraints, otherwise use coordinate constraints.
-   coord\_dev - Controls how quickly constraints increase with increasing deviation for all three constraint types. A value in Angstroms, with smaller numbers being tighter constraints.
-   bound\_width - for coordinate constraints, if non-zero (actually, greater than 1e-3) use bounded constraints with the given flat-bottom width. If zero, use harmonic constraints.
-   min\_seq\_sep - for atom pair distance constraints, the minimum sequence separation between pairs of constrained residues.
-   max\_distance - for atom pair distance constraints, the maximum Cartesian distance between pairs of constrained Calpha atoms. - Note: Because of implementation details, the value of the constraint will be forced to zero at distances greater than 10 Ang, regardless of the max\_distance setting.
-   cst\_weight - for atom pair distance constraints, the scaling factor
-   task\_operations - apply constraints to residues which are non-packing and non-design ones. Leave it empty if want to apply constraints to all residues
-   CA\_only -Apply constraints only on CA atom. Otherwise, apply to all non-hydrogen atoms (in coordinate constraints).
-   bb\_only - Only apply to backbone heavy atoms (only support in coordinate constraints)

(Remember that to have effect, the appropriate scoreterm - "coordinate\_constraint" or "atom\_pair\_constraint" - must be nonzero in the scorefunction.)

## AtomCoordinateCstMover

The mover which adds coordinate constraints to the pose for the relax application. Coordinate constraints are added to the pose according to the state of the pose at apply time, or based on a separate native pose.

```
<AtomCoordinateCstMover name=(&string) coord_dev=(&Real 0.5) bounded=(&bool false) bound_width=(&Real 0) sidechain=(&bool false) native=(&bool false) task_operations=(&comma-delimited list of taskoperations) />
```

-   coord\_dev - the strength/deviation of the constraints to use (e.g. -relax:coord\_cst\_stdev)
-   bounded - whether to use harmonic (false) or bounded (true) constraints
-   bound\_width - the width of the bounded constraint (e.g. -relax::coord\_cst\_width)
-   sidechain - whether to constrain just the backbone heavy atoms (false) or all heavy atoms (true) (e.g. -relax:coord\_constrain\_sidechains)
-   native - if true, use the pose from -in:file:native as the reference instead of the pose at apply time. A heuristic based on the size and PDB designations is used to match up residues in the two poses. Poses of differing sequences can be used, even for sidechain constraints. Only matching atoms will be constrained.
-   task\_operations - if given, only apply constraints to those residues which are listed as packable by the task\_operations. If not given, apply constraints to all residues in the pose.

Remember that to have effect, the coordinate\_constraint scoreterm must be on in the scorefunction. It is highly recommended that you apply a virtual root to your pose prior to applying these constraints, especially if you're constraining against a native. (See the [VirtualRoot](#VirtualRoot) mover.)

## FavorSymmetricSequence

Add ResidueTypeLinkingConstraints to the pose such that a symmetric sequence (CATCATCAT) will be favored during design. You should add this mover before sequence design is performed.

    <FavorSymmetricSequence penalty=(&real) name=symmetry_constraints symmetric_units=(&size)/> 

-   penalty should be a positive Real number and represents the penalty applied to a pair of asymmetric residues.
-   symmetric\_units should be a positive Integer representing the number of symmetric units in the sequence. It should be a value of 2 or greater

The total constraint score is listed as 'res\_type\_linking\_constraint'

# Fragment Insertion

## SingleFragmentMover

Performs a single fragment insertion move on the pose. Respects the restrictions imposed by the user-supplied *MoveMap* and underlying kinematics of the pose (i.e. *FoldTree* ). By default, all backbone torsions are movable. The *MoveMap* parameter is used to specify residues that should remain fixed during the simulation. Insertion positions are chosen in a biased manner in order to have roughly equivalent probability of acceptance at each allowable insertion position. This has traditionally been referred to as "end-biasing." Once an insertion position has been chosen, a *Policy* object is responsible for choosing from among the possible fragments contained in the fragment file. Currently, two policies are supported-- "uniform" and "smooth." The former chooses uniformly amongst the set of possibilities. The latter chooses the fragment that, if applied, causes minimal distortion to the pose.

In order to be useful, *SingleFragmentMover* should be paired with a Monte Carlo-based mover. If you're folding from the extended chain, "GenericMonteCarloMover" is a common choice. When folding from a reasonable starting model, "GenericMonteCarloMover" is \*not\* recommended-- it unilaterally accepts the first move. A simplified version of the *ClassicAbinitio* protocol is recapitulated in demo/rosetta\_scripts/classic\_abinitio.xml.

Input is \*not\* restricted to monomers. Oligomers work fine.

```

<SingleFragmentMover name=(&string) fragments=(&string) policy=(uniform &string)>
  <MoveMap>
    <Span begin=(&int) end=(&int) chi=(&int) bb=(&int)/>
  </MoveMap>
</SingleFragmentMover>
```

# Symmetry

The following set of movers are aimed at creating and manipulating symmetric poses within RosettaScripts. For the complete symmetry documentation, see the "Symmetry User's Guide" in Rosetta's Doxygen documentation.

Notice that symmetric poses must be scored with symmetric score functions. See the 'symmetric' tag in the RosettaScripts score function documentation.

## SetupForSymmetry

Given a symmetry definition file that describes configuration and scoring of a symmetric system, this mover "symmetrizes" an asymmetric pose. For example, given the symmetry definition file 'C2.symm':

```
<SetupForSymmetry name=setup_symm definition=C2.symm/>
```

## DetectSymmetry

This mover takes a non-symmetric pose composed of symmetric chains and transforms it into a symmetric system. It only works with cyclic symmetries from C2 to C99.

```
<DetectSymmetry name=detect subunit_tolerance(&real 0.01) plane_tolerance=(&real 0.001)/>
```

subunit\_tolerance: maximum tolerated CA-rmsd between the chains. plane\_tolerance: maximum accepted displacement(angstroms) of the center of mass of the whole pose from the xy-plane.

## SymDofMover

Used to setup symmetric systems in which the input structures(s) are aligned along the x, y, or z axis. All functionality, except for grid sampling, can handle any number of distinct input structures for multi-component symmetric systems (Grid sampling can handle 1 or 2). Input subunits are first optionally flipped 180 degrees about the specified axes (x, y, or z) to "reverse" the inputs if desired, then translated along the specified axes (x, y, or z) by the values specified by the user in the radial\_disps option and rotated about the specified axes by the value specified by the user in the angles option, and lastly, if the user specifies axes for the align\_input\_axes\_to\_symdof\_axes option, then for each input subunit the user specified axis (x, y, or z) is aligned to the correct axis corresponding to the sym\_dof\_name in the symmetry definition file. Following these initial manipulations of the input structures, a symmetric pose is generated using the user specified symmetry definition file. If one wishes to sample around the user defined radial\_disps and angles, then this can be done either through non-random grid sampling, random sampling from a Gaussian distribution within a user defined range, or random sampling from a uniform distribution within a user defined range. Each sampling method is driven by nstruct. If grid sampling is desired, then the user must specify radial\_disps\_range\_min, radial\_disps\_range\_max, angles\_range\_min, angle\_range\_max to define the range within to sample around the docked configuration and the bin sizes in which to sample these displacements and angles, which are set through the radial\_disp\_steps and angle\_steps options. If uniform sampling is desired, then the user must specify radial\_disps\_range\_min, radial\_disps\_range\_max, angles\_range\_min, and angle\_range\_max. If Gaussian sampling is desired, then the user must specify the radial\_disp\_deltas and angle\_deltas (a random number derived from a Gaussian distribution between -1 and 1 will then be multiplied by these step values and added to the initial radial\_disps or angles). If the auto\_range option is set to true, then the ranges set by the user for the grid or uniform sampling will be interpreted by the mover such that negative values move the structures toward the origin and positive values move the structures away from the origin (this is helpful if you have a mix of structures with negative or positive initial displacements, so that you can use a generic xml or run\_script for all of them).

    <SymDofMover name=(&string)  symm_file=(&string)  sym_dof_names=(&comma-delimited list of strings) flip_input_about_axes=(&comma-delimited list of chars) translation_axes=(&comma-delimited list of chars) rotation_axes=(&comma-delimited list of chars) align_input_axes_to_symdof_axes=(&comma-delimited list of chars) auto_range=(false &bool) sampling_mode=("single_dock" &string) 
    radial_disps=(&string) angles=(&string) radial_disps_range_min=(&string) radial_disps_range_max=(&string) angles_range_min=(&string) angles_range_max=(&string) radial_disp_steps=(&string) 
    angle_steps=(&string) radial_disp_deltas=(&strings) angle_deltas=(&string) radial_offsets=(&strings) set_sampler=(true &bool)/>

-   symm\_file - Symmetry definition file.
-   sym\_dof\_names - Names of the sym\_dofs in the symmetry definition file along which one wishes to move or rotate the input. NOTE: For multicomponent systems, the order of the displacements, angles, ranges, and steps must correspond with the the order of the sym\_dof\_names. Passed as a string with comma-separated list (e.g. sym\_dof\_names="JTP1,JDP1")
-   flip\_input\_about\_axes - Rotate subunits 180 degrees about the specified axes prior to applying transtions, rotations, alignment, and symmetry. ie, "reverse" the component before further manipulation.
-   translation\_axes - Axes (x, y, or z) along which to translate each subunit prior to applying symmetry.
-   rotation\_axes - Axes (x, y, or x) along which to rotate each subunit prior to applying symmetry.
-   align\_input\_axes\_to\_symdof\_axes - If specified, will align the specified axis of each subunit with the corresponding axis of the symdof jump from the symmetry definition file.
-   auto\_range - Boolean to set the manner in which the user defined ranges for radial displacements are interpreted. If set to true, then the negative values for min or max displacement are interpreted as moving the structure closer to the origin and positive values away from the origin.
-   sampling\_mode - Which mode to use to sample around the initial configuration, if desired. "grid", "uniform", or "gaussian"
-   radial\_disps - Initial displacement(s) by which to translate the input structure(s) along the user specified axis. Passed as a string with a comma-separated list (e.g. radial\_disps="-65.4,109.2")
-   angles - Initial angle(s) by which to rotate the input structure(s) about the user specified axis. Passed as a comma-separated list (e.g. angles="-65.4,109.2")
-   radial\_disps\_range\_min - For use with grid or uniform sampling. Minimum distance(s) in Angstroms by which to modify the initial radial\_disps. Passed as a string with a comma-separated list (e.g. radial\_disps\_range\_min="-1,-1".
-   radial\_disps\_range\_max - For use with grid or uniform sampling. Maximum distance(s) in Angstroms by which to modify the initial radial\_disps. Passed as a string with a comma-separated list (e.g. radial\_disps\_range\_max="1,1".
-   angles\_range\_min - For use with grid or uniform sampling. Minimum angle(s) in degrees by which to rotate the structure around the initial angle(s) provided by the user. Passed as a string with a comma-separated list (e.g. angles\_range\_min="-1,-1".
-   angles\_range\_max - For use with grid or uniform sampling. Maximum angle(s) in degrees by which to rotate the structure around the initial angle(s) provided by the user. Passed as a string with a comma-separated list (e.g. angles\_range\_max="1,1".
-   radial\_disp\_steps - For use with grid sampling. Set the bin size(s) by which to sample within the user defined range(s). Passed as a string with a comma-separated list (e.g. radial\_disps\_steps="0.5,0.5".
-   angle\_steps - For use with grid sampling. Set the bin size(s) by which to sample within the user defined range(s). Passed as a string with a comma-separated list (e.g. angle\_steps="0.5,0.5".
-   radial\_disp\_deltas - For use with Gaussian sampling. The range within to sample inward and outward around the user specified initial displacement(s). Passed as a string with a comma-separated list (e.g. radial\_disp\_deltas="0.5,0.5".
-   angle\_deltas - For use with Gaussian sampling. The range within to sample around the user specified initial angle(s). Passed as a string with a comma-separated list (e.g. angle\_deltas="0.5,0.5".
-   radial\_offsets - Can be used in any sampling mode. Offset value(s) are added to the corresponding radial\_disps before grid, uniform, or gaussian sampling is performed. Works with auto\_range. For example, if one wants to space out both symdofs a given structure by 2 angstroms, one can pass radial\_offsets="2,2" and auto\_range=true. Then, regardless of the sign of the radial disps, the subunits will be displaced 2 angstroms further from the origin (assuming the input subunit(s) start at the origin).
-   set\_sampler - For use with the GetRBDOFValues filter.  If set to false, then the RBDOF values will not be updated when the reported DOF values are not affected by the SymDofMoverSampler. Defaults to true.

## ExtractAsymmetricUnit

The inverse of SetupForSymmetry: given a symmetric pose, make a nonsymmetric pose that contains only the asymmetric unit.

```
<ExtractAsymmetricUnit name=extract_asu/>
```

<!--- BEGIN_INTERNAL -->
## ExtractSubpose

(This is a devel Mover and not available in released versions.)

Used to extract a subset of the subunits from a symmetric pose based on contacts with a user specified component (via sym\_dof\_name(s)). This subpose is dumped as a pdb with the user specified prefix, suffix, and basename derived from the job distributer. DOES NOT MODIFY THE POSE. For each sym\_dof\_name passed by the user, all neighboring subunits (as assessed by CA or CB contacts with the user specified contact\_distance (10.0 A by default)). If extras=true, then all the full building block for each sym\_dof will be extracted along with all touching building blocks.

    <ExtractSubpose name=(&string) sym_dof_names=(&string) prefix=("" &string) suffix=("" &string) contact_dist=(10.0 &Real) extras=(0 &bool) />

-   sym\_dof\_names - Name(s) of the sym\_dofs corresponding to the primary component(s) to extract along with the neighboring subunits/building blocks. Passed as a string (optionally: with a comma-separated list).
-   prefix - Optional prefix for the output pdb name.
-   suffix - Optional suffix for the output pdb name.
-   contact\_dist - Maximum CA or CB distance from any residue in the primary component(s) to any residue in another component for it to be considered a "neighbor" and added to the extracted subpose.
-   extras - Boolean option to set whether or not full building blocks are extracted rather than just subunits.

<!--- END_INTERNAL --> 

## ExtractAsymmetricPose

Similar to ExtractAsymmetricUnit: given a symmetric pose, make a nonsymmetric pose that contains the entire system (all monomers). Can be used to run symmetric and asymmetric moves in the same trajectory.

```
<ExtractAsymmetricPose name=extract_asp/>
```

## SymPackRotamersMover and SymRotamerTrialsMover

The symmetric versions of pack rotamers and rotamer trials movers (they take the same tags as asymmetric versions)

```
<SymPackRotamersMover name=symm_pack_rot scorefxn=score12_symm task_operations=.../>
<SymRotamerTrialsMover name=symm_rot_trials scorefxn=score12_symm task_operations=.../>
```

## SymMinMover

The symmetric version of min mover (they take the same tags as asymmetric version). Notice that to refine symmetric degrees of freedom, all jumps must be allowed to move with the tag 'jump=ALL'.

```
<SymMinMover name=min1 scorefxn=ramp_rep1 bb=1 chi=1 jump=ALL/>
```

## Example: Symmetric FastRelax

The following RosettaScript runs a protocol similar to Rosetta's symmetric fast relax using the symmetric pack rotamers and symmetric min mover (note that the fastrelax mover respects symmetric poses, this example is merely done to illustrate the symmetric movers).

```
<ROSETTASCRIPTS>
    <TASKOPERATIONS>
        <InitializeFromCommandline name=init/>
        <RestrictToRepacking name=restrict/>
        <IncludeCurrent name=keep_curr/>
    </TASKOPERATIONS>
    <SCOREFXNS>
        <ramp_rep1 weights=score12_full symmetric=1>
            <Reweight scoretype=fa_rep weight=0.0088/>
        </ramp_rep1>
        <ramp_rep2 weights=score12_full symmetric=1>
            <Reweight scoretype=fa_rep weight=0.11/>
        </ramp_rep2>
        <ramp_rep3 weights=score12_full symmetric=1>
            <Reweight scoretype=fa_rep weight=0.22/>
        </ramp_rep3>
        <ramp_rep4 weights=score12_full symmetric=1/>
    </SCOREFXNS>
    <FILTERS>
    </FILTERS>
    <MOVERS>
        <SetupForSymmetry   name=setup_symm definition=C2.symm/>
        <SymPackRotamersMover name=repack1 scorefxn=ramp_rep1 task_operations=init,restrict,keep_curr/>
        <SymPackRotamersMover name=repack2 scorefxn=ramp_rep2 task_operations=init,restrict,keep_curr/>
        <SymPackRotamersMover name=repack3 scorefxn=ramp_rep3 task_operations=init,restrict,keep_curr/>
        <SymPackRotamersMover name=repack4 scorefxn=ramp_rep4 task_operations=init,restrict,keep_curr/>
        <SymMinMover name=min1 scorefxn=ramp_rep1 type=lbfgs_armijo_nonmonotone tolerance=0.01 bb=1 chi=1 jump=ALL/>
        <SymMinMover name=min2 scorefxn=ramp_rep2 type=lbfgs_armijo_nonmonotone tolerance=0.01 bb=1 chi=1 jump=ALL/>
        <SymMinMover name=min3 scorefxn=ramp_rep3 type=lbfgs_armijo_nonmonotone tolerance=0.01 bb=1 chi=1 jump=ALL/>
        <SymMinMover name=min4 scorefxn=ramp_rep4 type=lbfgs_armijo_nonmonotone tolerance=0.00001 bb=1 chi=1 jump=ALL/>
        <ParsedProtocol name=ramp_rep_cycle>
            <Add mover=repack1/>
            <Add mover=min1/>
            <Add mover=repack2/>
            <Add mover=min2/>
            <Add mover=repack3/>
            <Add mover=min3/>
            <Add mover=repack4/>
            <Add mover=min4/>
        </ParsedProtocol>
        <GenericMonteCarlo name=genericMC mover_name=ramp_rep_cycle scorefxn_name=ramp_rep4 temperature=100.0 trials=4/> 
    </MOVERS>
    <APPLY_TO_POSE>
    </APPLY_TO_POSE>
    <PROTOCOLS>
        <Add mover=setup_symm/>
        <Add mover=genericMC/>
    </PROTOCOLS>
</ROSETTASCRIPTS>
```

<!--- BEGIN_INTERNAL -->

## TaskAwareSymMinMover

(This is a devel Mover and not available in released versions.)

A task-aware version of the SymMinMover that allows minimization of only certain sets of residues specified by user-defined task operations.

    <TaskAwareSymMinMover name=(&string) scorefxn=(&scorefxn) bb=(0 &bool) chi=(1 &bool) rb=(0 &bool) task_operations=(comma-delimited list of task operations) />

-   bb - Whether to allow backbone minimization.
-   chi - Whether to allow side chain minimization.
-   rb - Whether to allow rigid body minimization.

<!--- END_INTERNAL --> 

## Issues with Symmetry and Rosetta Scripts

For the most part, simple movers and filters will handle symmetric poses without modification. More complicated movers may run into some problems. To adopt a complex mover for symmetry, see the section "How to adopt your protocol to use symmetry" in the "Symmetry User's Guide" in Rosetta's Doxygen documentation.

One RosettaScript-specific problem with parsable movers and symmetry has to do with how the scorefunction map is accessed in parse\_my\_tag. When getting a scorefunction off the data map, the following code WILL NOT WORK WITH SYMMETRY:

```
scorefxn_ = new ScoreFunction( *data.get< ScoreFunction * >( "scorefxns", sfxn_name ));
```

This ignores whether 'sfxn\_name' is symmetric or not. Instead, use clone to preserve whether or not the scorefunction is symmetric:

```
scorefxn_ = data.get< ScoreFunction * >( "scorefxns", sfxn_name )->clone();
```

This often is the problem when a mover gives the following error in a symmetric pose:

```
ERROR: !core::pose::symmetry::is_symmetric( pose )
ERROR:: Exit from: src/core/scoring/ScoreFunction.cc line: 547
```
# Kinematic Closure Movers

## Generalized Kinematic Closure (GeneralizedKIC)

Kinematic closure is a computationally-inexpensive, analytical algorithm for loop closure.  Given a loop with defined start- and endpoints, with N degrees of freedom, it is possible to sample N-6 of these degrees of freedom and to solve for the remaining 6.  GeneralizedKIC is a generalization of the classic KIC algorithm that permits closure and conformational sampling of any covalently-connected chain of atoms.  Chains to be closed can include backbone segments, covalently-linked side-chains (_e.g._ disulfide bonds), ligands, noncanonical residues, _etc._  GeneralizedKIC is invoked in RosettaScripts as follows:
```
<GeneralizedKIC name="&string" closure_attempts=(2000 &int) stop_if_no_solution=(0 &int) stop_when_solution_found=(false &bool) selector="&string" selector_scorefunction="&string" selector_kbt=(1.0 &Real) contingent_filter="&string">
     #Define loop residues in order:
     <AddResidue res_index=(&int)/>
     <AddResidue res_index=(&int)/>
     <AddResidue res_index=(&int)/>
     ...
     #List tail residues in any order (see documentation for details):
     <AddTailResidue res_index=(&int)/>
     <AddTailResidue res_index=(&int)/>
     <AddTailResidue res_index=(&int)/>
     ...
     #Pivot atoms are flanked by dihedrals that the KIC algorithm will solve for in order to enforce closure:
     <SetPivots res1=(&int) atom1="&string" res2=(&int) atom2="&string" res3=(&int) atom3="&string" />
     #One or more perturbers may be specified to sample loop conformations:
     <AddPerturber effect="&string">
          ...
     </AddPerturber>
     ...
     #One or more filters may be specified to discard unwanted or bad closure solutions:
     <AddFilter type="&string">
          ...
     </AddFilter>
     ...
</GeneralizedKIC>
```
See the [[GeneralizedKIC documentation|GeneralizedKIC]] for details about [[GeneralizedKIC options|GeneralizedKIC]], and about GeneralizedKIC [[perturbers|GeneralizedKICperturber]], [[filters|GeneralizedKICfilter]], and [[selectors|GeneralizedKICselector]], as well as for usage examples.  _**Note:** GeneralizedKIC should currently be considered a "beta" feature.  Some details of the implementation are likely to change._

# Parametric Backbone Generation

## MakeBundle

Generates a helical bundle using the Crick equations (which describe a helix of helices).  This mover is general enough to create arbitrary helices using arbitrary backbones.  Since strands are a special case of a helix (in which the turn per residue is about 180 degrees), the mover can also generate beta-barrels or other strand bundles.  The generated secondary structure elements are disconnected, so subsequent movers (e.g. <b>GeneralizedKIC</b>) must be invoked to connect them with loops.

```
<MakeBundle name=(&string) reset=(true &bool) symmetry=(0 &int) symmetry_copies=(0 &int) set_dihedrals=(true &bool) set_bondlengths=(true &bool) set_bondangles=(true &bool) residue_name=("ALA" &string) crick_params_file=("alpha_helix" &string)  helix_length=(0 &int) r0=(0.0 &real) omega0=(0.0 &real) delta_omega0=(0.0 &real) omega1=(0.0 &real) z1=(0.0 &real) delta_omega1=(0.0 &real) delta_t=(0.0 &real) z1_offset=(0.0 &real) z0_offset=(0.0 &real) invert=(false &bool) >
     <Helix set_dihedrals=(true &bool) set_bondlengths=(false &bool) set_bondangles=(false &bool) residue_name=("ALA" &string) crick_params_file=("alpha_helix" &string)  helix_length=(0 &int) r0=(0.0 &real) omega0=(0.0 &real) delta_omega0=(0.0 &real) omega1=(0.0 &real) z1=(0.0 &real) delta_omega1=(0.0 &real) delta_t=(0.0 &real) z1_offset=(0.0 &real) z0_offset=(0.0 &real) invert=(false &bool) />
...
</MakeBundle>
```

Options in the <b>MakeBundle</b> tag set defaults for the whole bundle.  Individual helices are added with the <b>Helix</b> sub-tags, each of which may include additional options overriding the defaults.  The parameters that can be adjusted are:

<b>set_bondlengths, set_bondangles, set_dihedrals</b>: Should the mover be able to set each of these DOF types?  By default, all three are set by the mover.  Allowing bond angles and bond lengths to be set creates non-ideal backbones, but which are flexible enough to more perfectly form a helix of helices.  (Slight deviations form perfect major helices are seen with only dihedrals being set.)<br/>
<b>r0</b>: The major helix radius (the radius of the bundle, in Angstroms).<br/>
<b>omega0</b>:  The major helix turn per residue, in radians.  If set too high, no sensible geometry can be generated, and the mover throws an error.  <i>Note: All angular values are in <b>radians</b>.</i><br/>
<b>delta_omega0</b>:  An offset value for <b>omega0</b> that will rotate the generated helix about the bundle axis.<br/>
<b>crick_params_file</b>:  A filename containing parameters (e.g. minor helix radius, minor helix twist per residue, minor helix rise per residue, <i>etc.</i>) for the minor helix.  Crick parameters files for helices formed by arbitrary noncanonical backbones can be generated using the <b>fit_helixparams</b> app.  The Rosetta database currently contains six sets of minor helix parameters:<br/>
- "alpha_helix": A standard L-amino acid right-handed alpha-helix, with phi=-64.8, psi=-41.0, and omega=180.0.<br/>
- "beta_strand": An L-amino acid beta-strand, with phi=-135.0, psi=135.0, and omega=180.0.<br/>
- "neutral_beta_strand": An unnaturally straight beta-strand, with phi=180.0, psi=180.0, and omega=180.0.  Both L- and D-amino acids can access this region of Ramachandran space.<br/>
- "L_alpha_helix": A left-handed alpha-helix, as can be formed by D-amino acids.  Phi=64.8, psi=41.0, and omega=180.0.<br/>
- "daa_beta_strand": A beta-strand formed by D-amino acids, mirroring that formed by L-amino acids.  Phi=135.0, psi=-135.0, and omega=180.0.<br/>
- "14_helix": A left-handed helix formed by beta-amino acids.  Phi=-139.9, theta=59.5, psi=-138.7, and omega=180.0.<br/>

<b>omega1</b>:  The minor helix turn per residue.  This is usually set with a Crick parameters file, but this option overrides whatever value is read in from the file.<br/>
<b>delta_omega1</b>:  An offset value for <b>omega1</b>.  This rotates the generated helix about the minor helix axis ("rolling" the helix).<br/>
<b>z1</b>:  The minor helix rise per residue.  This is usually set with a Crick parameters file, but this option overrides whatever value is read in from the file.<br/>
<b>delta_t</b>:  Shifts the registry of the helix.  (This value is the number of amino acid residues by which the helix should be shifted.)  Mainchain atoms are shifted along a path shaped like a helix of helices.<br/>
<b>z1_offset</b>:  Shifts the helix along the minor helix axis.  (The distance is measured in Angstroms along the <i>major helix axis</i>).  Mainchain atoms are shifted along a path shaped like a helix.  Inverted helices are shifted in the opposite direction.<br/>
<b>z0_offset</b>:  Shifts the helix along the major helix axis.  (The distance is measured in Angstroms).  Mainchain atoms are shifted along a path shaped like a straight line.  Inverted helices are shifted in the opposite direction.<br/>
<b>invert</b>:  This reverses the direction of a helix, which makes it easy to generate antiparallel bundles or sheets.<br/>

In addition, the following options can only be set for the bundle as a whole:

<b>reset</b>:  If "true" (the default), then the input pose is deleted and new geometry is generated.  If "false", then the geometry is added to the input pose as new chains.<br/>
<b>symmetry</b>:  Defines the radial symmetry of the bundle.  If set to something other than 0 (the default) or 1, then each helix specified is repeated this many times around the z-axis.  For example, if the script defined 2 helices and symmetry were set to 3, a total of 6 helices would be generated.  <i>Note:  At the present time, this mover does not automatically set up a symmetric conformation that symmetry-aware movers will respect.</i>  Other symmetrization movers must be invoked if the intent is to preserve symmetry during subsequent design or minimization steps.<br/>
<b>symmetry_copies</b>:  Defines how many radially symmetric copies of the defined helices will be placed.  A value of 0 results in copies matching the symmetry (for example, given six-fold symmetry, one would get six copies of the defined helices about the z-axis.)  Nonzero values result in only a subset of the symmetric copies being placed, permitting the generation of partial bundles.<br/>

Example:  This script generates an antiparallel beta-barrel with a bundle of alpha-helices on the inside.
```
<MakeBundle name=bundle1 set_bondlengths=true set_bondangles=true residue_name=ALA crick_params_file=beta_strand symmetry=16 r0=29 omega0=0.075 helix_length=20 >
        #The parameters set above ensure that by default, each "helix" will actually be a strand:
	<Helix /> #A strand
	<Helix delta_omega0=0.19634954 invert=1 delta_t=0.25 delta_omega1=1.5707963 /> #An offset, inverted strand.
	<Helix r0=21 omega0=0.05 crick_params_file=alpha_helix helix_length=40 /> #An alpha-helix.
	#The three elements defined above are repeated 16 times about the bundle axis to make the bundle.
</MakeBundle>

```

Note that RosettaScripts requires some sort of input on which to operate, but this mover, by default, deletes input geometry and replaces it with the generated geometry.  When running RosettaScripts, one can either pass in a dummy PDB file with the -in:file:s flag, or a dummy FASTA file with the -in:file:fasta flag.


## BundleGridSampler
Generates a helical bundle, sampling user-specified ranges of parameters and outputting the lowest-energy bundle encountered (and its accompanying parameter values).  Sampled parameters are evenly distributed in user-specified ranges; if more than one parameter is sampled, the mover samples an n-dimensional grid of sample values.  Optionally, this mover can also output PDB files for all bundle geometries sampled.  Note that because a strand is a special case of a helix, this mover can also be used to sample beta-barrel conformations or mixed alpha-beta structures.

```
<BundleGridSampler name=(&string) symmetry=(0 &int) symmetry_copies=(0 &int) set_dihedrals=(true &bool)
   set_bondlengths=(true &bool) set_bondangles=(true &bool) residue_name=("ALA" &string)
   crick_params_file=("alpha_helix" &string)  helix_length=(0 &int) invert=(false &bool)
   scorefxn=(&string) selection_type=("low"||"high" &string) pre_selection_mover=(&string)
   pre_selection_filter=(&string) dump_pdbs=(false &bool) pdb_prefix=("bgs_out" &string)
   max_samples=(10000 &int) reset=(true &bool) nstruct_mode=(false &bool) nstruct_repeats=(1 &int)
    r0=(&real) OR ( r0_min=(&real) r0_max=(&real) r0_samples=(&int) )
    omega0=(&real) OR ( omega0_min=(&real) omega0_max=(&real) omega0_samples=(&int) )
    delta_omega0=(&real) OR ( delta_omega0_min=(&real) delta_omega0_max=(&real) delta_omega0_samples=(&int) )
    delta_omega1=(&real) OR ( delta_omega1_min=(&real) delta_omega1_max=(&real) delta_omega1_samples=(&int) )
    delta_t=(&real) OR ( delta_t_min=(&real) delta_t_max=(&real) delta_t_samples=(&int) )
    z1_offset=(&real) OR (z1_offset_min=(&real) z1_offset_max=(&real) z1_offset_sample=(&int))
    z0_offset=(&real) OR (z0_offset_min=(&real) z0_offset_max=(&real) z0_offset_sample=(&int))
   >
   <Helix set_dihedrals=(true &bool) set_bondlengths=(false &bool) set_bondangles=(false &bool) invert=(false &bool)
     residue_name=("ALA" &string) crick_params_file=("alpha_helix" &string) helix_length=(0 &int)
     r0=(&real) OR (r0_copies_helix=(&int)) OR ( r0_min=(&real) r0_max=(&real) r0_samples=(&int) )
     omega0=(&real) OR (omega0_copies_helix=(&int)) OR (pitch_from_helix=(&int)) OR ( omega0_min=(&real) omega0_max=(&real) omega0_samples=(&int) )
     delta_omega0=(&real) OR (delta_omega0_copies_helix=(&int)) OR ( delta_omega0_min=(&real) delta_omega0_max=(&real) delta_omega0_samples=(&int) )
     delta_omega1=(&real) OR (delta_omega1_copies_helix=(&int)) OR ( delta_omega1_min=(&real) delta_omega1_max=(&real) delta_omega1_samples=(&int) )
     delta_t=(&real) OR (delta_t_copies_helix=(&int)) OR ( delta_t_min=(&real) delta_t_max=(&real) delta_t_samples=(&int) )
     z1_offset=(&real) OR (z1_offset_copies_helix=(&int)) OR ( z1_offset_min=(&real) z1_offset_max=(&real) z1_offset_samples=(&int) )
     z0_offset=(&real) OR (z0_offset_copies_helix=(&int)) OR ( z0_offset_min=(&real) z0_offset_max=(&real) z0_offset_samples=(&int) )
   >
   <Helix ...>
   <Helix ...>
   ...
</BundleGridSampler>
```

Default parameter values or parameter ranges are set in the <b>BundleGridSampler</b> tag, and overrides are set in the individual <b>Helix</b> tags.  Refer to the <a href="https://www.rosettacommons.org/docs/latest/general-movers.html#MakeBundle"><b>MakeBundle</b> mover</a> for options that both movers have in common.  Additional options include:
- <b>[parameter]\_min</b>, <b>[parameter]_max</b>: Minimum and maximum parameter values for a range to be sampled.
- <b>[parameter]\_samples</b>: The number of samples.  Note that the total number of samples is the product of all individual samples, and this can get quite large very fast.
- <b>[parameter]\_copies\_helix</b>: This option may only be specified in a <b>Helix</b> sub-tag.  It indicates that a particular parameter for that helix is always set to the same value as that parameter from a previously-defined helix.  See below for an example.
- <b>pitch_from_helix</b>: This is a special case.  As an alternative to <b>omega0_copies_helix</b>, which indicates that the major helix twist per residue should be matched to that of another helix, the user may specify that the helical pitch (the rise along the major helical axis per turn about the major helical axis) be matched to that of another helix.  This is useful in the case of bundles in which different helices may lie different distances from the bundle axis (i.e. have different r0 values), but which still need to pack together nicely.  If the helix pitch is matched, helices can run parallel to other helices despite having different r0 values.  The major helix pitch will be maintained despite sampling changes in r0 or omega0.
- <b>max\_samples</b>: The maximum number of samples permitted.  If the total number of samples is larger than this, the mover throws an error at apply time.  This is meant as a protection for the user, to prevent unreasonably large grid sampling jobs from being attempted.  The default value of 10,000 samples is conservative, and may be increased.
- <b>reset</b>: If true (the default setting), the pose is reset before generating bundles.  If false, the bundle geometry is added to the input geometry.
- <b>nstruct_mode</b>: By default, each separate trajectory samples all possible sets of Crick parameters and picks the lowest-energy one to pass to the next mover.  If you set nstruct_mode=true, then each separate trajectory (set using the -nstruct flag at the command line when calling the rosetta_scripts app) samples one set of Crick parameter values.  This is very useful in conjunction with the MPI compilation of RosettaScripts, since it provides an easy way to split the sampling over trajectories that will be handled in parallel.
- <b>nstruct_repeats</b>:  This option is ignored unless nstruct_mode is set to true. If nstruct_mode is set, and nstruct_repeats is set to a value greater than 1, each set of Crick parameter values will be sampled N times.  This is useful in conjunction with other sampling movers that split sampling over trajectories set with the -nstruct flag.  For example, if one were using the BundleGridSampler to sample 100 different sets of Crick parameter values, and a subsequent mover to sample another 100 different sets of parameter values of something else, there would be 10,000 pairwise combinations.  To sample all of these, one could set nstruct_repeats to 100, so that each set of Crick parameters is sampled 100 times and passed to the next mover which carries out 100 different trajectories with 100 different sets of the parameters sampled in step 2.
- <b>scorefxn</b>: The scoring function to use.  This must be specified, since this mover selects the lowest-energy bundle generated.
- <b>selection\_type</b>:  Although the lowest-energy bundle is selected by default ("low"), the user may optionally specify that the highest-energy bundle ("high") be selected instead.
- <b>pre\_selection\_mover</b>:  If specified, this mover will be applied to each generated bundle prior to energy evaluation.  This can be useful for side-chain packing or minimization as backbone conformations are sampled.  Note that this can greatly increase runtime, however.  Note also that, if a mover is used that alters the backbone conformation, the conformation may no longer lie within the Crick parameter space.
- <b>pre\_selection\_filter</b>:  If specified, this filter will be applied to each generated bundle prior to picking the lowest-energy bundle.  If PDB output has been turned on, only bundles passing filters will be written to disk.
- <b>dump\_pdbs</b>: If true, a PDB file is written for every bundle conformation sampled.  False by default.
- <b>pdb\_prefix</b>: The prefix for the PDB filenames if PDB files are being written.  Filenames will be of the format [prefix]\_#####.pdb.  This defaults to "bgs_out".

Note that default parameter ranges are applied separately to each helix.  For example, the following script would perform 16 samples (4 each for r0 of helix 1 and r0 of helix 2):

```
<BundleGridSampler name="bgs1" helix_length=20 scorefxn="sfxn1" r0_min=5.0 r0_max=8.0 r0_samples=4 omega0=0.05 delta_omega0=0 delta_omega1=0 delta_t=0>
     <Helix />
     <Helix delta_omega0=3.14 />
</BundleGridSampler>
```

In order to sample a range of parameters, keeping a parameter value for two different helices the same, the <b>[parameter]\_copies\_helix</b> option may be used in a <b>Helix</b> tag.  The helix to be copied must be declared before the helix that has the <b>[parameter]\_copies\_helix</b> option.  The following script, for example, carries out 4 samples, with r0 for both helices ranging from 5 to 8 (and always the same for both helices):

```
<BundleGridSampler name="bgs1" helix_length=20 scorefxn="sfxn1" r0_min=5.0 r0_max=8.0 r0_samples=4 omega0=0.05 delta_omega0=0 delta_omega1=0 delta_t=0>
     <Helix />
     <Helix delta_omega0=3.14 r0_copies_helix=1/>
</BundleGridSampler>
```


## PerturbBundle

This mover operates on a pose generated with the MakeBundle mover.  It perturbs (<i>i.e.</i> adds a small, random value to) one or more Crick parameters, then alters the backbone conformation to reflect the altered Crick parameters.  This is useful for iterative Monte Carlo searches of Crick parameter space.

```

<PerturbBundle name=(&string) default_perturbation_type=(&string)
     r0_perturbation=(&real) r0_perturbation_type=(&string)
     omega0_perturbation=(&real) omega0_perturbation_type=(&string)
     delta_omega0_perturbation=(&real) delta_omega0_perturbation_type=(&string)
     delta_omega1_perturbation=(&real) delta_omega1_perturbation_type=(&string)
     delta_t_perturbation=(&real) delta_t_perturbation_type=(&string)
     z1_offset_perturbation=(&real) z1_offset_perturbation_type=(&string)
     z0_offset_perturbation=(&real) z0_offset_perturbation_type=(&string) >
          <Helix helix_index=(&int)
               r0_perturbation=(&real) r0_perturbation_type=(&string) r0_copies_helix=(&int)
               omega0_perturbation=(&real) omega0_perturbation_type=(&string) omega0_copies_helix=(&int) pitch_from_helix=(&int)
               delta_omega0_perturbation=(&real) delta_omega0_perturbation_type=(&string) delta_omega0_copies_helix=(&int)
               delta_omega1_perturbation=(&real) delta_omega1_perturbation_type=(&string) delta_omega1_copies_helix=(&int)
               delta_t_perturbation=(&real) delta_t_perturbation_type=(&string) delta_t_copies_helix=(&int)
               z1_offset_perturbation=(&real) z1_offset_perturbation_type=(&string) z1_offset_copies_helix=(&int)
               z0_offset_perturbation=(&real) z0_offset_perturbation_type=(&string) z0_offset_copies_helix=(&int) />
</PerturbBundle>

```

Default options for all helices are set in the **PerturbBundle** tag.  A default perturber type for all perturbations can be set with the **default_perturbation_type** option; currently-accepted values are "gaussian" and "uniform".  These can be overridden on a parameter-by-parameter basis with individual **perturbation_type** options.  Default perturbation magnitudes are set with **perturbation** options.  If an option is omitted, that Crick parameter is not perturbed.  These can also be overridden on a helix-by-helix basis by adding **Helix** sub-tags.  In the sub-tags, if an option is omitted, that degree of freedom is not perturbed unless a default perturbation was set for it in the main tag.  In the sub-tags, helices can also be set to copy degrees of freedom of other helices with **copies_helix** options.  A special case of this is the **pitch_copies_helix** option, which will set omega0 to whatever value is necessary to ensure that one helix copies the major helix pitch (the rise along the major helix axis per turn about the major helix axis) of another helix.  Perturbable Crick parameters include:

<b>r0</b>: The major helix radius.<br/>
<b>omega0</b>: The major helix twist per residue.<br/>
<b>delta_omega0</b>: The radial offset about the major helix axis.<br/>
<b>delta_omega1</b>: The rotation of the minor helix about the minor helix axis.<br/>
<b>delta_t</b>: A value to offset the helix by a certain number of amino acid residues along its direction of propagation (i.e. along the helix-of-helices path through space).<br/>
<b>z1_offset</b>: A value to offset the helix by a certain number Angstroms along the minor helix axis (i.e. a helical path through space).  Note that the distance is measured along the z-axis (not along the helical path).  Inverted helices are shifted in the opposite direction.<br/>
<b>z0_offset</b>: A value to offset the helix by a certain number Angstroms along the major helix axis (i.e. a straight path through space).  Inverted helices are shifted in the opposite direction.<br/>

# Other Pose Manipulation

## MutateResidue

Change a single residue to a different type. For instance, mutate Arg31 to an Asp.

```
<MutateResidue name=(&string) target=(&string) new_res=(&string) preserve_atom_coords=(false &bool) />
```

-   target: The location to mutate (eg 31A (pdb number) or 177 (rosetta index)). *Required*
-   new\_res: The name of the residue to introduce. This string should correspond to the ResidueType::name() function (eg ASP). *Required*
-   preserve\_atom\_coords: If true, then atoms in the new residue that have names matching atoms in the old residue will be placed at the coordinates of the atoms in the old residue, with other atoms rebuilt based on ideal coordinates.  If false, then only the mainchain heavyatoms are placed based on the old atom's mainchain heavyatoms; the sidechain is built from ideal coordinates, and sidechain torsion values are then set to the sidechain torsion values from the old residue.  False if unspecified.

## AlignChain

Align a chain in the working pose to a chain in a pose on disk (CA superposition).

```
<AlignChain name=(&string) source_chain=(0&Int) SymMinMover name=min4 scorefxn=ramp_rep4 type=lbfgs_armijo_nonmonotone tolerance=0.00001 bb=1 chi=1 jump=ALL/target_chain=(0&Int) target_name=(&string)/>
```

-   source\_chain: the chain number in the working pose. 0 means the entire pose.
-   target\_chain: the chain number in the target pose. 0 means the entire pose.
-   target\_name: file name of the target pose on disk. The pose will be read just once at the start of the run and saved in memory to save I/O.

target and source chains must have the same length of residues.

## BluePrintBDR

Build a structure in centroid from a blueprint given an input pdb.

```
<BluePrintBDR name=bdr blueprint="input.blueprint" use_abego_bias=0 use_sequence_bias=0 scorefxn=scorefxn1/>
```

Options (default):

     num_fragpick ( 200 ), 
     use_sequence_bias ( false ), use sequence bias in fragment picking
     use_abego_bias ( false ), use abego bias in fragment picking
     max_linear_chainbreak ( 0.07 ),
     ss_from_blueprint ( true ),
     constraints_NtoC ( -1.0 ),
     constraints_sheet ( -1.0 ),
     constraint_file ( "" ),
     dump_pdb_when_fail ( "" ),
     rmdl_attempts ( 1 ),
     use_poly_val ( true ),
     tell_vlb_to_not_touch_fold_tree (false),
     invrot_tree_(NULL),
     enzcst_io_(NULL)

Blueprint format:

     resnum  residue  (ss_struct)(abego) rebuild
     resnum = consecutive (starting from 1) or 0 (to indicate a new residue not in the input.pdb)
     residue = one letter code amino acid (e.g. V for Valine)
     ss_struct = secondary structure, E,L or H. ss_struct and abego are single-letter and have no space between them.
     abego = abego type (ABEGO), use X if any is allowed
     rebuild = R (rebuild this position) or "." (leave as is)

Examples

     1   V  LE  R   (position 1, Val, loop, abego type E, rebuild)
     0   V  EX  R   (insert a residue, Val, sheet, any abego, rebuild)
     2   V  EB  .   (position 2, Val, sheet, abego type B, do not rebuild)

Note that this is often used with a SetSecStructEnergies mover, which would be applied first, both calling the same blueprint file with a header indicating the desired pairing. See SetSecStructEnergies for more.

## ModifyVariantType

Add or remove variant types on specified residues.

```
<ModifyVariantType name=[name] add_type=[type[,type]...] remove_type=[type[,type...]] task_operations=(&string,&string,&string)/>
```

Adds (if missing) or removes (if currently added) variant types to the residues specified in the given task operations. Use [[OperateOnCertainResidues|TaskOperations-RosettaScripts#Per-Residue-Specification]] operations to select specific residues.

## MotifGraft

MotifGraft is a new implementation of the well know motif grafting protocol. The protocol can recapitulate previous grafts made by the previous Fortran protocol (de novo loop insertions has not been implemented yet). The current protocol ONLY performs the GRAFT of the fragment(s), hence invariably, at least, it MUST be followed by design and minimization/repacking steps.

The input is composed by three structures:

1.  Motif, which is the fragment (or fragments) that the user want to graft.
2.  Context, which is the protein (or proteins) that interact with the motif.
3.  Pose (or list of poses), that is the scaffold in which the mover will try to insert the Motif.

The target is to find fragments in the Pose that are compatible with the motif(s), and then replace those fragments with the motif(s). To determine if a fragment is compatible, the algorithm uses three user-definable cut-offs:

1.  RMSD of the fragment(s) alignment (option: RMSD\_tolerance),
2.  RMSD of the N-/C- points after the alignment (option: NC\_points\_RMSD\_tolerance)
3.  clash\_score (option: clash\_score\_cutoff).

The algorithm has two methods of alignment that are mutually exclusive:

1.  Using only the N-/C- points of the fragment(s) (option: full\_motif\_bb\_alignment="0")
2.  Full backbone of the fragment(s) (option: full\_motif\_bb\_alignment="1").

When full backbone alignment is used, the size of the fragment to be replaced has to be exactly the same size of the Motif fragment. Since the grafting can lead to multiple different solutions in a single scaffold, the mover will return by default the top-RMSD match (lowest RMSD in the alignment), however the user can specify the option "-nstruct" to command RosettaScripts in returning more structures, but a disadvantage is that the number of resulting structures is unknown before running the protocol, therefore it is recommended to use the option \<allow\_repeat\_same\_graft\_output="0"\> in combination with a large number of -nstruc (e.g. 100), which effect is to force RosettaScripts to stop generating outputs when the last match (if any) is reached.

An example of a minimal XML code for this mover is the next:

```
        <MotifGraft name="motif_grafting" context_structure="./contextStructure.pdb" motif_structure="./motif_2NM1B.pdb"  RMSD_tolerance="1.0" NC_points_RMSD_tolerance="1.0" clash_score_cutoff="5" full_motif_bb_alignment="1" revert_graft_to_native_sequence="1" allow_repeat_same_graft_output="0" />
```

However the mover contains many options that can be useful under different scenarios. Particularly, of special interest are: "hotspots", "allow\_repeat\_same\_graft\_output" and "graft\_only\_hotspots\_by\_replacement". A complete list of the available options follows:

-   context\_structure (&string): The path/name of the context structure pdb.
-   motif\_structure (&string): The path/name of the motif pdb (can contain multiple discontiguos motif separated by the keyword TER).
-   RMSD\_tolerance (&real): The maximum RMSD tolerance (Angstrom) for the alignment.
-   NC\_points\_RMSD\_tolerance (&real): The maximum RMSD tolerance (Angstrom) for the N-/C-points, after the alignment.
-   clash\_test\_residue (&string):The Motif will be mutated before test for clashes (possible values: "GLY", "ALA", "VAL", "NATIVE"), except if the option "NATIVE" is specified. It is recommended to use "GLY or "ALA".
-   clash\_score\_cutoff (&int): The maximum number of atomic clashes that are tolerated. The number of atom clashes are = (motif vs scaffold) + ( scaffold vs pose), after the translation and mutation (to the "clash\_test\_residue") of the scaffold. Recommended: "5".
-   combinatory\_fragment\_size\_delta (&string): Is a string separated by a semicolon that defines the maximum number of amino acids in which the Motif size can be variated in the N- and C-terminal regions (e.g. "positive-int:positive-int"). If several fragments are present the values should be specified by the addition of a comma (eg. 0:0, 1:2, 0:3). All the possible combinations in deltas of 1 amino acid will be tested.
-   max\_fragment\_replacement\_size\_delta (&string): Is a string separated by a semicolon that specifies a range with the minimum and maximum size difference of the fragment that can be replaced in the scaffold. For example: "-1:2", means that the fragment replaced in the scaffold can be in the range of motifSize-1 to motifSize+2, practically: if the motif size is 10a.a., in this example the motif can replace a fragment in the scaffold of 9,10 or 11 amino acids. (possible values: negative-int:positive-int). If several fragments are present the values should be specified by the addition of a comma (eg. -1:0, -1:2, 0:3). This option has effect only if the alignment mode is set to full\_motif\_bb\_alignment="0" .
-   hotspots (&string): Is a string separated by a semicolon that defines the index of the aminoacids that are considered hotspots. i.e. that this positions will not be mutated for clash check and will be labeled in the PDBinfo. The format is "index1:index2:...:indexN"). If several fragments are present the values should be specified by the addition of a comma (eg. 0:1:3,1:2,0:3:5).
-   full\_motif\_bb\_alignment (&bool): Boolean that defines the motif fragment(s) alignment mode is full Backbone or not (i.e. only N-C- points).
-   allow\_independent\_alignment\_per\_fragment (&bool): \*\*EXPERIMENTAL\*\* When more that one fragment is present, after the global alignment, this option will allow each fragment to re-align independently to the scaffold. In most cases you want this option to be turned OFF.
-   graft\_only\_hotspots\_by\_sidechain\_replacement (&bool): Analogous to the old multigraft code option "fragment replacement", this option will only align the scaffold, and then copy the side-chains identities and torsions (only for hotspots). No BB will be modified. This option is useful only if the RMSD between the motif and the target fragment in the scaffold is very low (e.g. \< 0.3 A), otherwise you can expect extraneous results.
-   only\_allow\_if\_NC\_points\_match\_aa\_identity (&bool): This option will only perform grafts if the N-/C- point amino acids in the motif match the amino acids to be replaced in the target Scaffold fragment. This can be useful if for example one is looking to replace a fragment that starts in a S-S bridge.
-   revert\_graft\_to\_native\_sequence (&bool): This option will revert/transform/modify the sequence of the graft piece(s) in the sequence of the native scaffold, except the hotspots. This option only can work in conjunction with the full\_bb alignment mode (full\_motif\_bb\_alignment="1") and, of course, it only makes sense if you are replacing fragments in the target scaffold that are of the same size of your motif, which is the default behavior for full\_bb alignment.
-   allow\_repeat\_same\_graft\_output (&bool): If turned on (option: allow\_repeat\_same\_graft\_output="1") it will prevent the generation of repeated outputs, in combination with a large number of -nstruc (e.g. 100), it can be useful to extract all the matches without repetition, since when the last n-graft match is reached the mover will stop. if turned off (option: allow\_repeat\_same\_graft\_output="0"), the usual -nstruct behavior will happen, that is: rosetta will stop only when -nstructs are generated (even if it has to repeat n-times the same result) or if the mover fails (i.e. no graft matches at all).

Finally, an example XML Rosettascripts code using all the options for a single fragment graft:

```
<MotifGraft name="motif_grafting" context_structure="./context.pdb" motif_structure="./motif.pdb" RMSD_tolerance="1.0"   NC_points_RMSD_tolerance="1.0" clash_test_residue="GLY" clash_score_cutoff="5" combinatory_fragment_size_delta="0:0" max_fragment_replacement_size_delta="0:0"  hotspots="1:2:4" full_motif_bb_alignment="1"  optimum_alignment_per_fragment="0" graft_only_hotspots_by_replacement="0" only_allow_if_NC_points_match_aa_identity="0" revert_graft_to_native_sequence="0" allow_repeat_same_graft_output="0"/>
```

and for a two fragments graft:

```
<MotifGraft name="motif_grafting" context_structure="./context.pdb" motif_structure="./motif.pdb" RMSD_tolerance="1.0"   NC_points_RMSD_tolerance="1.0" clash_test_residue="GLY" clash_score_cutoff="0.0" combinatory_fragment_size_delta="0:0,0:0" max_fragment_replacement_size_delta="0:0,0:0"  hotspots="1:2:4,1:3" full_motif_bb_alignment="1"  optimum_alignment_per_fragment="0" graft_only_hotspots_by_replacement="0" only_allow_if_NC_points_match_aa_identity="0" revert_graft_to_native_sequence="0" allow_repeat_same_graft_output="0"/>
```

 Task operations after MotifGraft : For your convinience, the mover will generate some PDBinfo labels inside the pose. The available labels are: "HOTSPOT", "CONTEXT", "SCAFFOLD", "MOTIF" and "CONNECTION", which luckily correspond exactly to the elements that each of the labels describe. You can easily use this information in residue level task operations in order to prevent or restrict modifications for particular elements. Example:

```
        <OperateOnCertainResidues name="hotspot_onlyrepack">
            <RestrictToRepackingRLT/>
            <ResiduePDBInfoHasLabel property="HOTSPOT"/>
        </OperateOnCertainResidues>
        <OperateOnCertainResidues name="scaffold_onlyrepack">
            <RestrictToRepackingRLT/>
            <ResiduePDBInfoHasLabel property="SCAFFOLD"/>
        </OperateOnCertainResidues>
        <OperateOnCertainResidues name="context_norepack">
            <PreventRepackingRLT/>
            <ResiduePDBInfoHasLabel property="CONTEXT"/>
        </OperateOnCertainResidues>
```

## LoopCreationMover

(This is a devel Mover and not available in released versions.)

**!!!!WARNING!!!!!** This code is under very active development and is subject to change

Build loops to connect elements of protein structure. Protocol is broken into two independent steps - addition of loop residues to the pose, followed by closing the loop. These tasks are performed by LoopInserter and LoopCloser respectively (both are mover subclasses).

 **LOOP INSERTERS**

LoopInserters are responsible for building loops between residues loop\_anchor and loop\_anchor+1

-   LoophashLoopInserter

    ```
    <LoophashLoopInserter name=(&string) loop_anchor=(&integer) loop_sizes=(&integer) modify_flanking_regions=(1/0) />
    ```

    -   loop\_anchor: Starting residue number for loop inserter, for example with 'loop\_anchor=18', it will insert loops between loop\_anchor (=18) and loop\_anchor+1 (=19). Multiple loop\_anchors are possible like 'loop\_anchor=18, 35, 67', when there are 3 gaps. Residue numbers will be automatically renumbered as the mover runs.
    -   loop\_sizes: Size of newly added loop, for example with 'loop\_sizes=2,3,4,5', it will add loops of size 2\~5
    -   max\_torsion\_rms: Maximum torsion rmsd for the pre and post-loop segments comparison between old and new (use generous amount to allow the non-anchor side to be left open wide. ex. 100)
    -   min\_torsion\_rms: Minimum torsion rmsd for the pre and post-loop segments comparison between old and new
    -   modify\_flanking\_regions: If "modify\_flanking\_regions=1", apply the torsions of the loophash fragment to residue lh\_fragment\_begin in the pose (default is 0 which applies the torsions of the loophash fragment to residue loop\_anchor()+1 in the pose).
    -   num\_flanking\_residues\_to\_match: Number of residues before and after the loop to be built to calculate geometric compatibility (default=3).
    -   max\_lh\_radius: Maximum radius whithin which loophash segments are looked for

-   FragmentLoopInserter: Attempt to find single fragments that have ends with low-rmsd to the flanking residues of the loop to build.

    ```
    <FragmentLoopInserter name=(&string) loop_anchor=(&int)/>
    ```

 **LOOP CLOSERS**

LoopClosers are responsible for closing the recently build loops. These are just wrappers of common loop closure algorithms (i.e. KIC and CCD) built into the LoopCloser interface (as of 04/18/2013, CCD is recommended for this application).

-   CCDLoopCloser - Use CCD to close recently built loop

    ```
    <CCDLoopCloser name=(&string) />
    ```

    -   max\_ccd\_moves\_per\_closure\_attempt: Maximum ccd moves per closure attempt (usually max\_ccd\_moves\_per\_closure\_attempt=10000 is enough).
    -   max\_closure\_attempts: Maximum number of attempts to close. Obviously high number like 100 would increase successful closing probability.

 **LOOP CREATION MOVER**

-   LoopCreationMover

    ```
    <LoopCreationMover name=(&string) loop_closer=(&LoopCloser name) loop_inserter=(&LoopInserter name) />
    ```

    -   attempts\_per\_anchor: If 'attempts\_per\_anchor=10', it attempts to close per anchor 10 times. (recommended to use but attempts\_per\_anchor=0 by default)
    -   dump\_pdbs: If "dump\_pdbs=1", dump pdbs during after each addition residues, refinement, and closing of the loop
    -   filter\_by\_lam (filter by loop analyzer mover): If "filter\_by\_lam=1", filter out undesirable loops by [total\_loop\_score=rama+omega+peptide\_bond+chainbreak (by this loop) \<= lam\_score\_cutoff\_ (= 0 by default)]. (recommended to use but filter\_by\_lam=0 by default)
    -   include\_neighbors: If "include\_neighbors=1", include loop neighbors in packing/redesign, then calculate them
    -   loop\_closer: A name of loop\_closer, for example with 'loop\_closer=ccd', it uses \<CCDLoopCloser name=ccd/\>
    -   loop\_inserter: A name of loop\_inserter, for example with 'loop\_inserter =lh', it uses \<LoophashLoopInserter name=lh/\>

 *ResourceManager*

With loop\_sizes=2,3,4,5, in loop inserter, loop\_sizes in ResourceOptions should be 8,9,10,11 (since LOOP CREATION MOVER uses 3 (default) residue forward and 3 residues backward additionally to calculate geometric compatibility).

```
<JD2ResourceManagerJobInputter>
        <ResourceOptions>
                <LoopHashLibraryOptions tag=lh_lib_options loop_sizes="8,9,10,11"/>
        </ResourceOptions>
...
</JD2ResourceManagerJobInputter>
```

## SegmentHybridize

SegmentHybridize takes the principle from the cartesian hybridize protocol to close loops. it will align fragments to the broken section until the ends are close enough (as defined through rms\_frags) to use the cartesian minimizer for closure. The principle is to allow small breaks to close one big gap, with the idea of closing the small ones through minimization. Can be used for loop closure or grafting (still very experimental).

```
<SegmentHybridizer name=hyb frag_big=3 rms_frags=0.5 nfrags=2000 frag_tries=2000 auto_mm=1 all_movable=0 extra_min=1 mc_cycles=1000 use_frags=1 use_seq=1>
               <Span begin=6B end=15B extend_outside=2 extend_inside=1/>

</SegmentHybridizer> 
```

-   frag\_big: what fragment size should be used to close the gaps?
-   rms\_frags: at what size of a break to use the cartesian minimizer to close the gap
-   frag\_tries: how many fragments should be tried?
-   auto\_mm: should the movemap (defines what should be allowed to minimize) be set automatically?
-   all\_movable: everything in the last chain will be minimized (target would be the first chain)
-   extra\_min: extra minimization?
-   use\_frags: use fragments or just the minimizer
-   use\_seq: how to pick the fragments, as in either only secondary structure dependent or secondary structure and sequence dependent (if 1)
-   span defines the loop of interest, can be automated or everything can be used and then it will just try to fix every possible gap
-   extend\_outside: how far to go outside of the loop to allow fragement hybridization for loop closure (note, if you go too far out it might not close the loop...)
-   to what residue inside the loop should the fragment be aligned to?

## Disulfidize

Scans a protein and builds disulfides that join residues in one set of residues with those in another set. Non-protein and GLY residues are ignored. Residues to be joined must be min_loop residues apart in primary sequence. Potential disulfides are first identified by CB-CB distance, then by mutating the pair to CYS, forming a disulfide, and performing energy minimization.  If the energy is less than the user-specified cutoff, it is compared with a set of rotations and translations for all known disulfides.  If the "distance" resulting from this rotation and translation is less than the user-specified match_rt_limit, the pairing is considered a valid disulfide bond.

Once valid disulfides are found, they are combinatorially added. For example, if disulfides are identified between residues 3 and 16 and also between residues 23 and 50, the following configurations will be found:
1. [3,16]
2. [23,50]
3. [3,16],[23,50]

NOTE: This is a multiple pose mover. If non-multiple-pose-compatible movers are called AFTER this mover, only the first disulfide configuration will be returned.

```
<Disulfidize name=(&string) set1=(&selector) set2=(&selector) match_rt_limit=(&float) max_disulf_score=(&float) min_loop=(&int) />
```

- set1: Name of a residue selector which identifies a pool of residues which can connect to residues in set2 (default: all residues)
- set2: Name of a residue selector which identifies a pool of residues which can connect to residues in set1 (default: all residues)
- match_rt_limit: "distance" in 6D-space (rotation/translation) which is allowed from native disulfides (default: 2.0)
- max_disulf_score: Highest allowable per-disulfide dslf_fa13 score (default: -0.25 )
- min_loop: Minimum distance between disulfide residues in primary sequence space
- min_disulfides: Smallest allowable number of disulfides
- max_disulfides: Largest allowable number of disulfides

**EXAMPLE**  The following example looks for 1-3 disulfides. All found disulfide configurations are then designed using FastDesign.

```
<Disulfidize name="disulf" min_disulfides="1" max_disulfides="3" max_disulf_score="0.3" min_loop="6" />
<MultiplePoseMover name="multi_fastdes" >
	<ROSETTASCRIPTS>
		<MOVERS>
			<FastDesign name="fastdes" />
		</MOVERS>
		<PROTOCOLS>
			<Add mover="fastdes" />
		</PROTOCOLS>
	</ROSETTASCRIPTS>
</MultiplePoseMover>
```


## Dssp

Calculate secondary structures based on dssp algorithm, and load the information onto Pose.

```
<Dssp name=(&string) reduced_IG_as_L=(0 &int)/>
```

-   reduced\_IG\_as\_L: if set to be 1, will convert IG from Dssp definition as L rather than H

## AddChain

Reads a PDB file from disk and concatenates it to the existing pose.

```
<AddChain name=(&string) file_name=(&string) new_chain=(1&bool) scorefxn=(score12 &string) random_access=(0&bool) swap_chain_number=(0 &Size)>/>
```

-   file\_name: the name of the PDB file on disk.
-   new\_chain: should the pose be concatenated as a new chain or just at the end of the existing pose?
-   scorefxn: used for scoring the pose at the end of the concatenation. Also calls to detect\_disulfides are made in the code.
-   random\_access: If true, you can write a list of file names in the file\_name field. At parse time one of these file names will be picked at random and throughout the trajectory this file name will be used. This saves command line variants.
-   swap\_chain\_number: If specified, AddChain will delete the chain with number 'swap\_chain\_number' and add the new chain instead.

## AddChainBreak

Adds a chainbreak at the specified position

```
<AddChainBreak name=(&string) resnum=(&string) change_foldtree=(1 &bool) find_automatically=(0 &bool) distance_cutoff=(2.5&Real) remove=(0 &bool)/>
```

-   change\_foldtree: add a jump at the cut site.
-   find\_automatically: find cutpoints automatically according to the distance between subsequent C and N atoms.
-   distance\_cutoff: the distance cutoff between subsequent C and N atoms at which to decide that a cutpoint exists.
-   remove: if true remove the chainbreak from the specified position rather than add it.

## FoldTreeFromLoops

Wrapper for utility function fold\_tree\_from\_loops. Defines a fold tree based on loop definitions with the fold tree going up to the loop n-term, and the c-term and jumping between. Cutpoints define the kinematics within the loop

```
<FoldTreeFromLoops name=(&string) loops=(&string)/>
```

the format for loops is: Start:End:Cut,Start:End:Cut...

and either pdb or rosetta numbering are allowed. The start, end and cut points are computed at apply time so would respect loop length changes.


## Superimpose

Superimpose current pose on a pose from disk. Useful for returning to a common coordinate system after, e.g., torsion moves.

```
<Superimpose name=(&string) ref_start=(1 &Integer) ref_end=(0 &Integer) target_start=(1 &Integer) target_end=(0 &Integer) ref_pose=(see below &string) CA_only=(1 &integer)/> 
```
-   CA\_only, Superimpose CA only or BB atoms (N,C,CA,O).  Defaults True.
-   ref\_start, target\_start: start of segment to align. Accepts only rosetta numbering.
-   ref\_end, target\_end: end of segment to align. If 0, defaults to number of residues in the pose.
-   ref\_pose: the file name of the reference structure to align to. Defaults to the commandline option -in:file:native, if no pose is specified.

## SetSecStructEnergies

Give a bonus to the secondary structures specified by a blueprint header. For example "1-4.A.99" in a blueprint would specify an antiparallel relationship between strand 1 and strand 4; when this is present a bonus (negative) score is applied to the pose.

```
<SetSecStructEnergies name=(&string) scorefxn=(&string) blueprint="file.blueprint" natbias_ss=(&float)/> 
```

-   blueprint = a blueprint file with a header line for the desired pairing. Strand pairs are indicated by number (1-4 is strand 1 / strand 4) followed by a ".", followed by A of P (Antiparallel/Parallel), followed by a ".", followed by the desired register shift where "99" indicates any register shift.
-   e.g. "1-6.A.99;2-5.A.99;" Indicates an antiparallel pair between strand 1 and strand 6 with any register; and an antiparallel pair between strand 2 and strand 5 with any register
-   In the order of secondary structure specification, pairs start from the lowest strand number. So a strand 1 / strand 2 pair would be 1-2.A, not 2-1.A, etc.
-   natbias\_ss = score bonus for a correct pair.

## SwitchChainOrder

Reorder the chains in the pose, for instance switching between chain B and A. Can also be used to cut out a chain from the PDB (simply state which chains should remain after cutting out the undesired chain).

```
<SwitchChainOrder name=(&string) chain_order=(&string)/>
```

-   chain\_order: a string of chain numbers. This is the order of chains in the new pose. For instance, "21" will form a pose ordered B then A, "12" will change nothing.

## LoadPDB

Replaces current PDB with one from disk. This is probably only useful in checkpointing, since this mover deletes all information gained so far in the trajectory.

```
<LoadPDB name=(&string) filename=(&string)/>
```

-   filename: what filename to load?

## LoopLengthChange

Changes a loop length without closing it.

```
<LoopLengthChange name=(&string) loop_start=(&resnum) loop_end=(&resnum) delta=(&int)/>
```

-   loop\_start, loop\_end: where the loop starts and ends.
-   delta: by how much to change. Negative values mean cutting the loop.

## MakePolyX

Convert pose into poly XXX ( XXX can be any amino acid )

    <MakePolyX name="&string" aa="&string" keep_pro=(0 &bool)  keep_gly=(1 &bool) keep_disulfide_cys=(0 &bool) />

Options include:

-   aa ( default "ALA" ) using amino acid type for converting
-   keep\_pro ( default 0 ) Pro is not converted to XXX
-   keep\_gly ( default 1 ) Gly is not converted to XXX
-   keep\_disulfide\_cys ( default 0 ) disulfide CYS is not converted to XXX

## MembraneTopology

Simple wrapper around the MembraneTopology object in core/scoring. Takes in a membrane span file and inserts the membrane topology into the pose cache. The pose can then be used with a membrane score function.

```
<MembraneTopology name=(&string) span_file=(&string)/>
```

Span files have the following structure:

-   comment line
-   1 23 number of tm helices, number of residues
-   parallel topology
-   n2c n2c or c2n
-   1 27 1 27 the residue spans in rosetta-internal numbering. For some reason needs to be written twice for each membrane span

## Splice

(This is a devel Mover and not available in released versions.)

This is a fairly complicated mover with several different ways to operate:

-   1. given a source pose: splices segments from source pose onto current pose and ccd closes it. Use either with from\_res to\_res options or with the task\_operations. Generates a database file with the dihedral angle data from the spliced segment.
-   2. given a database file: splices segments from the database. If entry is left at 0, splices random entries.
-   3. given a database file and a template file: splices segments from the database. The residue start and end in the database are mapped onto the template rather than the source pose.
-   4. ccd on or off: Obviously ccd is very time consuming.

```
<Splice name="&string" from_res=(&integer) to_res=(&integer) source_pdb=(&string) scorefxn=(score12 &string) ccd=(1 &bool) res_move=(4 &integer) rms_cutoff=(99999&real) task_operations=(&comma-delimited list of taskoperations) torsion_database=(&string) database_entry=(0&int) template_file=(""&string) thread_ala=(1&bool) equal_length=(0&bool)/>
```

-   from\_res: starting res in target pdb
-   to\_res: end res in target pdb
-   source\_pdb: name of pdb file name from which to splice
-   ccd: close chainbreak at the end?
-   res\_move: how many residues to move during ccd? 3 flanking residues outside the inserted segment will be allowed to move, and the remainder will be moved within the segment, so if you specify 5, you'll have 3 flanking and 2 residues within the segment at each end.
-   rms\_cutoff: allowed average displacement of Calpha atoms compared to source pdb. If the average displacement is above this limit, then the mover will set its status to fail and no output will be generated.
-   task\_operations: set which residues will be spliced. This merely goes through all of the designable residues according to the task-factory, takes the min and max, and splices the section in between (inclusive). Logically this replaces from\_res/to\_res, so task\_operations cannot be defined concomitantly with these. these task\_operations are not used to decide how to design/repack residues within the mover, only on the stretch to model.
-   torsion\_database: a database of torsion angles to be spliced. The database is light-weight, removing the requirement to read a pdb for each segment to be spliced in. Each line in the database is a segment entry defining the dofs: ( \<phi\> \<psi\> \<omega\> \<3-letter resn\> ) x number of residues in the segment.
-   database\_entry: which entry in the database to splice. If 0, an entry is chosen randomly at runtime.
-   thread\_ala: thread alanine residues in all positions where source has no gly/pro or disagrees with current pose? If false, allows design at those positions.
-   equal\_length: when sampling from a database, do you want to restrict only to entries with equal length to the current pose?



## SwitchResidueTypeSetMover

Switches the residue sets (e.g., allatom-\>centroid, or vice versa).

```
<SwitchResidueTypeSetMover name="&string" set=(&string)/>
```

-   set: which set to use (options: centroid, fa\_standard...)

Typically, RosettaScripts assumes that poses are all-atom. In some cases, a centroid pose is needed, e.g., for centroid scoring, and this mover is used in those cases.

## FavorNativeResidue

```
<FavorNativeResidue bonus=(1.5 &bool)/>
```

Adds residue\_type\_constraints to the pose with the given bonus. The name is a slight misnomer -- the "native" residue which is favored is actually the identity of the residue of the current pose at apply time (-in:file:native is not used by this mover).

For more flexible usage see FavorSequenceProfile (with "scaling=prob matrix=IDENTITY", this will show the same native-bonus behavior).

## FavorSequenceProfile

```
<FavorSequenceProfile scaling=("prob" &string) weight=(1 &Real)  pssm=(&string) use_native=(0 &bool) use_fasta=(0 &bool) use_starting=(0 &bool) chain=(0, &int) use_current=(0 &bool) pdbname=(&string) matrix=(BLOSUM62 &string) scorefxns=(comma seperated list of &string)/>
```

Sets residue type constraints on the pose according to the given profile and weight. Set one (and only one) of the following:

-   pssm - a filename of a blast formatted pssm file containing the sequence profile to use
-   use\_native - use the structure specified by -in:file:native as reference
-   use\_fasta - use a native FASTA sequence specified by the -in:file:fasta as reference
-   use\_starting - use the starting input structure (e.g. one passed to -s) as reference
-   use\_current - use the current structure (the one passed to apply) as the reference
-   pdbname - use the structure specified by the filename as the reference

specify if needed:

-   chain - 0 is all chains, otherwise if a sequence is added, align it to the specified chain

You can set how to scale the given values with the "scaling" settings. The default value of "prob" does a per-residue Boltzmann-weighted probability based on the profile score (the unweighted scores for all 20 amino acid identities at any given position sum to -1.0). A setting of "global" does a global linear fixed-zero rescaling such that all (pre-weighted) values fall in the range of -1.0 to 1.0. A setting of "none" does no adjustment of values.

The parameter "weight" can be used to adjust the post-scaling strength of the constraints. (e.g. at a weight=0.2, global-scaled constraint energies fall in the range of -0.2 to 0.2 and prob-weighted IDENTITY-based constraint energies are in the range of -0.2 to 0, both assuming a res\_type\_constraint=1)

Note that the weight parameter does not affect the value of res\_type\_constraint in the scorefunction. As the constraints will only be visible with non-zero res\_type\_constraint values, the parameter scorefxns is a convenience feature to automatically set res\_type\_constraint to 1 in the listed functions where it is currently turned off.

If a structure is used for input instead of a PSSM, the profile weights used are based off of the given substitution matrix in the database. Current options include:

-   MATCH: unscaled/unweighted scores of -1 for an amino acid match and 1 for a mismatch
-   IDENTITY: unscaled/unweighted scores of -1 for a match and +10000 for a mismatch. Most useful with prob-scaling, giving a prob-scaled/unweighted score of -1.0 for an amino acid match, and 0 for a mismatch.
-   BLOSUM62: Values vary based on aa and substitution. Unnscaled/unweighted scores are mostly in the range of -2 to +4, but range up to -11 and +4.

NOTE: The default behavior of FavorSequenceProfile has changed from previous versions. If you're using a structure as a reference, you'll want to check your weight, scaling and substitution matrix to make sure your energy values are falling in the appropriate range.

## SetTemperatureFactor

Set the temperature (b-)factor column in the PDB based on a filter's per-residue information. Useful for coloring a protein based on some energy. The filter should be ResId-enabled (reports per-residue values) or else an error occurs.

```
<SetTemperatureFactor name="&string" filter=(&string) scaling=(1.0&Real)/>
```

-   filter: A ResId-compatible filter name
-   scaling: Values reported by the filter will be multiplied by this factor.

## PSSM2Bfactor

Set the temperature (b-)factor column in the PDB based on filter's per-residue PSSM score. Sets by default PSSM scores less than -1 to 50, and larger than 5 to 0 in the B-factor column. Between -1 and 5 there is a linear gradient.

```
<PSSM2Bfactor name="&string" Value_for_blue=(&Real) Value_for_red=(&Real)/>
```

-   Value\_for\_blue: All PSSM scoring with value and lower will be converted to 0 in the Bfactor column. default 5.
-   Value\_for\_red: All PSSM scoring with value and higher will be converted to 50 in the Bfactor column. Default 0.

## RigidBodyTransMover

Translate chains.

     <RigidBodyTransMover name=(&string) jump=(1 &int) distance=(1.0 &Real) x=(0.0 &Real) y=(0.0 &Real) z=(0.0 &Real) />

-   jump: The chain downstream of the specified jump will be translated.
-   distance: The distance to translate along the axis
-   x,y,z: Specify the axis along which to translate. The vector will be normalized to unit length before use. All zeros (the default) results in automatic apply-time setting of the direction on the axis between the approximate centers of the two components being separated.

## RollMover

Rotate pose over a given axis.

```
        <RollMover name=(&string) start_res=(&int) stop_res=(&int) min_angle=(&Real) max_angle=(&Real) > 
               <axis x=(&Real) y=(&Real) z=(&Real) /> 
               <translate x=(&Real) y=(&Real) z=(&Real) /> 

        </RollMover>
```

-   start\_res: first residue id of object to roll
-   stop\_res: last residue id of object to roll
-   min\_angle: minimum angle to roll about axis
-   max\_angle: maximum angle to roll about axis
-   axis: vector to rotate about
-   translate: point to translate axis to

## RemodelMover (including building disulfides)

Remodel and rebuild a protein chain

IMPORTANT NOTE!!!!: Remodel uses an internal system of trajectories controlled by the option -num\_trajectory [integer, \>= 1]. If num\_trajectory \> 1 each result is scored with score12 and the pose with lowest energy is handed to the next mover or filter. -num\_trajectory 1 is recommended for rosetta\_scripts.

```
  <RemodelMover name=(&string) blueprint=(&string)/>      
```

-   blueprint: blueprint file name
-   other tags coming, use flags for now as described on the [[Remodel page|Remodel]]

For building multiple disulfides simultaneously using RemodelMover, use the following syntax-

```
<RemodelMover name=(&string) build_disulf=True match_rt_limit=(1.0 &Real) quick_and_dirty=(0 &Bool) bypass_fragments=(0 &Bool) min_disulfides=(1 &Real) max_disulfides=(1 &Real) min_loop=(1 &Real) fast_disulf=(0 &Bool) keep_current_disulfides=(0 &Bool) include_current_disulfides=(0 &Bool)/>
```

-   `      build_disulf     ` : indicates that disulfides should be built into the structure
-   `      use_match_rt    ` : Handles disulfide searching by computing the rotation-translation (RT) matrix between all pairs of residue backbones, and comparing these RT matrices to a database of known disulfides.  Euclidian distance is used to determine the similarity between the query RT matrix and each disulfide in the database.  The cutoff for similarity between the RT matrix and a known disulfide is match_rt_limit (below).  Default true.
-   `      match_rt_limit     ` : Upper threshold for determining if two residues can form a disulfide based on the RT matrix between their backbone atoms.  1.0 is strict, 2.0 is loose, 6.0 is very loose, \>6 makes no difference.  Default 1.0.
-   `      use_disulf_fa_score    ` : Handles disulfide searching by actually building disulfide bonds between all pairs of residues within a distance cutoff, minimizing these, scoring the disulfides using the default full-atom disulfide potential (dslf_fa13), and then applying an upper threshold.  Some backbone flexibility may be allowed in the minimization.  Default false.
-   `      disulf_fa_max     ` : Upper threshold for determining if two residues can form a disulfide based on actually building and minimizing a disulfide there.  Default -0.25.
-   `      relax_bb_for_disulf     ` : Allow backbone minimization during disulfide building using use_disulf_fa_score.  This backbone relaxation is done on a poly-alanine backbone and thus the backbone may be more flexible than is actually feasible for a given structure, resulting in accepting disulfides that will be strained on the actual structure.  Allowing backbone minimization should increase the overall number of possible disulfide bonds found.  Default false.
-   `      quick_and_dirty     ` : Bypass the refinement step within remodel; useful to save time if performing refinement elsewehere
-   `      bypass_fragments     ` : Bypasses rebuilding the structure from fragments
-   `      min_disulfides     ` : Specifies the minimum number of disulfides required in the output structure. If min\_disulfides is greater than the number of potential disulfides that pass match\_rt\_limit, the protocol will fail. **This is only read/applied if build\_disulf or fast\_disulf are set to true.**
-   `      min_disulfides     ` : Specifies the maximum number of disulfides allowed in the output structure.
-   `      min_loop     ` : Specifies the minimum number of residues between the two cysteines to be disulfide bonded; used to avoid disulfides that link pieces of chain that are already close in primary structure.
-   `      fast_disulf     ` : Sets the build\_disulf, quick\_and\_dirty, and bypass\_fragment flags to true. Also bypasses any design during remodel, including building the disulfide itself! This means that the remodel mover must be followed by a design mover such as FastDesign. This is my recommended method for building multiple disulfides into a *de novo* scaffold.
-   `      keep_current_disulfides     ` : Will prevent Remodel from using a residue that is already part of a disulfide to form a new disulfide
-   `      include_current_disulfides     ` : Forces Remodel to include the existing disulfides on the list of potential disulfides (not much purpose except for debugging).


Note that no blueprint is required when fast\_disulf or build\_disulf; if no blueprint is provided, all residues will be considered as potential cysteine locations.

If multiple disulfides are being built simultaneously and the structure can accommodate multiple disulfide configurations (combinations of disulfide bonds), then the best ranking configuration according to DisulfideEntropyFilter is outputted. If the exact same input structure is provided to RemodelMover a second time (because it is part of a loop in rosetta\_scripts, for example), the second ranking configuration will be outputted the second time, and so forth. Using this method, multiple disulfide configurations on the same structure can be fed into downstream RosettaScripts movers and filters, and then looped over until an optimal one is found.

## SetupNCS

Establishes a non crystallographic symmetry (NCS) between residues. The mover sets dihedral constraints on backbone and side chains to force residues to maintain the same conformation. The amino acid type can be enforced too. This mover does not perform any minimization, so it is usually followed by MinMover or RelaxMover.

```
  <SetupNCS name=(&string) bb=(1 &bool) chi=(1 &bool) symmetric_sequence=(0 &bool)/> 
       <NCSgroup source="38A-55A" target="2A-19A"/>
       <NCSgroup source="38A-55A" target="20A-37A"/>
       ...
       <NCSend source="55A" target="1A"/>
       <NCSend source="54A" target="108A"/>
       ...
  </SetupNCS>
```

-   bb: sets dihedral constraints for backbone
-   chi: sets dihedral constraints for side chains
-   symmetric\_sequence: forces the sequence from the source into the target (see below)
-   NCSgroup: defines two set of residues for which the constraints are generated. Source and target groups need to contain the same number of residues. The constraints are defined to minimize the different between dihedral angles, instead of forcing the target conformation into the source conformation. Backbone dihedral angles cannot be set for residues at the beginning or at the end of a chain.
-   source: reference residues, express as single residue or interval. Source and target need the same number of residues.
-   target: target residues, express as single residue or interval. Source and target need the same number of residues.
-   NCSend: forces sequence and conformation from source to target but does not set up any constraint. This tag applies only if symmetric\_sequence=1.


<!--- BEGIN_INTERNAL -->
## StoreTask

(This is a devel Mover and not available in released versions.)

Creates a packer task by applying the user-specified task operations to the current pose and saves the packer task in the pose's cacheable data, allowing the task to be accessed, unchanged, at a later point in the RosettaScripts protocol. Must be used in conjunction with the RetrieveStoredTask task operation.

    <StoreTaskMover name=(&string) task_name=(&string) task_operations=(comma-delimited list of task operations) overwrite=(0 &bool) />

-   task\_name - The index where the task will be stored in the pose's cacheable data. Must be identical to the task\_name used to retrieve the task using the RetrieveStoredTask task operation.
-   task\_operations - A comma-delimited list of task operations used to create the packer task.
-   overwrite - If set to true, will overwrite an existing task with the same task\_name if one exists.

## StoreCompoundTaskMover

(This is a devel Mover and not available in released versions.)

This mover uses previously defined task operations applied to the current pose to construct a new compound logical task with NOT, AND, OR, XOR, NAND, NOR, ANDNOT, and ORNOT operations. It then creates a packer task by applying the task operations to the current pose and saves the packer task in the pose's cacheable data, allowing the task to be accessed, unchanged, at a later point in the RosettaScripts protocol. Must be used in conjunction with the RetrieveStoredTask task operation. By making compound tasks of compound tasks, esssentially all logical tasks can be defined. Note: this mover has not yet been thoroughly tested. The source code is currently located in: src/devel/matdes/

```
<StoreCompoundTaskMover name=(&string) task_name=(&std::string) mode=("packable" &std::string) true_behavior=(&string) false_behavior=("prevent_repacking" &string) invert=(false &bool) verbose=(false &bool) overwrite=(false &bool)>
<OPERATION task_operations=(comma-delimited list of operations &string)/> 
<.... 
</StoreCompoundTaskMover> 
```

Example:

```
<StoreCompoundTaskMover name=store_packable_any task_name=packable_any mode="packable" true_behavior="" false_behavior="prevent_repacking" invert=0 verbose=1 overwrite=0>
    <OR task_operations=resfile1 />
    <OR task_operations=resfile2 />
    <OR task_operations=design_bbi />
</StoreCompoundTaskMover>
```

-   task\_name: The index where the task will be stored in the pose's cacheable data. Must be identical to the task\_name used to retrieve the task using the RetrieveStoredTask task operation.
-   mode: What property of the residues should be assessed? Options: packable or designable
-   true\_behavior: What behavior should be assigned to residues for which the compound task is true? Options: prevent\_repacking or restrict\_to\_repacking. If not set to one of these options, then by default these residues will remain designable.
-   false\_behavior: What behavior should be assigned to residues for which the compound task is false? Default: prevent\_repacking Options: prevent\_repacking or restrict\_to\_repacking. If false\_behavior="", then these residues will remain designable.
-   invert: setting to true will cause the final outcome to be inverted. If, for instance multiple AND statements are evaluated and each evaluates to true for a given residue, then the false\_behavior will be assigned to that residue.
-   verbose: setting to true will produce a pymol selection string for the positions assigned the true behavior
-   overwrite: above which threshold (e.g. delta score/delta ddg) a negative state will be counted in the Boltzmann fitness calculation. This prevents the dilution of negative states.
-   OPERATION: any of the operations the following logical operations: NOT, AND, OR, XOR, NAND, NOR, ANDNOT, and ORNOT. Note that the operations are performed in the order that they are defined. No precedence rules are enforced, so that any precedence has to be explicitly written by making compound statements of compound statements. Note that the first OPERATION specified in the compound statement treated as a negation if NOT, ANDNOT, or ORNOT is specified.
-   task\_operations: A comma-delimited list of task operations

<!--- END_INTERNAL --> 

## VirtualRoot

Reroot the pose foldtree on a (new) virtual residue. Useful for minimization in the context of absolute frames (coordinate constraints, electron density information, etc.)

```
<VirtualRoot name=(&string) removable=(&bool false) remove=(&bool false) />
```

By default, the mover will add a virtual root residue to the pose if one does not already exist. If you wish to later remove the virtual root, add the root with a mover with removable set to true, and then later use a separate VirtualRoot mover with remove set to true to remove it.

Currently VirtualRoot with remove true is very conservative in removing virtual root residues, and won't remove the residue if it's no longer the root residue, if pose length changes mean that the root residue falls at a different numeric position, or if the virtual root residue wasn't added by a VirtualRoot mover with "removable" set. Don't depend on the behavior of no-op removals, though, as the mover may become more permissive in the future.
