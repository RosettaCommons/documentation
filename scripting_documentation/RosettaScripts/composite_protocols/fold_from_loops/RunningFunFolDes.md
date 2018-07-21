# Running FunFolDes
This entry list the main requirements to execute a simple **FunFolDes** run.

# Problem setup
Let's assume that we have:
* `template.pdb`: A PDB that contains our **template**.
* `motif.pdb`: A PDB that contains our **motif**.

And we know:
* We will use chain `A` from `template.pdb` as our actual **template**.
* We will select as our `insert_point` into the **template** the segment: `50A-65A`.
* We will define our **motif** as `30B-45B` from `motif.pdb`.
* We will consider chain `A` from `motif.pdb` as a binder to our motif.

Finally, we'll need a `vall` database in order to be able to create the fragments.

# Making the script
## ResidueSelectors
To properly run **FunFolDes**, one needs to add the ResidueSelectors to pick each of the working labels and guide the non-fixed parts of the process. The following ones are the ones needed to generate the **FLL**-standard behaviour, and one can more or less consider that they should always be added:
```xml
<RESIDUE_SELECTORS>
  <ResiduePDBInfoHasLabel name="MOTIF"     property="MOTIF" />
  <Not                    name="!MOTIF"    selector="MOTIF" />
  <ResiduePDBInfoHasLabel name="TEMPLATE"  property="TEMPLATE" />
  <Not                    name="!TEMPLATE" selector="TEMPLATE" />
  <ResiduePDBInfoHasLabel name="CONTEXT"   property="CONTEXT" />
  <Not                    name="!CONTEXT"  selector="CONTEXT" />
  <ResiduePDBInfoHasLabel name="FLEXIBLE"  property="FLEXIBLE" />
  <Not                    name="!FLEXIBLE" selector="FLEXIBLE" />
  <ResiduePDBInfoHasLabel name="HOTSPOT"   property="HOTSPOT" />
  <Not                    name="!HOTSPOT"  selector="HOTSPOT" />
  <ResiduePDBInfoHasLabel name="COLDSPOT"  property="COLDSPOT" />
  <Not                    name="!COLDSPOT" selector="COLDSPOT" />
  
  # can design
  <Or name="COLDSPOT_OR_TEMPLATE"              selectors="COLDSPOT,TEMPLATE" />
  # bb movement
  <Or name="FLEXIBLE_OR_TEMPLATE"              selectors="FLEXIBLE,TEMPLATE" />
  # chi movement
  <Or name="COLDSPOT_OR_FLEXIBLE_OR_TEMPLATE"  selectors="COLDSPOT,FLEXIBLE,TEMPLATE" />
  # prevent repacking and design
  <Or name="HOTSPOT_OR_CONTEXT"                selectors="HOTSPOT,CONTEXT" /> 
  <And name="HOTSPOT_OR_CONTEXT_AND_!FLEXIBLE" selectors="HOTSPOT_OR_CONTEXT,!FLEXIBLE" />
  # no design
  <And name="FLEXIBLE_AND_!COLDSPOT"           selectors="FLEXIBLE,!COLDSPOT" />
```
And we also need to add the specific selectors for our exercise. Be aware that the `design` _ChainResidueSelector_  is setup to `B`. This is due to the fact that designs pull their chainID from the chainID of the **motif**. This way, there can be no repetition of the identifier if the binder is added.
```xml
  <Chain name="template" chains="A" />
  <Index name="insert" resnums="50A-65A" />
  <Index name="motif" resnums="30B-45B" />
  <Chain name="binder" chains="A" />
  <Chain name="design" chains="B" />
</RESIDUE_SELECTORS>
```

## TaskOperations
There are 3 main TaskOperations needed for **FunFolDes**; the one that defines _static-non designable_ residues (`FFLMOTIF_TASKOP`); the one that defines _packable-non-designable_ residues (`FFLFLEX_TASKOP`) and the one that defines _bbflex-designable_ residues (`FFLTEMPLATE_TASKOP`)
```xml
<TASKOPERATIONS>
  <OperateOnResidueSubset name="FFLMOTIF_TASKOP" selector="HOTSPOT_OR_CONTEXT_AND_!FLEXIBLE" >
    <PreventRepackingRLT/>
  </OperateOnResidueSubset>
  <OperateOnResidueSubset name="FFLFLEX_TASKOP" selector="FLEXIBLE_AND_!COLDSPOT" >
    <RestrictToRepackingRLT/>
  </OperateOnResidueSubset>
  <OperateOnResidueSubset name="FFLTEMPLATE_TASKOP" selector="COLDSPOT_OR_TEMPLATE" >
    <DisallowIfNonnativeRLT disallow_aas="C" />
  </OperateOnResidueSubset>
</TASKOPERATIONS>
```

