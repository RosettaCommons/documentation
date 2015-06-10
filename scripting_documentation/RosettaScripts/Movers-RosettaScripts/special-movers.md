[[_TOC_]]

# Combining Movers

## ParsedProtocol (formerly DockDesign)

This is a special mover that allows making a single compound mover and filter vector (just like protocols). The optional option mode changes the order of operations within the protocol, as defined by the option. If undefined, mode defaults to the historical functionality, which is operation of the Mover/Filter pairs in the defined order.

```
<ParsedProtocol name=( &string) mode=( &string)>
    <Add mover_name=( null &string) filter_name=( true_filter &string) apply_probabilities=(see below &Real/>
    ...
</ParsedProtocol>
```

-   mode: "sequence" - (default) perform the Mover/Filter pair in the specified sequence; "random\_order" - perform EACH of the defined Mover/Filter pairs one time in a random order; "single\_random" - randomly pick a SINGLE Mover/Filter pair from the list.
-   apply\_probabilities: This only works in mode single\_random. You can set the probability that an individual submover will be called 0-1. The probabilities must sum to 1.0, or you'll get an error message. Notice that this is used by GenericMonteCarlo in its adaptive\_movers mode to adjust the probabilities of movers dynamically during a sampling trajectory.

## MultiplePoseMover

This mover allows a multi-step "distribute and collect" protocol to be implemented in a single script, for example ab initio followed by RMSD clustering, or docking followed by design.

See the [[MultiplePoseMover|RosettaScripts-MultiplePoseMover]] page for details and examples.

## MultipleOutputWrapper

This is a simple wrapper that will execute the mover or ROSETTASCRIPTS protocol it contains to generate additional (derived) output poses from the original pose.
This mover is designed to work with the MultiplePoseMover.
"MoverName" is a placeholder for the actual name of the mover to be used.
Use this wrapper if the mover you want to use does cannot provided more than one output pose (yet).

```
<MultipleOutputWrapper name=(&string) max_output_poses=(&integer)>
    <MoverName .../>
</MultipleOutputWrapper>
```

or

<MultipleOutputWrapper name=(&string) max_output_poses=(&integer)>
    <ROSETTASCRIPTS>
        ...
    </ROSETTASCRIPTS>
</MultipleOutputWrapper>

-   max\_output\_poses: Maximum number of output poses this wrapper should generate (i.e. how many times the inner mover is executed).

## Subroutine

Calling another RosettaScript from within a RosettaScript

```
<Subroutine name=(&string) xml_fname=(&string)/>
```

-   xml\_fname: the name of the RosettaScript to call.

This definition in effect generates a Mover that can then be incorporated into the RosettaScripts PROTOCOLS section. This allows a simplification and modularization of RosettaScripts.

Recursions are allowed but will cause havoc.

## ContingentAcceptMover

Calculates the value of a filter before and after the move, and returns false if the difference in filter values is greater than delta.

```
<ContingentAccept name=( &string) mover=(&string) filter=(&string) delta=(&Real)/>
```

## IfMover

Implements a simple IF (filter(pose)) THEN true\_mover(pose) ELSE false\_mover(pose). *true\_mover* is required, *false\_mover* is not.

```
<If name=( &string) filter_name=(&string) true_mover_name=(&string) false_mover_name=(null &string)/>
```

## RandomMover

Randomly apply a mover from a list given probability weights. The **movers** tag takes a comma separated list of mover names. The **weights** tag takes a comma separate list of weights that sum to 1. The lengths of the movers and weights lists should must match.

```
<RandomMover name=( &string) movers=(&string) weights=(&string) repeats=(null &string)/>
```

# Looping/Monte Carlo Movers

## LoopOver

Allows looping over a mover using either iterations or a filter as a stopping condition (the first turns true). By using ParsedProtocol mover (formerly named the DockDesign mover) above with loop can be useful, e.g., if making certain moves is expensive and then we want to exhaust other, shorter moves.

```
<LoopOver name=(&string) mover_name=(&string) filter_name=( false_filter &string) iterations=(10 &Integer) drift=(true &bool)/>
```

drift: true- the state of the pose at the end of the previous iteration will be the starting state for the next iteration. false- the state of the pose at the start of each iteration will be reset to the state when the mover is first called. Note that "falling off the end" of the iteration will revert to the original input pose, even if drift is set to true.

This mover is somewhat deprecated in favor of the more general GenericMonteCarlo mover.

## GenericMonteCarlo

Allows sampling structures by MonteCarlo with a mover. The score evaluation of pose during MC are done by Filters that can do report\_sm(), not only ScoreFunctions.
 You can choose either format:

1) scoring by Filters

