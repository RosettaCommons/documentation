#Movers (RosettaScripts)

[[Return To RosettaScripts|RosettaScripts]]

Each mover definition has the following structure

```
<"mover_name" name="&string" .../>
```

where "mover\_name" belongs to a predefined set of possible movers that the parser recognizes and are listed below, name is a unique identifier for this mover definition and then any number of parameters that the mover needs to be defined.

[[_TOC_]]

Mover Documentation Guide
-------------------------

Since RosettaScripts allows you to put Movers together in ways that have not been tried before there are a few things you **NEED** to answer when documenting your mover:

-   General description of what the mover does
    -   Example: This is meant as an example of how to construct a Mover in RosettaScripts and how to describe all of the options that it takes. This outline was decided upon at Post-RosettaCon11-Minicon.
-   XML code example:

```
<MyMover name="&string" bool_option=(1 &bool) int_option=(50 &int) string_option=(&string) real_option=(2.2 &Real) scorefxn=(default_scorefxn &string) task_operations=(&string,&string,&string)/>)
```

-   What the tags do:
    -   **bool\_option** describes how a boolean tag is made. Default is true.
    -   **int\_option** describes how an integer tag is made. Let's say this represents \# of cycles of a loop to run, so the range would have to be \> 0.
    -   **real\_option** describes how to a Real option tag is made.
    -   **string\_option** is an example of how a string tag is made.
-   What options must be provided?
    -   For example let's say that we need to pass a value to string\_option or the protocol will not not run, you would include something like this:
    -   string\_option="/path/to/some/file" needs to be defined to avoid mover exit.
-   Expected input type:
    -   Does this mover expect a certain kind of pose (protein/DNA, 2 chains, monomer)
-   Internal TaskOperations:
    -   Are there default TaskOperations (RestrictToInterface for example) that this mover uses, is there a way to override them?
-   FoldTree / Constraint changes:
    -   Describe if/how the mover modifies the input (or default) FoldTree or Constraints
-   If the mover can change the length of the pose say so.

Predefined Movers
-----------------

The following are defined internally in the parser, and the protocol can use them without defining them explicitly.

#### NullMover

Has an empty apply. Will be used as the default mover in \<PROTOCOLS\> if no mover\_name is specified. Can be explicitly specified, with the name "null".

Special Movers
--------------

### Combining Movers

#### ParsedProtocol (formerly DockDesign)

This is a special mover that allows making a single compound mover and filter vector (just like protocols). The optional option mode changes the order of operations within the protocol, as defined by the option. If undefined, mode defaults to the historical functionality, which is operation of the Mover/Filter pairs in the defined order.

```
<ParsedProtocol name=( &string) mode=( &string)>
    <Add mover_name=( null &string) filter_name=( true_filter &string) apply_probabilities=(see below &Real/>
    ...
</ParsedProtocol>
```

-   mode: "sequence" - (default) perform the Mover/Filter pair in the specified sequence; "random\_order" - perform EACH of the defined Mover/Filter pairs one time in a random order; "single\_random" - randomly pick a SINGLE Mover/Filter pair from the list.
-   apply\_probabilities: This only works in mode single\_random. You can set the probability that an individual submover will be called 0-1. The probabilities must sum to 1.0, or you'll get an error message. Notice that this is used by GenericMonteCarlo in its adaptive\_movers mode to adjust the probabilities of movers dynamically during a sampling trajectory.

#### MultiplePoseMover

This mover allows a multi-step "distribute and collect" protocol to be implemented in a single script, for example ab initio followed by RMSD clustering, or docking followed by design.

See the [[MultiplePoseMover|RosettaScripts-MultiplePoseMover]] page for details and examples.

#### MultipleOutputWrapper

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

#### Subroutine

Calling another RosettaScript from within a RosettaScript

```
<Subroutine name=(&string) xml_fname=(&string)/>
```

-   xml\_fname: the name of the RosettaScript to call.

This definition in effect generates a Mover that can then be incorporated into the RosettaScripts PROTOCOLS section. This allows a simplification and modularization of RosettaScripts.

Recursions are allowed but will cause havoc.

#### ContingentAcceptMover

Calculates the value of a filter before and after the move, and returns false if the difference in filter values is greater than delta.

```
<ContingentAccept name=( &string) mover=(&string) filter=(&string) delta=(&Real)/>
```

#### IfMover

Implements a simple IF (filter(pose)) THEN true\_mover(pose) ELSE false\_mover(pose). *true\_mover* is required, *false\_mover* is not.

```
<If name=( &string) filter_name=(&string) true_mover_name=(&string) false_mover_name=(null &string)/>
```

#### RandomMover

Randomly apply a mover from a list given probability weights. The **movers** tag takes a comma separated list of mover names. The **weights** tag takes a comma separate list of weights that sum to 1. The lengths of the movers and weights lists should must match.

```
<RandomMover name=( &string) movers=(&string) weights=(&string) repeats=(null &string)/>
```

### Looping/Monte Carlo Movers

#### LoopOver

Allows looping over a mover using either iterations or a filter as a stopping condition (the first turns true). By using ParsedProtocol mover (formerly named the DockDesign mover) above with loop can be useful, e.g., if making certain moves is expensive and then we want to exhaust other, shorter moves.

```
<LoopOver name=(&string) mover_name=(&string) filter_name=( false_filter &string) iterations=(10 &Integer) drift=(true &bool)/>
```

drift: true- the state of the pose at the end of the previous iteration will be the starting state for the next iteration. false- the state of the pose at the start of each iteration will be reset to the state when the mover is first called. Note that "falling off the end" of the iteration will revert to the original input pose, even if drift is set to true.

This mover is somewhat deprecated in favor of the more general GenericMonteCarlo mover.

#### GenericMonteCarlo

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

#### GenericSimulatedAnnealer

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

#### MonteCarloTest

Associated with GenericMonteCarlo. Simply test the MC criterion of the specified GenericMonteCarloMover and save the current pose if accept.

```
<MonteCarloTest name=(&string) MC_name=(&string)/>
```

-   MC\_name: name of a previously defined GenericMonteCarloMover

Useful in conjunction with MonteCarloRecover (below) if you're running a trajectory consisting of many different sorts of movers, and would like at each point to decide whether the pose has made an improvement.

#### MonteCarloRecover

Associated with GenericMonteCarlo and MonteCarloTest. Recover a pose from a GenericMonteCarloMover.

```
<MonteCarloRecover name=(&string) MC_name=(&string) recover_low=(1 &bool)/>
```

-   MC\_name: name of a previously defined GenericMonteCarloMover
-   recover\_low: recover the lowest-energy pose, or the last pose.

Useful in conjunction with MonteCarloRecover (below) if you're running a trajectory consisting of many different sorts of movers, and would like at each point to decide whether the pose has made an improvement.

#### MonteCarloUtil

(This is a devel Mover and not available in released versions.)

This mover takes as input the name of a montecarlo object specified by the user, and calls the reset or recover\_low function on it.

```
<MonteCarloUtil name=(&string) mode=(&string) montecarlo=(&string)/>
```

-   mode: Mode of the monte carlo mover. can be either "reset" or "recover\_low"
-   montecarlo: the monte carlo object to act on

#### MetropolisHastings

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

#### IteratedConvergence

Repeatedly applies a sub-mover until the given filter returns a value within the given delta for the given number of cycles

```
<IteratedConvergence name=(&string) mover=(&string) filter=(&string) delta=(0.1 &real) cycles=(1 &integer) maxcycles=(1000 &integer) />
```

-   mover - the mover to repeatedly apply
-   filter - the filter to use when assaying for convergence (should return a reasonable value from report\_sm())
-   delta - how close do the filter values have to be to count as converged
-   cycles - for how many mover applications does the filter value have to fall within `      delta     ` of the reference value before counting as converged. If the filter is outside of the range, the reference value is reset to the new filter value.
-   maxcycles - exit regardless if filter doesn't converge within this many applications of the mover - intended mainly as a safety check to prevent infinite recursion.

#### RampMover

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

### Reporting/Saving

#### SavePoseMover

This mover allows one to save a pose at any time point through out a trajectory or from disk, and recall it any time point again to replace a current pose. Can also just be used with filter, eg. delta filters.

```
<SavePoseMover name=native restore_pose=(1, &bool) reference_name=(&string) pdb_file=(&string) />
```

-   restore\_pose - if you want to replace it
-   reference\_name - is what the pose gets saved under. so to recall that one specific pose, just re-call it under the name given when first called.
-   pdb\_file - Optional. If present, will load the given PDB file into the referenced pose at parse time.

#### ReportToDB

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

#### ResetBaseline
Use this mover to call the reset_baseline method in filters Operator and CompoundStatement. Monte Carlo mover takes care of
resetting independently, so no need to reset if you use MC.

```
<ResetBaseline name=(&string) filter=(&filter)/>
```
- filter: the name of the Operator or CompoundStatement filter.

#### TrajectoryReportToDB

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

#### DumpPdb

Dumps a pdb. Recommended ONLY for debuggging as you can't change the name of the file during a run, although if tag\_time is true a timestamp with second resolution will be added to the filename, allowing for a limited amount of multi-dumping. If scorefxn is specified, a scored pdb will be dumped.

    <DumpPdb name=(&string) fname=(dump.pdb &string) scorefxn=(&string) tag_time=(&bool 0)/>

