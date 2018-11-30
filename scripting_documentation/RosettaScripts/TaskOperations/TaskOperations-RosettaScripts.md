#TaskOperations (RosettaScripts)

[[Return To RosettaScripts|RosettaScripts]]

TaskOperations are used by a TaskFactory to configure the behavior and create a PackerTask when it is generated on-demand for routines that use the "packer" to reorganize/mutate sidechains. The PackerTask controls which residues are packable, designable, or held fixed.  When used by certain Movers (at present, the PackRotamersMover and its subclasses), the set of TaskOperations control what happens during packing, usually by restriction "masks."  

The PackerTask can be thought of as an ice sculpture.  By default, everything is able to pack AND design.  By using TaskOperations, or your set of chisels, one can limit packing/design to only certain residues.  As with ICE, once these residues are restricted, they generally cannot be turned back on.

There exist certain commonly-used TaskOperations that one usually should include when designing.  For more information on these, please see the page on [[recommended TaskOperations for design|Recommended_Design_TaskOperations]].

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
      <OperateOnResidueSubset name=NoPackHelix>
          <SecondaryStructure ss="H" />
          <PreventRepackingRLT/>
      </OperateOnResidueSubset>
    </TASKOPERATIONS>
    ...
    <MOVERS>
      <PackRotamersMover name=packrot scorefxn=sf task_operations=rrf,NoPackHelix,rtrp,restrict_Y100/>
    </MOVERS>
    ...

In the rosetta code, the TaskOperation instances are registered with and then later created by a TaskOperationFactory. The factory calls parse\_tag() on the base class virtual function, with no result by default. However, some TaskOperation classes (e.g. OperateOnCertainResidues and ReadResfile above) do implement parse\_tag, and therefore their behavior can be configured using additional options in the "XML"/Tag definition.

Residue Selectors
==================

[[ResidueSelectors]] are a flexible system for specifying particular set of residues in a pose. They can be used with the [[OperateOnResidueSubset TaskOperation|OperateOnResidueSubsetOperation]] to control packing behavior, or can be used with other movers and filters. 

Per Residue Specification
=========================

TaskOp  | Description
------------ | -------------
**[[OperateOnResidueSubset|OperateOnResidueSubsetOperation]]** | Use [[ResidueSelectors]] and [[Residue Level TaskOperations]] to specify a particular behavior on a particular subset of residues.  
**[[OperateOnCertainResidues Operation|OperateOnCertainResiduesOperation]]** | An older way of specifying particular groups of residues. **Deprecated** - use OperateOnResidueSubset instead.

Specialized Operations
==========================


Position/Identity Specification
-------------------------------

### General Specification

TaskOP  | Description
------------ | -------------
**[[PreventRepacking|PreventRepackingOperation]]** | Do not pack a particular residue.
**[[PreventResiduesFromRepacking|PreventResiduesFromRepackingOperation]]** | Do not pack a specified set of residues.
**[[RestrictToRepacking|RestrictToRepackingOperation]]** | Do not design any residues.
**[[RestrictResidueToRepacking|RestrictResidueToRepackingOperation]]** | Do not design a particular residue.
**[[RestrictResiduesToRepacking|RestrictResiduesToRepackingOperation]]** | Do not design a specified set of residues.
**[[RestrictChainToRepacking|RestrictChainToRepackingOperation]]** | Do not design a particular chain.

### General Design Specification

TaskOp  | Description
------------ | -------------
**[[ReadResfile|ReadResfileOperation]]** | Read a [[resfile|resfiles]] and apply the specified behavior.
**[[ReadResfileFromDB|ReadResfileFromDBOperation]]** | Apply a [[resfile|resfiles]] stored in a relational database.
**[[RestrictAbsentCanonicalAAS|RestrictAbsentCanonicalAASOperation]]** | Limit design to specified amino acids.
**[[DisallowIfNonnative|DisallowIfNonnativeOperation]]** | Do not design to certain residues, but allow them if they already exist.
**[[LinkResidues]]** | Constrain groups of residues to mutate together.

<!--- BEGIN_INTERNAL -->
TaskOp  | Description
------------ | -------------
**[[RestrictIdentities|RestrictIdentitiesOperation]]** | Do not design residues with a particular starting identity.
<!--- END_INTERNAL --> 

