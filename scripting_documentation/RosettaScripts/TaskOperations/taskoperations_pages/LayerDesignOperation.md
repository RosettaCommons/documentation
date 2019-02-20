# LayerDesign
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*

_Note that as of January 2019, LayerDesign no longer supports noncanonical design.  For noncanonical design, please use the [[Layer|ResidueSelectors#residueselectors_conformation-dependent-residue-selectors_layerselector]] ResidueSelector._

_Also note that we plan to deprecate LayerDesign outright before long.  Please update your scripts to use the [[Layer|ResidueSelectors#residueselectors_conformation-dependent-residue-selectors_layerselector]] ResidueSelector instead._

Layer design is used to control which amino acids are available for design at each residue position depending on the local context, _e_._g_. solvent exposure and secondary structure. Each residue is assigned to one of three layers: core, boundary, or surface.  The two methods of determining solvent accessibility are: SASA (solvent accessible surface area of mainchain + CB) and side chain neighbors (number of amino acid side chains in a cone extending along the CA-CB vector).  When using SASA, the solvent exposure of the designed position depends on the conformation of neighboring side chains; this is useful when you are making one or two mutations and not changing many neighboring amino acids.  When using side chain neighbors, solvent exposure depends on which direction the amino acid side chain is pointed; this is useful for _de novo_ design or protocols where many amino acids will be designed simultaneously.

In essence, layer design is a hack to prevent the packer from putting too many hydrophobic amino acids on the protein's surface and too many polar residues in the protein's interior.  Improvements to the energy function will  one day obviate the need for layer design.

**Note: The LayerDesign TaskOperation will be deprecated in the future**.  Legacy LayerDesign breaks commutativity, and this leads to opaque and often troublesome behavior.  Instead, we recommend using the [[LayerSelector|ResidueSelectors#residueselectors_conformation-dependent-residue-selectors_layerselector]] ResidueSelector and [[DesignRestrictions|DesignRestrictionsOperation]] TaskOperation. Control over which regions of the pose are to be designed/packed should be performed using an [[OperateOnResidueSubset|OperateOnResidueSubsetOperation]] TaskOperation.
* The documentation for legacy LayerDesign can still be accessed at the bottom of this page.

##LayerDesign

Here is an example implementation of LayerDesign using LayerSelector and DesignRestrictions. 

```xml
<RESIDUE_SELECTORS>

	<!-- Layer Design -->
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

<TASKOPERATIONS>

	<DesignRestrictions name="layer_design">
		<Action selector_logic="surface AND helix_start"	aas="DEHKPQR"/>
		<Action selector_logic="surface AND helix"		aas="EHKQR"/>
		<Action selector_logic="surface AND sheet"		aas="EHKNQRST"/>
		<Action selector_logic="surface AND loop"		aas="DEGHKNPQRST"/>
		<Action selector_logic="boundary AND helix_start"	aas="ADEHIKLMNPQRSTVWY"/>
		<Action selector_logic="boundary AND helix"		aas="ADEHIKLMNQRSTVWY"/>
		<Action selector_logic="boundary AND sheet"		aas="DEFHIKLMNQRSTVWY"/>
		<Action selector_logic="boundary AND loop"		aas="ADEFGHIKLMNPQRSTVWY"/>
		<Action selector_logic="core AND helix_start"		aas="AFILMPVWY"/>
		<Action selector_logic="core AND helix"			aas="AFILMVWY"/>
		<Action selector_logic="core AND sheet"			aas="FILMVWY"/>
		<Action selector_logic="core AND loop"			aas="AFGILMPVWY"/>
		<Action selector_logic="helix_cap"			aas="DNST"/>
	</DesignRestrictions>

</TASKOPERATIONS>

```

**differences from legacy LayerDesign in the example above**
* If the first residue of a chain is in a helix, the helix_cap selection won't work, so proline won't be available at the helix_start residue position (it will be assigned to the helix selection instead)
* minH="3" minE="2" are used in the secondary structure selections to make design more robust to weird loop conformations. Legacy LayerDesign behavior would be: minH="1" minE="1"
* Methionine is allowed in the boundary and core
* Glycine is allowed in loops in the core
* Histidine is allowed in the boundary
* Asp, Asn, Ser, and Thr are not included at surface positions of helices (except for helix start). [These residues have a destabilizing effect on proteins when included helices](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5568797/), and it seems unlikely that a structure would require one of these particular amino acids at a surface position (they're still allowed at boundary positions in helices)
* Asp is not included at surface positions of beta sheets.  [This residue has a destabilizing effect on proteins when included in beta sheets](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5568797/), and it seems unlikely that a structure would require this particular amino acid at a surface position.


##Legacy LayerDesign

While not recommended, users can still use the original LayerDesign task operation.

Additional layers can be defined in the xml file by passing another taskoperation to get the residue selection. Only the residues that are marked as designable in the packer task are taken into consideration, any information about the available amino acids/rotamers selected by the taskoperation are not going to be considered. The amino acids to be used in each of this new layers has to be specified in the xml. Several taskoperations can be combined to the intersection between the different sets of designable residues.

LayerDesign, like all TaskOperations, obeys commutivity: the effect of applying another TaskOperation before LayerDesign is the same as the effect of applying it after LayerDesign.  However, residues defined by PIKAA, NATAA, or NATRO operations in a resfile are often "special" residues that one would like to leave alone.  The <b>ignore_pikaa_natro=true</b> option allows this, at the expense of breaking commutivity.  If the user uses this option, and if a resfile is read before calling LayerDesign, the LayerDesign operation is not applied for the residues defined by PIKAA, NATAA or NATRO in the resfile.

Note that this task is ligand compatible.  However, the user should set the ligand to be repackable but not designable with another TaskOperation.

        <LayerDesign name="(&string layer)" layer="(&string core_boundary_surface)" pore_radius="(&real 2.0)" core="(&real 20.0)" surface="(&real 40.0)" ignore_pikaa_natro="(&bool 0)" repack_non_design="(&bool 1)" make_rasmol_script="(&bool 0)" make_pymol_script="(&bool 0)" use_sidechain_neighbors="(&bool 0)" use_symmetry="(&bool 1)" sc_neighbor_dist_midpoint="(9.0 &Real)" sc_neighbor_dist_exponent="(1.0 &Real)" sc_neighbor_angle_shift_factor="(0.5 &Real)" sc_neighbor_angle_exponent="(2.0 &Real)" sc_neighbor_denominator="(1.0 &Real)" >
            <ATaskOperation name="task1" >
                <all copy_layer="(&string layer)" append="(&string)" exclude="(&string)"  specification="(&string 'designable')"  operation="(&string 'design')" />
                <SecStructType aas="(&string)" append(&string) exclude="(&string)" />            
            </ATaskOperation >
        </LayerDesign>

Option list

-   layer ( default "core\_boundary\_surface\_other" ) : layer to be designed, other ex. core\_surface means only design core and surface layer, other refers to the additional layers defined with packertasks
-   use\_original\_non\_designed\_layer ( default, 0 ) : restrict to repacking the non design layers
-   pore\_radius ( default 2.0) : pore radius for calculating accessible surface area
-   core ( default 20.0) : residues of which asa is \< core are defined as core
-   surface ( default 40.0) : residues of which asa is \> surface are defined as surface
-   (layer)\_(ss): set up the asa threshold for a specific secondary structure element in a particular layer. For example surface\_E=30 makes that for strand residues the asa cutoff is 30 instead of the one defined by surface.
-   ignore\_pikaa\_natro: if true, and if a resfile is read before applying this TaskOperation, ignore any residues that have been set in the resfile with the PIKAA, NATRO, or NATAA commands.
-   make\_rasmol\_script: if true, write a rasmol script coloring the residues by the three basic layers, core, boundary and surface.
-   make\_pymol\_script: if true, write a pymol script coloring the residues by the three basic layer and the aditional taskoperation defined layers..
-   repack\_non\_design: if true, side chains will be repacked, left untouched if otherwise.
-   use\_sidechain\_neighbors: if true, assign a residue's layers based on counting the number CA atoms from other residues within a cone in front of the residue's ca-cb vector.  Because this option is no longer SASA based, the layer assignments will always be identical regardless of the protein sequence; i.e. layers could be assigned based on a polyalanine backbone and it would make no difference.  This option changes the defaults for core and surface to neighbors < 2 (surface) and neighbors > 5.2 (core).  HOWEVER, these defaults will be overwritten if core and surface are manually specified in declaring the taskoperation!  So make sure you do not specify new core and surface settings appropriate for SASA when you are actually counting neighboring residues.
-   sc_neighbor_dist_midpoint, sc_neighbor_dist_exponent, sc_neighbor_angle_shift_factor, sc_neighbor_angle_exponent, sc_neighbor_denominator: These values fine-tune the behavior of the sidechain neighbors residue-counting logic.  Typically, a user need not change these from default values.  For details on these, see the [[LayerSelector|ResidueSelectors#residueselectors_conformation-dependent-residue-selectors_layerselector]] ResidueSelector's documentation.

TaskOperations can be combined together using the CombinedTasks tag, the nested tasks don't need to be named, just declared with type and parameters.

        <CombinedTasks name=combined_task>
             <ATaskOperation />
             <AnotherTaskOperation />
        </CombinedTasks>

_**Currently Deprecated, new syntax for residue assignment coming soon! **_
After you combined tasks you need to assign residues, you can use the 'all' tag to assign residues for all the different secondary structure elements.

        <combined_task>
            <all copy_layer="(&string)" append="(&string)" exclude="(&string)"  specification="(&string 'designable')"  operation="(&string 'design')"/>
        </combined_task>

The options for the "all" tag are the following:

-   copy\_layer: layer from where to copy the residues definition, can be core, boundary, surface or a task defined layer.
-   aa: assign the following residues to the defined layer.  The string is composed of one-letter amino acid codes.
-   append: append the following residues to the defined layer (i.e. add them to any already allowed in this layer).  The string is composed of one-letter amino acid codes.
-   exclude: opposite as append (delete residues from the list allowed for the layer).
-   specification: What residues from the task operation should be considered as the layer. Options are "designable" (pick designable residues), "repacakble" (pick residues restricted to only repack) or "fixed" (residues marked by the task as not repackable). Default is "designable"
-   operation: What to do with the specified layer. Default is 'design', other options are 'no\_design' (allow repacking) and 'omit'.  If 'omit' is chosen, layer design will ignore any residues in the layer (i.e. not restrict design).

After an all operation other definitions can be performed, for example:

        <combined_task>
            <all copy_layer=surface/>
            <Strand append="F"/>
        </combine_task>

copies the layer definition from surface and adds Phe to the available residue types only to the residues on the strands.

Below are the selected amino acid types for each layer, this can be overwritten in the xml:

core

-   Loop: AFILPVWY
-   Strand: FIL VWY
-   Helix: AFIL VWY ( P only at the beginning of helix )
-   HelixCapping: DNST

boundary

-   Loop: ADEFGIKLNPQRSTVWY
-   Strand: DEF IKLN QRSTVWY
-   Helix: ADE IKLN QRSTVWY ( P only at the beginning of helix )
-   HelixCapping: DNST

surface

-   Loop: DEGHKNPQRST
-   Strand: DE HKN QRST
-   Helix: DE HKN QRST ( P only at the beginning of helix )
-   HelixCapping: DNST

Nterm

-   all: ACDEFGHIKLMNPQRSTVWY

Cterm

-   all: ACDEFGHIKLMNPQRSTVWY

<!-- -->

     This example creates a new layer that combines BuildingBlockInterface(symmetric interface with SelectBySasa picking up the core of the complex
     since applying task operations returns the intersection of the sets this combined task will return the buried residues of the symmetric  interface.

```xml
    <LayerDesign name=layer layer=other >

        <CombinedTasks name=symmetric_interface_core>
            <BuildingBlockInterface  />
            <SelectBySASA state=bound core=1 />
        </CombinedTasks>

         assign to the new layer for the interface core the same residues as for the surface and append for all possible secondary structures , append  phe and a leu to all ss types.

        <symmetric_interface_core>
            <all copy_layer=surface append="FL"/>
        </symmetric_interface_core>

    </LayerDesign>
```

## LayerDesign with Symmetry

In its original implementation, LayerDesign could only work with symmetry if it were passed a symmetry-compatible TaskOperation (e.g. SelectBySASA, used in the example above).  More recently, the ```use_symmetry``` option has been added to permit LayerDesign to be symmetry-aware.  If ```use_symmetry``` is set to true (the default), layers are defined for symmetric poses using the full, symmetric pose.  If ```use_symmetry``` is set to false, then the old behaviour is preserved: the asymmetric unit is extracted and used in isolation to set up layers.  Here is a very simple example in which LayerDesign is used to force valine in the core, alanine in the boundary layer, and serine at the surface for a symmetric pose, explicitly considering neighbours that might be in other asymmetric units in the symmetric pose.

```xml
<LayerDesign name=layerdes layer=core_boundary_surface use_sidechain_neighbors=true core=2 surface=1 use_symmetry=true >
    <core>
        <all aa="V" />
    </core>
    <boundary>
        <all aa="A" />
    </boundary>
    <surface>
        <all aa="S" />
    </surface>
</LayerDesign>
```




##See Also

* [[Design applications|Design-applications]]: Various methods for doing design in Rosetta
* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta
