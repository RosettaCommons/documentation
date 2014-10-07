[[_TOC_]]


## PatchdockTransform

Uses the Patchdock output files to modify the configuration of the pose.

```
<PatchdockTransform name="&string" fname=(&string) from_entry=(&integer) to_entry=(&integer) random_entry=(&bool)/>
```

Since Patchdock reading is also enabled on the commandline, the defaults for each of the parameters can be defined on the commandline. But, setting patchdock commandline options would provoke the JobDistributor to call the PatchDock JobInputter and that might conflict with the mover options defined here.

-   fname: the patchdock file name.
-   from\_entry: from which entry to randomly pick a transformation.
-   to\_entry: to which entry to randomly pick a transformation.
-   random\_entry: randomize the chosen entry?

If you choose from\_entry to\_entry limits that go beyond what's provided in the patchdock file, the upper limit would be automatically adjusted to the limit in the patchdock file.

## ProteinInterfaceMS

Multistate design of a protein interface. The target state is the bound (input) complex and the two competitor states are the unbound partners and the unbound, unfolded partners. Uses genetic algorithms to select, mutate and recombine among a population of starting designed sequences. See Havranek & Harbury NSMB 10, 45 for details.

```
<ProteinInterfaceMS name="&string" generations=(20 &integer) pop_size=(100 &integer) num_packs=(1 &integer) pop_from_ss=(0 &integer) numresults=(1 &integer) fraction_by_recombination=(0.5 &real) mutate_rate=(0.5 &real) boltz_temp=(0.6 &real) anchor_offset=(5.0 &real) checkpoint_prefix=("" &string) gz=(0 &bool) checkpoint_rename=(0 &bool) scorefxn=(score12 &string) unbound=(1 &bool) unfolded=(1&bool) input_is_positive=(1&bool) task_operations=(&comma-delimited list) unbound_for_sequence_profile=(unbound &bool) profile_bump_threshold=(1.0 &Real) compare_to_ground_state=(see below & bool) output_fname_prefix=("" &string)>
   <Positive pdb=(&string) unbound=(0&bool) unfolded=(0&bool)/>
   <Negative pdb=(&string) unbound=(0&bool) unfolded=(0&bool)/>
   .
   .
   .
</ProteinInterfaceMS>
```

The input file (-s or -l) is considered as either a positive or negative state (depending on option, input\_is\_positive). If unbound and unfolded is true in the main option line, then the unbound and the unfolded states are added as competitors. Any number of additional positive and negative states can be added. Unbound and unfolded takes a different meaning for these states: if unbound is checked, the complex will be broken apart and the unbound state will be added. If unfolded is checked, then the unbound and unfolded protein will be added.

unbound\_for\_sequence\_profile: use the unbound structure to generate an ala pose and prune out residues that are not allowed would clash in the monomeric structure. Defaults to true, if unbound is used as a competitor state. profile\_bump\_threshold: what bump threshold to use above. The difference between the computed bump and the bump in the ala pose is compared to this threshold.

compare\_to\_ground\_state: by default, if you add states to the list using the Positive/Negative tags, then the energies of all additional states are zeroed at their 'best-score' values. This allows the user to override this behaviour. See code for details.

output\_fname\_prefix: All of the positive/negative states that are defined by the user will be output at the end of the run using this prefix. Each state will have its sequence changed according to the end sequence and then a repacking and scoring of all states will take place according to the input taskfactory.

Rules of thumb for parameter choice. The Fitness F is defined as:

    F = Sum_+( exp(E/T) ) / ( Sum_+( exp(E/T) ) + Sum_-( exp(E/T) ) + Sum_+((E+anchor)/T) )

where Sum\_-, and Sum\_+ is the sum over the negative and positive states, respectively.

the values for F range from 1 (perfect bias towards +state) to 0 (perfect bias towards -state). The return value from the PartitionAggregateFunction::evaluate method is -F, with values ranging from -1 to 0, correspondingly. You can follow the progress of MSD by looking at the reported fitnesses for variants within a population at each generation. If all of the parameters are set properly (temperature etc.) expect to see a wide range of values in generation 1 (-0.99 - 0), which is gradually replaced by higher-fitness variants. At the end of the simulation, the population will have shifted to -1.0 - -0.5 or so.

For rules of thumb, it's useful to consider a two-state, +/- problem, ignoring the anchor (see below, that's tantamount to setting anchor very high) In this case FITNESS simplifies to:

    F = 1/(exp( (dE)/T ) + 1 )

and the derivative is:

    F' = 1/(T*(exp(-dE/T) + exp(dE/T) + 2)

where dE=E\_+ - E\_-

A good value for T would then be such where F' is sizable (let's say more than 0.05) at the dE values that you want to achieve between the positive and negative state. Since solving F' for T is not straightforward, you can plot F and F' at different temperatures to identify a reasonable value for T, where F'(dE, T) is above a certain threshold. If you're lazy like me, set T=dE/3. So, if you want to achieve differences of at least 4.5 e.u between positive and negative states, use T=1.5.

To make a plot of these functions use MatLab or some webserver, e.g., [http://www.walterzorn.com/grapher/grapher\_e.htm](http://www.walterzorn.com/grapher/grapher_e.htm) .

The anchor\_offset value is used to set a competitor (negative) state at a certain energy above the best energy of the positive state. This is a computationally cheap assurance that as the specificity changes in favour of the positive state, the stability of the system is not overly compromised. Set anchor\_offset to a value that corresponds to the amount of energy that you're willing to forgo in favour of specificity.

## InterfaceAnalyzerMover

Calculate binding energies, buried interface surface areas, packing statistics, and other useful interface metrics for the evaluation of protein interfaces.

```
<InterfaceAnalyzerMover name="&string" scorefxn=(&string) packstat=(&bool) pack_input=(&bool) pack_separated=(0, &bool) jump=(&int) fixedchains=(A,B,&string) tracer=(&bool) use_jobname=(&bool) resfile=(&bool) ligandchain=(&string) />
```

-   packstat: activates packstat calculation; can be slow so it defaults to off. See the paper on RosettaHoles to find out more about this statistic (Protein Sci. 2009 Jan;18(1):229-39.)
-   jump: which jump number should be used to determine across which chains to make the interface? NOT RECOMMENDED - use -fixedchains instead.
-   fixedchains: comma-delimited list of chain ids to define a group in the interface.
-   tracer: print to a tracer (true) or a scorefile (false)? Combine the true version with -out:jd2:no\_output and the false with out:file:score\_only (scorefile).
-   use\_jobname: use\_jobname (bool) - if using tracer output, this turns the tracer name into the name of the job. If you run this code on 50 inputs, the tracer name will change to match the input, labeling each line of output with the input to which it applies. Not relevant if not using tracer output.
-   pack\_separated: repack the exposed interfaces when calculating binding energy? Usually a good idea.
-   resfile: warns the protocol to watch for the existence of a resfile if it is supposed to do any packing steps. (This is normally signealed by the existance of the -resfile flag, but here the underlying InterfaceAnalyzerMover is not intended to use -resfile under normal circumstances, so a separate flag is needed. You can still pass the resfile with -resfile.)
-   pack\_input: prepack before separating chains when calculating binding energy? Useful if these are non-Rosetta inputs
-   ligandchain: Specify a single ligand chain by pdb chain ID. All chains in the protein other than this will be marked as fixed as if they were specified using fixedchains.

## Docking

Does both centroid and full-atom docking

```
<Docking name="&string" score_low=(score_docking_low &string) score_high=(score12 &string) fullatom=(0 &bool) local_refine=(0 &bool) jumps=(1 &Integer vector) optimize_fold_tree=(1 &bool) conserve_foldtree=(0 &bool) design=(0 &bool) ignore_default_docking_task=(0 &bool) task_operations=("" comma-separated list)/>
```

-   score\_low is the scorefxn to be used for centroid-level docking
-   score\_high is the scorefxn to be used for full atom docking
-   fullatom: if true, do full atom docking
-   local\_refine: if true, skip centroid. Note that fullatom=0 and local\_refine=1 together will result in NO DOCKING!
-   jumps is a comma-separated list of jump numbers over which to carry out rb motions
-   optimize\_fold\_tree: should DockingProtocol make the fold tree for this pose? This should be turned to 0 only if AtomTree is used
-   conserve\_foldtree: should DockingProtocol reset the fold tree to the input one after it is done
-   design: Enable interface design for all chains downstream of the rb\_jump
-   ignore\_default\_docking\_task: allows you to ignore the default docking task and only use the ones defined in your task\_operations section

## Docking with Hotspot

Does centroid docking with long range hotspot constraints and interchain\_cen energy function.

```
<DockWithHotspotMover name="&string" hotspot_score_weight=(10 &Real) centroidscore_filter=(0 &Real) hotspotcst_filter="40 &Real">
     <StubSets explosion=(0 &integer) stub_energy_threshold=(1.0 &Real)  max_cb_dist=(3.0 &Real) cb_force=(0.5 &Real)>
        <Add file_name=(hotspot1 &string) cb_force="1.0 &Real"/>
        <Add file_name=(hotspot2 &string) cb_force="1.0 &Real"/>
     </StubSets>
</DockWithHotspotMover>
```

-   hotspot\_score\_weight is the weighting of hotspot constraints
-   centroidscore\_filter is evaluated when interface is mutated to Alanine and pose is converted to centroid. Only docking decoys passing this threshold will be retained.
-   hotspotcst\_filter is a penalty term from a summation of all stub libraries. Only docking decoys passing this threshold will be retained. Default is 40 for each stub library.
-   file\_name is the name of stub library. Put on multiple lines if you have several stub libraries.
-   cb\_force is the weighting factor in matching CB distance. Default to 1.0. Set to 0.0 when you are interested in matching backbone (Ca, C and N) only. Useful in using backbone hydrogen bond in hotspot library

## Prepack

Performs something approximating r++ prepacking (but less rigorously without rotamer-trial minimization) by doing sc minimization and repacking. Separates chains based on jump\_num, does prepacking, then reforms the complex. If jump\_num=0, then it will NOT separate chains at all.

```
<Prepack name=(&string) scorefxn=(score12 &string) jump_number=(1 &integer) task_operations=(comma-delimited list) min_bb=(0 &bool)/>
  <MoveMap>
  ...
  </MoveMap>
</Prepack>
```

-   min\_bb: minimize backbone in the bound state, before separating the partners. This option activates MoveMap parsing.
-   MoveMap: just like in FastRelax and MinMover, but is only activated if min\_bb is set to true.

## RepackMinimize

RepackMinimize does the design/repack and minimization steps using different score functions as defined by the protocol. For most purposes, the combination of PackRotamersMover with MinMover provide more flexibility and transparency than RepackMinimize, and are advised.

repack\_partner1 (and 2) defines which of the partners to design. If no particular residues are defined, the interface is repacked/designs. If specific residues are defined, then a shell of residues around those target residues are repacked/designed and minimized. repack\_non\_ala decides whether or not to change positions that are not ala. Useful for designing an ala\_pose so that positions that have been changed in previous steps are not redesigned. min\_rigid\_body minimize rigid body orientation. (as in docking)

```
<RepackMinimize name="&string" scorefxn_repack=(score12 &string) scorefxn_minimize=(score12 &string) repack_partner1=(1 &bool) repack_partner2=(1 &bool) design_partner1=(0 &bool) design_partner2=(1 &bool) interface_cutoff_distance=(8.0 &Real) repack_non_ala=(1 &bool) minimize_bb=(1 &bool * see below for more details) minimize_rb=(1 &bool) minimize_sc=(1 &bool) optimize_fold_tree=(1 & bool) task_operations=("" &string)>
    <residue pdb_num/res_num=(&string) />
</RepackMinimize>
```

-   scorefxn\_repack
-   scorefxn\_minimize
-   interface\_cutoff\_distance: Residues farther away from the interface than this cutoff will not be designed or minimized.
-   repack\_non\_ala: if true, change positions that are not ala. if false, leave non-ala positions alone. Useful for designing an ala\_pose so that positions that have been changed in previous steps are not redesigned.
-   minimize\_bb\*: minimize back bone conformation? (\*see line below)
-   minimize\_bb\_ch1 and/or minimize\_bb\_ch2: allows to specify which chain(s)' backbone will be minimized
-   minimize\_rb: minimize rigid body orientation? (as in docking)
-   optimize\_fold\_tree: see above
-   task\_operations: comma-separated list of task operations. This is a safer way of working with user-defined restrictions than automatic\_repacking=false.
-   pdb\_num/res\_num: see [[RosettaScripts Documentation#Specifying Residues|RosettaScripts-Documentation#Specifying-Residues]]

If no repack\_partner1/2 options are set, you can specify repack=0/1 to control both. Similarly with design\_partner1/2 and design=0/1

## DesignMinimizeHBonds

Same as for RepackMinimize with the addition that a list of target residues to be hbonded can be defined. Within a sphere of 'interface\_cutoff\_distance' of the target residues,the residues will be set to be designed.The residues that are allowed for design are restricted to hbonding residues according to whether donors (STRKWYQN) or acceptors (EDQNSTY) or both are defined. If residues have been designed that do not, after design, form hbonds to the target residues with energies lower than the hbond\_energy, then those are turned to Ala.

```
<DesignMinimizeHbonds name=(design_minimize_hbonds &string) hbond_weight=(3.0 &float) scorefxn_design=(score12 &string) scorefxn_minimize=score12) donors="design donors? &bool" acceptors="design acceptors? &bool" bb_hbond=(0 &bool) sc_hbond=(1 &bool) hbond_energy=(-0.5 &float) interface_cutoff_distance=(8.0 &float) repack_partner1=(1 &bool) repack_partner2=(1 &bool) design_partner1=(0 &bool) design_partner2=(1 &bool) repack_non_ala=(1 &bool) min_rigid_body=(1 &bool) task_operations=("" &string)>
        <residue pdb_num/res_num=(&string) />
</DesignMinimizeHbonds>
```

-   hbond\_weight: sets the increase (in folds) of the hbonding terms in each of the scorefunctions that are defined.
-   bb\_hbond: do backbone-backbone hbonds count?
-   sc\_hbond: do backbone-sidechain and sidechain-sidechain hbonds count?
-   hbond\_energy: what is the energy threshold below which an hbond is counted as such.
-   repack\_non\_ala,task\_operations:see RepackMinimize
-   optimize\_fold\_tree: see DockingProtocol
-   pdb\_num/res\_num: see [[RosettaScripts Documentation#Specifying Residues|RosettaScripts-Documentation#Specifying-Residues]]

## build\_Ala\_pose

Turns either or both sides of an interface to Alanines (except for prolines and glycines that are left as in input) in a sphere of 'interface\_distance\_cutoff' around the interface. Useful as a step before design steps that try to optimize a particular part of the interface. The alanines are less likely to 'get in the way' of really good rotamers.

```
<build_Ala_pose name=(ala_pose &string) partner1=(0 &bool) partner2=(1 &bool) interface_cutoff_distance=(8.0 &float) task_operations=("" &string)/>
```

-   task\_operations: see [RepackMinimize](#RepackMinimize)

## SaveAndRetrieveSidechains

To be used after an ala pose was built (and the design moves are done) to retrieve the sidechains from the input pose that were set to Ala by build\_Ala\_pose. OR, to be used inside mini to recover sidechains after switching residue typesets. By default, sidechains that are different than Ala will not be changed, **unless** allsc is true. Please note that naming your mover "SARS" is almost certainly bad luck and strongly discouraged.

    <SaveAndRetrieveSidechains name=(save_and_retrieve_sidechains &string) allsc=(0 &bool) task_operations=("" &string) two_steps=(0&bool) multi_use=(0&bool)/>

-   task\_operations: see [RepackMinimize](#RepackMinimize)
-   two\_steps: the first call to SARS only saves the sidechains, second call retrieves them. If this is false, the sidechains are saved at parse time.
-   multi\_use: If SaveAndRetrieveSidechains is used multiple times with two\_steps enabled throughout the xml protocol, multi\_use should be enabled. If not, the side chains saved the first time SaveAndRetrieveSidechains is called, will be retrieved for all the proceeding calls.

## AtomTree

Sets up an atom tree for use with subsequent movers. Connects pdb\_num on host\_chain to the nearest residue on the neighboring chain. Connection is made through connect\_to on host\_chain pdb\_num residue

```
<AtomTree name=(&string) docking_ft=(0 &bool) pdb_num/res_num=(&string) connect_to=(see below for defaults &string) anchor_res=(pdb numbering) connect_from=(see below) host_chain=(2 &integer) simple_ft=(0&bool) two_parts_chain1=(0&bool) fold_tree_file=(&string)/>
```

-   fold_tree_file: if this is set to a file name the mover will read a foldtree from a file and then impose it. Nothing more. Here's an example for a fold-tree definition:

FOLD_TREE EDGE 1 18 -1 EDGE 18 32 1 EDGE 18 21 -1 EDGE 32 22 -1 EDGE 32 50 -1 EDGE 50 79 -1 EDGE 50 163 2 EDGE 163 98 -1 EDGE 98 82 3 EDGE 98 96 -1 EDGE 82 95 -1 EDGE 82 80 -1 EDGE 163 208 -1

-   docking\_ft: set up a docking foldtree? if this is set all other options are ignored.
-   simple\_ft: set a simple ft going from 1-\>chain1\_end; 1-\>chain2\_begin; chain2\_begin-\>chain2\_end; etc.
-   two\_parts\_chain1: If chain1 is composed of two interlocking parts and you want to allow movements between these two parts, set to true. The mover will find the centers of mass of the first part of chain1, connect to the second part, and also connect the center of mass of the entire chain to the center of mass of chain2.
     Detailed settings for a foldtree:
     These options specify the actual jump atoms. anchor\_res (this is the residue) and connect\_from (the actual atom) are a pair and are used for the first chain, whereas pdb\_num (residue) and connect\_to (atom) are a pair on chain 2 (the one that typically moves)
-   connect\_to: Defaults to using the farthest carbon atom from the mainchain for each residue, e.g., CB, Cdelta for Gln etc.
-   connect\_from: user can specify which atom the jump should start from. Currently only the pdb naming works. If not specified, the "optimal" atomic connection for anchor residue is chosen (that is to their functional groups).
-   pdb\_num/res\_num: see [[RosettaScripts Documentation#Specifying Residues|RosettaScripts-Documentation#Specifying-Residues]]

## SpinMover

Allows random spin around an axis that is defined by the jump. Works preferentially good in combination with a loopOver or best a GenericMonteCarlo and other movers together. Use SetAtomTree to define the jump atoms.

```
<SpinMover name=(&string) jump_num=(1 &integer)/>
```

## TryRotamers

Produces a set of rotamers from a given residue. Use after [AtomTree](#AtomTree) to generate inverse rotamers of a given residue.

```
<TryRotamers name=(&string) pdb_num/res_num=(&string) automatic_connection=(1 &bool) jump_num=(1, &Integer) scorefxn=(score12 &string) explosion=(0 &integer) shove=(&comma-separated residue identities)/>
```

-   explosion: range from 0-4 for how much extra rotamer explosion to include. Extra explosion in this context means EX\_FOUR\_HALF\_STEP\_STDDEVS (+/- 0.5, 1.0, 1.5, 2.0 sd). (By default EX\_ONE\_STDDEV (+/- 1.0 sd) is included for all chi1,2,3,4.)
    -   1 = explode chi1
    -   2 = explode chi1,2
    -   3 = explode chi1,2,3
    -   4 = explode chi1,2,3,4
-   pdb\_num/res\_num: see [[RosettaScripts Documentation#Specifying Residues|RosettaScripts-Documentation#Specifying-Residues]]
-   shove: use the shove atom-type (reducing the repulsive potential on backbone atoms) for a comma-separated list of residue identities. e.g., shove=3A,40B.
-   automatic\_connection: should TryRotamers set up the inverse-rotamer fold tree independently?

Each pass through TryRotamers will place the next rotamer at the given position. Increase -nstruct settings appropriately to obtain them all. Once all rotamers have been placed, TryRotamers will cause subsequent runs through the protocol with the same settings to fail.

## BackrubDD

Do backrub-style backbone and sidechain sampling.

```
<BackrubDD name=(backrub &string) partner1=(0 &bool) partner2=(1 &bool) interface_distance_cutoff=(8.0 &Real) moves=(1000 &integer) sc_move_probability=(0.25 &float) scorefxn=(score12 &string) small_move_probability=(0.0 &float) bbg_move_probability=(0.25 &float) temperature=(0.6 &float) task_operations=("" &string)>
        <residue pdb_num/res_num=(&string)/>
        <span begin="pdb or rosetta-indexed number, eg 10 or 12B &string" end="pdb or rosetta-indexed number, e.g., 20 or 30B &string"/>
</BackrubDD>
```

With the values defined above, backrub will only happen on residues 31B, serial 212, and the serial span 10-20. If no residues and spans are defined then all of the interface residues on the defined partner will be backrubbed by default. Note that setting partner1=1 makes all of partner1 flexible. Adding segments has the effect of adding these spans to the default interface definition Temperature controls the monte-carlo accept temperature. A setting of 0.1 allows only very small moves, where as 0.6 (the default) allows more exploration. Note that small moves and bbg\_moves introduce motions that, unlike backrub, are not confined to the region that is being manipulated and can cause downstream structural elements to move as well. This might cause large lever motions if the epitope that is being manipulated is a hinge. To prevent lever effects, all residues in a chain that is allowed to backrub will be subject to small moves. Set small\_move\_probability=0 and bbg\_move\_probability=0 to eliminate such motions.

bbg\_moves are backbone-Gaussian moves. See The J. Chem. Phys., Vol. 114, pp. 8154-8158.

Note: As of June 29, 2011, this mover was renamed from "Backrub" to "BackrubDD". Scripts run with versions of Rosetta after that date must be updated accordingly.

-   pdb\_num/res\_num: see [[RosettaScripts Documentation#Specifying Residues|RosettaScripts-Documentation#Specifying-Residues]]
-   task\_operations: see [RepackMinimize](#RepackMinimize)

## BestHotspotCst

Removes Hotspot BackboneStub constraints from all but the best\_n residues, then reapplies constraints to only those best\_n residues with the given cb\_force constant. Useful to prune down a hotspot-derived constraint set to avoid getting multiple residues getting frustrated during minimization.

```
<BestHotspotCst name=(&string) chain_to_design=(2 &integer) best_n=(3 &integer) cb_force=(1.0 &Real)/>
```

-   best\_n: how many residues to cherry-pick. If there are fewer than best\_n residues with constraints, only those few residues will be chosen.
-   chain\_to\_design: which chain to reapply constraints
-   cb\_force: Cbeta force to use when reapplying constraints

## DomainAssembly (Not tested thoroughly)

Do domain-assembly sampling by fragment insertion in a linker region. frag3 and frag9 specify the fragment-file names for 9-mer and 3-mer fragments.

```
<DomainAssembly name=(&string) linker_start_(pdb_num/res_num, see below) linker_end_(pdb_num/res_num, see below) frag3=(&string) frag9=(&string)/>
```

-   pdb\_num/res\_num: see [[RosettaScripts Documentation#Specifying Residues|RosettaScripts-Documentation#Specifying-Residues]]

## LoopFinder

Finds loops in the current pose and loads them into the DataMap for use by subsequent movers (eg - LoopRemodel)

    <LoopFinder name="&string" interface=(1 &Size) ch1=(0 &bool) ch2=(1 &bool) min_length=(3 &Integer)
     max_length=(1000 &Integer) iface_cutoff=(8.0 &Real) resnum/pdb_num=(&string) 
    CA_CA_distance=(15.0 &Real) mingap=(1 &Size)/>

-   interface: only keep loops at the interface? value = jump number to use (0 = keep all loops)
-   ch1: keep loops on partner 1
-   ch2: keep loops on partner 2
-   resnum/pdb\_num: if specified, loop finder only takes the loops that are within the defined CA\_CA\_distance. If this option is occluded, it extracts loops given by chain1, chain2 and interface options.So occlude if you don't know the residue.
-   CA\_CA\_distance: cutoff for CA distances between defined residue and any interface loop residue
-   iface\_cutoff: distance cutoff for interface
-   min\_length: minimum loop length (inclusive)
-   max\_length: maximum loop length (inclusive)
-   mingap: minimum gap size between loops (exclusive, so mingap=1 -\> single-residue gaps are disallowed). Setting this to 0 will almost certainly cause problems!
-   pdb\_num/res\_num: see [[RosettaScripts Documentation#Specifying Residues|RosettaScripts-Documentation#Specifying-Residues]]

## LoopRemodel

Perturbs and/or refines a set of user-defined loops. Useful to sample a variety of loop conformations.

```
<LoopRemodel name="&string" auto_loops=(0 &bool) loop_start_(pdb_num/res_num) loop_end_(pdb_num/res_num) hurry=(0 &bool) cycles=(10 &Size) protocol=(ccd &string) perturb_score=(score4L &string) refine_score=(score12 &string) perturb=(0 &bool) refine=(1 &bool) design=(0 &bool)/>
```

-   pdb\_num/res\_num: see [[RosettaScripts Documentation#Specifying Residues|RosettaScripts-Documentation#Specifying-Residues]]
-   auto\_loops: use loops defined by previous LoopFinder mover? (overrides loop\_start/end)
-   loop\_start\_pdb\_num: start of the loop
-   loop\_end\_pdb\_num: end of the loop
-   hurry: 1 = fast sampling and minimization. 0 = Use full-blown loop remodeling.
-   cycles: if hurry=1, number of modeling cycles to perform. Each cycle is 50 steps of mc-accepted kinematic loop modeling, followed by a repack of the surrounding area. if hurry=0 and protocol=remodel, this controls the max number of times to attempt closure with the remodel protocol (low cycles might leave chain breaks!)
-   protocol: Only activated if hurry=0. Choose "kinematic", "ccd", or "remodel". ccd appears to work best at the moment.
-   perturb\_score: scorefunction to use for loop perturbation
-   refine\_score: scorefunction to use for loop refinement
-   perturb: perturb loops for greater diversity?
-   refine: refine loops?
-   design: perform design during loop modeling?

## LoopMoverFromCommandLine

Perturbs and/or refines a set of loops from a loop file. Also takes in fragment libraries from command line (-loops:frag\_sizes , -loops:frag\_files). Has kinematic, ccd and automatic protocols.

```
<LoopMoverFromCommandLine name="&string" loop_file=("loop.loops" &string) protocol=(ccd &string) perturb_score=(score4L &string) refine_score=(score12 &string) perturb=(0 &bool) refine=(1 &bool)/>
```

-   protocol: Only activated if hurry=0. Choose "automatic", "kinematic" or "ccd".If you set automatic, this mover becomes a wrapper around the 'modern' version of LoopRemodelMover which has all of the loop options defined within it. This is the recommended way of activating this mover. If you do that, then you get access to the following string options: relax (no,&string), refine (ccd is best), intermedrelax (no is default and is best), remodel (quick\_ccd is best).
-   perturb\_score: scorefunction to use for loop perturbation
-   refine\_score: scorefunction to use for loop refinement
-   perturb: perturb loops for greater diversity?
-   refine: refine loops?
-   loop\_file: loop file that should be in current working directory using minirosetta loop format.

For protocol="automatic" (Based on Loop Modeling Application and LoopRemodel):

```
<LoopMoverFromCommandLine name="&string" loop_file=("loop.loops" &string) protocol=automatic perturb_score=(score4L &string) refine_score=(score12 &string) perturb=(0 &bool) refine=(no &string) remodel=(quick_ccd &string) relax=(no, &string) intermedrelax=(no &string)/>
```

-   refine:'no','refine\_ccd','refine\_kic'. This option controls the fullatom refinement stage of loop modeling.
-   remodel:'no','perturb\_ccd','perturb\_kic','quick\_ccd','quick\_ccd\_moves','old\_loop\_relax'.
-   relax:'no','fastrelax','shortrelax','full relax'. Controls whether a full-structure relax occurs after loop modeling.
-   intermedrelax: Currently not used; eventually may provide for a full-pose relax between centroid and full atom modeling.

## DisulfideMover

Introduces a disulfide bond into the interface. The best-scoring position for the disulfide bond is selected from among the residues listed in `     targets    ` . This could be quite time-consuming, so specifying a small number of residues in `     targets    ` is suggested.

If no targets are specified on either interface partner, all residues on that partner are considered when searching for a disulfide. Thus including only a single residue for `     targets    ` results in a disulfide from that residue to the best position across the interface from it, and omitting the `     targets    ` param altogether finds the best disulfide over the whole interface.

Disulfide bonds created by this mover, if any, are guaranteed to pass a DisulfideFilter.

```
<DisulfideMover name="&string" targets=(&string)/>
```

-   targets: A comma-seperated list of residue numbers. These can be either with rosetta numbering (raw integer) or pdb numbering (integer followed by the chain letter, eg '123A'). Targets are required to be located in the interface. Default: All residues in the interface. *Optional*

## MutateResidue

Change a single residue to a different type. For instance, mutate Arg31 to an Asp.

```
<MutateResidue name=(&string) target=(&string) new_res=(&string) />
```

-   target The location to mutate (eg 31A (pdb number) or 177 (rosetta index)). *Required*
-   new\_res The name of the residue to introduce. This string should correspond to the ResidueType::name() function (eg ASP). *Required*

## InterfaceRecapitulation

Test a design mover for its recapitulation of the native sequence. Similar to SequenceRecovery filter below, except that this mover encompasses a design mover more specifically.

```
<InterfaceRecapitulation name=(&string) mover_name=(&string)/>
```

The specified mover needs to be derived from either DesignRepackMover or PackRotamersMover base class and to to have the packer task show which residues have been designed. The mover then computes how many residues were allowed to be designed and the number of residues that have changed and produces the sequence recapitulation rate. The pose at parse-time is used for the comparison.

## VLB (aka Variable Length Build)

Under development! All kudos to Andrew Ban of the Schief lab for making the Insert, delete, and rebuild segments of variable length. This mover will ONLY work with non-overlapping segments!

**IMPORTANT NOTE!!!!** : VLB uses its own internal tracking of ntrials! This allows VLB to cache fragments between ntrials, saving a very significant amount of time. But each ntrial trajectory will also get ntrials extra internal VLB apply calls. For example, "-jd2:ntrials 5" will cause a maximum of 25 VLB runs (5 for each ntrial). Success of a VLB move will break out of this internal loop, allowing the trajectory to proceed as normal.

```
<VLB name=(&string) scorefxn=(string)>
    <VLB TYPES GO HERE/>
</VLB>
Default scorefxn is score4L. If you use another scorefxn, make sure the chainbreak weight is > 0. Do not use a full atom scorefxn with VLB!
```

There are several move types available to VLB, each with its own options. The most popular movers will probably be SegmentRebuild and SegmentInsert.

```

<SegmentInsert left=(&integer) right=(&integer) ss=(&string) aa=(&string) pdb=(&string) side=(&string) keep_bb_torsions=(&bool)/> 

Insert a pdb into an existing pose. To perform a pure insertion without replacing any residues within a region, use an interval with a zero as the left endpoint.
e.g. [0, insert_after_this_residue].
If inserting before the first residue the Pose then interval = [0,0].  If inserting after the last residue of the Pose then interval = [0, last_residue]. 

*ss = secondary structure specifying the flanking regions, with a character '^' specifying where the insert is to be placed. Default is L^L.
*aa = amino acids specifying the flanking regions, with a character '^' specifying insert.
*keep_bb_torsions = attempt to keep the a few torsions from around the insert. This should be false for pure insertions. (default false)
*side = specifies insertion on its N-side ("N"), C-side ("C") or decide randomly between the two (default "RANDOM"). Random is only random on parsing, not per ntrial
```

```

<SegmentRebuild left=(&integer) right=(&integer) ss=(&string) aa=(&string)/> 
Instruction to rebuild a segment. Can also be used to insert a segment, by specifying secondary structure longer than the original segment.
```

```
Very touchy. Watch out.
<SegmentSwap left=(&integer) right=(&integer) pdb=(&string)/> instruction to swap a segment with an external pdb
```

```
<Bridge left=(&integer) right=(&integer) ss=(&string) aa=(&string)/> connect two contiguous but disjoint sections of a
                       Pose into one continuous section
```

```
<ConnectRight left=(&integer) right=(&integer) pdb=(&string)/> instruction to connect one PDB onto the right side of another
```

```
<GrowLeft pos=(&integer) ss=(&string) aa=(&string)/> Use this for n-side insertions, but typically not n-terminal
            extensions unless necessary.  It does not automatically cover the
            additional residue on the right endpoint that needs to move during
            n-terminal extensions due to invalid phi torsion.  For that case,
            use the SegmentRebuild class replacing the n-terminal residue with
            desired length+1.
```

```
<GrowRight pos=(&integer) ss=(&string) aa=(&string)/> instruction to create a c-side extension
```

For more information, see the various BuildInstructions in src/protocols/forge/build/

# Computational 'affinity maturation' movers (highly experimental)

These movers are meant to take an existing complex and improve it by subtly changing all relevant degrees of freedom while optimizing the interactions of key sidechains with the target. The basic idea is to carry out iterations of relax and design of the binder, designing a large sphere of residues around the interface (to get second/third shell effects).

We start by generating high affinity residue interactions between the design and the target. The foldtree of the design is cut such that each target residue has a cut N- and C-terminally to it, and jumps are introduced from the target protein to the target residues on the design, and then the system is allowed to relax. This produces deformed designs with high-affinity interactions to the target surface. We then use the coordinates of the target residues to generate harmonic coordinate restraints and send this to a second cycle of relax, this time without deforming the backbone of the design. Example scripts are available in demo/rosetta\_scripts/computational\_affinity\_maturation/

## RandomMutation

Introduce a random mutation in a position allowed to redesign to an allowed residue identity. Control the residues and the target identities through `     task_operations    ` . The protein will be repacked according to `     task_operations    ` and `     scorefxn    ` to accommodate the mutated amino acid. The mover can work with symmetry poses; simply use SetupForSymmetry and run. It will figure out that it needs to do symmetric packing for itself.

This can be used in conjunction with GenericMonteCarlo to generate trajectories of affinity maturation.

```
<RandomMutation name=(&string) task_operations=(&string comma-separated taskoperations) scorefxn=(score12 &string)/>
```

## GreedyOptMutationMover

This mover will first attempt isolated/independent mutations defined in the input task operation, score/filter them all, rank them by score, then attempt to combine them, starting with the best scoring single mutation, accepting the mutation only if the filter score decreases (see skip\_best\_check for optional exception), and working down the list to the end. Optionally test one of the top N mutations at each positions instead of just the best.

This mover is parallelizable with MPI. To use it, you must set the option parallel=1, and you must set the command line flag nstruct = nprocs - 1

Note: Each attempted mutation is always followed by repacking all residues in an 8 Å shell around the mutation site. The user-defined relax\_mover is called after that.

Note: Producing the very first output structure requires calculating all point mutant filter scores, which may take a bit, but output of subsequent structures (with nstruct \> 1 ) will re-use this table if it's still valid, making subsequent design calculations significantly faster. However, the table must be recalculated each time if it is receiving different structures at each iteration (e.g. if movers that stochastically change the structure are being used before this mover is called).

Necessary:

-   task\_operations: defines designable positions and identities
-   filter: defines the score you're trying to optimize (and a cutoff), defaults to lower = better
-   relax\_mover: a mover for post-repacking relaxation (e.g. minimization)

Optional:

-   filter\_delta: add sequence diversity; useful with nstruct \> 1; randomly try any mutation that scores within N filter points of the best-scoring mutation at each position instead of just the first, e.g. filter\_delta=0.5 for attempting any mutation within 0.5 filter points of the best one
-   incl\_nonopt: Default = false. Use with filter\_delta. This option modifies filter\_delta behavior such that all mutations that score within N filter points of the best are attempted in the combinatorial design stage.
-   sample\_type: if your filter values are such that higher = better, use "sample\_type=high"
-   dump\_pdb: if you want to see a pdb of every trial mutation, add "dump\_pdb=1"
-   dump\_table: if true, will save to a file the table of amino acids/filter values over which it is operating. (Filename and format of table may be subject to change: Current version lists the score for each allowed mutation, with an \* next to the original identity. The order of amino acids in the table is set by a sort over the filter, so the first aa listed is the best as judged by the filter, etc.)
-   design\_shell: default is set to -1, so there is no design. Set a positive value to determine the radius of design shell. This might be useful in case of reversion to native where more than one mutation is needed to revert.
-   repack\_shell: what radius should we repack around each tested/designed mutation
-   stopping\_condition: stops before trials are done if a filter evaluates to true (accepting the last mutation that caused the filter to evaluate to true by default. See stop\_before\_condition to change this behavior).
-   stop\_before\_condition: Default = false. Stop mover once the stopping\_condition is reached and do not accept the last mutation (ie, reject the mutation that set the stopping\_condition to true)
-   skip\_best\_check: Default = false. Accept mutations during the combining stage as long as they pass the filter(s), regardless of whether or not the value is the best so far.
-   reset\_delta\_filters: comma-separated list of delta\_filters. Will reset the baseline value of each delta filter to match the "best pose" after each accepted mutation during the combining stage. Useful so that the mutations are still evaluated on an individual basis, in the context of the current best pose.
-   rtmin: do rtmin following repack?
-   parallel: run the point mutation calculator in parallel, use in conjunction with openMPI

```
<GreedyOptMutationMover name=(&string) task_operations=(&string comma-separated taskoperations) filter=(&string) scorefxn=(score12 &string) relax_mover=(&string) sample_type=(low &string) diversify_lvl=(1 &int) dump_pdb=(0 &bool) dump_table=(0 &bool) rtmin=(0 &bool) stopping_condition=("" &string) stop_before_condition=(0 &bool) skip_best_check=(0 &bool) reset_delta_filters=(&string comma-separated deltafilters) design_shell=(-1, real) repack_shell=(8.0, &real)/>
```

## ParetoOptMutationMover

This mover will first attempt isolated/independent mutations defined in the input task operation and score/filter them all using all defined filters. Then, the Pareto-optimal mutations are identified at each position (see: [http://en.wikipedia.org/wiki/Pareto\_efficiency\#Pareto\_frontier](http://en.wikipedia.org/wiki/Pareto_efficiency#Pareto_frontier) ), discarding the non-optimal mutations. Next, the mover attempts to combine the Pareto-optimal mutations at each position. To do this, it starts with the sequence position that has the best score for filter \#1, and combines each of n mutations at that position with m mutations at the next position, producing n\*m new designs. These n\*m designs are then filtered for Pareto-optimality, leaving only the Pareto-optimal set. This process is repeated to the last designable position, producing multiple structures

This mover is parallelizable with MPI. To use it, you must set the option parallel=1, and you must set the nstruct flag equal to nprocs - 1 at the command line.

Important!: This mover produces multiple output structures from one input structure. To get rosetta\_scripts to output these, use nstruct \> 1. The number of structures produced is dependent on the number of filters defined. 2 filters commonly results in \~20 structures.

Note: Each attempted mutation is always followed by repacking all residues in an 8 Å shell around the mutation site. The user-defined relax\_mover is called after that.

Note: Producing the very first output structure requires calculating all point mutant filter scores, which may take a bit, but output of subsequent structures (with nstruct \> 1 ) will re-use this table if it's still valid, making subsequent design calculations significantly faster. However, the table must be recalculated each time if it is receiving different structures at each iteration (e.g. if movers that stochastically change the structure are being used before this mover is called).

Necessary:

-   task\_operations: defines designable positions and identities
-   relax\_mover: a mover for post-repacking relaxation (e.g. minimization)
-   multiple filters must be defined with branch tags; see example below!

Example:

```
<ParetoOptMutationMover name=popt task_operations=task relax_mover=min scorefxn=score12>
    <Filters>
       <AND filter_name=filter1 sample_type=low/>
       <AND filter_name=filter2 sample_type=low/>
    </Filters>
</ParetoOptMutationMover>
```

Optional:

-   sample\_type: if your filter values are such that higher = better, use "sample\_type=high"
-   dump\_pdb: if you want to see a pdb of every trial mutation, add "dump\_pdb=1"
-   parallel: run the point mutation calculator in parallel, use in conjunction with openMPI

```
<ParetoOptMutationMover name=(&string) task_operations=(&string comma-separated taskoperations) scorefxn=(score12 &string) relax_mover=(&string) sample_type=(low &string) dump_pdb=(0 &bool)/>
```

## HotspotDisjointedFoldTree

Creates a disjointed foldtree where each selected residue has cuts N- and C-terminally to it.

```
<HotspotDisjointedFoldTree name=(&string) ddG_threshold=(1.0 &Real) resnums=("" comma-delimited list of residues &string) scorefxn=(score12 &string) chain=(2 &Integer) radius=(8.0 &Real)/>
```

-   ddG\_threshold: The procedure can look for hot-spot residues automatically by using this threshold. If you want to shut it off, specify a number above 100R.e.u. and set the residues in resnums
-   chain: Anything other than chain 1 is untested, but should not be a big problem to make work.
-   radius: what distance from the target protein constitutes interface. Used in conjunction with the ddG\_threshold to set the target residues automatically.

## AddSidechainConstraintsToHotspots

Adds harmonic constraints to sidechain atoms of target residues (to be used in conjunction with HotspotDisjointedFoldTree). Save the log files as those would be necessary for the next stage in affinity maturation.

```
<AddSidechainConstraintsToHotspots name=(&string) chain=(2 &Integer) coord_sdev=(1.0 &Real) resnums=(comma-delimited list of residue numbers)/>
```

-   resnums: the residues for which to add constraints. Notice that this list will be treated in addition to any residues that have cut points on either side.
-   coord\_sdev: the standard deviation on the coordinate restraints. The lower the tighter the restraints.

# Placement and Placement-associated Movers & Filters

The placement method has been described in:

Fleishman, SJ, Whitehead TA, et al. Science 332, 816-821. (2011) and JMB 413:1047

The objective of the placement methods is to help in the task of generating hot-spot based designs of protein binders. The starting point for all of them is a protein target (typically chain A), libraries of hot-spot residues, and a scaffold protein.

A few keywords used throughout the following section have special meaning and are briefly explained here.

-   Hot-spot residue: typically a residue that forms optimized interactions with the target protein. The goal here is to find a low-energy conformation of the scaffold protein that incorporates as many such hot-spot residues as possible.
-   Stub: used interchangeably with hot-spot residue. This is a dismembered residue in a specified location against the target surface.
-   Placement: positioning of the scaffold protein such that it incorporates the hot-spot residue optimally.

Hotspot residue-libraries can be read once by the SetupHotspotConstraintsMover. In this mover you can decide how many hotspot residues will be kept in memory for a given run. This number of residues will be chosen randomly from the residues that were read. In this way, you can read arbitrarily large hotspot residue libraries, but each trajectory will only iterate over a smaller set.

## Auction

This is a special mover associated with PlaceSimultaneously, below. It carries out the auctioning of residues on the scaffold to hotspot sets without actually designing the scaffold. If pairing is unsuccessful Auction will report failure.

```
<Auction name=( &string) host_chain=(2 &integer) max_cb_dist=(3.0 &Real) cb_force=(0.5 &Real)>
   <StubSets>
     <Add stubfile=(&string)/>
   </StubSets>
</Auction>
```

Note that none of the options, except for name, needs to be set up by the user if PlaceSimultaneously is notified of it. If PlaceSimultaneously is notified of this Auction mover, PlaceSimultaneously will set all of these options.

## MapHotspot

Map out the residues that might serve as a hotspot region on a target. This requires massive user guidance. Each hot-spot residue should be roughly placed by the user (at least as backbone) against the target. Each hot-spot residue should have a different chain ID. The method iterates over all allowed residue identities and all allowed rotamers for each residue. Tests its filters and for the subset that pass selects the lowest-energy residue by score12. Once the first hot-spot residue is identified it iterates over the next and so on until all hot-spot residues are placed. The output contains one file per residue identity combination.

```
<MapHotspot name="&string" clash_check=(0 &bool) file_name_prefix=(map_hs &string)>
   <Jumps>
     <Add jump=(&integer) explosion=(0 &integer) filter_name=(true_filter & string) allowed_aas=("ADEFIKLMNQRSTVWY" &string) scorefxn_minimize=(score12 &string) mover_name=(null &string)/>
     ....
   </Jumps>
</MapHotspot>
```

-   clash\_check: whether the rotamer set is prescreened by the packer for clashes. Advised to be off always.
-   file\_name\_prefix: Prefix for the output file names.
-   explosion: How many chi angles to explode (giving more rotamers.
-   allowed\_aas: 1-letter codes for the allowed residues.
-   scorefxn\_minimize: which scorefxn to use during rb/sc minimization.
-   mover\_name: a mover (no restrictions) to run just before hot-spot residue minimization.

## PlacementMinimization

This is a special mover associated with PlaceSimultaneously, below. It carries out the rigid-body minimization towards all of the stubsets.

```
<PlacementMinimization name=( &string) minimize_rb=(1 &bool) host_chain=(2 &integer) optimize_foldtree=(0 &bool) cb_force=(0.5 &Real)>
  <StubSets>
    <Add stubfile=(&string)/>
  </StubSets>
</PlacementMinimization>
```

## PlaceOnLoop

Remodels loops using kinematic loop closure, including insertion and deletion of residues. Handles hotspot constraint application through these sequence changes.

```
<PlaceOnLoop name=( &string) host_chain=(2 &integer) loop_begin=(&integer) loop_end=(&integer) minimize_toward_stub=(1&bool) stubfile=(&string) score_high=(score12 &string) score_low=(score4L&string) closing_attempts=(100&integer) shorten_by=(&comma-delimited list of integers) lengthen_by=(&comma-delimited list of integers)/>
```

currently only minimize\_toward\_stub is avaible. closing attempts: how many kinematic-loop closure cycles to use. shorten\_by, lengthen\_by: by how many residues to change the loop. No change is also added by default.

At each try, a random choice of loop change will be picked and attempted. If the loop cannot close, failure will be reported.

Demonstrated in JMB 413:1047

## PlaceStub

Hotspot-based sidechain placement. This is the main workhorse of the hot-spot centric method for protein-binder design. A paper describing the method and a benchmark will be published soon. The "stub" (hot-spot residue) is chosen at random from the provided stub set. To minimize towards the stub (during placement), the user can define a series of movers (StubMinimize tag) that can be combined with a weight. The weight determines the strength of the backbone stub constraints that will influence the mover it is paired with. Finally, a series of user-defined design movers (DesignMovers tag) are made and the result is filtered according to final\_filter. There are two main ways to use PlaceStub:

1.  PlaceStub (default). Move the stub so that it's on top of the current scaffold position, then move forward to try to recover the original stub position.
2.  PlaceScaffold. Move the scaffold so that it's on top of the stub. You'll keep the wonderful hotspot interactions, but suffer from lever effects on the scaffold side. PlaceScaffold can be used as a replacement for docking by deactivating the "triage\_positions" option.

```
<PlaceStub name=(&string) place_scaffold=(0 &bool) triage_positions=(1 &bool) chain_to_design=(2 &integer) score_threshold=(0.0 &Real) allowed_host_res=(&string) stubfile=(&string) minimize_rb=(0 &bool) after_placement_filter=(true_filter &string) final_filter=(true_filter &string) max_cb_dist=(4.0 &Real) hurry=(1 &bool) add_constraints=(1 &bool) stub_energy_threshold=(1.0 &Real) leave_coord_csts=(0 &bool) post_placement_sdev=(1.0 &Real)>
     <StubMinimize>
        <Add mover_name=(&string) bb_cst_weight=(10, &Real)/>
     </StubMinimize>
     <DesignMovers>
        <Add mover_name=(&string) use_constraints=(1 &bool) coord_cst_std=(0.5 &Real)/>
     </DesignMovers>
     <NotifyMovers>
        <Add mover_name=(&string)/>
     </NotifyMovers>
</PlaceStub>
```

-   place\_scaffold: use PlaceScaffold instead of PlaceStub. this will place the scaffold on the stub's position by using an inverse rotamer approach.
-   triage\_positions: remove potential scaffold positions based on distance/cst cutoffs. speeds up the search, but must be turned off to use place\_scaffold=1 as a replacement for docking (that is, when placing the scaffold at positions regardless of the input structure). triage\_positions=1 triages placements based on whether the hotspot is close enough (within max\_cb\_distance) and whether the hotspot's vectors align with those of the host position (with some tolerance).
-   chain\_to\_design
-   score\_threshold
-   allowed\_host\_res: A list of residues on the host scaffold where the stub may be placed. The list should be comma-seperated and may contain either rosetta indices (e.g. 123) or pdb indices (e.g. 123A). Note that allowed residues must still pass the triage step (if enabled) and other restrictions on which residues may be designed (e.g. not proline).
-   stubfile: using a stub file other than the one used to make constraints. This is useful for placing stubs one after the other.
-   minimize\_rb: do we want to minimize the rb dof during stub placement? This will allow a previously placed stub to move a a little to accommodate the new stub. It's a good idea to use this with the previously placed stub adding its implied constraints.
-   after\_placement\_filter: The name of a filter to be applied immediately after stub placement and StubMinimize movers, but before the DesignMovers run. Useful for quick sanity check on tstring) score_low=(score4Lhe goodness of the stub.
-   final\_filter: The name of a filter to be applied at the final stage of stub placement as the last test, after DesignMovers run. Useful, e.g., if we want a stub to form an hbond to a particular target residue.
-   max\_cb\_dist: the maximum cb-cb distance between stub and potential host residue to be considered for placement
-   hurry: use a truncated scorefxn for minimization. large speed increases, doesn't seem to be less accurate.
-   add\_constraints: should we apply the coordinate constraints to this stub?
-   stub\_energy\_threshold: Decoys are only considered if the single-residue energy of the stub is below this value
-   leave\_coord\_csts: should the coordinate constraints be left on when placement is completed successfully? This is useful if you plan on making moves after placement and you want the hotspot's placement to be respected. Note that designing a residue that has constraints on it is likely to yield crashes. You can use task operations to disallow that residue from designing.
-   post\_placement\_sdev: relating to the item above. The lower the sdev (towards 0) the more stringent the constraint.

The available tracers are:

-   protocols.ProteinInterfaceDesign.movers.PlaceStubMover - light-io documentation of the run
-   STATS.PlaceStubMover - statistics on distances and score values during placement
-   DEBUG.PlaceStubMover - more io intensive documentation

**Submovers:** Submovers are used to determine what moves are used following stub placement. For example, once a stub has been selected, a StubMinimize mover can try to optimize the current pose towards that stub. A DesignMover can be used to design the pose around that stub. Using DesignMover submovers within PlaceStub (instead of RepackMinimize movers outside PlaceStub) allows one to have a "memory" of which stub has been used. In this way, a DesignMover can fail a filter without causing the trajectory to completely reset. Instead, the outer PlaceStub mover will select another stub, and the trajectory will continue.
 There are two types of sub movers that can be called within the mover.

1.  **StubMinimize**
     Without defining this submover, the protocol will simply perform a rigid body minimization as well as sc minimization of previous placed stubs in order to minimize towards the stub. Otherwise, a series of previously defined movers can be added, such as backrub, that will be applied for the stub minimization step. Before and after the list of stub minimize movers, there will be a rigid body minimization and a sc minimization of previously placed stubs. The bb\_cst\_weight determines how strong the constraints are that are derived from the stubs.
    -   mover\_name: a user previously defined design or minimize mover.
    -   bb\_cst\_weight: determines the strength of the constraints derived from the stubs. This value is a weight on the cb\_force, so larger values are stronger constraints.

    Valid/sensible StubMinimize movers are:
    -   BackrubDD
    -   LoopRemodel

2.  **DesignMovers**
     Design movers are typically used once the stubs are placed to fill up the remaining interface, since placestub does not actually introduce any further design other than stub placement.
    -   mover\_name: a user previously defined design or minimize mover.
    -   use\_constraints: whether we should use coordinate constraints during this design mover
    -   coord\_cst\_std: the std of the coordinate constraint for this mover. The coord constraints are harmonic, and the force constant, k=1/std. The smaller the std, the stronger the constraint

    Valid/sensible DesignMovers are:
    -   RepackMinimize

3.  **NotifyMovers**
    Movers placed in this section will be notified not to repack the PlaceStub-placed residues. This is not necessary if placement movers are used in a nested (recursive) fashion, as the placement movers automatically notify movers nested in them of the hot-spot residues. Essentially, you want to make the downstream movers (you list under this section) aware about the placement decisions in this upstream mover. These movers will not be run at in this placestub, but will be subsequently aware of placed residues for subsequent use. Useful for running design moves after placestub is done, e.g., in loops. Put task awareness only in the deepest placestub mover (if PlaceStub is nested), where the final decisions about which residues harbour hot-spot residues is made.

## PlaceSimultaneously

Places hotspot residues simultaneously on a scaffold, rather than iteratively as in PlaceStub. It is faster therefore allowing more backbone sampling, and should be useful in placing more than 2 hotspots.

```
<PlaceSimultaneously name=(&string) chain_to_design=(2 &Integer) repack_non_ala=(1 &bool) optimize_fold_tree=(1 &bool) after_placement_filter=(true_filter &string) auction=(&string) stub_score_filter=(&string) stubscorefxn="backbone_stub_constraint &string" coor_cst_cutoff="100 &Real"/>
     <DesignMovers>
        <Add mover_name=(null_mover &string) use_constraints=(1 &bool) coord_cst_std=(0.5 &Real)/>
     </DesignMovers>
     <StubSets explosion=(0 &integer) stub_energy_threshold=(1.0 &Real)  max_cb_dist=(3.0 &Real) cb_force=(0.5 &Real)>
        <Add stubfile=(& string) filter_name=(&string)/>
     </StubSets>
     <StubMinimize min_repeats_before_placement=(0&Integer) min_repeats_after_placement=(1&Integer)>
       <Add mover_name=(null_mover &string) bb_cst_weight=(10.0 &Real)/>
     </StubMinimize>
     <NotifyMovers>
       <Add mover_name=(&string)/>
     </NotifyMovers>
</PlaceSimultaneously>
```

Most of the options are similar to PlaceStub above. Differences are mentioned below:

-   explosion: which chis to explode
-   stub\_energy\_threshold: after placement and minimization, what energy cutoff to use for each of the hotspots.
-   after\_placement\_filter: After all individual placement filters pass, this is called (might be redundant?)
-   min\_repeats: How many minimization repeats (over StubMinimize movers) after placement
-   movers defined under NotifyMovers will not be allowed to change the identities or rotamers of their hot-spot residues beyond what PlaceSimultaneously has decided on. This would be useful for avoiding losing the hot-spot residues in design movers after placement.
-   filters specified in the StubSets section may be set during PlaceSimultaneously's execution by PlaceSimultaneously. This allows filters to be set specifically for placed hot-spot residues. One such filter is AtomicContact.
-   rb\_stub\_minimization: a StubMinimization mover that will be run before PlaceSimultaneously.
-   auction: and Auction mover that will be run before PlaceSimultaneously.
-   stub\_score\_filter: a StubScoreFilter that will be run before PlaceSimultaneously.
-   stubscorefxn is the energy function used for hotspot, default to backbone\_stub\_constraint to produce old results. Use "backbone\_stub\_linear\_constraint" will use a different protocol for placesimultaneously. The difference is that rather than choose one type from the stub library randomly, this protocol will choose only the residue type in the stub library, when placed by packer, have the lowest deviation (coordinate constraint energy) from the stub library conformation.
-   coor\_cst\_cutoff is the threshold coordinate constraint energy between the added hotspot residues and the one in the stub library. Use with stubscorefxn=backbone\_stub\_linear\_constraint. PlaceSimultaneously fails if placed residues deviates beyond this threshold.

rb\_stub\_minimization, auction and stub\_score\_filter allow the user to specify the first moves and filtering steps of PlaceSimultaneously before PlaceSimultaneously is called proper. In this way, a configuration can be quickly triaged if it isn't compatible with placement (through Auction's filtering). If the configuration passes these filters and movers then PlaceSimultaneously can be run within loops of docking and placement, until a design is identified that produces reasonable ddg and sasa.

## RestrictRegion

Makes a mutation to a pose, and creates a resfile task which repacks (no design) the mutated residue, and designs the region around the mutation. Residues far from the mutated residue are fixed. The residue to be mutated can be selected by several different metrics (see below). Useful for altering small regions of the pose during optimization without making large sequence changes.

```
<RestrictRegion name=(&string) type=(&string) resfile=("" &string) psipred_cmd=(&string) blueprint=(&string) task_operations=(task,task,task) num_regions=(&int) scorefxn=() />
```

-   type: Defines the method by which residues from the designable residues in the fast factory are selected for mutation. Possible types are:
    -   random\_mutation: Choose a residue at random.
    -   psipred: Choose residues with secondary structure that disagrees with psipred calculations.
    -   packstat: Choose residues with poor packstat scores.
    -   score: Choose residues with poor per-residue energy.
    -   random: Randomly choose from one of the above.
-   num\_regions: Number of mutations and regions to design
-   resfile: RestrictRegion creates a resfile with the proper information. This resfile should be read by any mover or filter which needs to use the RestrictRegion functionality. The resfile created will include restrictions from the task factory that is passed to RestrictRegion.
-   psipred\_cmd: Path to psipred executable. Required if the type is "psipred"
-   scorefxn: Scorefunction to use for determining poorly scoring regions. Only used if the type is "score"
-   task\_operations: Task factory which defines the possible mutations to the pose.
-   blueprint: Path to blueprint file which contains secondary structure information. Used if the type is "psipred"

**Example**

```
<SCOREFXNS>
    <SFXN weights="talaris2013.wts" />
</SCOREFXNS>
<TASKOPERATIONS>
    <ReadResfile name="restrict_resfile" filename="restrict.resfile" />
</TASKOPERATIONS>
<MOVERS>
    <RestrictRegion name="restrict" resfile="restrict.resfile" type="random_mutation" num_regions="1" scorefxn="SFXN" />
    <PackRotamersMover name="design_region" task_operations="restrict_resfile" scorefxn="SFXN" />
</MOVERS>
<PROTOCOLS>
    <Add mover_name="restrict" />
    <Add mover_name="design_region" />
</PROTOCOLS>
```

## StubScore

This is actually a filter (and should go under FILTERS), but it is tightly associated with the placement movers, so it's placed here. A special filter that is associated with PlaceSimultaneouslyMover. It checks whether in the current configuration the scaffold is 'feeling' any of the hotspot stub constraints. This is useful for quick triaging of hopeless configuration.

```
<StubScore name=(&string) chain_to_design=(2 &integer) cb_force=(0.5 &Real)>
  <StubSets>
     <Add stubfile=(&string)/>
  </StubSets>
</StubScore>
```

Note that none of the flags of this filter need to be set if PlaceSimultaneously is notified of it. In that case, PlaceSimultaneously will set this StubScore filter's internal data to match its own.

## ddG

This mover is useful for reporting the total or per-residue ddgs in cases where you don't want to use the ddG filter for some reason. (also, the ddg filter can't currently do per-residue ddgs). Ddg scores are reported as string-real pairs in the job. The total ddg score has the tag "ddg" and the each pre residue ddg has the tag "residue\_ddg\_n" where n is the residue number.

```
<ddG name=(&string) jump=(1 &integer) per_residue_ddg=(0 &bool) repack=(0 bool&) scorefxn=("score12" &string) chain_num=(&int,&int...) chain_name=(&char,&char) filter=(&string)/>
```

chain\_num and chain\_name allow you to specify a list of chain numbers or chain names to use to calculate the ddg, rather than a single jump. You cannot move chain 1, moving all the other chains is the same thing as moving chain 1, so do that instead. If filter is specified, the computed value of the filter will be used for the reported difference in score, rather than the given scorefunction. Use of the filter with per-residue ddG is not supported.

This mover supports the Poisson-Boltzmann energy method by setting the runtime environment to indicate the altering state, either bound or unbound. When used properly in conjunction with SetupPoissonBoltzmannPotential (mover), the energy method (see: core/scoring/methods/PoissonBoltzmannEnergy) is enabled to solve for the PDE only when the conformation in corresponding state has changed sufficiently enough. As ddG uses all-atom centroids to determine the separation vector when the movable chains are specified by jump, it is highly recommended to use chain\_num/chain\_name to specify the movable chains, to avoid invalidating the unbound PB cache due to small changes in atom positioning.

Example:

The script below shows how to enable PB with ddg mover. I have APBS (Adaptive Poisson-Boltzmann Solver) installed in /home/honda/apbs-1.4/ and "apbs" executable is in the bin/ subdiretory. Chain 1 is charged in this case. You can list more than one chain by comma-delimit (without extra whitespace. e.g. "1,2,3"). I use full scorefxn as the basis and add the PB term.

    <SCOREFXNS>
        <sc12_w_pb weights=score12_full patch=pb_elec/>  patch PB term
    </SCOREFXNS>
    <MOVERS>
        <SetupPoissonBoltzmannPotential name=setup_pb scorefxn=sc12_w_pb charged_chains=1 apbs_path="/home/honda/apbs-1.4/bin/apbs"/>
        <Ddg name=ddg scorefxn=sc12_w_pb chain_num=2/>
    </MOVERS>
    <FILTERS>
        ...
    </FILTERS>
    <PROTOCOLS>
        <Add mover_name=setup_pb/>  Initialize PB
        <Add mover_name= .../>  some mover
        <Add mover_name=ddg/> use PB-enabled ddg as if filter
        <Add filter_name=.../>  more filtering
    </PROTOCOLS>

## ContactMap

Calculate and output contact maps for each calculated structure

```
<ContactMap name="&string" region1=( &string) region2=( &string) ligand=( &string)  distance_cutoff=( 10.0 &Real)  prefix=("contact_map_" &string) reset_count=("true" &string) models_per_file=(1 &int) row_format=("false" &string) / >
```

-   region1: region definition for region1 of ContactMap in format '\<start\>-\<end\>' or '\<chainID\>' defaults to 1-\<n\_residue()\>
-   region2: region definition for region2 of ContactMap
-   ligand: sequence position or chainID of ligand - all non-hydrogen atoms of the corresponding residue will be mapped against the CB atoms of region1(ignored if region2-tag is specified)
-   distance\_cutoff: Maximum distance of two atoms so contacts count will be increased
-   prefix: Prefix for output\_filenames
-   reset\_count: flag whether the count will be reset to 0 after the ContactMap was output to a file. if set to false, the same file will be updated every 'models\_per\_file' structures (only applies for n\_struct\>1 when called with the Scripter)
-   models\_per\_file: defines after how many structures an output file should be generated (no file will be created if equal to 0 or greater than n\_struct !)
-   row\_format: flag if output should be in row format rather than the default matrix format