### Property-based specification

TaskOp  | Description
------------ | -------------
**[[ConservativeDesign|ConservativeDesignOperation]]** | Only design to amino acids that are similar to native.
**[[ConsensusLoopDesign|ConsensusLoopDesignOperation]]** | Only design to amino acids in loops which match the ABEGO torsion bins.
**[[DsspDesign|DsspDesignOperation]]** | Specify design identity based on secondary structure.
**[[DesignCatalyticResidues|DesignCatalyticResiduesOperation]]** | Only design residues surrounding the residues in [[enzdes constraints|match-cstfile-format]]. 
**[[DesignByResidueCentrality|DesignByResidueCentralityOperation]]** | Design only residues which have a high inter-connectedness to other residues.
**[[DesignByCavityProximity|DesignByCavityProximityOperation]]** | Only design residues around voids.
**[[DesignRandomRegion|DesignRandomRegionOperation]]** | Design only a random section of the pose. 
**[[HighestEnergyRegion|HighestEnergyRegionOperation]]** | Design only residues which have a bad energy.
**[[LayerDesign|LayerDesignOperation]]** | Specify design identity based on secondary structure and burial.
**[[NoRepackDisulfides|NoRepackDisulfidesOperation]]** | Do not repack disulfide residues.
**[[ProteinCore|ProteinCoreOperation]]** | Do not design residues in the protein core.
**[[SelectResiduesWithinChain|SelectResiduesWithinChainOperation]]** | Do not pack/design residues based on their position in a chain.
**[[SelectBySASA|SelectBySASAOperation]]** | Repack residue based on surface exposure.
**[[SetCatalyticResPackBehavior|SetCatalyticResPackBehaviorOperation]]** | Turn of packing or design for residues in [[enzdes constraints|match-cstfile-format]]. 
**[[RestrictToTermini|RestrictToTerminiOperation]]** | Only repack termini.

<!--- BEGIN_INTERNAL -->
TaskOp  | Description
------------ | -------------
**[[DesignBySecondaryStructure|DesignBySecondaryStructureOperation]]** | Do not design residues which match their secondary structure predictions.
<!--- END_INTERNAL -->

### Interface/Neighborhood Specifications

TaskOp  | Description
------------ | -------------
**[[DesignAround|DesignAroundOperation]]** | Limit design and repack to a certain distance around specified residues. 
**[[DetectProteinLigandInterface|DetectProteinLigandInterfaceOperation]]** | Only repack and design residues near a specified protein/ligand interface.
**[[ProteinInterfaceDesign|ProteinInterfaceDesignOperation]]** | Only repack and design residues near a specified protein/protein interface.
**[[RestrictToInterface|RestrictToInterfaceOperation]]** | Restricts to a protein/protein interface.
**[[RestrictToInterfaceVector|RestrictToInterfaceVectorOperation]]** | Restricts to a protein/protein interface.
**[[RestrictDesignToProteinDNAInterface|RestrictDesignToProteinDNAInterfaceOperation]]** | Limit repacking and design to residues around DNA.

<!--- BEGIN_INTERNAL -->
TaskOp  | Description
------------ | -------------
**[[BuildingBlockInterface|BuildingBlockInterfaceOperation]]** | Only design residues near the interface of symmetric building blocks.
<!--- END_INTERNAL --> 

### Input-based design

TaskOp  | Description
------------ | -------------
**[[AlignedThread|AlignedThreadOperation]]** | Design to identities in a FASTA file.
**[[DatabaseThread|DatabaseThreadOperation]]** | Design based off a sequence in a database.
**[[JointSequence|JointSequenceOperation]]** | Design only to identities common to multiple inputs.
**[[RestrictNativeResidues|RestrictNativeResiduesOperation]]** | Turn off design or repacking to residues which are the same as the native pose.
**[[RestrictIdentitiesAtAlignedPositions|RestrictIdentitiesAtAlignedPositionsOperation]]** | Restrict design to the sequence of a provided PDB.
**[[RestrictToAlignedSegments|RestrictToAlignedSegmentsOperation]]** | Only design at aligned segments.
**[[SeqprofConsensus|SeqprofConsensusOperation]]** | Design residues based off a PSSM.
**[[ThreadSequence|ThreadSequenceOperation]]** | Design to identities of a provided sequence.