#### PDBTrajectoryRecorder

Record a trajectory to a multimodel PDB file. Only record models every n times using stride. Append ".gz" to filename to use compression.

```
<PDBTrajectoryRecorder stride=(100 &Size) filename=(traj.pdb &string) cumulate_jobs=(0 &bool) cumulate_replicas=(0 &bool)/>
```

If run with MPI, the cumulate\_jobs and cumulate\_replicas parameters affect the filename where the trajectory is ultimately written. For instance, with the default filename parameter of `     traj.pdb    ` , input structure name of `     structname    ` , trajectory number of `     XXXX    ` , and replica number of `     YYY    ` , the following names will be generated given the options.

-   cumulate\_jobs=0 cumulate\_replicas=0: structname\_XXXX\_YYY\_traj.pdb
-   cumulate\_jobs=0 cumulate\_replicas=1: structname\_XXXX\_traj.pdb
-   cumulate\_jobs=1 cumulate\_replicas=0: YYY\_traj.pdb
-   cumulate\_jobs=1 cumulate\_replicas=1: traj.pdb

#### SilentTrajectoryRecorder

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

#### MetricRecorder

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

#### AddJobPairData

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

#### WriteLigandMolFile

```
<WriteLigandMolFile name=(&string) chain=(&string) directory=(&string) prefix=(&string)/>
```

WriteLigandMolFile will output a V2000 mol file record containing all atoms of the specified ligand chain and all data stored in the current Job for each processed pose. The following options are required:

-   chain: The PDB chain ID of the ligand to be output
-   directory: The directory all mol records will be output to. Directory will be created if it does not exist.
-   prefix: the file prefix for the output files. If Rosetta is being run without MPI, the output path will be directory/prefix.sdf. If Rosetta has been compiled with MPI support, the output path will be directory/prefix\_nn.sdf where nn is the MPI rank ID that processed the pose. Each rosetta process or MPI controlled job should have a unique prefix or output to a separate directory to avoid file clobbering.

#### RenderGridsToKinemage

```
<RenderGridsToKinemage name=(&string) file_name=(&string) grid_name=(&string) low_color=(&string) high_color = (&string) stride=(&int)/>
```

RenderGridsToKinemage will output a Kinemage file representing 1 or more scoring grids. If you want to output multiple scoring grids, run the mover multiple times, specifying a different grid name each time. This mover is intended for debugging purposes, and should only be run with a single pose. It is also very slow. Kinemage files can be viewed with King

-   file\_name: The filename to output the kinemage file to
-   grid\_name: the name of the grid in the scoring manager to output
-   low\_color: 3 comma sepeated floats describing the color of the minimum value of the grid. The floats should be 0.0-1.0 and represent red, green blue. For example, a value of "1.0,0.0,0.0" will be red.
-   high\_color: 3 comma sepeated floats describing the color of the minimum value of the grid. colors of grid points will be in a smooth gradient between low\_color and high\_color.
-   stride: The "stride" of the grid. If stride is 1, every grid point will be output. if stride is 5, every 5th grid point will be output.

#### PyMolMover
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

### Setup Movers

#### SetupPoissonBoltzmannPotential

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

General Movers
--------------

These movers are general and should work in most cases. They are usually not aware of things like interfaces, so may be most appropriate for monomers or basic tasks.

### Packing/Minimization

#### ForceDisulfides

Set a list of cystein pairs to form disulfides and repack their surroundings. Useful for cases where the disulfides aren't recognized by Rosetta. The disulfide fixing uses Rosetta's standard, Conformation.fix\_disulfides( .. ), which only sets the residue type to disulfide. The repacking step is necessary to realize the disulfide bond geometry.

```
<ForceDisulfides name="&string" scorefxn=(score12 &string) disulfides=(&list of residue pairs)/>
```

-   scorefxn: scorefunction to use for repacking. Repacking takes place in 6A shells around each affected cystein.
-   disulfides: For instance: 23A:88A,22B:91B. Can also take regular Rosetta numbering as in: 24:88,23:91.

#### PackRotamersMover

Repacks sidechains with user-supplied options, including TaskOperations

```
<PackRotamersMover name="&string" scorefxn=(score12 &string) task_operations=(&string,&string,&string)/>
```

-   scorefxn: scorefunction to use for repacking (NOTE: the error "Scorefunction not set up for nonideal/Cartesian scoring" can be fixed by adding 'Reweight scoretype="pro_close" weight="0.0"' under the talaris2013_cart scorefxn in the SCOREFXNS section)
-   taskoperations: comma-separated list of task operations. These must have been previously defined in the TaskOperations section.

#### PackRotamersMoverPartGreedy

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

#### MinMover

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

#### CutOutDomain

Cuts a pose based on a template pdb. The two structures have to be aligned. The user supplies a start res num and an end res num of the domain on the **template pose** and the mover cuts the corresponding domain from the input PDB.

```
<CutOutDomain name="&string" start_res=(&int) end_res=(&int) suffix="&string" source_pdb="&string"/>
```

-   start\_res/end\_res: begin and end residues on the template pdb (e.g -s template.pdb)
-   suffix: suffix of outputted structure
-   source\_pdb: name of pdb to be cut

#### TaskAwareMinMover

Performs minimization. Accepts TaskOperations via the task\_operations option e.g.

    task_operations=(&string,&string,&string)

to configure which positions are minimized. Options

    chi=(&bool) and bb=(&bool) jump=(0 &bool) scorefxn=(score12 &string)

control jump, sidechain or backbone freedom. Defaults to sidechain minimization. Options type, and tolerance are passed to the underlying MinMover.

To allow backbone minimization, the residue has to be designable. If the residue is only packable only the side chain will be minimized.

#### MinPackMover

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

#### Sidechain

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

#### SidechainMC

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

#### RotamerTrialsMover

This mover goes through each repackable/redesignable position in the pose, taking every permitted rotamer in turn, and evaluating the energy. Each position is then updated to the lowest energy rotamer. It does not consider coordinated changes at multiple residues, and may need several invocations to reach convergence.

In addition to the score function, the mover takes a list of task operations to specify which residues to consider. (See [[TaskOperations (RosettaScripts)|TaskOperations-RosettaScripts]] .)

```
<RotamerTrialsMover name="&string" scorefxn=(&string) task_operations=(&string,&string,&string) show_packer_task=(0 &bool) />
```

#### RotamerTrialsMinMover

This mover goes through each repackable/redesignable position in the pose, taking every permitted rotamer in turn, minimizing it in the context of the current pose, and evaluating the energy. Each position is then updated to the lowest energy minimized rotamer. It does not consider coordinated changes at multiple residues, and may need several invocations to reach convergence.

In addition to the score function, the mover takes a list of task operations to specify which residues to consider. (See [[TaskOperations (RosettaScripts)|TaskOperations-RosettaScripts]] .)

```
<RotamerTrialsMinMover name="&string" scorefxn=(&string) task_operations=(&string,&string,&string) nonideal=(&bool)/>
```

#### ConsensusDesignMover

This mover will mutate residues to the most-frequently occuring residues in a multiple sequence alignment, while making sure that the new residue scores well in rosetta. It takes a position specific scoring matrix (pssm) as input to determine the most frequently occuring residues at each position. The user defines a packer task of the residues which will be designed. At each of these positions only residues which appear as often or more often (same pssm score or higher) will be allowed in subsequent design. Design is then carried out with the desired score function, optionally adding a residues identity constraint proportional to the pssm score (more frequent residues get a better energy).

```
<ConsensusDesignMover name="&string" scorefxn=(&string) invert_task=(&bool) sasa_cutoff=(&float) use_seqprof_constraints=(&bool) task_operations=(&string)/>
```

-   scorefxn: Set the desired score function (defined in a the \<SCOREFXNS\> block)
-   taskoperations: Hand in a task operation defining the residues you want to design (or their inverse). Without a task\_operation and with invert\_task=0 everything will be designed.
-   use\_seqprof\_constraints: Only residues which appear more often in the pssm than the wild-type residue at position i are allowed in the packer task as position i. If use\_seqprof\_constraints = 0 all of those are allowed with equal probability -- that is, no extra constraint energy is added. If use\_seqprof\_constraints = 1 the more frequent residues are added to the packer task at residue i and each is granted a sequence constraint roughly proportional to the pssm score. In effect the more-frequent residues are included in proportion to their frequency of occurence in the pssm.
-   sasa\_cutoff: Buried residues (with sasa \< sasa\_cutoff) will not be designed. Surface residues (with sasa \> sasa\_cutoff) will be designed. To carry out consensus design on all residues in the task simply don't enter a sasa\_cutoff or set it to 0.
-   invert\_task: A common usage case is to take an interface/ligand packer task and then do consensus design for everything outside of that design (which is presumably optimized by rosetta for binding). That use requires a task that is the opposite of the original task. This flag turns on that inverted task.

### Idealize/Relax

#### Idealize