```
<GenericMonteCarlo name=(&string) mover_name=(&string) filter_name=(&string) trials=(10 &integer) sample_type=(low, &string) temperature=(0, &Real) drift=(1 &bool) recover_low=(1 &bool) boltz_rank=(0 &bool) stopping_condition=(FalseFilter &string) preapply=(1 &bool) adaptive_movers=(0 &bool) adaptation_period=(see below &integer) saved_accept_file_name=("" &string) saved_trial_file_name=("" &string) reset_baselines=(1 &bool) progress_file=("" &string)>
  <Filters>
     <AND filter_name=(&string) temperature=(&Real) sample_type=(low, &string) rank=(0 &bool)/>
     ...
  </Filters>
</GenericMonteCarlo>
```

2) scoring by ScoreFunction

```
<GenericMonteCarlo name=(&string) mover_name=(&string) scorefxn_name=(&string) trials=(10 &integer) sample_type=(low, &string) temperature=(0, &Real) drift=(1 &bool) recover_low=(1 &bool) stopping_condition=(FalseFilter &string) preapply=(1 &bool) saved_accept_file_name=("" &string) saved_trial_file_name=("" &string)/>
```

-   *stopping\_condition* : stops before trials are done if a filter evaluates to true.
-   *sample\_type* : low - sampling structures having lower scores; high - sampling structures having higher scores
-   *drift* : true - the state of the pose at the end of the previous iteration will be the starting state for the next iteration; false - the state of the pose at the start of each iteration will be reset to the state when the mover is first called ( Of course, this is not MC ).
-   *recover\_low* : true - at the end of application, the pose is set to the lowest (or highest if sample\_type="high") scoring pose; false - the pose after apply completes is the last accepted pose
-   *preapply* : true - Automatically accept the first application of the sub-mover, ignoring the Boltzmann criterion. false - apply Boltzmann accept/reject to all applications of the mover. Though defaulting to true for historical reasons, it is highly recommended to set this to false unless you know you need it to be true.
-   adaptive\_movers: If the mover you call or a submover of that mover is of type ParsedProtocol with mode single-random, then GenericMonteCarlo can 'learn' the best sampling strategy by adapting the apply probabilities of individual movers within that ParsedProtocol. For each adaptation period (say 20 mover applies) the number of accepts of each submover is recorded (with pseudocounts of 1 for each mover) and during the next adaptation period the apply probabilities of the submovers in the ParsedProtocol are adjusted according in proportion to the acceptance probabilities of the previous stage. Due to the pseudocounts, all movers have at least some chance of being called.
-   adaptation\_period: goes together with adaptive\_movers, defined above. Defaults to max( max\_trials/10, 10 ) but can be set to any integer.
-   saved\_accept\_file\_name: save the most recent accepted structure in a temporary PDB? This allows recovery by checkpointing. Note that different processes would need to work from different directories or somehow control the checkpointing file name, else confusion will reign.
-   saved\_trial\_file\_name: checkpointing file for the current trial number. Allows the mover to recover after failure.
-   reset\_baselines: If the filter is of type Sigmoid/Operator/CompoundStatement, look for all subfilters of type Sigmoid and reset their baseline to the pose's current filter evaluation at trial=1. Useful in cases where you want to set the thresholds relative to the pose's evaluation at the start of the MC trajectory.
-   progress\_file: If specified opens a file in which each trial's outcome is reported (trial number, accept/reject, filter value, and pose sequence). Useful to monitor progress in MC.

Multiple filters can be defined for an MC mover. These filters are then applied sequentially in the order listed and only if the pose passes the Metropolis criterion for all filters is it accepted. This allows the extension of MC to a multicriterion framework where more than one criterion is optimized, say the total score and the binding energy. See demos/rosetta\_scripts/experimental/computational\_affinity\_maturation\_strategy2 for an example. It's recommended to list the computationally expensive filters last, as later filters will only be calculated if the earlier filters all pass.

In the multiple filter case, the filter to be used for the official score of the pose (e.g. for recover\_low purposes) can be specified with the *rank* parameter (this has no effect on the MC accept/reject). If no sub-filters are set with rank=1, the first filter is used for ranking. As a special case, if *boltz\_rank* is set to true, the ranking score is a temperature-weighted sum of all filter values. (This value is equivalent to the effective value optimized by the MC protocol.)

A task can optionally be included for automatic setting of the number of trials in a GenericMonteCarlo run. Without a task input the number of trials is set by the Trials integer input. If a task is included, the number of designable residues will be calculated and the number of trials will be automatically set as task\_scaling \* (number designable residues). For example, if there are 10 designable residues and task\_scaling is 5 (the default) the number of trials will be 50. The task\_scaling is set to 5 by default and can be adjusted in the xml with the task\_scaling flag. Giving an input task will override any value set by the Trials input. This allows for automation over a number of different input files. Input the task as for any other move, see example xml line below. Note that the input task does not alter the movers/filters contained within the GenericMonteCarlo, it is only used for calculating the number of designable residues.