## MoveMapFactory
**MoveMapFactory** allows to generate MoveMaps on apply time through residue selectors. By defining this `FFLSTANDARD_MOVEMAP`, we can guide the non-fixed parts of the protocol so that they still behave as expected.
```xml
<MOVE_MAP_FACTORIES>
  <MoveMapFactory name="FFLSTANDARD_MOVEMAP" bb="false" chi="false" nu="false" branches="false" jumps="false" >
    <Backbone enable="true" residue_selector="FLEXIBLE_OR_TEMPLATE" />
    <Chi      enable="true" residue_selector="COLDSPOT_OR_FLEXIBLE_OR_TEMPLATE" />
  </MoveMapFactory>
</MOVE_MAP_FACTORIES>
```

## Movers
First of all, we will need to load/make the structural-based fragments:
```xml
<StructFragmentMover name="FragmentPicker" prefix="auto"
  vall_file="path/to/vall/database/vall.jul19.2011.gz" output_frag_files="1"
  small_frag_file="auto.200.3mers" large_frag_file="auto.200.9mers"
/>
```
This will create the fragments unless the fragment files exist, in which case they will just be loaded.
Take notice of the `prefix` attribute. This sets up the identifier of these fragments, as other fragments for other processes might also be added. 

Before folding our protein it is recommended to generate `atom_pair_constraints` to guide it. This can be very easily done:
```xml
<AddConstraints name="foldingCST" >
  <AtomPairConstraintGenerator name="atompairCST1" sd="1.5" ca_only="true"
    use_harmonic="true" unweighted="true" min_seq_sep="6" max_distance="40" residue_selector="template"
  />
</AddConstraints>
```
 
Now we can call [[NubInitio]]:
```xml
<NubInitioMover name="FunFolDes" fragments_id="auto" template_motif_selector="insert" >
  <Nub pose_file="motif.pdb" residue_selector="motif" binder_selector="binder" />
</NubInitioMover>
```
One could also first load the PDB file into a pose and then pass it as a `reference_pose`; something like:
```xml
<SavePoseMover name="readMotif" reference_name="motif_pose" pdb_file="motif.pdb" />
<NubInitioMover name="FunFolDes" fragments_id="auto" template_motif_selector="insert" >
  <Nub reference_name="motif_pose" residue_selector="motif" binder_selector="binder" />
</NubInitioMover>
```
There are some alternatives to the most basic call of [[NubInitio]].  
For example, let's say that one wants two residues on each side of the **motif** to be able to move, hopping for a better fit into the **template**, and one also considers that residues `2,4,6,8,13` (inside the motif count) are not in actual contact with the binder and, thus, they can be designed. One can target specific parameters of each segment in the **motif**:
```xml
<NubInitioMover name="FunFolDes" fragments_id="auto" template_motif_selector="insert" >
  <Nub pose_file="motif.pdb" residue_selector="motif" binder_selector="binder" >
    <Segment order="1" n_term_flex="2" c_term_flex="2" editable="2,4,6,8,13" />
  </Nub>
</NubInitioMover>
```

Once the folding is done, we can guide the design process with the previously defined MoveMap and TaskOperations:
```xml
<FastDesign name="DesignRelax" scorefxn="fullatom" clear_designable_residues="true"
  task_operations="FFLMOTIF_TASKOP,FFLFLEX_TASKOP,FFLTEMPLATE_TASKOP"
  repeats="3" delete_virtual_residues_after_FastRelax="true"
  movemap_factory="FFLSTANDARD_MOVEMAP" >
</FastDesign>
```

And last, we make sure that the structure is properly closed (this is unnecessary with only one inserted segment, but in those cases it will simply not do anything).
```xml
<NubInitioLoopClosureMover name="loopC" fragments_id="auto"
  break_side_ramp="true" design="true" fullatom_scorefxn="fullatom" />
```

## All together
In summary, let's put all together with some extra boilerplate, and a regular **FunFolDes** script without any special evaluation/filter or added design conditions will look like:

