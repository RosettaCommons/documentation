# AtomicContactCount
*Back to [[Filters|Filters-RosettaScripts]] page.*
## AtomicContactCount

Counts sidechain carbon-carbon contacts among the specified residues under the given distance cutoff.

Iterates across all side-chain atoms of residues specified as packable in the given task operation, defaulting to all residues if no task operation is given, counting carbon-carbon pairs. Optionally restricts count to cross-jump contacts or cross-chain contacts. Optionally normalizes contact count by cross-jump or cross-chain interface sasa.

Operates in three modes:

-   'all' - Counts all side-chain carbon-carbon contacts among residues specified in the task operation.

<!-- -->

       <AtomicContactCount name="(&string)" partition="all" task_operations="(comma-delimited list of operations &string)"  distance="(4.5 &integer)"/>

-   'jump' - Counts all side-chain carbon-carbon contacts spanning the specified jump among the specified residues. Normalize-by-sasa calculates sasa score using the specified jump and the sasa filter.

<!-- -->

        <AtomicContactCount name="(&string)" partition="jump" task_operations="(comma-delimited list of operations &string)"  distance="(4.5 &integer)" jump="(1 &integer)" normalize_by_sasa="(0 &bool)"/>

-   'chain' - Counts all side-chain carbon-carbon contacts between residues on different chains among the specified residues. Normalize-by-sasa defaults to all calculating sasa for all chains in the pose, optional 'detect\_by\_task' only calculates interface sasa among chains containing residues specified in the task. May under-calculate sasa if the task operation unexpectedly excludes all residues within a chain.

<!-- -->

       <AtomicContactCount name="(&string)" partition="chain" task_operations="(comma-delimited list of operations &string)"  distance="(4.5 &integer)" normalize_by_sasa="(0*|detect_by_task|1 &str)"/>

Example:

To count atomic contacts between aromatic and apolar residues, an OperateOnCertainResidues task operation to select aromatic and apolar residues is passed to the AtomicContactCount filter.

       <TASKOPERATIONS>
         <OperateOnCertainResidues name="aromatic_apolar">
           <NoResFilter>
             <ResidueType aromatic="1" apolar="1"/>
           </NoResFilter>
           <PreventRepackingRLT/>
         </OperateOnCertainResidues>
       </TASKOPERATIONS>
       ....
       <FILTERS>
         <AtomicContactCount name="cc_jump" partition="jump" jump="1" normalize_by_sasa="0" task_operations="aromatic_apolar" confidence="0"/>
         <AtomicContactCount name="cc_jump_norm" partition="jump" jump="1" normalize_by_sasa="1" task_operations="aromatic_apolar" confidence="0"/>
       </FILTERS>
       ...
       <PROTOCOLS>
         <Add filter_name="cc_jump"/>
         <Add filter_name="cc_jump_norm"/>
       </PROTOCOLS>

Additinal options:

* non_local: Detect only non-local contacts, i.e., sequence distance more than 2. Positions in separate chains are automatically considered non-local.
* res_contact: Only count one atom contact per residue. This option ignores normalize_by_sasa and normalize_by_carbon_count.
* count_SD_NE1: In addition to carbon atoms, count methionine SD and tryptophan NE1.

To obtain the same behavior as the "hphob_sc_contacts" metric published in "Global analysis of protein folding using massively parallel design, synthesis, and testing" (Science, 2017) keep defaults, except for: distance=4.3, non_local=True, res_contact=True, count_SD_NE1=True, and make only hydrophobic amino-acids (FILMVYW) packable.

## See Also

* [[AtomicContactFilter]]
* [[AtomicDistanceFilter]]
* [[ResidueCountFilter]]
* [[ResidueDistanceFilter]]
* [[PlaceSimultaneouslyMover]]

