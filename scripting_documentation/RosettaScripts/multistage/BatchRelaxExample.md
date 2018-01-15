#MRS: BatchRelax Example

This script was used to Relax 30,000 [[abinitio|abinitio]] results (only 5 shown here for the sake of saving space).
All 30,000 structues went through one repeat of [[FastRelax|FastRelaxMover]].
The 7,500 best results survived and went through the second repeat.
After that, the 1,875 best results went through the final 2 repeats.
This was roughly 3 times faster than running 30,000 through all 4 repeats using traditional rosetta scripts (will update this page once this experiment is published).


<JobDefinitionFile>
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
            <ScoreType name="beta16_filter2" score_type="total_score" scorefxn="common_sfxn" threshold="999999"/>
        </FILTERS>

        <MOVERS>
            <FastRelax disable_design="true" name="relax_1" repeats="1" scorefxn="common_sfxn" task_operations="ifc,ic,ex1ex2"/>
            <FastRelax disable_design="true" name="relax_2" repeats="2" scorefxn="common_sfxn" task_operations="ifc,ic,ex1ex2"/>
            <SwitchResidueTypeSetMover name="to_fa" set="fa_standard"/>
        </MOVERS>

        <PROTOCOLS>
            <Stage num_runs_per_input_struct="1" total_num_results_to_keep="7500">
            <Add mover_name="to_fa"/>
                <Add mover_name="VR_ROOT"/>
                <Add mover_name="relax_1"/>
                <Sort filter_name="beta16_filter2"/>
            </Stage>

            <Stage num_runs_per_input_struct="1" total_num_results_to_keep="1875">
                <Add mover_name="relax_1"/>
                <Sort filter_name="beta16_filter2"/>
            </Stage>

            <Stage num_runs_per_input_struct="1" total_num_results_to_keep="1875">
                <Add mover_name="relax_2"/>
                <Sort filter_name="beta16_filter2"/>
            </Stage>

        </PROTOCOLS>

    </Common>

    <Job>
        <Input>
            TODO: The script converter is not smart enough to know if this file is actually a pdb file. Please correct this tag if necessary!
            <PDB filename="../Abinit_jd3/S_00000001.pdb"/>
        </Input>
    </Job>

    <Job>
        <Input>
            TODO: The script converter is not smart enough to know if this file is actually a pdb file. Please correct this tag if necessary!
            <PDB filename="../Abinit_jd3/S_00000002.pdb"/>
        </Input>
    </Job>

    <Job>
        <Input>
            TODO: The script converter is not smart enough to know if this file is actually a pdb file. Please correct this tag if necessary!
            <PDB filename="../Abinit_jd3/S_00000003.pdb"/>
        </Input>
    </Job>

    <Job>
        <Input>
            TODO: The script converter is not smart enough to know if this file is actually a pdb file. Please correct this tag if necessary!
            <PDB filename="../Abinit_jd3/S_00000004.pdb"/>
        </Input>
    </Job>

    <Job>
        <Input>
            TODO: The script converter is not smart enough to know if this file is actually a pdb file. Please correct this tag if necessary!
            <PDB filename="../Abinit_jd3/S_00000005.pdb"/>
        </Input>
    </Job>

<JobDefinitionFile>