Some protocols (LoopHashing) require the pose to have ideal bond lengths and angles. Idealize forces these values and then minimizes the pose in a stripped-down energy function (rama, disulf, and proline closure) and in the presence of coordinate constraints. Typically causes movements of 0.1A from original pose, but the scores deteriorate. It is therefore recommended to follow idealization with some refinement.

```
<Idealize name=(&string) atom_pair_constraint_weight=(0.0&Real) coordinate_constraint_weight=(0.01&Real) fast=(0 &bool) report_CA_rmsd=(1 &bool) ignore_residues_in_csts=(&comma delimited residue list) impose_constraints=(1&bool) constraints_only=(0&bool)/>
```

-   ignore\_residues\_in\_csts: set certain residues to not have coordinate constraints applied to them during idealization, meaning that they're free to move in order to form completely ideal bonds. Useful when, e.g., changing loop length and quickly making a chemically sensible chain.
-   impose\_constraints: impose the coordinate and pair constraints on the current pose?
-   constraints\_only: jump out of idealize after imposing the constraints without doing the actual idealization run?

impose\_constraints & constraints\_only can be used intermittently to break the idealize process into two stages: first impose the constraints on a 'realistic' pose without idealizing (constraints\_only=1), then mangle the pose and apply idealize again (impose\_constraints=0).

#### FastRelax

Performs the fast relax protocol.

    <FastRelax name="&string" scorefxn=(score12 &string) repeats=(8 &int) task_operations=(&string, &string, &string)
      batch=(false &bool) ramp_down_constraints=(false &bool) 
      cartesian=(false &bool) bondangle=(false &bool) bondlength=(false &bool)
      min_type=(dfpmin_armijo_nonmonotone &string) >
       <MoveMap name=(""&string)>
          <Chain number=(&integer) chi=(&bool) bb=(&bool)/>
          <Jump number=(&integer) setting=(&bool)/>
          <Span begin=(&integer) end=(&integer) chi=(&bool) bb=(&bool)/>
       </MoveMap>
    </FastRelax>

Options include:

-   scorefxn (default "score12")
-   repeats (default 8)
-   sc\_cst\_maxdist &integer. Sets up sidechain-sidechain constraints between atoms up to maxdist, at neighboring sidechains. Need to also call ramp\_constraints = false, otherwise these will be turned off in the later rounds of relax.
-   task\_operations FastRelax will now respect any TaskOps passed to it. However, the default behavior is now to add RestrictToRepacking operation unless <code>disable_design=false</code> is set.
-   disable_design (default true) Disable design if TaskOps are passed?  Needs to be false if purposefully designing.
-   MoveMap name: this is optional and would actually not work with all movers. The name allows the user to specify a movemap that can later be called by another mover without specifying all of the options. Movers that do not support this functionality will exit with an error message.
-   jumps, bb torsions and chi angles are set to true (1) by default

The MoveMap is initially set to minimize all degrees of freedom. The movemap lines are read in the order in which they are written in the xml file, and can be used to turn on or off dofs. The movemap is parsed only at apply time, so that the foldtree and the kinematic structure of the pose at the time of activation will be respected.

#### FastDesign

Performs a FastRelax with design enabled. By default, each repeat of FastDesign involves four repack/minimize cycles in which the repulsive energy term is initially very low and is increased during each cycle. Optionally, constraint weights can also be decreased during each cycle. This enables improved packing and scoring. This mover can use all FastRelax options, and in addition contains design-centric features.

    <FastDesign name="&string" scorefxn=(talaris2013 &string) clear_designable_residues=(false &bool) ramp_design_constraints=(false &bool) />

In addition to all options supported by FastRelax, FastDesign supports:

-   clear\_designable\_residues (default false): If set, all residues set to designable by the task operations will be mutated to alanine prior to design.
-   ramp\_design\_constraints (default false): If set, constraints will be ramped during the FastDesign process according to the relax script. By default, each repeat of FastDesign will use constraint weight multipliers of [ 1.0, 0.5, 0.0, 0.0 ] for the four design/minimize cycles. The constraints ramped are coordinate\_constraint, atom\_pair\_constraint, angle\_constraint and dihedral\_constraint.

### Docking/Assembly

#### DockingProtocol

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

#### FlexPepDock

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

### Backbone Design

#### ConnectJumps

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

### Backbone Movement

#### SetTorsion

Sets a given torsion to a specified value.

```
<SetTorsion name="&string" resnum=(pdb/rosetta numbering) torsion_name=(&string) angle=(&real)/>
```

-   resnum: which residue? either rosetta numbering or pdb (25A)
-   torsion\_name: phi/psi.

#### Shear

Shear style backbone-torsion moves that minimize downstream propagation.

```
<Shear name="&string" temperature=(0.5 &Real) nmoves=(1 &Integer) angle_max=(6.0 &Real) preserve_detailed_balance=(0 &bool)/>
```

-   temperature: what MC acceptance temperature to use (tests only the rama score, so not a full MC).
-   nmoves: how many consecutive moves to make.
-   angle\_max: by how much to perturb the backbone.
-   preserve\_detailed\_balance: If set to true, does not test the MC acceptance criterion, and instead always accepts.

See Rohl CA, et al. (2004) Methods Enzymol. Protein structure prediction using Rosetta, 383:66

#### Small

Small-move style backbone-torsion moves that, unlike shear, do not minimize downstream propagation.

```
<Small name="&string" temperature=(0.5 &Real) nmoves=(1 &Integer) angle_max=(6.0 &Real) preserve_detailed_balance=(0 &bool)/>
```

-   temperature: what MC acceptance temperature to use (tests only the rama score, so not a full MC).
-   nmoves: how many consecutive moves to make.
-   angle\_max: by how much to perturb the backbone.
-   preserve\_detailed\_balance: If set to true, does not test the MC acceptance criterion, and instead always accepts.

See Rohl CA, et al. (2004) Methods Enzymol. Protein structure prediction using Rosetta, 383:66

#### Backrub

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

### Constraints

#### ClearConstraintsMover

Remove any constraints from the pose.

    <ClearConstraintsMover name=(&string) />

#### ConstraintSetMover

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

#### ResidueTypeConstraintMover

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



#### TaskAwareCsts

Add coordinate constraints to all residues that are considered designable by the task\_operations. Mean and SD are hardwired to 0,1 at present. If you want to use this, don't forget to make downstream movers aware of coordinate constraints by changing their scorefxn's coordinate\_constraint weight.

```
<TaskAwareCsts name=(&string) anchor_resnum=("" &string) task_operations=(&comma-delimited list of task operations)/>
```
-  anchor_resnum: which residue to use as anchor for the coordinate constraints? Since Rosetta conformation sampling is done in torsion space coordinate constraints are relative to a position. If this option is not set the anchor is set to the first designable residue defined in the task_operations. Use general pose numbering here: 3 means 3rd residue in the pose, whereas 3B means residue 3 in chain b. The residue number is parsed at apply time.
-  task_operations: residues defined as designable have coordinate restraints placed on their CAs.


#### AddConstraintsToCurrentConformationMover

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

#### AtomCoordinateCstMover

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

#### FavorSymmetricSequence

Add ResidueTypeLinkingConstraints to the pose such that a symmetric sequence (CATCATCAT) will be favored during design. You should add this mover before sequence design is performed.

    <FavorSymmetricSequence penalty=(&real) name=symmetry_constraints symmetric_units=(&size)/> 

-   penalty should be a positive Real number and represents the penalty applied to a pair of asymmetric residues.
-   symmetric\_units should be a positive Integer representing the number of symmetric units in the sequence. It should be a value of 2 or greater

The total constraint score is listed as 'res\_type\_linking\_constraint'

### Fragment Insertion

#### SingleFragmentMover

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

### Symmetry

The following set of movers are aimed at creating and manipulating symmetric poses within RosettaScripts. For the complete symmetry documentation, see the "Symmetry User's Guide" in Rosetta's Doxygen documentation.

Notice that symmetric poses must be scored with symmetric score functions. See the 'symmetric' tag in the RosettaScripts score function documentation.

#### SetupForSymmetry

Given a symmetry definition file that describes configuration and scoring of a symmetric system, this mover "symmetrizes" an asymmetric pose. For example, given the symmetry definition file 'C2.symm':

```
<SetupForSymmetry name=setup_symm definition=C2.symm/>
```

#### DetectSymmetry

This mover takes a non-symmetric pose composed of symmetric chains and transforms it into a symmetric system. It only works with cyclic symmetries from C2 to C99.

```
<DetectSymmetry name=detect subunit_tolerance(&real 0.01) plane_tolerance=(&real 0.001)/>
```

subunit\_tolerance: maximum tolerated CA-rmsd between the chains. plane\_tolerance: maximum accepted displacement(angstroms) of the center of mass of the whole pose from the xy-plane.

#### SymDofMover

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

#### ExtractAsymmetricUnit

The inverse of SetupForSymmetry: given a symmetric pose, make a nonsymmetric pose that contains only the asymmetric unit.

```
<ExtractAsymmetricUnit name=extract_asu/>
```

<!--- BEGIN_INTERNAL -->
#### ExtractSubpose

(This is a devel Mover and not available in released versions.)