```
<GenericMonteCarlo name=(&string) mover_name=(&string) filter_name=(&string) trials=(10 &integer) sample_type=(low, &string) temperature=(0, &Real) drift=(1 &bool) recover_low=(1 &bool) boltz_rank=(0 &bool) stopping_condition=(FalseFilter &string) preapply=(1 &bool) task_operations=(&string,&string,&string) task_scaling=(5 &integer)>
```

## GenericSimulatedAnnealer

Allows finding global minima by sampling structures using SimulatedAnnealing. Simulated annealing is essentially a monte carlo in which the acceptance temperature starts high (permissive) to allow energy wells to be found globally, and is gradually lowered so that the structure can proceed as far into the energy well as possible. Like the GenericMonteCarlo, any movers can be used for monte carlo moves and any filters with a functional report\_sm function can be used for evaluation. All options available to GenericMonteCarlo are usable in the GenericSimulatedAnnealer (see above), and only options unique to GenericSimulatedAnnealer are described here. The specified filters are applied sequentially in the order listed and only if the pose passes the Metropolis criterion for all filters is the move accepted. See the documentation for GenericMonteCarlo for more details on acceptance.

Temperature scaling occurs automatically. Temparatures for all filters are multiplied by a scaling factor that ranges from 1.0 (at the start) and is reduced as the number of acceptances increases. The multiplier is equal to e\^(-anneal\_step/num\_filters). During each step, the GenericSimulatedAnnealer keeps track of the last several accepted poses (the number of accepted poses it keeps = history option). When improvements in the accepted scores slow, the annealer lowers the temperature to the next step.

```
<GenericSimulatedAnnealer name=(&string) mover_name=(&string) filter_name=(&string) trials=(10 &integer) sample_type=(low, &string) temperature=(0, &Real) drift=(1 &bool) recover_low=(1 &bool) boltz_rank=(0 &bool) stopping_condition=(FalseFilter &string) preapply=(1 &bool) adaptive_movers=(0 &bool) adaptation_period=(see below &integer) saved_accept_file_name=("" &string) saved_trial_file_name=("" &string) reset_baselines=(1 &bool) history=(10 &int) eval_period=(0 &int) periodic_mover=("" &string) checkpoint_file=("" &string) keep_checkpoint_file=(0 &bool) >
  <Filters>
     <AND filter_name=(&string) temperature=(&Real) sample_type=(low, &string) rank=(0 &bool)/>
     ...
  </Filters>
</GenericSimulatedAnnealer>
```

-   history: The number of accepted scores and poses to use to determine when to scale the temperatures.
-   eval\_period: If set, the periodic\_mover will be run every eval\_period trials.
-   checkpoint\_file: Saves progress to disk after every trial into a file with the specified name.
-   keep\_checkpoint\_file: If true, the checkpoint files created by the SimulatedAnnealer will not be cleaned up.
-   periodic\_mover: A user-specified mover that is run every eval\_period trials. This mover is NOT a monte carlo move, it does not count toward the number of trials, and its results are always accepted.

**Example**
 The following example uses the GenericSimulatedAnnealer to repeatedly redesign a protein to optimize agreement of secondary structure prediction with actual secondary structure without significant loss of score. It also relaxes the structure every 50 iterations. Although this example redesigns the entire protein at each iterations, this type of optimization should be restricted to small areas of the pose at a time for best results (see RestrictRegion mover).

```
<FILTERS>
    <SSPrediction name="ss_pred" use_svm="0" cmd="/path/to/runpsipred_single" />
    <ScoreType name="total_score" scorefxn="SFXN" score_type="total_score" threshold="0" confidence="0" />
</FILTERS>
<MOVERS>
    <FastRelax name="relax" />
    <PackRotamersMover name="design" />
    <GenericSimulatedAnnealer name="optimize_pose"
    mover_name="design" trials="500"
    periodic_mover="relax" eval_period="50" history="10" 
    bolz_rank="1" recover_low="1" preapply="0" drift="1" 
    checkpoint_file="mc" keep_checkpoint_file="1"
    filter_name="total_score" temperature="1.5" sample_type="low" > 
        <Filters>
            <AND filter_name="ss_pred" temperature="0.005" />
        </Filters>
    </GenericSimulatedAnnealer>
</MOVERS>
<PROTOCOLS>
    <Add mover_name="optimize_pose" />
</PROTOCOLS>
```

## MonteCarloTest

Associated with GenericMonteCarlo. Simply test the MC criterion of the specified GenericMonteCarloMover and save the current pose if accept.

```
<MonteCarloTest name=(&string) MC_name=(&string)/>
```

-   MC\_name: name of a previously defined GenericMonteCarloMover

Useful in conjunction with MonteCarloRecover (below) if you're running a trajectory consisting of many different sorts of movers, and would like at each point to decide whether the pose has made an improvement.

