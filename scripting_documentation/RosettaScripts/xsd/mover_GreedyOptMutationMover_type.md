<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
This mover will first attempt isolated/independent mutations defined in the input task operation, score/filter them all, rank them by score, then attempt to combine them, starting with the best scoring single mutation, accepting the mutation only if the filter score decreases (see skip_best_check for optional exception), and working down the list to the end. Optionally test one of the top N mutations at each positions instead of just the best.

```xml
<GreedyOptMutationMover name="(&string;)" relax_mover="(null &string;)"
        dump_pdb="(false &bool;)" dump_table="(false &bool;)"
        parallel="(false &bool;)" stopping_condition="(&string;)"
        design_shell="(-1.0 &real;)" repack_shell="(8.0 &real;)"
        stop_before_condition="(false &bool;)" skip_best_check="(false &bool;)"
        rtmin="(false &bool;)" shuffle_order="(false &bool;)"
        diversify="(true &bool;)" incl_nonopt="(false &bool;)"
        filter="(true_filter &string;)"
        sample_type="(low &choices_for_sample_types;)"
        filter_delta="(0.0 &real;)"
        task_operations="(&task_operation_comma_separated_list;)"
        packer_palette="(&named_packer_palette;)" scorefxn="(&string;)" >
    <Filters >
        <AND filter_name="(&string;)" sample_type="(low &choices_for_sample_types;)"
                filter_delta="(0.0 &real;)" />
    </Filters>
    <Filter filter="(true_filter &string;)"
            sample_type="(low &choices_for_sample_types;)"
            filter_delta="(0.0 &real;)" />
</GreedyOptMutationMover>
```

-   **relax_mover**: A mover for post-repacking relaxation (e.g. minimization)
-   **dump_pdb**: If you want to see a pdb of every trial mutation, add 'dump_pdb=1'.
-   **dump_table**: If true, will save to a file the table of amino acids/filter values over which it is operating.
-   **parallel**: Run the point mutation calculator in parallel, use in conjunction with openMPI.
-   **stopping_condition**: Stops before trials are done if a filter evaluates to true (accepting the last mutation that caused the filter to evaluate to true by default. See stop_before_condition to change this behavior).
-   **design_shell**: Default is set to -1, so there is no design. Set a positive value to determine the radius of design shell. This might be useful in case of reversion to native where more than one mutation is needed to revert.
-   **repack_shell**: The radius around which we repack around each tested/designed mutation.
-   **stop_before_condition**: Default = false. Stop mover once the stopping_condition is reached and do not accept the last mutation (ie, reject the mutation that set the stopping_condition to true).
-   **skip_best_check**: Default = false. Accept mutations during the combining stage as long as they pass the filter(s), regardless of whether or not the value is the best so far.
-   **rtmin**: Do rtmin following repack.
-   **shuffle_order**: Randomize sequence position order of mutations.
-   **diversify**: Diversify solutions to pareto front calculation.
-   **incl_nonopt**: Default = false. Use with filter_delta. This option modifies filter_delta behavior such that all mutations that score within N filter points of the best are attempted in the combinatorial design stage.
-   **filter**: Name of a single filter you wish you process.
-   **sample_type**: If your filter values are such that higher = better, use 'sample_type=high'
-   **filter_delta**: Add sequence diversity; useful with nstruct greater than 1; randomly try any mutation that scores wit     hin N filter points of the best-scoring mutation at each position instead of just the first, e.g. filter_delta=0.5 for attempting any mutation within 0.5 filter points of the best one.
-   **task_operations**: A comma-separated list of TaskOperations to use.
-   **packer_palette**: A previously-defined PackerPalette to use, which specifies the set of residue types with which to design (to be pruned with TaskOperations).
-   **scorefxn**: Name of score function to use


Subtag **Filters**:   These are the names of the filters being input into GreedyOptMutationMover.



Subtag **AND**:   

-   **filter_name**: (REQUIRED) Name of the filter you want to apply. Load multiple filters from branch tags.
-   **sample_type**: If your filter values are such that higher = better, use 'sample_type=high'
-   **filter_delta**: Add sequence diversity; useful with nstruct greater than 1; randomly try any mutation that scores within N filter points of the best-scoring mutation at each position instead of just the first, e.g. filter_delta=0.5 for attempting any mutation within 0.5 filter points of the best one.

Subtag **Filter**:   These are the attributes of a single filter being optimized.

-   **filter**: Name of a single filter you wish you process.
-   **sample_type**: If your filter values are such that higher = better, use 'sample_type=high'
-   **filter_delta**: Add sequence diversity; useful with nstruct greater than 1; randomly try any mutation that scores wit     hin N filter points of the best-scoring mutation at each position instead of just the first, e.g. filter_delta=0.5 for attempting any mutation within 0.5 filter points of the best one.

---
