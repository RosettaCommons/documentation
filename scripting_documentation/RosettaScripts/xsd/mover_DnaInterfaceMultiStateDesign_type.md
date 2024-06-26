<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Performs multistate design on DNA interfaces

```xml
<DnaInterfaceMultiStateDesign name="(&string;)"
        generations="(&non_negative_integer;)"
        pop_size="(&non_negative_integer;)" num_packs="(&non_negative_integer;)"
        pop_from_ss="(&non_negative_integer;)"
        numresults="(&non_negative_integer;)"
        fraction_by_recombination="(&real;)" mutate_rate="(&real;)"
        boltz_temp="(&real;)" anchor_offset="(&real;)"
        checkpoint_prefix="(&string;)"
        checkpoint_interval="(&non_negative_integer;)" checkpoint_gz="(&bool;)"
        checkpoint_rename="(&bool;)" scorefxn="(&string;)"
        task_operations="(&task_operation_comma_separated_list;)"
        packer_palette="(&named_packer_palette;)" />
```

-   **generations**: Number of generations for the genetic algorithm to evolve
-   **pop_size**: number of sequences per generation
-   **num_packs**: number of times to call the simulated annealer to find the best rotamer configuration for a given sequence
-   **pop_from_ss**: number of sequences to include in the initial population that are created by mutation of the sequence determined by full redesign
-   **numresults**: number of sequences to output structures for, starting with the lowest scoring sequence
-   **fraction_by_recombination**: fraction of sequences to generate by recombination of sequences from the previous generation
-   **mutate_rate**: probability of randomizing each residue when a sequence is mutated
-   **boltz_temp**: Temperature for Metropolis criterion
-   **anchor_offset**: Anchor offset for multistate packer aggregate function
-   **checkpoint_prefix**: prefix to add to the beginning of checkpoint file names
-   **checkpoint_interval**: frequency in number of sequences scored with which the checkpoint files are written
-   **checkpoint_gz**: compress the checkpoint files with gzip
-   **checkpoint_rename**: rename checkpoint files after the genetic algorithm completes, so that subsequent runs generate new output
-   **scorefxn**: Name of score function to use
-   **task_operations**: A comma-separated list of TaskOperations to use.
-   **packer_palette**: A previously-defined PackerPalette to use, which specifies the set of residue types with which to design (to be pruned with TaskOperations).

---