```xml
<ROSETTASCRIPTS>

  <SCOREFXNS>
    # A weight is added to small-range hbonds to favor helix, and beta pairing
    # and to take residue propensity into account. This way, we can favor
    # helix-forming residues in our designs.
    <ScoreFunction name="fullatom" weights="ref2015">
      <Reweight scoretype="atom_pair_constraint" weight="1.6" />
    </ScoreFunction>
  </SCOREFXNS>

  <RESIDUE_SELECTORS>
    <ResiduePDBInfoHasLabel name="MOTIF"     property="MOTIF" />
    <Not                    name="!MOTIF"    selector="MOTIF" />
    <ResiduePDBInfoHasLabel name="TEMPLATE"  property="TEMPLATE" />
    <Not                    name="!TEMPLATE" selector="TEMPLATE" />
    <ResiduePDBInfoHasLabel name="CONTEXT"   property="CONTEXT" />
    <Not                    name="!CONTEXT"  selector="CONTEXT" />
    <ResiduePDBInfoHasLabel name="FLEXIBLE"  property="FLEXIBLE" />
    <Not                    name="!FLEXIBLE" selector="FLEXIBLE" />
    <ResiduePDBInfoHasLabel name="HOTSPOT"   property="HOTSPOT" />
    <Not                    name="!HOTSPOT"  selector="HOTSPOT" />
    <ResiduePDBInfoHasLabel name="COLDSPOT"  property="COLDSPOT" />
    <Not                    name="!COLDSPOT" selector="COLDSPOT" />
  
    # can design
    <Or name="COLDSPOT_OR_TEMPLATE"              selectors="COLDSPOT,TEMPLATE" />
    # bb movement
    <Or name="FLEXIBLE_OR_TEMPLATE"              selectors="FLEXIBLE,TEMPLATE" />
    # chi movement
    <Or name="COLDSPOT_OR_FLEXIBLE_OR_TEMPLATE"  selectors="COLDSPOT,FLEXIBLE,TEMPLATE" />
    # prevent repacking and design
    <Or name="HOTSPOT_OR_CONTEXT"                selectors="HOTSPOT,CONTEXT" /> 
    <And name="HOTSPOT_OR_CONTEXT_AND_!FLEXIBLE" selectors="HOTSPOT_OR_CONTEXT,!FLEXIBLE" />
    # no design
    <And name="FLEXIBLE_AND_!COLDSPOT"           selectors="FLEXIBLE,!COLDSPOT" />

    <Chain name="template" chains="A" />
    <Index name="insert" resnums="50A-65A" />
    <Index name="motif" resnums="30B-45B" />
    <Chain name="binder" chains="A" />
    <Chain name="design" chains="B" />
  </RESIDUE_SELECTORS>
  <TASKOPERATIONS>
    <OperateOnResidueSubset name="FFLMOTIF_TASKOP" selector="HOTSPOT_OR_CONTEXT_AND_!FLEXIBLE" >
      <PreventRepackingRLT/>
    </OperateOnResidueSubset>
    <OperateOnResidueSubset name="FFLFLEX_TASKOP" selector="FLEXIBLE_AND_!COLDSPOT" >
      <RestrictToRepackingRLT/>
    </OperateOnResidueSubset>
    <OperateOnResidueSubset name="FFLTEMPLATE_TASKOP" selector="COLDSPOT_OR_TEMPLATE" >
      <DisallowIfNonnativeRLT disallow_aas="C" />
    </OperateOnResidueSubset>
  </TASKOPERATIONS>
  <MOVE_MAP_FACTORIES>
    <MoveMapFactory name="FFLSTANDARD_MOVEMAP" bb="false" chi="false" nu="false" branches="false" jumps="false" >
      <Backbone enable="true" residue_selector="FLEXIBLE_OR_TEMPLATE" />
      <Chi      enable="true" residue_selector="COLDSPOT_OR_FLEXIBLE_OR_TEMPLATE" />
    </MoveMapFactory>
  </MOVE_MAP_FACTORIES>
  <MOVERS>
    # ** SavePoseMover used like this does not need to be called during PROTOCOL to work.
    <SavePoseMover name="readMotif" reference_name="motif_pose" pdb_file="motif.pdb" />

    ## PREPROCESSING: MAKING FRAGMENTS
    <StructFragmentMover name="makeFrags" prefix="T12"
      small_frag_file="%%pdb%%.%%frags%%.200.3mers" large_frag_file="%%pdb%%.%%frags%%.200.9mers"
    />

    ## PREPROCESSING: CONSTRAINTS
    <StructFragmentMover name="FragmentPicker" prefix="auto"
      vall_file="path/t/vall/database/vall.jul19.2011.gz" output_frag_files="1"
      small_frag_file="auto.200.3mers" large_frag_file="auto.200.9mers"
    />

    # MAIN: NUBINITIO FOLDING
    <NubInitioMover name="FunFolDes" fragments_id="auto" template_motif_selector="insert" >
      <Nub reference_name="motif_pose" residue_selector="motif" binder_selector="binder" />
    </NubInitioMover>

    # POSTPROCESSING: CONSTRAINTS
    <AddConstraints name="designCST" >
      <AtomPairConstraintGenerator name="atompairCST2" sd="1" ca_only="true"
        use_harmonic="true" unweighted="true" min_seq_sep="6" max_distance="40" residue_selector="design"
      />
    </AddConstraints>
    <ClearConstraintsMover name="clearCST" />

    # POSTPROCESSING: DESING
    <FastDesign name="DesignRelax" scorefxn="fullatom" clear_designable_residues="true"
      task_operations="FFLMOTIF_TASKOP,FFLFLEX_TASKOP,FFLTEMPLATE_TASKOP"
      repeats="3" delete_virtual_residues_after_FastRelax="true"
      movemap_factory="FFLSTANDARD_MOVEMAP" >
    </FastDesign>

    # POSTPROCESSING: LOOP CLOSURE
    <NubInitioLoopClosureMover name="loopC" fragments_id="auto"
      break_side_ramp="true" design="true" fullatom_scorefxn="fullatom" />
  </MOVERS>
  <PROTOCOLS>
    # PREPROCESSING
    <Add mover="makeFrags"   />
    <Add mover="foldingCST"  />
    # MAIN
    <Add mover="FunFolDes"  />
    <Add mover="clearCST"   />
    # POSTPROCESSING
    <Add mover="designCST"   />
    <Add mover="DesignRelax" />
    <Add mover="loopC"       />
  </PROTOCOLS>
</ROSETTASCRIPTS>
```
