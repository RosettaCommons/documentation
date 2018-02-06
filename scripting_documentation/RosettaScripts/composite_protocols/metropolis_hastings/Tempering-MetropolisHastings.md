<!-- --- title: Tempering (Metropolishastings) -->The tempering module supports Monte Carlo simulations where not only the conformation x, but also temperature or scoring weights are made dynamical variables that can be sampled. In replica exchange simulations, for instance, multiple pre-defined temperature levels are sampled. With a pre-defined frequency a temperature swap between simulations at different temperatures is attempted. By using a generalized Metropolis-Criterion to decide whether an attempted temperature swap is successful one guarantees that the stationary distribution at each temperature-level is still the Boltzmann-distribution similar to a single-temperature Metropolis Monte Carlo simulation (see [Parallel Tempering](http://en.wikipedia.org/wiki/Parallel_tempering) ).

-   Parallel Tempering ( replica exchange ): multiple processes (replicas) each at one temperature level
-   SimulatedTempering: single process switching stochastically between temperature levels
-   Hamiltonian Exchange: multiple processes -- change of temperature and score-weights possible

SimulatedTempering has the advantage that it does not require inter-process communication and thus can be run on distributed computing systems. However, it requires weights to achieve uniform sampling of all temperature levels. Identifying optimal weights can be challenging [\[1\]](http://link.aps.org/doi/10.1103/PhysRevE.76.016703) .

Common Options of all Tempering modules
---------------------------------------

Many options are shared between all tempering modules. Options can be accessed via command-line or as tags in RosettaScripts (Note to developers: requires registering of ClassName::register\_options() at beginning of application ). The configuration of temperature-levels and range and of the score-functions can be controlled to some extent via options, or it can be supplied directly per input file. An input file will always override any choices made via the options.

|Option|Tag|Type|Explanation|
|:-----|:--|:---|:----------|
|tempering:stride|temp\_stride|Int|attempt frequency of temperature switch|
|tempering:temp:file|temp\_file|File|configuration file --- definition of temperature levels and/or score-functions; weights for simulated tempering|
|tempering:temp:levels|temp\_levels|Int|how many different levels/replicas|
|tempering:temp:range|temp\_range|Real Real|min- and maximum temperature|
|tempering:temp:low|temp\_low|Real|minimum temperature|
|tempering:temp:high|temp\_high|Real|maximum temperature|
|\<none\>|temp\_interpolation|string/enum|type of interpolation between low and high temperatures: "linear" or "exponential"|
|tempering:stats:file|stats\_file|File|filename (postfix) for output of tempering statistics|
|tempering:stats:line\_output|stats\_line\_output|Bool|write statistics information in single line per job|
|tempering:stats:silent|stats\_silent\_output|Bool|write statistic of all jobs in single file (uses line\_output mode)|

Comment during development: should we drop the temp\_ prefix and the ::temp:: part of the option ?

SimulatedTempering
------------------

some extra options to control reweighting. To achieve uniform sampling in temperature space weights can be chosen. To improve the uniformness over time we count steps sampled at each temperature level and update the weights after a certain interval (reweights\_stride) or after each job.

|Option|Tag|Type|Explanation|
|:-----|:--|:---|:----------|
|tempering:temp:offset|temp\_offset|Real|offset for score (effectively scales all weights|
|tempering:reweight:stride|reweight\_stride|Int|how many trials between automatic reweighting - 0 for once per job|
|tempering:temp:jump|jump|Bool|jump to any temperature not just +/- 1 level|

ParallelTempering
-----------------

This module only uses common options as described above. However, there are several other external requirements. ParallelTempering uses a specialized MPI (message passing interface) build of Rosetta. Several related parameters must be specified in a self consistent manner:

-   the number of processors specified through the MPI interface (usually through the `    miprun -np   ` command line parameter)
-   the number of replicas given to Rosetta through the command line (through the `    -run:n_replica   ` command line parameter)
-   the number of temperature levels (through the `    temp_levels   ` RosettaScripts parameter or `    -tempering:temp:levels   ` command line parameter)

The number of replicas and number of temperature levels must always be identical. To coordinate starting individual jobs and capturing their output, two processors are required in addition to those that are used for running the individual replicas.

If multiple input files are specified (through the `   -in:file:s  ` or `   -in:file:l  ` command line parameters) and/or multiple output structures are requested (through the `   -out:nstruct  ` command line parameter), then it is possible to run separate replica exchange simulations in parallel through the same invocation of Rosetta. Given T temperature levels, S simultaneous replica exchange simulations, the number of processors (P) required is calculated: P = 2+T\*S.

An example command line for invoking a single 8 temperature-level replica exchange RosettaScript is as follows:

    mpirun -np 10 rosetta_scripts.mpi.<platform><compiler>release -database Rosetta/main/database -parser:protocol metropolis_hastings.xml -in:file:s structure.pdb -run:n_replica 8

In this case, the `   metropolis_hastings.xml  ` would need to contain the following:

```xml
<ROSETTASCRIPTS>
  ...
  <MOVERS>
    <MetropolisHastings ...>
      <ParallelTempering temp_levels="8" .../>
      ...
    </MetropolisHastings>
  </MOVERS>
  ...
</ROSETTASCRIPTS>
```

One could instead run two simultaneous independent simulations starting from the same structure by changing `   -np 10  ` to `   -np 18  ` and adding `   -out:nstruct 2  ` to the end of the command line.

At the end of the simulation, ParallelTempering gives some useful output to determine the sampling and computational efficiency. The master process for a given simulation (here 2) shows the temperature exchange frequencies, in this example a 4 temperature level simulation from 2.4-4.8:

```
protocols.canonical_sampling.ParallelTempering: (2) Temperature Exchange Frequencies:
protocols.canonical_sampling.ParallelTempering: (2) 2.400 <-> 3.024: 0.346 (173 of 500)
protocols.canonical_sampling.ParallelTempering: (2) 3.024 <-> 3.810: 0.260 (130 of 500)
protocols.canonical_sampling.ParallelTempering: (2) 3.810 <-> 4.800: 0.326 (163 of 500)
```

The total number of exchange attempts for a given pair of temperatures will be half of what one would expect from the `   stride  ` parameter, because an attempt to exchange a given pair of temperatures is only made every other time. The first time temperatures are exchanged, the pairs used are 1\<-\>2, 3\<-\>4, etc. The second time the pairs used are 2\<-\>3, 4\<-\>5, etc. The third time is the same as the first and so on.

Another piece of information given by each process is the time it waits for other processes to finish before temperature exchange can complete. For example:

```
protocols.canonical_sampling.ParallelTempering: (5) Spent 6.45519% time waiting for MPI temperature exchange (11.6047 seconds out of 179.773 total)
protocols.canonical_sampling.ParallelTempering: (2) Spent 6.54907% time waiting for MPI temperature exchange (11.7734 seconds out of 179.772 total)
protocols.canonical_sampling.ParallelTempering: (3) Spent 7.05215% time waiting for MPI temperature exchange (12.6739 seconds out of 179.716 total)
protocols.canonical_sampling.ParallelTempering: (4) Spent 8.22242% time waiting for MPI temperature exchange (14.7771 seconds out of 179.717 total)
```

This can be useful for determining how much CPU time is wasted because of replicas taking differing amounts of time to execute the `   stride  ` Monte Carlo trials between exchanges. As with all MPI-related output, the results can appear out of order as shown above.

HamiltonianExchange
-------------------

The HamiltonianExchange module allows switching between different score-functions as well as tempeatures. Switches will be attempted between neighboring levels. In contrast to temperature replica exchange where a clear 1-dim ordering is natural the changes between different score-functions might be multi-dimensional. To account for this the user has the ability to define a multi-dimensional grid. Each Hamiltonian level is assigned to a grid-cell, exchange attempts are done between neighboring grid-cells.

*TODO: as different hamiltonians (with different score-function terms) might have widely different times required for time-steps we should allow that the tempering-stride is set independently for each temp-level.*

#### Configuration File Format

The configuration file (common option : temp\_file ) controls the complete setup of the Hamiltonians. Instead of a file the configuration can also be assembled directly in the xml file (not implemented yet). The file has the following format:

    [ GRID_DIM d ]
    [ GLOBAL_PATCH patch 
    [ GLOBAL_PATCH patch2 [..] ]]
    cell-coord temp score:weights score:patch/NOPATCH score_type op wt [...] ETABLE FA_STANDARD 

-   the header line "GRID\_DIM" can be omitted (default 1).
-   header lines "GLOBAL\_PATCH" can be omitted. Every patch defined here will be applied to all score-functions.
-   score:weights specifies a score.wts file in the database or local.
-   score:patch specifies a patch-file name (database or local).
-   score\_type op wt: is an inline patch with operator(op) "\*=" or "=" and a real number wt
-   NOPATCH is a placeholder in case no patch from file should be applied but "inline" patches or ETABLE entries follow
-   ETABLE: allows loading of a specific etable. (e.g., FA\_STANDARD\_SOFT )
-   Note: that gaps in the cell-coords do not matter. i.e., 1 2 5 6 creates 4 levels with exchanges 1\<-\>2, 2\<-\>5, and 5\<-\>6.

Example 1: 1 dimension, 3 cells (levels). Exchange between different temperature and hard\<-\>soft

    1 0.6 score12
    2 0.6 score12 NOPATCH ETABLE FA_STANDARD_SOFT
    3 1.0 score12 NOPATCH fa_rep *= 1.1 ETABLE FA_STANDARD_SOFT

Example 2: 2 dimensions 6 cells (levels).

    GRID_DIM 2
    GLOBAL_PATCH cst_patch.txt
    GLOBAL_PATCH fa_atr = 2
    1 1 0.6 score12 occ_Hbond_sol_exact
    1 2 1.0 score12 occ_Hbond_sol_exact fa_atr *= 1.5
    2 1 0.6 score12 NOPATCH fa_rep *= 0.5
    2 2 1.0 score12 NOPATCH fa_rep *= 0.5
    3 2 1.0 score12 NOPATCH fa_rep *= 0.2 
    3 3 2.0 score12 NOPATCH fa_rep = 0.1

all score-functions will be patched with cst\_patch.txt and get an fa\_atr = 2. cst\_patch.txt will be searched in your local directory (and maybe contains atom\_pair\_constraint = 1.0) GLOBAL\_PATCHes are applied after creation of the score-function with the score12 and NOPATCH/patch , but before the other local patch-operations.

exchanges between the following cells: (1,1)\<-\>(1,2); (1,1)\<-\>(2,1); (1,2)\<-\>(2,2); (2,1)\<-\>(2,2); (2,2)\<-\>(3,2); (3,2)\<-\>(3,3)

#### ExchangeGrid

[[images/ExchangeGrid_MHM.jpg]]

#### Replica Exchange sampling Docking Low-resolution Stage

commandline:

    mpirun -np 14 rosetta_scripts.mpi.<platform><compilter>release -database Rosetta/main/database -parser:protocol dock_cen.xml -in:file:s P.pdb -in:file:native native.pdb -partners A_B -score:weights interchain_cen -n_replica 3 -nstruct 4 -run:intermediate_structures -out:file:silent decoys.out -out:file:scorefile scores.fsc

RosettaScripts file `   dock_cen.xml  ` with comments to guide you through:

```xml
<ROSETTASCRIPTS>
    <SCOREFXNS>
        <ScoreFunction name="score_dock_low" weights="interchain_cen" />
    </SCOREFXNS>
    <FILTERS>
    </FILTERS>
    <MOVERS>
       ''// sampling in low-resolution'' 
        <SwitchResidueTypeSetMover name="switch2centroid" set="centroid"/>

       '' // unbiased mover for translation and rotation, mover step size using constant gaussian mean value, alternatively use dock_cen_inter.xml, which interpolate mover's step size based on temperature level''
        <ThermodynamicRigidBodyPerturbNoCenter name="rb_mover" rot_mag="1" trans_mag="0.5"/> 

        ''// setup fold_tree, and store movable_jump into RigidBodyInfo''
        <DockSetupMover name="setup_jump"/> 

      ''  // very loose Atompair constraint between closest-to-mass-center CAs. For example: "AtomPair  CA   337  CA   531 BOUNDED       0.1 s(1)+s(2)+gap 0.5 Encounter" , 337 and 531 are the closest-to-mass-center residues of each docking partners respectively, and s(i) is the furthest distance of a surface CA of docking partner i to its center CA.''
        <AddEncounterConstraintMover name="encounter_cst" gap="8" />  

        ''// randomly reorient the two docking partners''
        <DockingInitialPerturbation name="init_pert" randomize2="1" randomize1="1" /> 
        // sampling engine

        ''// acceptance rate recorder''
        <TrialCounterObserver name="count" file="trial.stats"/> 

        ''// temp_file contains the temperature configuration. exchange between neighbor temperature is attempted every 1000 strides. No specific reason why using HamiltonianExchange mover intead of ParalleTempering, only because I started with it at the very beginning and it works as well if only temperature exchange involved.''
        <HamiltonianExchange name="h_exchange" temp_file="hamiltonians_cen.txt"  temp_stride="1000"/> 

        ''// take snapshots every 1000 stride and output the decoy into a trajectory silent file''
        <SilentTrajectoryRecorder name="traj" score_stride="1" stride="1000" cumulate_replicas="1" />

        ''// Empirically, 5000,000 steps are enough for converge.'' 
        <MetropolisHastings name="sampler" trials="5000000" scorefxn="score_dock_low" > 
            <Add mover_name="h_exchange"/>
            <Add mover_name="traj"/>
            <Add mover_name="count"/>
            <Add mover_name="rb_mover"/>
        </MetropolisHastings>

    </MOVERS>
    <APPLY_TO_POSE>
    </APPLY_TO_POSE>
    <PROTOCOLS>
        <Add mover_name="switch2centroid"/>
        <Add mover_name="setup_jump"/>
        <Add mover_name="encounter_cst"/>
        <Add mover_name="init_pert"/>
        <Add mover_name="sampler"/>
    </PROTOCOLS>
</ROSETTASCRIPTS>
```

configuration file `   hamiltonians_cen.txt  `

    GRID_DIM 1
    GLOBAL_PATCH atom_pair_constraint = 5
    1 2.0 interchain_cen   
    2 3.0 interchain_cen 
    3 5.0 interchain_cen  

After low-resolution sampling is done, selected decoys can procede to the standard RosettaDock refinement protocol.