### Misc.

<!--- BEGIN_INTERNAL -->
TaskOp  | Description
------------ | -------------
**[[RetrieveStoredTask|RetrieveStoredTaskOperation]]** | Use a task stored by a [[StoreTaskMover]].
<!--- END_INTERNAL --> 

Rotamer Specification
---------------------

TaskOp  | Description
------------ | -------------
**[[InitializeFromCommandline|InitializeFromCommandlineOperation]]** | Apply certain command line packer behavior flags. 
**[[IncludeCurrent|IncludeCurrentOperation]]** | Tell the packer to also consider the input rotamer.
**[[ExtraRotamersGeneric|ExtraRotamersGenericOperation]]** | Sample residue chi angles much more finely during packing.
**[[AddLigandMotifRotamers|AddLigandMotifRotamersOperation]]** | Include native-like interactions to a ligand based on a database file.
**[[InteractingRotamerExplosion|InteractingRotamerExplosionOperation]]** | Increase sampling of rotamers that score well with a specified target residue.
**[[ImportUnboundRotamers|ImportUnboundRotamersOperation]]** | Include rotamers from a PDB file.
**[[LimitAromaChi2|LimitAromaChi2Operation]]** | Don't use aromatics rotamers known to be spurious design.
**[[RotamerExplosion|RotamerExplosionOperation]]** | Sample residue chi angles much more finely during packing.
**[[SampleRotamersFromPDB|SampleRotamersFromPDBOperation]]** | Limit rotamers to ones similar to those in a PDB file.
**[[PruneBuriedUnsats|PruneBuriedUnsatsOperation]]** | Remove rotamers that will cause buried unsats.


Packer Behavior Modification
----------------------------

TaskOp  | Description
------------ | -------------
**[[ModifyAnnealer|ModifyAnnealerOperation]]** | Change the behavior of the packer.
**[[ProteinLigandInterfaceUpweighter|ProteinLigandInterfaceUpweighterOperation]]** | Increase the contribution of protein/ligand interactions during design.

Development/Testing
-------------------

TaskOp  | Description
------------ | -------------
**[[InitializeExtraRotsFromCommandline|InitializeExtraRotsFromCommandlineOperation]]** | (Under development)
**[[SetRotamerCouplings|SetRotamerCouplingsOperation]]** | (Under development)
**[[AppendRotamer|AppendRotamerOperation]]** | (Under development)
**[[AppendRotamerSet|AppendRotamerSetOperation]]** | (Under development)
**[[PreserveCBeta|PreserveCBetaOperation]]** | (Under development)
**[[RestrictYSDesign|RestrictYSDesignOperation]]** | Restrict amino acid choices during design to Tyr and Ser.

Antibody and CDR Specific Operations
============================

These require a renumbered antibody and are intended to be combined with each other.  Please see [[General Antibody Tips | General-Antibody-Options-and-Tips]] and [[Rosetta Antibody Guide | antibody-applications]] for more information.

TaskOp  | Description
------------ | -------------
**[[AddCDRProfilesOperation]]** | Add North/Dunbrack CDR Cluster based profile design during packing of selected CDRs.
**[[AddCDRProfileSetsOperation]]** | Sample full CDR sequences of the current CDR cluster for design.
**[[DisableAntibodyRegionOperation]]** | Disable packing or design of an antibody region (CDRs, framework, antigen).
**[[DisableCDRsOperation]]** | Disable packing or design of a set of specified CDRs.
**[[RestrictToCDRsAndNeighbors]]** | Restrict Packing/Design to only selected CDRs and any neighbor residues in other CDRs and the antigen/framework.  Combine with DisableAntibodyRegionOperation for more control. 

See Also
========

* [[RosettaScripts]]: The RosettaScripts home page
* [[Recommended TaskOperations for design|Recommended_Design_TaskOperations]]
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[RosettaScripts Movers|Movers-RosettaScripts]]
* [[RosettaScripts Filters|Filters-RosettaScripts]]
* [[I want to do x]]: Guide for making specific structural perturbations using RosettaScripts
* [[Scripting Documentation]]: The Scripting Documentation home page
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Getting Started]]: A page for people new to Rosetta
* [[Glossary]]
* [[RosettaEncyclopedia]]