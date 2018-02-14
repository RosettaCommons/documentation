#MultistageRosettaScripts

#DataMap Overload Example

Back To [[Multistage Rosetta Scripts|MultistageRosettaScripts]]

- Written by Jack Maguire, send questions to jackmaguire1444@gmail.com
- All information here is valid as of Feb 13, 2018

This script was contrived for the purposes of showing how to overload [[DataMap Info|XML#DataMap Info]].

There are two main things to note here:

1. Each input structure has a different resfile. This is not a problem because they all use the same name "rrf".
When the `FastRelax` tag gets parsed, it will use whatever "rrf" task operation is relevant to the job being run.

2. The 3rd job actually uses a completely different FastRelax protocol.
Design is enabled and the ExtraRotamersGeneric task operation "ex1ex2" is removed.
When the stages run, they will use whatever mover is named "relax" for that particular job.

Whenever an element has the same name as a previously declared element, the new one is ignored.
For the first job tag, there is only one Mover named "relax".
However, the third job tag has two Movers named "relax" (one in the Job block and one in the Common block).

```xml
<JobDefinitionFile>
    <Job>
        <RESIDUE_SELECTORS>
            <ReadResfile name="rrf" filename="resfile1"/>
        </RESIDUE_SELECTORS>
        <Input>
            <PDB filename="../S1.pdb"/>
        </Input>
    </Job>

    <Job>
        <RESIDUE_SELECTORS>
            <ReadResfile name="rrf" filename="resfile2"/>
        </RESIDUE_SELECTORS>
        <Input>
            <PDB filename="../S2.pdb"/>
        </Input>
    </Job>

    <Job>
        <RESIDUE_SELECTORS>
            <ReadResfile name="rrf" filename="resfile3"/>
        </RESIDUE_SELECTORS>
        <MOVERS>
            <FastDesign disable_design="false" name="relax" repeats="1" scorefxn="common_sfxn" task_operations="ifc,ic,rrf"/>
        </MOVERS>
        <Input>
            <PDB filename="../S3.pdb"/>
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
            <FastRelax disable_design="true" name="relax" repeats="1" scorefxn="common_sfxn" task_operations="ifc,ic,ex1ex2,rrf"/>
        </MOVERS>

        <PROTOCOLS>
            <Stage num_runs_per_input_struct="10" total_num_results_to_keep="3">
                <Add mover_name="relax"/>
                <Sort filter_name="beta16_filter"/>
            </Stage>

            <Stage num_runs_per_input_struct="10" total_num_results_to_keep="2">
                <Add mover_name="relax"/>
                <Sort filter_name="beta16_filter"/>
            </Stage>

            <Stage num_runs_per_input_struct="10" total_num_results_to_keep="1">
                <Add mover_name="relax"/>
                <Sort filter_name="beta16_filter"/>
            </Stage>

        </PROTOCOLS>

    </Common>

</JobDefinitionFile>
```