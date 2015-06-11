#TaskOperations (RosettaScripts)

[[Return To RosettaScripts|RosettaScripts]]


TaskOperations are used by a TaskFactory to configure the behavior and create a PackerTask when it is generated on-demand for routines that use the "packer" to reorganize/mutate sidechains. The PackerTask controls which residues are packable, designable, or held fixed.  When used by certain Movers (at present, the PackRotamersMover and its subclasses), the set of TaskOperations control what happens during packing, usually by restriction "masks."  

The PackerTask can be thought of as an ice sculpture.  By default, everything is able to pack AND design.  By using TaskOperations, or your set of chisels, one can limit packing/design to only certain residues.  As with ICE, once these residues are restricted, they generally cannot be turned back on.


<code> For Developers </code> 

This section defines instances of the TaskOperation class hierarchy when used in the context of the Parser/RosettaScripts. They become available in the DataMap.


[[_TOC_]]

Example
=======

    ...
    <TASKOPERATIONS>
      <ReadResfile name=rrf/>
      <ReadResfile name=rrf2 filename=resfile2/>
      <PreventRepacking name=NotBeingUsedHereButPresenceOkay/>
      <RestrictResidueToRepacking name=restrict_Y100 resnum=100/>
      <RestrictToRepacking name=rtrp/>
      <OperateOnCertainResidues name=NoPackNonProt>
        <PreventRepackingRLT/>
        <ResidueLacksProperty property=PROTEIN/>
      </OperateOnCertainResidues>
    </TASKOPERATIONS>
    ...
    <MOVERS>
      <PackRotamersMover name=packrot scorefxn=sf task_operations=rrf,NoPackNonProt,rtrp,restrict_Y100/>
    </MOVERS>
    ...

In the rosetta code, the TaskOperation instances are registered with and then later created by a TaskOperationFactory. The factory calls parse\_tag() on the base class virtual function, with no result by default. However, some TaskOperation classes (e.g. OperateOnCertainResidues and ReadResfile above) do implement parse\_tag, and therefore their behavior can be configured using additional options in the "XML"/Tag definition.

Residue Selections
==================

[[ResidueSelectors]] are a flexible system for specifying particular set of residues in a pose. They can be used with the [[OperateOnResidueSubset TaskOperation|OperateOnResidueSubsetOperation]] to control packing behavior, or can be used with other movers and filters. 

Per Residue Specification
=========================

**[[OperateOnResidueSubset|OperateOnResidueSubsetOperation]]** - Use [[ResidueSelectors]] and [[Residue Level TaskOperations]] to specify a particular behavior on a particular subset of residues.  

[[OperateOnCertainResidues Operation]] - An older way of specifying particular groups of residues. Deprecated. Use OperateOnResidueSubset instead.

Specialized TaskOperations
==========================

List of current TaskOperation classes in the core library (\* indicates use-at-own-risk/not sufficiently tested/still under development):

Position/Identity Specification
-------------------------------

**[[SelectResiduesWithinChain|SelectResiduesWithinChainOperation]]** -

**[[SeqprofConsensus|SeqprofConsensusOperation]]** -

**[[ReadResfile|ReadResfileOperation]]** -

**[[ReadResfileFromDB|ReadResfileFromDBOperation]]** -

**[[RestrictIdentitiesAtAlignedPositions|RestrictIdentitiesAtAlignedPositionsOperation]]** -

**[[RestrictToAlignedSegments|RestrictToAlignedSegmentsOperation]]** -

**[[RestrictChainToRepacking|RestrictChainToRepackingOperation]]** -

**[[RestrictToRepacking|RestrictToRepackingOperation]]** -

**[[RestrictResidueToRepacking|RestrictResidueToRepackingOperation]]** -

**[[RestrictResiduesToRepacking|RestrictResiduesToRepackingOperation]]** -

**[[PreventRepacking|PreventRepackingOperation]]** -

**[[PreventResiduesFromRepacking|PreventResiduesFromRepackingOperation]]** -

**[[NoRepackDisulfides|NoRepackDisulfidesOperation]]** -

