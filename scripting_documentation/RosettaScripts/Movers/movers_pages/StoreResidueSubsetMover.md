# StoreResidueSubset
*Back to [[Mover|Movers-RosettaScripts]] page.*
## StoreResidueSubset

Creates a residue subset by applying the user-specified residue selector to the current pose and saves the subset in the pose's cacheable data, allowing the subset to be accessed (unchanged) at a later point in the protocol. Must be used in conjunction with the StoredResidueSubset residue selector.

    <StoreResidueSubset name="(&string)" subset_name="(&string)" residue_selector="(&string)" overwrite="(0 &bool)" />

-   subset\_name - The name the residue subset will be saved as in the pose's cacheable data. Must be identical to the subset\_name used to retrieve the task using the StoredResidueSubset task operation.
-   residue\_selector - The residue selector used to create the stored residue subset
-   overwrite - If set to true, will overwrite an existing subset with the same subset\_name if one exists. If false, Rosetta will exit with an error if the existing subset is overwritten.

**Example**

    <RESIDUE_SELECTORS>
      <!-- Creates a subset consisting of whatever is currently chain B -->
      <Chain name="chainb" chains="B" />

      <!-- Retrieves the residue subset created by the "StoreResidueSubset" mover -->
      <StoredResidueSubset name="get_original_chain_b" subset_name="original_chain_b" />
    </RESIDUE_SELECTORS>
    <MOVERS>
      <!-- stores a subset consisting of whatever is in chain B when this mover is called -->
      <StoreResidueSubset name="store_subset" residue_selector="chainb" subset_name="original_chain_b" />
    </MOVERS>

##See Also

* [[StoreTaskMover]]
* [[StoreCompoundTaskMover]]
* [[Task operations in RosettaScripts|TaskOperations-RosettaScripts]]
* [[TaskAwareCstsMover]]
* [[TaskAwareMinMOver]]
* [[TaskAwareSymMinMover]]
