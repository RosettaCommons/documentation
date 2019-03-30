# DesignRestrictions
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*

Concise way to combine residue selectors and residue-level task operations. The Action subtags allow you to specify several modifications to a packer task simultaneously. Using the 'selector_logic' attribute, you can combine as many previously-defined ResidueSelectors as you would like using AND, OR, ! (not), and parentheses or you can choose a particular, previously defined ResidueSelector using the 'residue_selector' attribute. One of the two must be provided. Then you may specify the set of canonical amino acids you'd like to restrict the indicated set of residues using the 'aas' attribute and/or by listing a set of previously-declared [[ResidueLevelTaskOperations|RosettaScripts#rosettascript-sections_residue_level_task_operations]].

```xml
<DesignRestrictions name="(&string;)" >
    <Action residue_selector="(&string;)" selector_logic="(&string;)"
            aas="(&string;)" residue_level_operations="(&string;)" />
</DesignRestrictions>
```

Subtag **Action**:   

-   **residue_selector**: The name of the already defined ResidueSelector that will be used by this object
-   **selector_logic**: Logically combine already-delcared ResidueSelectors using boolean AND, OR, and ! (not) operators. As convnetional, ! (not) has the highest precedence, then AND, then OR. Parentheses may be used to group operations together.
-   **aas**: A list of the canonical L amino acids that are to be allowed for the selected residues. Either upper or lower case letters are accepted. Note that if an amino acid is allowed for a residue that is selected by one action, but disallowed for that residue selected by a second action, the amino acid will not be allowed.
-   **residue_level_operations**: A comma-separated list of residue-level-task operations that will be retrieved from the DataMap.


##Example

Here is an example that performs LayerDesign on the protein surface, repacks the boundary, and disallows packing the the core. 

```xml
<RESIDUE_SELECTORS>
	<Layer name="surface" select_core="false" select_boundary="false" select_surface="true" use_sidechain_neighbors="true"/>
	<Layer name="boundary" select_core="false" select_boundary="true" select_surface="false" use_sidechain_neighbors="true"/>
	<Layer name="core" select_core="true" select_boundary="false" select_surface="false" use_sidechain_neighbors="true"/>
	<SecondaryStructure name="sheet" overlap="0" minH="3" minE="2" include_terminal_loops="false" use_dssp="true" ss="E"/>
	<SecondaryStructure name="entire_loop" overlap="0" minH="3" minE="2" include_terminal_loops="true" use_dssp="true" ss="L"/>
	<SecondaryStructure name="entire_helix" overlap="0" minH="3" minE="2" include_terminal_loops="false" use_dssp="true" ss="H"/>
	<And name="helix_cap" selectors="entire_loop">
		<PrimarySequenceNeighborhood lower="1" upper="0" selector="entire_helix"/>
	</And>
	<And name="helix_start" selectors="entire_helix">
		<PrimarySequenceNeighborhood lower="0" upper="1" selector="helix_cap"/>
	</And>
	<And name="helix" selectors="entire_helix">
		<Not selector="helix_start"/>
	</And>
	<And name="loop" selectors="entire_loop">
		<Not selector="helix_cap"/>
	</And>
</RESIDUE_SELECTORS>

<RESIDUE_LEVEL_TASK_OPERATIONS>
        <PreventRepackingRLT name="PreventRepacking" />
        <RestrictToRepackingRLT name="RestrictToRepacking" />
</RESIDUE_LEVEL_TASK_OPERATIONS>

<TASKOPERATIONS>
	<DesignRestrictions name="design_task">
		<Action selector_logic="surface AND helix_start"	aas="EHKPQR"/>
		<Action selector_logic="surface AND helix"		aas="EHKQR"/>
		<Action selector_logic="surface AND sheet"		aas="DEHKNQRST"/>
		<Action selector_logic="surface AND loop"		aas="DEGHKNPQRST"/>
		<Action residue_selector="boundary"			residue_level_operations="RestrictToRepacking"/>
		<Action residue_selector="core"				residue_level_operations="PreventRepacking"/>
		<Action residue_selector="helix_cap"			aas="DNST"/>
	</DesignRestrictions>
</TASKOPERATIONS>

```


##See Also

* [[LayerDesign|LayerDesignOperation]]: Specify design identity based on secondary structure and burial.