**[[DatabaseThread|DatabaseThreadOperation]]** -

**[[AlignedThread|AlignedThreadOperation]]** -

**[[DesignAround|DesignAroundOperation]]** -

**[[RestrictToTermini|RestrictToTerminiOperation]]** -

**[[DsspDesign|DsspDesignOperation]]** -

**[[LayerDesign|LayerDesignOperation]]** -

**[[SelectBySASA|SelectBySASAOperation]]** -

**[[RestrictToInterface|RestrictToInterfaceOperation]]** -

**[[RestrictToInterfaceVector|RestrictToInterfaceVectorOperation]]** -

**[[ProteinInterfaceDesign|ProteinInterfaceDesignOperation]]** -

**[[DetectProteinLigandInterface|DetectProteinLigandInterfaceOperation]]** -

**[[SetCatalyticResPackBehavior|SetCatalyticResPackBehaviorOperation]]** -

**[[RestrictAbsentCanonicalAAS|RestrictAbsentCanonicalAASOperation]]** -

**[[DisallowIfNonnative|DisallowIfNonnativeOperation]]** -

**[[ThreadSequence|ThreadSequenceOperation]]** -

**[[JointSequence|JointSequenceOperation]]** -

**[[RestrictDesignToProteinDNAInterface|RestrictDesignToProteinDNAInterfaceOperation]]** -


<!--- BEGIN_INTERNAL -->
**[[BuildingBlockInterface|BuildingBlockInterfaceOperation]]** -

**[[RestrictIdentities|RestrictIdentitiesOperation]]** -
<!--- END_INTERNAL --> 

**[[RestrictNativeResidues|RestrictNativeResiduesOperation]]** -

<!--- BEGIN_INTERNAL -->
**[[RetrieveStoredTask|RetrieveStoredTaskOperation]]** -
<!--- END_INTERNAL --> 

**[[ProteinCore|ProteinCoreOperation]]** -

**[[HighestEnergyRegion|HighestEnergyRegionOperation]]** -

**[[DesignByResidueCentrality|DesignByResidueCentralityOperation]]** -

**[[DesignRandomRegion|DesignRandomRegionOperation]]** -

**[[DesignCatalyticResidues|DesignCatalyticResiduesOperation]]** -

**[[DesignByCavityProximity|DesignByCavityProximityOperation]]** -

**[[DesignBySecondaryStructure|DesignBySecondaryStructureOperation]]** -

**[[InteractingRotamerExplosion|InteractingRotamerExplosionOperation]]** -

**[[ConsensusLoopDesign|ConsensusLoopDesignOperation]]** -

Rotamer Specification
---------------------

**[[InitializeFromCommandline|InitializeFromCommandlineOperation]]** -

**[[IncludeCurrent|IncludeCurrentOperation]]** -

**[[ExtraRotamersGeneric|ExtraRotamersGenericOperation]]** -

**[[RotamerExplosion|RotamerExplosionOperation]]** -

**[[LimitAromaChi2|LimitAromaChi2Operation]]** -

**[[AddLigandMotifRotamers|AddLigandMotifRotamersOperation]]** -

**[[ImportUnboundRotamers|ImportUnboundRotamersOperation]]** -

**[[SampleRotamersFromPDB|SampleRotamersFromPDBOperation]]** -


Packer Behavior Modification
----------------------------

**[[ModifyAnnealer|ModifyAnnealerOperation]]** -

**[[ProteinLigandInterfaceUpweighter|ProteinLigandInterfaceUpweighterOperation]]** -

Development/Testing
-------------------

**[[InitializeExtraRotsFromCommandline|InitializeExtraRotsFromCommandlineOperation]]** -

**[[SetRotamerCouplings|SetRotamerCouplingsOperation]]** -

**[[AppendRotamer|AppendRotamerOperation]]** -

**[[AppendRotamerSet|AppendRotamerSetOperation]]** -

**[[PreserveCBeta|PreserveCBetaOperation]]** -

**[[RestrictYSDesign|RestrictYSDesignOperation]]** -