Used to extract a subset of the subunits from a symmetric pose based on contacts with a user specified component (via sym\_dof\_name(s)). This subpose is dumped as a pdb with the user specified prefix, suffix, and basename derived from the job distributer. DOES NOT MODIFY THE POSE. For each sym\_dof\_name passed by the user, all neighboring subunits (as assessed by CA or CB contacts with the user specified contact\_distance (10.0 A by default)). If extras=true, then all the full building block for each sym\_dof will be extracted along with all touching building blocks.

    <ExtractSubpose name=(&string) sym_dof_names=(&string) prefix=("" &string) suffix=("" &string) contact_dist=(10.0 &Real) extras=(0 &bool) />

-   sym\_dof\_names - Name(s) of the sym\_dofs corresponding to the primary component(s) to extract along with the neighboring subunits/building blocks. Passed as a string (optionally: with a comma-separated list).
-   prefix - Optional prefix for the output pdb name.
-   suffix - Optional suffix for the output pdb name.
-   contact\_dist - Maximum CA or CB distance from any residue in the primary component(s) to any residue in another component for it to be considered a "neighbor" and added to the extracted subpose.
-   extras - Boolean option to set whether or not full building blocks are extracted rather than just subunits.

<!--- END_INTERNAL --> 

#### ExtractAsymmetricPose

Similar to ExtractAsymmetricUnit: given a symmetric pose, make a nonsymmetric pose that contains the entire system (all monomers). Can be used to run symmetric and asymmetric moves in the same trajectory.

```
<ExtractAsymmetricPose name=extract_asp/>
```

#### SymPackRotamersMover and SymRotamerTrialsMover

The symmetric versions of pack rotamers and rotamer trials movers (they take the same tags as asymmetric versions)

```
<SymPackRotamersMover name=symm_pack_rot scorefxn=score12_symm task_operations=.../>
<SymRotamerTrialsMover name=symm_rot_trials scorefxn=score12_symm task_operations=.../>
```

#### SymMinMover

The symmetric version of min mover (they take the same tags as asymmetric version). Notice that to refine symmetric degrees of freedom, all jumps must be allowed to move with the tag 'jump=ALL'.

```
<SymMinMover name=min1 scorefxn=ramp_rep1 bb=1 chi=1 jump=ALL/>
```

#### Example: Symmetric FastRelax

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

#### TaskAwareSymMinMover

(This is a devel Mover and not available in released versions.)

A task-aware version of the SymMinMover that allows minimization of only certain sets of residues specified by user-defined task operations.

    <TaskAwareSymMinMover name=(&string) scorefxn=(&scorefxn) bb=(0 &bool) chi=(1 &bool) rb=(0 &bool) task_operations=(comma-delimited list of task operations) />

-   bb - Whether to allow backbone minimization.
-   chi - Whether to allow side chain minimization.
-   rb - Whether to allow rigid body minimization.

<!--- END_INTERNAL --> 

#### Issues with Symmetry and Rosetta Scripts

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
### Kinematic Closure Movers

#### Generalized Kinematic Closure (GeneralizedKIC)

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

### Other Pose Manipulation

#### AlignChain

Align a chain in the working pose to a chain in a pose on disk (CA superposition).

```
<AlignChain name=(&string) source_chain=(0&Int) target_chain=(0&Int) target_name=(&string)/>
```

-   source\_chain: the chain number in the working pose. 0 means the entire pose.
-   target\_chain: the chain number in the target pose. 0 means the entire pose.
-   target\_name: file name of the target pose on disk. The pose will be read just once at the start of the run and saved in memory to save I/O.

target and source chains must have the same length of residues.

#### BluePrintBDR

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

#### ModifyVariantType

Add or remove variant types on specified residues.

```
<ModifyVariantType name=[name] add_type=[type[,type]...] remove_type=[type[,type...]] task_operations=(&string,&string,&string)/>
```