## MonteCarloRecover

Associated with GenericMonteCarlo and MonteCarloTest. Recover a pose from a GenericMonteCarloMover.

```
<MonteCarloRecover name=(&string) MC_name=(&string) recover_low=(1 &bool)/>
```

-   MC\_name: name of a previously defined GenericMonteCarloMover
-   recover\_low: recover the lowest-energy pose, or the last pose.

Useful in conjunction with MonteCarloRecover (below) if you're running a trajectory consisting of many different sorts of movers, and would like at each point to decide whether the pose has made an improvement.

## MonteCarloUtil

(This is a devel Mover and not available in released versions.)

This mover takes as input the name of a montecarlo object specified by the user, and calls the reset or recover\_low function on it.

```
<MonteCarloUtil name=(&string) mode=(&string) montecarlo=(&string)/>
```

-   mode: Mode of the monte carlo mover. can be either "reset" or "recover\_low"
-   montecarlo: the monte carlo object to act on

## MetropolisHastings

This mover performs [[Metropolis-Hastings Monte Carlo simulations|MetropolisHastingsMover]] , which can be used to estimate the thermodynamic distribution of conformational states for a given score function, temperature, and set of underlying movers. See the dedicated [[MetropolisHastings Documentation|MetropolisHastings-Documentation]] page for more information.

```
<MetropolisHastings name=(&string) scorefxn=(score12 &string) temperature=(0.6 &Real) trials=(1000 &Size)>
  ...
</MetropolisHastings>
```

The MetropolisHastings mover uses submovers to perform the trial moves and optionally record statistics about the simulation after each trial. They can be specified in one of two ways:

1.  Defining the movers within MetropolisHastings:

    ```
    <MetropolisHastings ...>
      <Backrub sampling_weight=(1 &Real) .../>
    </MetropolisHastings>
    ```

2.  Referencing previously defined movers:

    ```
    <Backrub name=backrub .../>
    <MetropolisHastings ...>
      <Add mover_name=backrub sampling_weight=(1 &Real)/>
    </MetropolisHastings>
    ```

In either case, the probability that any given submover will be chosen during the simulation can be controlled using the sampling\_weight parameter. The sampling weights for all movers are automatically normalized to 1. Submovers used with MetropolisHastings must be subclasses of ThermodynamicMover.

In addition to trial movers, you can also specify a specialized mover that will change the temperature or score function during the simulation. This type of mover is called a TemperatureController. Finally, additional movers that only record simulation statistics after each trial move can also be used, which are known as ThermodynamicObserver modules.

Both the TemperatureController and ThermodynamicObserver modules can be specified in the same two ways as trial movers, with the sampling\_weight excluded, for example:

```
<MetropolisHastings ...>
  <Backrub sampling_weight=(1 &Real) .../>
  <SimulatedTempering temp_low=(0.6 &Real) .../>
  <PDBTrajectoryRecorder stride=(100 &Size) filename=(traj.pdb &string)/>
  <MetricRecorder stride=(100 &Size) filename=(metrics.txt &string)>
    <Torsion rsd=(&string) type=(&string) torsion=(&Size) name=("" &string)/>
  </MetricRecorder>
</MetropolisHastings>
```

## IteratedConvergence

Repeatedly applies a sub-mover until the given filter returns a value within the given delta for the given number of cycles

```
<IteratedConvergence name=(&string) mover=(&string) filter=(&string) delta=(0.1 &real) cycles=(1 &integer) maxcycles=(1000 &integer) />
```

-   mover - the mover to repeatedly apply
-   filter - the filter to use when assaying for convergence (should return a reasonable value from report\_sm())
-   delta - how close do the filter values have to be to count as converged
-   cycles - for how many mover applications does the filter value have to fall within `      delta     ` of the reference value before counting as converged. If the filter is outside of the range, the reference value is reset to the new filter value.
-   maxcycles - exit regardless if filter doesn't converge within this many applications of the mover - intended mainly as a safety check to prevent infinite recursion.

## RampMover

Repeatedly applies a given mover while ramping the score from a low value to a high value.

```
<RampingMover name=(&string) start_weight=(&real) end_weight=(&real) outer_cycles=(&real) inner_cycles=(&real) score_type=(&string) ramp_func=(&string) montecarlo=(&string) mover=(&string)/>
```

-   start\_weight - starting weight for ramp
-   end\_weight - ending weight for ramp
-   outer\_cycles - number of increments to ramp score in
-   inner\_cycles - number of times to call inner mover in each score ramp increment
-   score\_type - name of the score term to ramp
-   ramp func - the ramp funct to use, valid options are linear, geometric, or inverse\_geometric
-   montecarlo - the name of the montecarlo object to use
-   mover - name of the inner mover to use.

# Reporting/Saving

## SavePoseMover

