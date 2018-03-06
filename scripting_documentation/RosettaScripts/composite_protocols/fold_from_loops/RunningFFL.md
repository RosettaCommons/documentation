# Running FFL
This entry list the main requirements to execute a simple **FFL** run.

# Problem setup
Let's assume that we have:
* `template.pdb`: A PDB that contains our **template**.
* `motif.pdb`: A PDB that contains our **motif**.

And we know:
* We will use chain `A` from `template.pdb` as our actual **template**.
* We will select as our `insert_point` into the **template** the segment: `50A-65A`.
* We will define our **motif** as `30B-45B` from `motif.pdb`.
* We will consider chain `A` from `motif.pdb` as a binder to our motif.

# Making the script
## ResidueSelectors
To properly run **FFL**, one needs to add the ResidueSelectors to pick each of the working labels and guide the non-fixed parts of the process. The following ones are the ones needed to generate the **FLL**-standard behaviour, and one can more or less consider that they should always be added:
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
And we also need to add the specific selectors for our exercise. Be aware that the `design` _ChainResidueSelector_  is setup to `B`. This is due to the fact that designs pull their chainID from the chainID of the **motif**. This way, there can be no repetition of the identifier when the 
```xml
  <Index name="insert" resnums="50A-65A" />
  <Index name="motif" resnums="30B-45B" />
  <Chain name="binder" chains="A" />
  <Chain name="design" chains="B" />
</RESIDUE_SELECTORS>
```

## TaskOperations
There are 3 main TaskOperations needed for **FFL**; the one that defines _static-non designable_ residues (`FFLMOTIF_TASKOP`); the one that defines _packable-non-designable_ residues (`FFLFLEX_TASKOP`) and the one that defines _bbflex-designable_ residues (`FFLTEMPLATE_TASKOP`)
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

## Filters
...
## Movers
...
## All together
...
