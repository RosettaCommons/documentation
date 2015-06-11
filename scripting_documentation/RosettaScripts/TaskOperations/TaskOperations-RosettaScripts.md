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

[[OperateOnCertainResidues Operation|OperateOnCertainResiduesOperation]] - An older way of specifying particular groups of residues. Deprecated. Use OperateOnResidueSubset instead.

Specialized TaskOperations
==========================

\* indicates use-at-own-risk/not sufficiently tested/still under development

Position/Identity Specification
-------------------------------

### General Specification

**[[PreventRepacking|PreventRepackingOperation]]** - Do not pack a particular residue.

**[[PreventResiduesFromRepacking|PreventResiduesFromRepackingOperation]]** - Do not pack a specified set of residues.

**[[RestrictToRepacking|RestrictToRepackingOperation]]** - Do not design any residues.
 
**[[RestrictResidueToRepacking|RestrictResidueToRepackingOperation]]** - Do not design a particular residue.

**[[RestrictResiduesToRepacking|RestrictResiduesToRepackingOperation]]** - Do not design a specified set of residues.

**[[RestrictChainToRepacking|RestrictChainToRepackingOperation]]** - Do not design a particular chain.

### General Design Specification

**[[ReadResfile|ReadResfileOperation]]** - Read a [[resfile|resfiles]] and apply the specified behavior.

**[[ReadResfileFromDB|ReadResfileFromDBOperation]]** - Apply a [[resfile|resfiles]] stored in a relational database.

**[[RestrictAbsentCanonicalAAS|RestrictAbsentCanonicalAASOperation]]** - Limit design to specified amino acids.

### Interface/Neighborhood Specifications

**[[DesignAround|DesignAroundOperation]]** - Limit design and repack to a certain distance around specified residues. 

**[[RestrictToInterface|RestrictToInterfaceOperation]]** - Restricts to a protein/protein interface.

**[[RestrictToInterfaceVector|RestrictToInterfaceVectorOperation]]** - Restricts to a protein/protein interface.

**[[ProteinInterfaceDesign|ProteinInterfaceDesignOperation]]** - Only repack and design residues near a specified protein/protein interface.

**[[DetectProteinLigandInterface|DetectProteinLigandInterfaceOperation]]** - Only repack and design residues near a specified protein/ligand interface.

### Property-based specification

**[[DsspDesign|DsspDesignOperation]]** - Specify design identity based on secondary structure.

**[[LayerDesign|LayerDesignOperation]]** - Specify design identity based on secondary structure and burial.

**[[SelectBySASA|SelectBySASAOperation]]** - Repack residue based on surface exposure.

**[[SetCatalyticResPackBehavior|SetCatalyticResPackBehaviorOperation]]** - Turn of packing or design for residue in enzdes constraints. 

**[[RestrictToTermini|RestrictToTerminiOperation]]** - Only repack termini.

### Misc.

**[[SelectResiduesWithinChain|SelectResiduesWithinChainOperation]]** -

**[[SeqprofConsensus|SeqprofConsensusOperation]]** -


**[[RestrictIdentitiesAtAlignedPositions|RestrictIdentitiesAtAlignedPositionsOperation]]** -

**[[RestrictToAlignedSegments|RestrictToAlignedSegmentsOperation]]** -





**[[NoRepackDisulfides|NoRepackDisulfidesOperation]]** -

**[[DatabaseThread|DatabaseThreadOperation]]** -

**[[AlignedThread|AlignedThreadOperation]]** -


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

**[[InitializeFromCommandline|InitializeFromCommandlineOperation]]** - Apply certain command line packer behavior flags. 

**[[IncludeCurrent|IncludeCurrentOperation]]** - Tell the packer to also consider the input rotamer.

**[[ExtraRotamersGeneric|ExtraRotamersGenericOperation]]** - Sample residue chi angles much more finely during packing.

**[[RotamerExplosion|RotamerExplosionOperation]]** - Sample residue chi angles much more finely during packing.

**[[LimitAromaChi2|LimitAromaChi2Operation]]** - Don't use aromatics rotamers known to be spurious design.

**[[AddLigandMotifRotamers|AddLigandMotifRotamersOperation]]** - Include native-like interactions to a ligand based on a database file.

**[[ImportUnboundRotamers|ImportUnboundRotamersOperation]]** - Include rotamers from a PDB file.

**[[SampleRotamersFromPDB|SampleRotamersFromPDBOperation]]** - Limit rotamers to ones similar to those in a PDB file.


Packer Behavior Modification
----------------------------

**[[ModifyAnnealer|ModifyAnnealerOperation]]** - Change the behavior of the packer.

**[[ProteinLigandInterfaceUpweighter|ProteinLigandInterfaceUpweighterOperation]]** - Increase the contribution of protein/ligand interactions during design.

Development/Testing
-------------------

**[[InitializeExtraRotsFromCommandline|InitializeExtraRotsFromCommandlineOperation]]** - (Under development)

**[[SetRotamerCouplings|SetRotamerCouplingsOperation]]** - (Under development)

**[[AppendRotamer|AppendRotamerOperation]]** - (Under development)

**[[AppendRotamerSet|AppendRotamerSetOperation]]** - (Under development)

**[[PreserveCBeta|PreserveCBetaOperation]]** - (Under development)

**[[RestrictYSDesign|RestrictYSDesignOperation]]** - Restrict amino acid choices during design to Tyr and Ser.