This mover allows one to save a pose at any time point through out a trajectory or from disk, and recall it any time point again to replace a current pose. Can also just be used with filter, eg. delta filters.

```
<SavePoseMover name=native restore_pose=(1, &bool) reference_name=(&string) pdb_file=(&string) />
```

-   restore\_pose - if you want to replace it
-   reference\_name - is what the pose gets saved under. so to recall that one specific pose, just re-call it under the name given when first called.
-   pdb\_file - Optional. If present, will load the given PDB file into the referenced pose at parse time.

## ReportToDB

Report structural data to a [[relational database|Database-IO]] using a modular schema. Each [[FeaturesReporter|FeatureReporters]] is responsible for a set of tables that conceptually represents a type of geometric, chemical, or meta property of a structure. All features reportered though a single instance of the ReportToDB Mover will be grouped into a **batch** of structures.

```
<ReportToDB name="&string" {database_connection_options}  cache_size=(&integer) batch_description="&string" protocol_id=(&integer) task_operations=(&task_operations) relevant_residues_mode=[explicit,implicit]>
   <Feature name="&string" {feature_specific_options}/>
   <Feature name="&string" {feature_specific_options}/>
   .
   .
   .
</ReportToDB>
```

**ReportToDB Tag** :

-   **name** *(&string)* : The name assigned to this mover to be referenced in the MOVERS section of the RosettaScript.
-   **[[database_connection_options|RosettaScripts-database-connection-options]]** : Options to connect to the relational database
-   **sample\_source** *(&string)* : A description for the *batch* of structures. This ends up in the `      description     ` column of the [[batches|MetaFeaturesReporters#BatchFeatures]] table.
-   **[[task_operations|RosettaScripts-Documentation#TASKOPERATIONS]]** : Restrict extraction of features to a subset of residues in a structure. A residue is *relevant* if it is *packable* . For multi-residue features, all residues must be *packable* for it to be reported.
-   **relevant\_residues\_mode** [ *explicit* `      default     ` , *implicit* ]: Determines which features should be reported given the set of relevant residues. With *explicit* all residues in a feature must be *relevant* to be reported. With *implicit* at least one residues in a feature must be *relevant* to be reported.

**Feature Subtags** : Each features subtag applies a [[features reporter|FeatureReporters]] to the structure.

-   **name** *(&string)* : This is the name of the feature, e.g. *RotamerRecoveryFeatures* .
-   **feature\_specific\_options** : See individual FeaturesReporters to for details.
-   The following FeaturesReporters are included automatically:
    -   **[[ProtocolFeatures|MetaFeaturesReporters#ProtocolFeatures]]** : About the Rosetta application execution.
    -   **[[BatchFeatures|MetaFeaturesReporters#BatchFeatures]]** : About the set of features extracted by this ReportToDB instance.
    -   **[[StructureFeatures|MultiBodyFeaturesReporters#StructureFeatures]]** : About each structure reportered by this ReportToDB instance. Note, currently each structure has a universally unique id, **struct\_id** that is used as a composite primary key in almost all feature tables.
-   The following tables are created to help organize the features database:
    -   **features\_reporters** : The FeaturesReporters used in any batch in the database

<!-- -->

        CREATE TABLE IF NOT EXISTS features_reporters (
            report_name TEXT,
            PRIMARY KEY (reporter_name));

-   **batch\_reports** : The features reporters used by this ReportToDB instance.

<!-- -->

        CREATE TABLE IF NOT EXISTS batch_reports (
            report_name TEXT,
            batch_id INTEGER,
            FOREIGN KEY (report_name) REFERENCES features_reporters (report_name) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (report_name, batch_id));

Additional Information:

-   General information using the a features database to do [[features analysis|FeaturesScientificBenchmark]] .
-   How to [[create|FeaturesExtracting]] a new FeaturesReporter.
-   Usage of features analysis for doing [scientific benchmarking](http://contador.med.unc.edu/features/paper/features_optE_methenz_120710.pdf) of the Rosetta ScoreFunction.

## ResetBaseline
Use this mover to call the reset_baseline method in filters Operator and CompoundStatement. Monte Carlo mover takes care of
resetting independently, so no need to reset if you use MC.

```
<ResetBaseline name=(&string) filter=(&filter)/>
```
- filter: the name of the Operator or CompoundStatement filter.

## TrajectoryReportToDB

The TrajectoryReportToDB mover is a subclass of [[ReportToDB|Movers-RosettaScripts#ReportToDB]] that can be used in Rosetta scripts to report features multiple times to a database for a single output, creating a "trajectory". Since this mover is a subclass of above, any tag or option described for ReportToDB can also be used here. See [[ReportToDB|Movers-RosettaScripts#ReportToDB]] for these options.

Structures are mapped to cycle step in the trajectory\_structures\_steps table. To select all trajectory output for a particular run, group struct\_ids by output tag (found in the structures table).

**ReportToDB Tag** :

-   Any tag used in [[ReportToDB|Movers-RosettaScripts#ReportToDB]] can also be used in TrajectoryReportToDB
-   **stride** *(&int)* : This one additional tag is unique to TrajectoryReportToDB. It controls the "stride", or how often trajectory features are reported in a simulation. Example: if stride is set to 10, then features will be reported every 10th iteration of the protocol.

**Feature Subtags** : Same as [[ReportToDB|Movers-RosettaScripts#ReportToDB]]

-   The following tables are created:
    -   **trajectory\_structures\_steps** : Maps struct\_id to trajectory step count.

<!-- -->

        CREATE TABLE trajectory_structures_steps(
             struct_id INTEGER NOT NULL,
             step INTEGER NOT NULL,
             FOREIGN KEY (struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
             PRIMARY KEY (struct_id, step));

## DumpPdb

Dumps a pdb. Recommended ONLY for debuggging as you can't change the name of the file during a run, although if tag\_time is true a timestamp with second resolution will be added to the filename, allowing for a limited amount of multi-dumping. If scorefxn is specified, a scored pdb will be dumped.

    <DumpPdb name=(&string) fname=(dump.pdb &string) scorefxn=(&string) tag_time=(&bool 0)/>

## PDBTrajectoryRecorder

Record a trajectory to a multimodel PDB file. Only record models every n times using stride. Append ".gz" to filename to use compression.

```
<PDBTrajectoryRecorder stride=(100 &Size) filename=(traj.pdb &string) cumulate_jobs=(0 &bool) cumulate_replicas=(0 &bool)/>
```

If run with MPI, the cumulate\_jobs and cumulate\_replicas parameters affect the filename where the trajectory is ultimately written. For instance, with the default filename parameter of `     traj.pdb    ` , input structure name of `     structname    ` , trajectory number of `     XXXX    ` , and replica number of `     YYY    ` , the following names will be generated given the options.

-   cumulate\_jobs=0 cumulate\_replicas=0: structname\_XXXX\_YYY\_traj.pdb
-   cumulate\_jobs=0 cumulate\_replicas=1: structname\_XXXX\_traj.pdb
-   cumulate\_jobs=1 cumulate\_replicas=0: YYY\_traj.pdb
-   cumulate\_jobs=1 cumulate\_replicas=1: traj.pdb

## SilentTrajectoryRecorder

Record a trajectory of snapshots as silent-file.

```
<SilentTrajectoryRecorder stride=(100 &Size) score_stride=(100 &Size) filename=(traj &string) cumulate_jobs=(0 &bool) cumulate_replicas=(0 &bool)/>
```

By default, this will actually generate PDB file output. To get silent file output, several additional command line flags are required:

     -out:file:silent <silent filename> -run:intermediate_structures

If used within [MetropolisHastings](#MetropolisHastings) , the current job output name becomes part of the filename. If run with MPI, the cumulate\_jobs and cumulate\_replicas parameters affect the filename where the trajectory is ultimately written. For instance, with the default filename parameter of `     traj    ` , input structure name of `     structname    ` , trajectory number of `     XXXX    ` , replica number of `     YYY    ` , and `     -out:file:silent default.out    ` , the following names will be generated given the options.

-   cumulate\_jobs=0 cumulate\_replicas=0: default\_structname\_XXXX\_YYY\_traj.out
-   cumulate\_jobs=0 cumulate\_replicas=1: default\_structname\_XXXX\_traj.out
-   cumulate\_jobs=1 cumulate\_replicas=0: default\_YYY\_traj.out
-   cumulate\_jobs=1 cumulate\_replicas=1: default\_traj.out

## MetricRecorder

Record numeric metrics to a tab-delimited text file. Only record metrics every n times using stride. Append ".gz" to filename to use compression.

Currently only torsion angles can be recorded, specified using the TorsionID. The residue can be indicated using absolute Rosetta number (integer) or with the PDB number and chain (integer followed by character).

```
<MetricRecorder stride=(100 &Size) filename=(metrics.txt &string) cumulate_jobs=(0 &bool) cumulate_replicas=(0 &bool) prepend_output_name=(0 &bool) >
  <Torsion rsd=(&string) type=(&string) torsion=(&Size) name=("" &string)/>
  ...
</MetricRecorder>
```

If used within [MetropolisHastings](#MetropolisHastings) , the current job output name is prepended to filename. If run with MPI, the cumulate\_jobs and cumulate\_replicas parameters affect the filename where the metrics are ultimately written. For instance, with the default filename parameter of `     metrics.txt    ` , input structure name of `     structname    ` , trajectory number of `     XXXX    ` , and replica number of `     YYY    ` , the following names will be generated given the options.

-   cumulate\_jobs=0 cumulate\_replicas=0: structname\_XXXX\_YYY\_metrics.txt
-   cumulate\_jobs=0 cumulate\_replicas=1: structname\_XXXX\_metrics.txt
-   cumulate\_jobs=1 cumulate\_replicas=0: YYY\_metrics.txt
-   cumulate\_jobs=1 cumulate\_replicas=1: metrics.txt

If not used within MetropolisHastings, by default the current job output name will not be prepended to the filename, similar to `     metrics.txt    ` above. If `     prepend_output_name=1    ` , then it will be prepended following the format, `     structname_XXXX_metrics.txt    ` .

## AddJobPairData

Add an arbitrary piece of data to the current Job, which will be output in the silent file, database, etc. This is useful for adding metadata to keep track of data generated using multiple experimental conditions.

The data appended to the Job consists of a key and a value. The key is a string, and the value can be either a real or string. The mover is used like this:

```
<AddJobPairData name=(&string) value_type=(&string) key=(&string) value=(&string, "real" or "string") value_from_ligand_chain=(%string)/>
```

The contents of "value\_type" must be either "string" or "real". "value" will be interpreted as either a string or real depending on the contents of "value\_type. If "value\_from\_ligand\_chain" and a ligand pdb chain is specified, the string or real value will be extracted from data cached in the ResidueType with the given key. Data can be added to a residuetype by appending lines to the ligand params file in the following format:

```
STRING_PROPERTY key value
NUMERIC_PROPERTY key 1.5
```

## WriteLigandMolFile

```
<WriteLigandMolFile name=(&string) chain=(&string) directory=(&string) prefix=(&string)/>
```

WriteLigandMolFile will output a V2000 mol file record containing all atoms of the specified ligand chain and all data stored in the current Job for each processed pose. The following options are required:

-   chain: The PDB chain ID of the ligand to be output
-   directory: The directory all mol records will be output to. Directory will be created if it does not exist.
-   prefix: the file prefix for the output files. If Rosetta is being run without MPI, the output path will be directory/prefix.sdf. If Rosetta has been compiled with MPI support, the output path will be directory/prefix\_nn.sdf where nn is the MPI rank ID that processed the pose. Each rosetta process or MPI controlled job should have a unique prefix or output to a separate directory to avoid file clobbering.

## RenderGridsToKinemage

```
<RenderGridsToKinemage name=(&string) file_name=(&string) grid_name=(&string) low_color=(&string) high_color = (&string) stride=(&int)/>
```

RenderGridsToKinemage will output a Kinemage file representing 1 or more scoring grids. If you want to output multiple scoring grids, run the mover multiple times, specifying a different grid name each time. This mover is intended for debugging purposes, and should only be run with a single pose. It is also very slow. Kinemage files can be viewed with King

-   file\_name: The filename to output the kinemage file to
-   grid\_name: the name of the grid in the scoring manager to output
-   low\_color: 3 comma sepeated floats describing the color of the minimum value of the grid. The floats should be 0.0-1.0 and represent red, green blue. For example, a value of "1.0,0.0,0.0" will be red.
-   high\_color: 3 comma sepeated floats describing the color of the minimum value of the grid. colors of grid points will be in a smooth gradient between low\_color and high\_color.
-   stride: The "stride" of the grid. If stride is 1, every grid point will be output. if stride is 5, every 5th grid point will be output.

## PyMolMover
PyMolMover will send a pose to an instance of the PyMol molecular visualization software running on the local host. Each call of the mover overwrites the object in PyMol. It is not a full featured as the version built in to PyRosetta but is extremely useful for visualizing the flow of a protocol or generating a frames for a movie of a protocol.

```
<PyMolMover name="&string" keep_history=(0 &bool) />
```
- keep\_history: each call to the mover stores the pose in a new state/frame of an object in PyMol rather than overwriting it. Frames can then be played back like a movie to visualize the flow of a protocol.

The following example would send the pose to PyMol before and after packing and store the structure in 2 states/frames of the same object.
```
  <MOVERS>
    <PyMolMover name=pmm keep_history=1/>
    <PackRotamersMover name="pack"/>
  </MOVERS>

  <PROTOCOLS>
    <Add mover_name=pmm/>
    <Add mover_name=pack/>
    <Add mover_name=pmm/>
  </PROTOCOLS>
```

**Prerequisites**

To allow PyMol to listen for new poses, you need to run the following script from within PyMol, where *$PATH_TO_ROSETTA* is replaced by the path to you Rosetta installation.
```
run $PATH_TO_ROSETTA/Rosetta/main/source/src/python/bindings/PyMOLPyRosettaServer.py
```

# Setup Movers

## SetupPoissonBoltzmannPotential

Initialize the runtime environment for Poisson-Boltzmann solver. It allows keeping track of protein mutations to minimize the number of PB evaluations.

Currently the feature is only supported by the **ddG** mover and filter.

**[ Prerequisites ]**

-   Build the customized version of [APBS](http://www.poissonboltzmann.org/apbs) and [iAPBS](http://mccammon.ucsd.edu/iapbs) , according to the instructions found in /path/to/rosetta/rosetta\_source/external/apbs/apbs-1.4-rosetta/README.

<!-- -->

       APBS:
        Baker NA, Sept D, Joseph S, Holst MJ, McCammon JA. Electrostatics of 
        nanosystems: application to microtubules and the ribosome. Proc. Natl. 
        Acad. Sci. USA 98, 10037-10041 2001. (Link)

       iAPBS:
        Robert Konecny, Nathan A. Baker and J. Andrew McCammon, 
        iAPBS: a programming interface to Adaptive Poisson-Boltzmann Solver 
        (APBS), Computational Science & Discovery, 2012, 5, 015005 (preprint).

        The iAPBS development is supported by grants from the National Center for 
        Research Resources (5P41RR008605-19) and the National Institute of General 
        Medical Sciences (8P41GM103426-19) from the National Institutes of Health. 

-   Build Rosetta with **extras=apbs** argument. This will cause linking your app against the APBS/iAPBS libraries.

-   Set the LD\_LIBRARY\_PATH environment variable to

<!-- -->

    export LD_LIBRARY_PATH=/path/to/rosetta/rosetta_source/external/apbs/apbs-1.4-rosetta/lib:${LD_LIBRARY_PATH}

-   In your rosetta script, call **SetupPoissonBoltzmannPotential** before any PB-enabled scorefxn (i.e. scorefxn with **pb\_elec** ) is evaluated.

**[ Usage ]**

    <SetupPoissonBoltzmannPotential name=pb_setup scorefxn=sc12_pb charged_chains=1 epsilon=2.0 sidechain_only=true revamp_near_chain=2 potential_cap=20.0 apbs_debug=2 calcenergy=false/>

-   name: Arbitary name used to refer to the mover
-   charged\_chains: Comma delimited list of charged chainnumbers (\>=1). e.g. charged\_chains=1,2,3 for chains 1, 2 and 3. No extra whitespace is permitted.
-   epsilon (optional): mutation tolerance in Angstrom. Potential is re-computed only when | Ca1 - Ca2 | \> epsilon, for all Ca1 in Alpha-carbon in previous pose and all Ca2 in the current pose. The default is 2.0 A.
-   sidechain\_only (optional): Set "true" to limit calculation of interactions to sidechain. Defaul to "false"
-   revamp\_near\_chain (optional): Comma delimited list of chain numbers. Scale down PB interactions if near the given chain(s). Default to none.
-   potential\_cap (optinal) : Upper limit for PB potential input. Default to 20.0.
-   apbs\_debug (optional): APBS debug level [0-6]. Default to 2.
-   calcenergy (optional): Set "true" to calculate energy. Not yet implemented. Default to false.

Warning: Pay attention to those movers or filters that prescore when their XML definitions appear & are parsed withint your script file. Use SavePoseMover to defer their prescoring timing. One filter that is known to-day is DeltaDdg filter. It evalutates the scorefxn when the definiton appears in the XML script. Here's how you have it defer and make PB works.

**[ Example ]**

    <SCOREFXNS>
        <sc12_pb weights=score12_full patch=pb_elec/>
    </SCOREFXNS>
    <MOVERS>
       <SetupPoissonBoltzmannPotential name=pb_setup charged_chains=1 scorefxn=sc12_pb />
       <SavePoseMover name=save_after_pb_setup reference_name=pose_after_setup/> 
    </MOVERS>
    <FILTERS>
       <Ddg name=ddg scorefxn=sc12_pb confidence=0 repeats=1/>
       <Delta name=delta_ddg filter=ddg  reference_name=pose_after_setup lower=0 upper=1 range=-0.5/> # defers scoring till the ref pose is saved
    </FILTERS>
    <PROTOCOLS>
       <Add mover_name=pb_setup/>  # init PB
       <Add mover_name=save_after_pb_setup/>  # save the reference pose
       ...
       <Add filter_name=delta_ddg/>
    </PROTOCOLS>

Protein mutation is monitored for both bounded or unbounded states, and a pose is cached for each state, across all scoring functions by default. If you need to cache different poses depending upon scorefxn, you need to customize the tags associated with cached poses using \<Set\> for scorefxns.

    <SCOREFXNS>
       <sc12_pb weights=score12_full patch=pb_elec>
          <Set pb_bound_tag=MyBound/>       # cache pose as "MyBound"
          <Set pb_unbound_tag=MyUnbound/>   # cache pose as "MyUnbound"
       </sc12_pb>
    </SCOREFXNS>

The default values are "bound" and "unbound", respectively.
