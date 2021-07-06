# DesignRestrictions
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*

###Purpose:

The DesignRestrictions task operation exists to allow concise, fine-grained control of selection. Before the DesignRestrictions TO, the LayerDesign task operation was often used to say "I want ABC AAs at surface residues and DEF AAs at buried residues and GHI AAs at intermediat residues" but when you wanted to combine LayerDesign with some other task, such as 1-sided interface design, suddenly things became very difficult. What if buried position X on the fixed side of the interface was a "B" AA but that LayerDesign had only allowed "DEF" at buried positions? Combine LayerDesign's restriction to "DEF" with RestrictToRepacking's restriction of "Nothing except for B" and you end up with an empty set of allowed amino acids. Instead of repacking residue X, residue X will be held fixed. That's not what you want!

The DesignRestrictions TO allows you to say "restrict to AAs ABC on surface residues of chain A" in a relatively concise manner.

###Description:

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

####Example 1

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

####Example 2

Say you wanted to keep the first 10 amino acids fixed and then use regular layer-design-like operations on the rest of the monomer you're designing.

Here's an example of what NOT to do:

```
 <ROSETTASCRIPTS>
    <SCOREFXNS>
        <ScoreFunction name="sfxn" weights="beta_nov16" />
    </SCOREFXNS>
    <RESIDUE_SELECTORS>
        <Layer name="surface" select_core="false" select_boundary="false" select_surface="true" use_sidechain_neighbors="true"/>
        <Layer name="boundary" select_core="false" select_boundary="true" select_surface="false" use_sidechain_neighbors="true"/>
        <Layer name="core" select_core="true" select_boundary="false" select_surface="false" use_sidechain_neighbors="true"/>

        <Index name="first_10" resnums="1-10" />
    </RESIDUE_SELECTORS>
    <TASKOPERATIONS>

        CAUTION: THIS IS A "WHAT **NOT** TO DO" EXAMPLE.
        CAUTION: DO NOT COPY AND PASTE IT INTO YOUR XML FILE      
        <DesignRestrictions name="do_not_use_this_desrest">
            <Action selector_logic="surface"  aas="R"/>
            <Action selector_logic="boundary" aas="N"/>
            <Action selector_logic="core"     aas="V"/>
        </DesignRestrictions>

        <OperateOnResidueSubset name="restrict_first10_to_repacking" selector="first_10">
            <RestrictToRepackingRLT/>
        </OperateOnResidueSubset>
    </TASKOPERATIONS>
    <MOVERS>
        <FastDesign name="FastDesign" scorefxn="sfxn" task_operations="do_not_use_this_desrest,restrict_first10_to_repacking"/>
    </MOVERS>
    <PROTOCOLS>
        <Add mover="FastDesign" />
    </PROTOCOLS>
    <OUTPUT />
</ROSETTASCRIPTS>
'''

The above script will not produce the intended behavior. The first ten residues will not be allowed to repack unless their native AA happens to be in the set of allowed amino acids. Let's imagine the first 10 residues are all Lysines (K). Then regardless of whether they are exposed, intermediate, or buried, they will have two restrictive operations placed on them: one to eliminate all AAs except K, and a second to eliminate all AAs except either R, N, or V depending on their burial level. The intersection of {K} and {R}, e.g., is the empty set. So there will be no allowed amino acids at that position. This is equivalent to disabling all packing at that position. These first 10 residues will be held completely fixed while packing takes place around them.

So the proper way to handle this is to include the "first_10" residue selector into the DesignRestrictions TO operations:

```
        <Index name="first_10" resnums="1-10" />
    </RESIDUE_SELECTORS>
    <TASKOPERATIONS>        
        <DesignRestrictions name="coreV_boundN_surfaceR">
            <Action selector_logic="surface AND ! first_10"  aas="R"/>
            <Action selector_logic="boundary AND ! first_10" aas="N"/>
            <Action selector_logic="core AND ! first_10"     aas="V"/>
        </DesignRestrictions>
```


##See Also

* [[LayerDesign|LayerDesignOperation]]: Specify design identity based on secondary structure and burial.
