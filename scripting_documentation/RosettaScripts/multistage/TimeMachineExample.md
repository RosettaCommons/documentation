#MultistageRosettaScripts

#Time Machine Example

Back To [[Multistage Rosetta Scripts|MultistageRosettaScripts]]

[[_TOC_]]

One of the consequences of
[[archiving job results on disk|RunningMRS#running-multistage-rosetta-scripts_relevant-commandline-flags_archive_on_disk]]
is that the results still exist when the program completes.
Sure, this usually just means that you have to do the extra chore of
deleting these binaries when you are done running,
but there are benefits too:

###Anecdote

Suppose your final results have some trait that you did not expect
and you would like to figure out how this trait was introduced.
For example, I* recently ran a protocol with 1 stage of DockingProtocol
followed by 5 stages of FastRelax (similar to the [[batch relax example|BatchRelaxExample]]).
The final structures were completely unfolded
and I wanted to figure out where things went wrong.
I loaded up the 5 intermediate states from their archives
and was able to look at each structure.
The protein was folded after the docking stage
but was unfolded after the first FastRelax stage.
Further inspection showed that the product of the DockingProtocol
had MANY side chain clashes that were not present in the input structure.

The use of this time machine feature allowed me to quickly figure out that
I was not using the [[SaveAndRetrieveSidechainsMover|SaveAndRetrieveSidechainsMover]]
correctly by showing me snapshots of a trajectory at the end of each stage.

###Toy Example

Let's play with a 3-stage protocol that does Docking, PackRotamersMover, and MinMover:

```xml
<JobDefinitionFile>
    <Job>
        <Input>
            <PDB filename="3U3B.pdb"/>
        </Input>
    </Job>

    <Common>

        <SCOREFXNS>
            <ScoreFunction name="sfxn" weights="ref2015_cart.wts"/>
            <ScoreFunction name="sfxn_lowres" weights="interchain_cen.wts"/>
        </SCOREFXNS>

        <FILTERS>
            <ScoreType name="sfxn_filter" score_type="total_score" scorefxn="sfxn" threshold="999999" />
        </FILTERS>

        <MOVERS>
		<DockingProtocol docking_score_low="sfxn_lowres" partners="A_B" low_res_protocol_only="true" name="dock" />
		<SwitchResidueTypeSetMover name="to_fa" set="fa_standard" />
		<SaveAndRetrieveSidechains allsc="1" multi_use="0" name="save_retrieve" two_step="1" />

		<PackRotamersMover scorefxn="sfxn" name="pack_rot" />

		<MinMover scorefxn="sfxn" name="min_mover" chi="1" bb="0"/>
        </MOVERS>

        <PROTOCOLS>
            <Stage num_runs_per_input_struct="100" total_num_results_to_keep="5">
                <Add mover_name="save_retrieve"/>
                <Add mover_name="dock"/>
                <Add mover_name="to_fa"/>
                <Add mover_name="save_retrieve"/>
                <Sort filter_name="sfxn_filter"/>
            </Stage>

            <Stage num_runs_per_input_struct="2" total_num_results_to_keep="5">
                <Add mover_name="pack_rot"/>
                <Sort filter_name="sfxn_filter"/>
            </Stage>

            <Stage num_runs_per_input_struct="1" total_num_results_to_keep="3">
                <Add mover_name="min_mover"/>
                <Sort filter_name="sfxn_filter"/>
            </Stage>

        </PROTOCOLS>

    </Common>

</JobDefinitionFile>
```

If you are following along, I am using the 3U3B
file directly from RCSB ([[link|https://files.rcsb.org/view/3U3B.pdb]]).

*Jack Maguire, 2018