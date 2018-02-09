#MultistageRosettaScripts

#Time Machine Example

Back To [[Multistage Rosetta Scripts|MultistageRosettaScripts]]

[[_TOC_]]

One of the consequences of
[[archiving job results on disk|RunningMRS#running-multistage-rosetta-scripts_relevant-commandline-flags_archive_on_disk]]
is that the results still exist when the program completes.
Sure, this usually just means that you have to do the extra chore of
going out of your way to delete these binaries when you are done running,
but there are benefits too:

###Anecdote

Suppose your final results have some trait that you did not expect
and you would like to figure out how this trait was introduced.
For example, I* recently ran a protocol with 1 stage of DockingProtocol
followed by 5 stages of FastRelax similar to [[this example|BatchRelaxExample]].
The final structures were completely unfolded
and I wanted to figure out where things went wrong.
I loaded up the 5 intermediates states from their archives (as shown below)
and was able to look at each structure.
The protein was folded after the docking stage
but was unfolded after the first FastRelax stage.
Further inspection showed that the product of the DockingProtocol
had MANY side chain clashes that were not present in the input structure.

The use of this time machine feature allowed me to quickly figure out that
I was not using the [[SaveAndRetrieveSidechainsMover|SaveAndRetrieveSidechainsMover]]
correctly by showing me snapshots of a trajectory at the end of each stage.

###Example

```xml
<JobDefinitionFile>
    <Job>
        <Input>
            <PDB filename="../S1.pdb"/>
        </Input>
    </Job>

    <Common>

        <SCOREFXNS>
            <ScoreFunction name="common_sfxn" weights="beta_nov16_cart.wts"/>
        </SCOREFXNS>

        <TASKOPERATIONS>
            <InitializeFromCommandline name="ifc"/>
            <IncludeCurrent name="ic"/>
            <ExtraRotamersGeneric ex1="true" ex2="true" name="ex1ex2"/>
        </TASKOPERATIONS>

        <FILTERS>
            <ScoreType name="beta16_filter" score_type="total_score" scorefxn="common_sfxn" threshold="999999"/>
        </FILTERS>

        <MOVERS>
            <FastRelax disable_design="true" name="relax_1" repeats="1" scorefxn="common_sfxn" task_operations="ifc,ic,ex1ex2"/>
            <FastRelax disable_design="true" name="relax_2" repeats="2" scorefxn="common_sfxn" task_operations="ifc,ic,ex1ex2"/>
            <SwitchResidueTypeSetMover name="to_fa" set="fa_standard"/>
        </MOVERS>

        <PROTOCOLS>
            <Stage num_runs_per_input_struct="1" total_num_results_to_keep="7500">
                <Add mover_name="to_fa"/>
                <Add mover_name="relax_1"/>
                <Sort filter_name="beta16_filter"/>
            </Stage>

            <Stage num_runs_per_input_struct="1" total_num_results_to_keep="1875">
                <Add mover_name="relax_1"/>
                <Sort filter_name="beta16_filter"/>
            </Stage>

            <Stage num_runs_per_input_struct="1" total_num_results_to_keep="1875">
                <Add mover_name="relax_2"/>
                <Sort filter_name="beta16_filter"/>
            </Stage>

        </PROTOCOLS>

    </Common>

</JobDefinitionFile>
```

*Jack Maguire, 2018