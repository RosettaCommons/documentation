# GenericSimulatedAnnealer
*Back to [[Mover|Movers-RosettaScripts]] page.*
## GenericSimulatedAnnealer

Allows finding global minima by sampling structures using SimulatedAnnealing. Simulated annealing is essentially a monte carlo in which the acceptance temperature starts high (permissive) to allow energy wells to be found globally, and is gradually lowered so that the structure can proceed as far into the energy well as possible. Like the GenericMonteCarlo, any movers can be used for monte carlo moves and any filters with a functional report\_sm function can be used for evaluation. All options available to GenericMonteCarlo are usable in the GenericSimulatedAnnealer (see above), and only options unique to GenericSimulatedAnnealer are described here. The specified filters are applied sequentially in the order listed and only if the pose passes the Metropolis criterion for all filters is the move accepted. See the documentation for GenericMonteCarlo for more details on acceptance.

Temperature scaling occurs automatically. Temparatures for all filters are multiplied by a scaling factor that ranges from 1.0 (at the start) and is reduced as the number of acceptances increases. The multiplier is equal to e\^(-anneal\_step/num\_filters). During each step, the GenericSimulatedAnnealer keeps track of the last several accepted poses (the number of accepted poses it keeps = history option). When improvements in the accepted scores slow, the annealer lowers the temperature to the next step.

```xml
<GenericSimulatedAnnealer name="(&string)" mover_name="(&string)" filter_name="(&string)" trials="(10 &integer)" sample_type="(low, &string)" temperature="(0, &Real)" drift="(1 &bool)" recover_low="(1 &bool)" boltz_rank="(0 &bool)" stopping_condition="(FalseFilter &string)" preapply="(1 &bool)" adaptive_movers="(0 &bool)" adaptation_period="(see below &integer)" saved_accept_file_name="('' &string)" saved_trial_file_name="('' &string)" reset_baselines="(1 &bool)" history="(10 &int)" eval_period="(0 &int)" periodic_mover="('' &string)" checkpoint_file="('' &string)" keep_checkpoint_file="(0 &bool)" >
  <Filters>
     <AND filter_name="(&string)" temperature="(&Real)" sample_type="(low, &string)" rank="(0 &bool)"/>
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

```xml
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


##See Also

* [[GenericMonteCarloMover]]
* [[RandomMover]]
* [[MonteCarloTestMover]]
* [[MonteCarloUtilMover]]
* [[MonteCarloRecoverMover]]
* [[SubroutineMover]]
* [[LoopOverMover]]
* [[MultiplePoseMover]]
* [[MultipleOutputWrapperMover]]
* [[I want to do x]]: Guide to choosing a mover