Adds (if missing) or removes (if currently added) variant types to the residues specified in the given task operations. Use [[OperateOnCertainResidues|TaskOperations-RosettaScripts#Per-Residue-Specification]] operations to select specific residues.

#### MotifGraft

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

#### LoopCreationMover

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

#### SegmentHybridize

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

#### Dssp

Calculate secondary structures based on dssp algorithm, and load the information onto Pose.

```
<Dssp name=(&string) reduced_IG_as_L=(0 &int)/>
```

-   reduced\_IG\_as\_L: if set to be 1, will convert IG from Dssp definition as L rather than H

#### AddChain

Reads a PDB file from disk and concatenates it to the existing pose.

```
<AddChain name=(&string) file_name=(&string) new_chain=(1&bool) scorefxn=(score12 &string) random_access=(0&bool) swap_chain_number=(0 &Size)>/>
```

-   file\_name: the name of the PDB file on disk.
-   new\_chain: should the pose be concatenated as a new chain or just at the end of the existing pose?
-   scorefxn: used for scoring the pose at the end of the concatenation. Also calls to detect\_disulfides are made in the code.
-   random\_access: If true, you can write a list of file names in the file\_name field. At parse time one of these file names will be picked at random and throughout the trajectory this file name will be used. This saves command line variants.
-   swap\_chain\_number: If specified, AddChain will delete the chain with number 'swap\_chain\_number' and add the new chain instead.

#### AddChainBreak

Adds a chainbreak at the specified position

```
<AddChainBreak name=(&string) resnum=(&string) change_foldtree=(1 &bool) find_automatically=(0 &bool) distance_cutoff=(2.5&Real) remove=(0 &bool)/>
```

-   change\_foldtree: add a jump at the cut site.
-   find\_automatically: find cutpoints automatically according to the distance between subsequent C and N atoms.
-   distance\_cutoff: the distance cutoff between subsequent C and N atoms at which to decide that a cutpoint exists.
-   remove: if true remove the chainbreak from the specified position rather than add it.

#### FoldTreeFromLoops

Wrapper for utility function fold\_tree\_from\_loops. Defines a fold tree based on loop definitions with the fold tree going up to the loop n-term, and the c-term and jumping between. Cutpoints define the kinematics within the loop

```
<FoldTreeFromLoops name=(&string) loops=(&string)/>
```

the format for loops is: Start:End:Cut,Start:End:Cut...

and either pdb or rosetta numbering are allowed. The start, end and cut points are computed at apply time so would respect loop length changes.


#### Superimpose

Superimpose current pose on a pose from disk. Useful for returning to a common coordinate system after, e.g., torsion moves.

```
<Superimpose name=(&string) ref_start=(1 &Integer) ref_end=(0 &Integer) target_start=(1 &Integer) target_end=(0 &Integer) ref_pose=(see below &string) CA_only=(1 &integer)/> 
```
-   CA\_only, Superimpose CA only or BB atoms (N,C,CA,O).  Defaults True.
-   ref\_start, target\_start: start of segment to align. Accepts only rosetta numbering.
-   ref\_end, target\_end: end of segment to align. If 0, defaults to number of residues in the pose.
-   ref\_pose: the file name of the reference structure to align to. Defaults to the commandline option -in:file:native, if no pose is specified.

#### SetSecStructEnergies

Give a bonus to the secondary structures specified by a blueprint header. For example "1-4.A.99" in a blueprint would specify an antiparallel relationship between strand 1 and strand 4; when this is present a bonus (negative) score is applied to the pose.

```
<SetSecStructEnergies name=(&string) scorefxn=(&string) blueprint="file.blueprint" natbias_ss=(&float)/> 
```

-   blueprint = a blueprint file with a header line for the desired pairing. Strand pairs are indicated by number (1-4 is strand 1 / strand 4) followed by a ".", followed by A of P (Antiparallel/Parallel), followed by a ".", followed by the desired register shift where "99" indicates any register shift.
-   e.g. "1-6.A.99;2-5.A.99;" Indicates an antiparallel pair between strand 1 and strand 6 with any register; and an antiparallel pair between strand 2 and strand 5 with any register
-   In the order of secondary structure specification, pairs start from the lowest strand number. So a strand 1 / strand 2 pair would be 1-2.A, not 2-1.A, etc.
-   natbias\_ss = score bonus for a correct pair.

#### SwitchChainOrder

Reorder the chains in the pose, for instance switching between chain B and A. Can also be used to cut out a chain from the PDB (simply state which chains should remain after cutting out the undesired chain).

```
<SwitchChainOrder name=(&string) chain_order=(&string)/>
```

-   chain\_order: a string of chain numbers. This is the order of chains in the new pose. For instance, "21" will form a pose ordered B then A, "12" will change nothing.

#### LoadPDB

Replaces current PDB with one from disk. This is probably only useful in checkpointing, since this mover deletes all information gained so far in the trajectory.

```
<LoadPDB name=(&string) filename=(&string)/>
```

-   filename: what filename to load?

#### LoopLengthChange

Changes a loop length without closing it.

```
<LoopLengthChange name=(&string) loop_start=(&resnum) loop_end=(&resnum) delta=(&int)/>
```

-   loop\_start, loop\_end: where the loop starts and ends.
-   delta: by how much to change. Negative values mean cutting the loop.

#### MakePolyX

Convert pose into poly XXX ( XXX can be any amino acid )

    <MakePolyX name="&string" aa="&string" keep_pro=(0 &bool)  keep_gly=(1 &bool) keep_disulfide_cys=(0 &bool) />

Options include:

-   aa ( default "ALA" ) using amino acid type for converting
-   keep\_pro ( default 0 ) Pro is not converted to XXX
-   keep\_gly ( default 1 ) Gly is not converted to XXX
-   keep\_disulfide\_cys ( default 0 ) disulfide CYS is not converted to XXX

#### MembraneTopology

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

#### Splice

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



#### SwitchResidueTypeSetMover

Switches the residue sets (e.g., allatom-\>centroid, or vice versa).

```
<SwitchResidueTypeSetMover name="&string" set=(&string)/>
```

-   set: which set to use (options: centroid, fa\_standard...)

Typically, RosettaScripts assumes that poses are all-atom. In some cases, a centroid pose is needed, e.g., for centroid scoring, and this mover is used in those cases.

#### FavorNativeResidue

```
<FavorNativeResidue bonus=(1.5 &bool)/>
```

Adds residue\_type\_constraints to the pose with the given bonus. The name is a slight misnomer -- the "native" residue which is favored is actually the identity of the residue of the current pose at apply time (-in:file:native is not used by this mover).

For more flexible usage see FavorSequenceProfile (with "scaling=prob matrix=IDENTITY", this will show the same native-bonus behavior).

#### FavorSequenceProfile

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

#### SetTemperatureFactor

Set the temperature (b-)factor column in the PDB based on a filter's per-residue information. Useful for coloring a protein based on some energy. The filter should be ResId-enabled (reports per-residue values) or else an error occurs.

```
<SetTemperatureFactor name="&string" filter=(&string) scaling=(1.0&Real)/>
```

-   filter: A ResId-compatible filter name
-   scaling: Values reported by the filter will be multiplied by this factor.

#### PSSM2Bfactor

Set the temperature (b-)factor column in the PDB based on filter's per-residue PSSM score. Sets by default PSSM scores less than -1 to 50, and larger than 5 to 0 in the B-factor column. Between -1 and 5 there is a linear gradient.

```
<PSSM2Bfactor name="&string" Value_for_blue=(&Real) Value_for_red=(&Real)/>
```

-   Value\_for\_blue: All PSSM scoring with value and lower will be converted to 0 in the Bfactor column. default 5.
-   Value\_for\_red: All PSSM scoring with value and higher will be converted to 50 in the Bfactor column. Default 0.

#### RigidBodyTransMover

Translate chains.

     <RigidBodyTransMover name=(&string) jump=(1 &int) distance=(1.0 &Real) x=(0.0 &Real) y=(0.0 &Real) z=(0.0 &Real) />

-   jump: The chain downstream of the specified jump will be translated.
-   distance: The distance to translate along the axis
-   x,y,z: Specify the axis along which to translate. The vector will be normalized to unit length before use. All zeros (the default) results in automatic apply-time setting of the direction on the axis between the approximate centers of the two components being separated.

#### RollMover

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

#### RemodelMover (including building disulfides)

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
-   `      match_rt_limit     ` : RMSD limit between two residue backbones and a disulfide in the database, used to determine if a disulfide can be built between those residues. 1.0 is strict, 2.0 is loose, 6.0 is very loose, \>6 makes no difference.
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

#### SetupNCS

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
#### StoreTask

(This is a devel Mover and not available in released versions.)

Creates a packer task by applying the user-specified task operations to the current pose and saves the packer task in the pose's cacheable data, allowing the task to be accessed, unchanged, at a later point in the RosettaScripts protocol. Must be used in conjunction with the RetrieveStoredTask task operation.

    <StoreTaskMover name=(&string) task_name=(&string) task_operations=(comma-delimited list of task operations) overwrite=(0 &bool) />

-   task\_name - The index where the task will be stored in the pose's cacheable data. Must be identical to the task\_name used to retrieve the task using the RetrieveStoredTask task operation.
-   task\_operations - A comma-delimited list of task operations used to create the packer task.
-   overwrite - If set to true, will overwrite an existing task with the same task\_name if one exists.

#### StoreCompoundTaskMover

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

#### VirtualRoot

Reroot the pose foldtree on a (new) virtual residue. Useful for minimization in the context of absolute frames (coordinate constraints, electron density information, etc.)

```
<VirtualRoot name=(&string) removable=(&bool false) remove=(&bool false) />
```

By default, the mover will add a virtual root residue to the pose if one does not already exist. If you wish to later remove the virtual root, add the root with a mover with removable set to true, and then later use a separate VirtualRoot mover with remove set to true to remove it.

Currently VirtualRoot with remove true is very conservative in removing virtual root residues, and won't remove the residue if it's no longer the root residue, if pose length changes mean that the root residue falls at a different numeric position, or if the virtual root residue wasn't added by a VirtualRoot mover with "removable" set. Don't depend on the behavior of no-op removals, though, as the mover may become more permissive in the future.

Protein Interface Design Movers
-------------------------------

These movers are at least somewhat specific to the design of protein-protein interfaces. Attempting to use them with, for example, protein-DNA complexes may result in unexpected behavior.

#### PatchdockTransform

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

#### ProteinInterfaceMS

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

#### InterfaceAnalyzerMover

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

#### Docking

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

#### Docking with Hotspot

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

#### Prepack

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

#### RepackMinimize

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

#### DesignMinimizeHBonds

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

#### build\_Ala\_pose

Turns either or both sides of an interface to Alanines (except for prolines and glycines that are left as in input) in a sphere of 'interface\_distance\_cutoff' around the interface. Useful as a step before design steps that try to optimize a particular part of the interface. The alanines are less likely to 'get in the way' of really good rotamers.

```
<build_Ala_pose name=(ala_pose &string) partner1=(0 &bool) partner2=(1 &bool) interface_cutoff_distance=(8.0 &float) task_operations=("" &string)/>
```

-   task\_operations: see [RepackMinimize](#RepackMinimize)

#### SaveAndRetrieveSidechains

To be used after an ala pose was built (and the design moves are done) to retrieve the sidechains from the input pose that were set to Ala by build\_Ala\_pose. OR, to be used inside mini to recover sidechains after switching residue typesets. By default, sidechains that are different than Ala will not be changed, **unless** allsc is true. Please note that naming your mover "SARS" is almost certainly bad luck and strongly discouraged.

    <SaveAndRetrieveSidechains name=(save_and_retrieve_sidechains &string) allsc=(0 &bool) task_operations=("" &string) two_steps=(0&bool) multi_use=(0&bool)/>

-   task\_operations: see [RepackMinimize](#RepackMinimize)
-   two\_steps: the first call to SARS only saves the sidechains, second call retrieves them. If this is false, the sidechains are saved at parse time.
-   multi\_use: If SaveAndRetrieveSidechains is used multiple times with two\_steps enabled throughout the xml protocol, multi\_use should be enabled. If not, the side chains saved the first time SaveAndRetrieveSidechains is called, will be retrieved for all the proceeding calls.

#### AtomTree

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

#### SpinMover

Allows random spin around an axis that is defined by the jump. Works preferentially good in combination with a loopOver or best a GenericMonteCarlo and other movers together. Use SetAtomTree to define the jump atoms.

```
<SpinMover name=(&string) jump_num=(1 &integer)/>
```

#### TryRotamers

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

#### BackrubDD

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

#### BestHotspotCst

Removes Hotspot BackboneStub constraints from all but the best\_n residues, then reapplies constraints to only those best\_n residues with the given cb\_force constant. Useful to prune down a hotspot-derived constraint set to avoid getting multiple residues getting frustrated during minimization.

```
<BestHotspotCst name=(&string) chain_to_design=(2 &integer) best_n=(3 &integer) cb_force=(1.0 &Real)/>
```

-   best\_n: how many residues to cherry-pick. If there are fewer than best\_n residues with constraints, only those few residues will be chosen.
-   chain\_to\_design: which chain to reapply constraints
-   cb\_force: Cbeta force to use when reapplying constraints

#### DomainAssembly (Not tested thoroughly)

Do domain-assembly sampling by fragment insertion in a linker region. frag3 and frag9 specify the fragment-file names for 9-mer and 3-mer fragments.

```
<DomainAssembly name=(&string) linker_start_(pdb_num/res_num, see below) linker_end_(pdb_num/res_num, see below) frag3=(&string) frag9=(&string)/>
```

-   pdb\_num/res\_num: see [[RosettaScripts Documentation#Specifying Residues|RosettaScripts-Documentation#Specifying-Residues]]

#### LoopFinder

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

#### LoopRemodel

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

#### LoopMoverFromCommandLine

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

#### DisulfideMover

Introduces a disulfide bond into the interface. The best-scoring position for the disulfide bond is selected from among the residues listed in `     targets    ` . This could be quite time-consuming, so specifying a small number of residues in `     targets    ` is suggested.

If no targets are specified on either interface partner, all residues on that partner are considered when searching for a disulfide. Thus including only a single residue for `     targets    ` results in a disulfide from that residue to the best position across the interface from it, and omitting the `     targets    ` param altogether finds the best disulfide over the whole interface.

Disulfide bonds created by this mover, if any, are guaranteed to pass a DisulfideFilter.

```
<DisulfideMover name="&string" targets=(&string)/>
```

-   targets: A comma-seperated list of residue numbers. These can be either with rosetta numbering (raw integer) or pdb numbering (integer followed by the chain letter, eg '123A'). Targets are required to be located in the interface. Default: All residues in the interface. *Optional*

#### MutateResidue

Change a single residue to a different type. For instance, mutate Arg31 to an Asp.

```
<MutateResidue name=(&string) target=(&string) new_res=(&string) />
```

-   target The location to mutate (eg 31A (pdb number) or 177 (rosetta index)). *Required*
-   new\_res The name of the residue to introduce. This string should correspond to the ResidueType::name() function (eg ASP). *Required*

#### InterfaceRecapitulation

Test a design mover for its recapitulation of the native sequence. Similar to SequenceRecovery filter below, except that this mover encompasses a design mover more specifically.

```
<InterfaceRecapitulation name=(&string) mover_name=(&string)/>
```

The specified mover needs to be derived from either DesignRepackMover or PackRotamersMover base class and to to have the packer task show which residues have been designed. The mover then computes how many residues were allowed to be designed and the number of residues that have changed and produces the sequence recapitulation rate. The pose at parse-time is used for the comparison.

#### VLB (aka Variable Length Build)

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

### Computational 'affinity maturation' movers (highly experimental)

These movers are meant to take an existing complex and improve it by subtly changing all relevant degrees of freedom while optimizing the interactions of key sidechains with the target. The basic idea is to carry out iterations of relax and design of the binder, designing a large sphere of residues around the interface (to get second/third shell effects).

We start by generating high affinity residue interactions between the design and the target. The foldtree of the design is cut such that each target residue has a cut N- and C-terminally to it, and jumps are introduced from the target protein to the target residues on the design, and then the system is allowed to relax. This produces deformed designs with high-affinity interactions to the target surface. We then use the coordinates of the target residues to generate harmonic coordinate restraints and send this to a second cycle of relax, this time without deforming the backbone of the design. Example scripts are available in demo/rosetta\_scripts/computational\_affinity\_maturation/

#### RandomMutation

Introduce a random mutation in a position allowed to redesign to an allowed residue identity. Control the residues and the target identities through `     task_operations    ` . The protein will be repacked according to `     task_operations    ` and `     scorefxn    ` to accommodate the mutated amino acid. The mover can work with symmetry poses; simply use SetupForSymmetry and run. It will figure out that it needs to do symmetric packing for itself.

This can be used in conjunction with GenericMonteCarlo to generate trajectories of affinity maturation.

```
<RandomMutation name=(&string) task_operations=(&string comma-separated taskoperations) scorefxn=(score12 &string)/>
```

#### GreedyOptMutationMover

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

#### ParetoOptMutationMover

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

#### HotspotDisjointedFoldTree

Creates a disjointed foldtree where each selected residue has cuts N- and C-terminally to it.

```
<HotspotDisjointedFoldTree name=(&string) ddG_threshold=(1.0 &Real) resnums=("" comma-delimited list of residues &string) scorefxn=(score12 &string) chain=(2 &Integer) radius=(8.0 &Real)/>
```

-   ddG\_threshold: The procedure can look for hot-spot residues automatically by using this threshold. If you want to shut it off, specify a number above 100R.e.u. and set the residues in resnums
-   chain: Anything other than chain 1 is untested, but should not be a big problem to make work.
-   radius: what distance from the target protein constitutes interface. Used in conjunction with the ddG\_threshold to set the target residues automatically.

#### AddSidechainConstraintsToHotspots

Adds harmonic constraints to sidechain atoms of target residues (to be used in conjunction with HotspotDisjointedFoldTree). Save the log files as those would be necessary for the next stage in affinity maturation.

```
<AddSidechainConstraintsToHotspots name=(&string) chain=(2 &Integer) coord_sdev=(1.0 &Real) resnums=(comma-delimited list of residue numbers)/>
```

-   resnums: the residues for which to add constraints. Notice that this list will be treated in addition to any residues that have cut points on either side.
-   coord\_sdev: the standard deviation on the coordinate restraints. The lower the tighter the restraints.

### Placement and Placement-associated Movers & Filters

The placement method has been described in:

Fleishman, SJ, Whitehead TA, et al. Science 332, 816-821. (2011) and JMB 413:1047

The objective of the placement methods is to help in the task of generating hot-spot based designs of protein binders. The starting point for all of them is a protein target (typically chain A), libraries of hot-spot residues, and a scaffold protein.

A few keywords used throughout the following section have special meaning and are briefly explained here.

-   Hot-spot residue: typically a residue that forms optimized interactions with the target protein. The goal here is to find a low-energy conformation of the scaffold protein that incorporates as many such hot-spot residues as possible.
-   Stub: used interchangeably with hot-spot residue. This is a dismembered residue in a specified location against the target surface.
-   Placement: positioning of the scaffold protein such that it incorporates the hot-spot residue optimally.

Hotspot residue-libraries can be read once by the SetupHotspotConstraintsMover. In this mover you can decide how many hotspot residues will be kept in memory for a given run. This number of residues will be chosen randomly from the residues that were read. In this way, you can read arbitrarily large hotspot residue libraries, but each trajectory will only iterate over a smaller set.

#### Auction

This is a special mover associated with PlaceSimultaneously, below. It carries out the auctioning of residues on the scaffold to hotspot sets without actually designing the scaffold. If pairing is unsuccessful Auction will report failure.

```
<Auction name=( &string) host_chain=(2 &integer) max_cb_dist=(3.0 &Real) cb_force=(0.5 &Real)>
   <StubSets>
     <Add stubfile=(&string)/>
   </StubSets>
</Auction>
```

Note that none of the options, except for name, needs to be set up by the user if PlaceSimultaneously is notified of it. If PlaceSimultaneously is notified of this Auction mover, PlaceSimultaneously will set all of these options.

#### MapHotspot

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

#### PlacementMinimization

This is a special mover associated with PlaceSimultaneously, below. It carries out the rigid-body minimization towards all of the stubsets.

```
<PlacementMinimization name=( &string) minimize_rb=(1 &bool) host_chain=(2 &integer) optimize_foldtree=(0 &bool) cb_force=(0.5 &Real)>
  <StubSets>
    <Add stubfile=(&string)/>
  </StubSets>
</PlacementMinimization>
```

#### PlaceOnLoop

Remodels loops using kinematic loop closure, including insertion and deletion of residues. Handles hotspot constraint application through these sequence changes.

```
<PlaceOnLoop name=( &string) host_chain=(2 &integer) loop_begin=(&integer) loop_end=(&integer) minimize_toward_stub=(1&bool) stubfile=(&string) score_high=(score12 &string) score_low=(score4L&string) closing_attempts=(100&integer) shorten_by=(&comma-delimited list of integers) lengthen_by=(&comma-delimited list of integers)/>
```

currently only minimize\_toward\_stub is avaible. closing attempts: how many kinematic-loop closure cycles to use. shorten\_by, lengthen\_by: by how many residues to change the loop. No change is also added by default.

At each try, a random choice of loop change will be picked and attempted. If the loop cannot close, failure will be reported.

Demonstrated in JMB 413:1047

#### PlaceStub

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
-   after\_placement\_filter: The name of a filter to be applied immediately after stub placement and StubMinimize movers, but before the DesignMovers run. Useful for quick sanity check on the goodness of the stub.
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

#### PlaceSimultaneously

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

#### RestrictRegion

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

#### StubScore

This is actually a filter (and should go under FILTERS), but it is tightly associated with the placement movers, so it's placed here. A special filter that is associated with PlaceSimultaneouslyMover. It checks whether in the current configuration the scaffold is 'feeling' any of the hotspot stub constraints. This is useful for quick triaging of hopeless configuration.

```
<StubScore name=(&string) chain_to_design=(2 &integer) cb_force=(0.5 &Real)>
  <StubSets>
     <Add stubfile=(&string)/>
  </StubSets>
</StubScore>
```

Note that none of the flags of this filter need to be set if PlaceSimultaneously is notified of it. In that case, PlaceSimultaneously will set this StubScore filter's internal data to match its own.

#### ddG

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

#### ContactMap

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

Ligand-centric Movers
---------------------

### Ligand docking

These movers replace the executable for ligand docking and provide greater flexibility to the user in customizing the docking protocol. An example XML file for ligand docking is found here (link forthcoming). The movers below are listed in the order found in the old executable.

#### StartFrom

```
<StartFrom name="&string" chain="&string"/>
   <Coordinates x=(&float) y=(&float) z=(&float)/>
   <File filename=(&string) chain_for_hash=(&string)/>
</StartFrom>
```

Provide a list of XYZ coordinates. One starting coordinate will be chosen at random and the specified chain will be recentered at this location.

Alternately, provide a File tag specifying a JSON formatted file containing hashes of protein chains and associated starting positions. Coordinates and File tags cannot be combined. if a File tag is specified, the Mover will compute the hash of the chain specified with the "chain for hash" flag and use that to look up the appropriate starting position. This is useful if you are docking ligands into a large number of protein structures. The application generate\_ligand\_start\_position\_file will generate these JSON files, which are in the format:

        [
            {
                "input_tag" : "infile.pdb",
                "x" : 0.0020,
                "y" : -0.004,
                "z" : 0.0020,
                "hash" : 14518543732039167129
            }
        ]

At present, Boost hashing of floats is extremely build and platform dependent. You should not consider these hash files to be at all portable. This will be addressed in the near future.

#### Transform

```
<Transform name="&string" chain="&string" box_size="&real" move_distance="&real" angle="&real" cycles="&int" repeats="&int" temperature="&real" initial_perturb="&real" rmsd="&real"/>
```

The Transform mover is designed to replace the Translate, Rotate, and SlideTogether movers, and typically exhibits faster convergence and better scientific performance than these movers. The Transform mover performs a monte carlo search of the ligand binding site using precomputed scoring grids. Currently, this mover only supports docking of a single ligand, and requires that Scoring Grids be specified and computed.

-   chain: The ligand chain, specified as the PDB chain ID
-   box\_size: The maximum translation that can occur from the ligand starting point. the "box" here is actually a sphere with the specified radius. Any move that results in the center of the ligand moving outside of this radius will be rejected
-   move\_distance: The maximum translation performed per step in the monte carlo search. Distance should be specified in angstroms. A random value is selected from a gaussian distribution between 0 and the specified distance.
-   angle: The maximum rotation angle performed per step in the monte carlo search. Angle should be specified in degrees. a random value is selected from a gaussian distribution between 0 and the specified angle in each dimension.
-   cycles: The total number of steps to be performed in the monte carlo simulation. The lowest scoring accepted pose will be output by the mover
-   repeats: The total number of repeats of the monte carlo simulation to be performed. if repeats \> 1, the simulation will be performed the specified number of times from the initial starting position, with the final pose selected.
-   temperature: The boltzmann temperature for the monte carlo simulation. Temperature is held constant through the simulation. The higher the number, the higher the percentage of accepted moves will be. 5.0 is a good starting point. "Temperature" here does not reflect any real world units.
-   initial\_perturb: Make an initial, unscored translation away from the starting position. Translation will be selected from a random uniform distribution between 0 and the specified value (in angstroms). This is mostly useful for benchmarking
-   rmsd: The maximum RMSD to be sampled away from the starting position. if this option is specified, any move above the specified RMSD will be rejected.

#### Translate

```
<Translate name="&string" chain="&string" distribution=[uniform|gaussian] angstroms=(&float) cycles=(&int)/>
```

The Translate mover is for performing a course random movement of a small molecule in xyz-space. This movement can be anywhere within a sphere of radius specified by "angstroms". The chain to move should match that found in the PDB file (a 1-letter code). "cycles" specifies the number of attempts to make such a movement without landing on top of another molecule. The first random move that does not produce a positive repulsive score is accepted. The random move can be chosen from a uniform or gaussian distribution. This mover uses an attractive-repulsive grid for lightning fast score lookup.

#### Rotate

```
<Rotate name="&string" chain="&string" distribution=[uniform|gaussian] degrees=(&int) cycles=(&int)/>
```

The Rotate mover is for performing a course random rotation throughout all rotational degrees of freedom. Usually 360 is chosen for "degrees" and 1000 is chosen for "cycles". Rotate accumulates poses that pass an attractive and repulsive filter, and are different enough from each other (based on an RMSD filter). From this collection of diverse poses, 1 pose is chosen at random. "cycles" represents the maximum \# of attempts to find diverse poses with acceptable attractive and repulsive scores. If a sufficient \# of poses are accumulated early on, less rotations then specified by "cycles" will occur. This mover uses an attractive-repulsive grid for lightning fast score lookup.

#### SlideTogether

```
<SlideTogether name="&string" chain="&string"/>
```

The initial translation and rotation may move the ligand to a spot too far away from the protein for docking. Thus, after an initial low resolution translation and rotation of the ligand it is necessary to move the small molecule and protein into close proximity. If this is not done then high resolution docking will be useless. Simply specify which chain to move. This mover then moves the small molecule toward the protein 2 angstroms at a time until the two clash (evidenced by repulsive score). It then backs up the small molecule. This is repeated with decreasing step sizes, 1A, 0.5A, 0.25A, 0.125A.

#### HighResDocker

```
<HighResDocker name="&string" repack_every_Nth=(&int) scorefxn="string" movemap_builder="&string" />
```

The high res docker performs cycles of rotamer trials or repacking, coupled with small perturbations of the ligand(s). The "movemap\_builder" describes which side-chain and backbone degrees of freedom exist. The Monte Carlo mover is used to decide whether to accept the result of each cycle. Ligand and backbone flexibility as well as which ligands to dock are described by LIGAND\_AREAS provided to INTERFACE\_BUILDERS, which are used to build the movemap according the the XML option.

#### FinalMinimizer

```
<FinalMinimizer name="&string" scorefxn="&string" movemap_builder=&string/>
```

Do a gradient based minimization of the final docked pose. The "movemap\_builder" makes a movemap that will describe which side-chain and backbone degrees of freedom exist.

#### InterfaceScoreCalculator

```
<InterfaceScoreCalculator name=(string) chains=(comma separated chars) scorefxn=(string) native=(string) compute_grid_scores=(bool)/>
```

InterfaceScoreCalculator calculates a myriad of ligand specific scores and appends them to the output file. After scoring the complex the ligand is moved 1000 Å away from the protein. The model is then scored again. An interface score is calculated for each score term by subtracting separated energy from complex energy. If compute\_grid\_scores is true, the scores for each grid will be calculated. This may result in the regeneration of the scoring grids, which can be slow. If a native structure is specified, 4 additional score terms are calculated:

1.  ligand\_centroid\_travel. The distance between the native ligand and the ligand in our docked model.
2.  ligand\_radious\_of\_gyration. An outstretched conformation would have a high radius of gyration. Ligands tend to bind in outstretched conformations.
3.  ligand\_rms\_no\_super. RMSD between the native ligand and the docked ligand.
4.  ligand\_rms\_with\_super. RMSD between the native ligand and the docked ligand after aligning the two in XYZ space. This is useful for evaluating how much ligand flexibility was sampled.

#### ComputeLigandRDF

```
<ComputeLigandRDF name=(string) ligand_chain=(string) mode=(string)>
    <RDF name=(string)/>
</ComputeLigandRDF>
```

ComputeLigandRDF computes Radial Distribution Functions using pairs of protein-protein or protein-ligand atoms. The conceptual and theoretical basis of Rosettas RDF implementation is described in the [ADRIANA.Code Documentation](http://www.molecular-networks.com/files/docs/adrianacode/adrianacode_manual.pdf) . A 100 bin RDF with a bin spacing of 0.1 Å is calculated.

all RDFs are inserted into the job as a string,string pair. The key is the name of the computed RDF, the value is a space separated list of floats

The outer tag requires the following options:

-   ligand\_chain: The PDB ID of the ligand chain to be used for RDF computation.
-   mode: The type of RDF to compute. valid options are "interface" in which the RDF is computed using all ligand atoms and all protein atoms within 10 Å of the ligand, and "pocket" in which the RDF is computed using all protein atoms within 10 Å of the ligand.

The ComptueLigandRDF mover requires that one or more RDFs be specified as RDF subtags. Descriptions of the currently existing RDFs are below:

##### RDFEtableFunction

RDFEtableFunction computes 3 RDFs using the Analytic Etables used to compute fa\_atr, fa\_rep and fa\_solv energy functions.

RDFEtableFunction requires that a score function be specified using the scorefxn option in its subtag.

##### RDFElecFunction

RDFElecFunction computes 1 RDF based on the fa\_elec electrostatic energy function.

RDFElecFunction requires that a score function be specified using the scorefxn option in its subtag.

##### RDFHbondFunction

RDFHbondFunction computes 1 RDF based on the hydrogen bonding energy function.

##### RDFBinaryHbondFunction

RDFBinaryHbondFunction computes 1 RDF in which an atom pair has a score of 1 if one atom is a donor and the other is an acceptor, and a 0 otherwise, regardless of whether these atoms are engaged in a hydrogen bonding interaction.

### Enzyme design

#### EnzRepackMinimize

EnzRepackMinimize, similar in spirit to RepackMinimize mover, does the design/repack followed by minimization of a protein-ligand (or TS model) interface with enzyme design style constraints (if present, see AddOrRemoveMatchCsts mover) using specified score functions and minimization dofs. Only design/repack or minimization can be done by setting appropriate tags. A shell of residues around the ligand are repacked/designed and/or minimized. If constrained optimization or cst\_opt is specified, ligand neighbors are converted to Ala, minimization performed, and original neighbor sidechains are placed back.

```
<EnzRepackMinimize name="&string" scorefxn_repack=(score12 &string) scorefxn_minimize=(score12 &string) cst_opt=(0 &bool) design=(0 &bool) repack_only=(0 &bool) fix_catalytic=(0 &bool) minimize_rb=(1 &bool) rb_min_jumps=("" &comma-delimited list of jumps) minimize_bb=(0 &bool) minimize_sc=(1 &bool) minimize_lig=(0 & bool) min_in_stages=(0 &bool) backrub=(0 &bool) cycles=(1 &integer) task_operations=(comma separated string list)/>
```

-   scorefxn\_repack: scorefunction to use for repack/design (defined in the SCOREFXNS section, default=score12)
-   scorefxn\_minimize: similarly, scorefunction to use for minimization (default=score12)
-   cst\_opt: perform minimization of enzdes constraints with a reduced scorefunction and in a polyAla background. (default= 0)
-   design: optimize sequence of residues spatially around the ligand (detection of neighbors need to be specified in the flagfile or resfile, default=0)
-   repack\_only: if true, only repack sidechains without changing sequence. (default =0) If both design and repack\_only are false, don't repack at all, only minimize.
-   minimize\_bb: minimize back bone conformation of backbone segments that surround the ligand (contiguous neighbor segments of \>3 residues are automatically chosen, default=0)
-   minimize\_sc: minimize sidechains (default=1)
-   minimize\_rb: minimize rigid body orientation of ligand (default=1)
-   rb\_min\_jumps: specify which jumps to minimize. If this is specified it takes precedence over minimize\_rb above. Useful if you have more than one ligand in the system and you only want to optimize one of the ligands, e.g., rb\_min\_jumps=1,2 would minimize only across jumps 1&2.
-   minimize\_lig: minimize ligand internal torsion degrees of freedom (allowed deviation needs to be specified by flag, default =0)
-   min\_in\_stages: first minimize non-backbone dofs, followed by backbone dofs only, and then everything together (default=0)
-   fix\_catalytic: fix catalytic residues during repack/minimization (default =0)
-   cycles: number of cycles of repack-minimize (default=1 cycle) (Note: In contrast to the enzyme\_design application, all cycles use the provided scorefunction.)
-   backrub:use backrub to minimize (default=0).
-   task\_operations: list of task operations to define the packable/designable residues, as well as the minimizable residues (the minimizable resiudes will the packable residues as well as such surrounding residues as needed to allow for efficient minimization). If explicit task\_operations are given, the design/repack\_only flags will not change them. (So it is possible to have design happen with the repack\_only flag set.) -- If task\_operations are not given, the default (command line controlled) enzyme\_design task will be used. Keep in mind that the default flags are to design everything and not to do interface detection, so being explicit with flags is recommended.

#### AddOrRemoveMatchCsts

Add or remove enzyme-design style pairwise (residue-residue) geometric constraints to/from the pose. A cstfile specifies these geometric constraints, which can be supplied in the flags file (-enzdes:cstfile) or in the mover tag (see below).

The "-run:preserve\_header" option should be supplied on the command line to allow the parser to read constraint specifications in the pdb's REMARK lines. (The "-enzdes:parser\_read\_cloud\_pdb" also needs to be specified for the parser to read the matcher's CloudPDB default output format.)

```
<AddOrRemoveMatchCsts name="&string" cst_instruction=( "void", "&string") cstfile="&string" keep_covalent=(0 &bool) accept_blocks_missing_header=(0 &bool) fail_on_constraints_missing=(1 &bool)/>
```

-   cst\_instruction: 1 of 3 choices - "add\_new" (read from file), "remove", or "add\_pregenerated" (i.e. if enz csts existed at any point previosuly in the protocol add them back)
-   cstfile: name of file to get csts from (can be specified here if one wants to change the constraints, e.g. tighten or relax them, as the pose progresses down a protocol.)
-   keep\_covalent: during removal, keep constraints corresponding to covalent bonds between protein and ligand intact (default=0).
-   accept\_blocks\_missing\_header: allow more blocks in the cstfile than specified in header REMARKs (see enzdes documentation for details, default=0)
-   fail\_on\_constraints\_missing: When removing constraints, raise an error if the constraint blocks do not exist in the pose (default=1).

#### PredesignPerturbMover

PredesignPerturbMover randomly perturbs a ligand in a protein active site. The input protein will be transformed to a polyalanine context for residues surrounding the ligand. A number of random rotation+translation moves are made and then accepted/rejected based on the Boltzmann criteria with a modified (no attractive) score function (enzdes\_polyA\_min.wts).

PredesignPerturbMover currently will perturb only the last ligand in the pose (the last jump).

    <PredesignPerturbMover name=(&string) trans_magnitude=(0.1 &real) rot_magnitude=(2.0 &real) dock_trials=(100 &integer) task_operations=(&string,&string)/>

-   dock\_trials - the number of Monte Carlo steps to attempt
-   trans\_magnitude - how large (stdev of a gaussian) a random translation step to take in each of x, y, and z (angstrom)
-   rot\_magnitude - how large (stdev of a gaussian) a random rotational step to take in each of the Euler angles (degrees)
-   task\_operations - comma separated list of task operations to specify which residues (specified as designable in the resulting task) are converted to polyAla

### Ligand design

These movers work in conjunction with ligand docking movers. An example XML file for ligand design is found here (link forthcoming). These movers presuppose the user has created or acquired a fragment library. Fragments have incomplete connections as specified in their params files. Combinatorial chemistry is the degenerate case in which a core fragment has several connection points and all library fragments have only one connection point.

#### GrowLigand

```
<GrowLigand name="&string" chain="&string"/>
```

Randomly connects a fragment from the library to the growing ligand. The connection point for connector atom1 must specify that it connects to atoms of connector atom2's type, and visa versa.

#### AddHydrogens

```
<AddHydrogens name="&string" chain="&string"/>
```

Saturates the incomplete connections with H. Currently the length of these created H-bonds is incorrect. H-bonds will be the same length as the length of a bond between connector atoms 1 and 2 should be.

DNA interface Design Movers
---------------------------

### DnaInterfacePacker

```
<DnaInterfacePacker name=(&string) scorefxn=(&string) task_operations=(&string,&string,&string) binding=(0, &bool) base_only=(false, &bool) minimize=(0, &bool) probe_specificity=(0, &bool) reversion_scan=(false, &bool)/>
```

-   binding: calculate binding energy
-   base\_only: consider only interaction with the DNA bases
-   minimize: minimize protein side chains at the interface
-   probe\_specificity: calculate binding energy of designed protein for alternative DNA targets and calculate a specificity score
-   reversion\_scan: revert mutations that do not contribute to the specificity score

Currently Undocumented
----------------------

The following Movers are available through RosettaScripts, but are not currently documented. See the code (particularly the respective parse\_my\_tag() and apply() functions) for details. (Some may be undocumented as they are experimental/not fully functional.)

AddEncounterConstraintMover, BackboneSampler, BackrubSidechain, BluePrintBDR, CAcstGenerator, CCDLoopCloser, CartesianSampler, CircularPermutation, CloseFold, CompoundTranslate, ConformerSwitchMover, ConstraintFileCstGenerator, CoordinateCst, DefineMovableLoops, DesignProteinBackboneAroundDNA, DnaInterfaceMinMover, DnaInterfaceMultiStateDesign, DockSetupMover, DockingInitialPerturbation, EnzdesRemodelMover, ExtendedPoseMover, FavorNonNativeResidue, FlxbbDesign, FragmentLoopInserter, GenericSymmetricSampler, GridInitMover, GrowPeptides, HamiltonianExchange, HotspotHasher, Hybridize, InsertZincCoordinationRemarkLines, InterlockAroma, InverseRotamersCstGenerator, InvrotTreeCstGenerator, IterativeLoophashLoopInserter, JumpRotamerSidechain, LigandDesign, LoadVarSolDistSasaCalculatorMover, LoadZnCoordNumHbondCalculatorMover, LoopHash, LoopHashDiversifier, LoopMover\_Perturb\_CCD, LoopMover\_Perturb\_KIC, LoopMover\_Perturb\_QuickCCD, LoopMover\_Perturb\_QuickCCD\_Moves, LoopMover\_Refine\_Backrub, LoopMover\_Refine\_CCD, LoopMover\_Refine\_KIC, LoopMover\_SlidingWindow, LoopRefineInnerCycleContainer, LoopRelaxMover, LoophashLoopInserter, MatchResiduesMover, MatcherMover, MinimizeBackbone, ModifyVariantType, ModulatedMover, MotifDnaPacker, NtoCCstGenerator, PDBReload, ParallelTempering, PerturbChiSidechain, PerturbRotamerSidechain, PlaceSurfaceProbe, RandomConformers, RemodelLoop, RemoveCsts, RepackTrial, ResidueVicinityCstCreator, RigidBodyPerturbNoCenter, RotamerRecoveryMover, Rotates, SaneMinMover, ScoreMover, SeedFoldTree, SeedSetupMover, SeparateDnaFromNonDna, SetAACompositionPotential, SetChiMover, SetSecStructEnergies, SetupForDensityScoring, SetupHotspotConstraints, SetupHotspotConstraintsLoops, ShearMinCCDTrial, SheetCstGenerator, ShoveResidueMover, SimulatedTempering, SmallMinCCDTrial, StapleMover, StoreCombinedStoredTasksMover, SwapSegment, Symmetrizer, TempWeightedMetropolisHastings, ThermodynamicRigidBodyPerturbNoCenter, TrialCounterObserver, load\_unbound\_rot, profile