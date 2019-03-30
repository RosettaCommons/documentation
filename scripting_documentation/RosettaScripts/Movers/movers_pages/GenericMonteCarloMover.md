# GenericMonteCarlo
*Back to [[Mover|Movers-RosettaScripts]] page.*
## GenericMonteCarlo

Allows sampling structures by MonteCarlo with a mover. The score evaluation of pose during MC are done by Filters that can do report\_sm(), not only ScoreFunctions.
 You can choose either format:

1) scoring by Filters

```xml
<GenericMonteCarlo name="(&string)" mover_name="(&string)" filter_name="(&string)" trials="(10 &integer)" sample_type="(low, &string)" temperature="(0, &Real)" drift="(1 &bool)" recover_low="(1 &bool)" boltz_rank="(0 &bool)" stopping_condition="(FalseFilter &string)" preapply="(1 &bool)" adaptive_movers="(0 &bool)" adaptation_period="(see below &integer)" saved_accept_file_name="('' &string)" saved_trial_file_name="('' &string)" reset_baselines="(1 &bool)" progress_file="('' &string)">
  <Filters>
     <AND filter_name="(&string)" temperature="(&Real)" sample_type="(low, &string)" rank="(0 &bool)"/>
     ...
  </Filters>
</GenericMonteCarlo>
```

2) scoring by ScoreFunction

```xml
<GenericMonteCarlo name="(&string)" mover_name="(&string)" scorefxn_name="(&string)" trials="(10 &integer)" sample_type="(low, &string)" temperature="(0, &Real)" drift="(1 &bool)" recover_low="(1 &bool)" stopping_condition="(FalseFilter &string)" preapply="(1 &bool)" saved_accept_file_name="('' &string)" saved_trial_file_name="('' &string)"/>
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

To determine whether a move "passes" the monte carlo move, values for each filter or scorefunction are computed one-by-one. A move must be accepted by all filters for the move to be accepted. A filter accepts a move on either of two conditions: 1) the filter score is improved over the filter score of the last accepted pose, or 2) the filter score is worse than the filter score of the last accepted pose, but the temperature allows for the filter score to pass. The probability of passing in this case is defined by P = e^( -multiplier*(filter_score - filter_score_0) / filter_temperature ), where multiplier is 1 for filters with sample_type="low" and -1 for filters with sample_type="high", filter_score is the score of the filter after the move, filter_score_0 is the score of the filter for the last accepted pose, filter_temperature is the user-specified temperature for the filter, and P is a real number between 0 and 1 indicating the probability of acceptance. GenericMonteCarloMover then generates a random number with uniform distribution between 0 and 1, and the move passes if the random number is less than P.

In the multiple filter case, the filter to be used for the official score of the pose (e.g. for recover\_low purposes) can be specified with the *rank* parameter (this has no effect on the MC accept/reject). If no sub-filters are set with rank=1, the first filter is used for ranking. As a special case, if *boltz\_rank* is set to true, the ranking score is a temperature-weighted sum of all filter values. (This value is equivalent to the effective value optimized by the MC protocol.)  This boltz\_rank score is computed by the equation SUM( multiplier * filter_value / filter_temperature ) over all filter values, where filter_value is the value returned by the filter and multiplier is 1 if the filter sample_type is low and -1 if the filter sample_type is high.

A task can optionally be included for automatic setting of the number of trials in a GenericMonteCarlo run. Without a task input the number of trials is set by the Trials integer input. If a task is included, the number of designable residues will be calculated and the number of trials will be automatically set as task\_scaling \* (number designable residues). For example, if there are 10 designable residues and task\_scaling is 5 (the default) the number of trials will be 50. The task\_scaling is set to 5 by default and can be adjusted in the xml with the task\_scaling flag. Giving an input task will override any value set by the Trials input. This allows for automation over a number of different input files. Input the task as for any other move, see example xml line below. Note that the input task does not alter the movers/filters contained within the GenericMonteCarlo, it is only used for calculating the number of designable residues.

```xml
<GenericMonteCarlo name="(&string)" mover_name="(&string)" filter_name="(&string)" trials="(10 &integer)" sample_type="(low, &string)" temperature="(0, &Real)" drift="(1 &bool)" recover_low="(1 &bool)" boltz_rank="(0 &bool)" stopping_condition="(FalseFilter &string)" preapply="(1 &bool)" task_operations="(&string,&string,&string)" task_scaling="(5 &integer)">
```

##See Also

* [[GenericSimulatedAnnealerMover]]
* [[RandomMover]]
* [[MonteCarloTestMover]]
* [[MonteCarloUtilMover]]
* [[MonteCarloRecoverMover]]
* [[LoopOverMover]]
* [[SubroutineMover]]
* [[MultiplePoseMover]]
* [[MultipleOutputWrapperMover]]
* [[I want to do x]]: Guide to choosing a mover
