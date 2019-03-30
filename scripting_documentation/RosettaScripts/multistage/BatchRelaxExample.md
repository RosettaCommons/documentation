#MultistageRosettaScripts

#Batch Relax Example

Back To [[Multistage Rosetta Scripts|MultistageRosettaScripts]]

- Written by Jack Maguire, send questions to jackmaguire1444@gmail.com
- All information here is valid as of Feb 13, 2018
(I will hopefully remember to update this page with more info once this experiment is published).

This script was used to relax 30,000 [[abinitio|abinitio]] results.
All 30,000 structues went through one repeat of [[FastRelax|FastRelaxMover]].
The 7,500 (25%) best results survived and went through the second repeat.
After that, the 1,875 (25%) best results went through the final 2 repeats.
This was roughly 3 times faster than running 30,000 through all 4 repeats using traditional rosetta scripts

```xml
<JobDefinitionFile>
    <Job>
        <Input>
            <PDB listfile="my_pdblist"/>
        </Input>
    </Job>

    <Common>

        <SCOREFXNS>
            <ScoreFunction name="common_sfxn" weights="ref2015.wts"/>
        </SCOREFXNS>

        <TASKOPERATIONS>
            <InitializeFromCommandline name="ifc"/>
            <IncludeCurrent name="ic"/>
            <ExtraRotamersGeneric ex1="true" ex2="true" name="ex1ex2"/>
        </TASKOPERATIONS>

        <FILTERS>
            <ScoreType name="sfxn_filter" score_type="total_score" scorefxn="common_sfxn" threshold="999999"/>
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
                <Sort filter_name="sfxn_filter"/>
            </Stage>

            <Stage num_runs_per_input_struct="1" total_num_results_to_keep="1875">
                <Add mover_name="relax_1"/>
                <Sort filter_name="sfxn_filter"/>
            </Stage>

            <Stage num_runs_per_input_struct="1" total_num_results_to_keep="1875">
                <Add mover_name="relax_2"/>
                <Sort filter_name="sfxn_filter"/>
            </Stage>

        </PROTOCOLS>

    </Common>

</JobDefinitionFile>
```