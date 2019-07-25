# Internal Documentation

[[_TOC_]]

##Introduction


This is the front page for the internal portion of the Rosetta documentation wiki.
It provides convenient access to documentation pages which aren't yet ready for public release.
(If a page will never be in a state to be released to the public, consider putting it on the 
internal RosettaCommons wiki instead.)

All files stored under the `internal_documents/` folder (use the rename function to move), 
as well as everything which is placed between

```
<!--- BEGIN_INTERNAL -->
```

and

```
<!--- END_INTERNAL -->
```

comment tags will be stripped from the documentation prior to being provided as a public release.

See [[how to write documentation|how-to-write-documentation]] for more details.

## Development Overview
- [[RosettaAcademy (or "Rosetta for Newbies")|RosettaAcademy]] - An intro guide for new RosettaCommons users and developers.
- [[Code Template Generation | code_templates ]] - How to use the template generator scripts to generate code templates of common Rosetta classes/apps/unit tests to save development time
- [[A guide to developing in Rosetta]] - Outdated, RosettaCommons centric developer overview.
- [[Before commit check]] - Things to check before submission.
- [[App name]] - Template for Rosetta application documentation.
    - [[Template app documentation page]] - Alternative application documentation template.
- [[ReviewerTemplate]] - A template for reviewers of application documentation.

## Rosetta Build System 

- [[Scons Overview and Specifics]]
- [[Cmake Overview and Specifics]]
- [[Building Rosetta on the Argonne "Mira" Blue Gene supercomputer]]

## Core Class Modifications

If you change the API for a core class (particularly if you *remove*, *rename*, or *alter* an existing function), please make a note of it here to make it easy to communicate this to the development community and the PyRosetta community, and for future documentation in the release notes.  Note that this applies to any API change in core.5 or below (numeric, basic, _etc._).  Such changes should be avoided if possible, but if such a change is unavoidable, please do the following:

1.  E-mail the developer list.  Developers need to know, and a conversation needs to happen.  Do not proceed with the change without community approval.
2.  If the change is approved, make sure that the Gray lab knows.  The PyRosetta tutorials will need to change.
3.  If possible, maintain an old function with the old interface, with a tracer warning that this function will be deprecated and that the new function should be used instead.
4.  Document the change here, for future inclusion in the release notes:

| Date | Author | Description | Reason |
| ---- | ------ | ----------- | ------ |
| 31 Aug 2016 | Andy Watkins | [Example]: core::pose::Pose::n_residue() was renamed to core::pose::Pose::size(). | An opportunity for maniacal laughter. |

## PyRosetta API changes
1. Since r59466 xyzMatrix now have .xy properties bound as 'data' instead of set/get functions. So if your code accessed this methods directly you will need to refactor it as m.xx( m.xy() ) --> m.xx = m.xy


## Rosetta Code-Writing Documentation

### [[Global Objects-Singletons in Rosetta | internal_documentation/singletons]]
 - Creating singletons that are threadsafe. Andrew

### [[Writing a New Simple Metric]]
 - Creating a SimpleMetric instead of Filter or for general analysis

## Rosetta Method Documentation

### [[Computing SASA in Rosetta]]
 - Method for computing SASA in Rosetta written by Jared

### Chemical XRW 2016 ##
#### - [[Overview of File I/O Code | FileIOOverview ]]
#### - [[Changes made post-XRW | PostChemicalXRWChanges ]]

### JD3 -- version 3 of the JobDistributor system ###
- TODO

## Energy Function optimization ##
### Seattle Group 
[[Overview of Seattle Group energy function optimization project]]
[[Updates beta july15]]
[[Updates beta nov15]]




## Documentation for Specific Projects

### Updating ResidueTypeSet to handle the full chemical repertoire of macromolecules
- [[ Overview of ResidueTypeSet ]]
- [[ ResidueTypeFinder ]] is new class to efficiently find ResidueTypes from a ResidueTypeSet for most (all?) queries.

### Modeling membrane proteins with RosettaMP

#### Movers & Methods in development
- [[ Movers | RosettaMP-Internal-Movers ]]
- [[ Methods | RosettaMP-Internal-Methods ]]

#### Score Functions

#### Applications
- Docking: 
    - [[ Global Docking in the Membrane | RosettaMP-Internal-MPFindInterface ]]
- Relax: 
    - [[ Mutate Relax | RosettaMP-Internal-MPMutateRelax ]]
    - [[ Quick Relax | RosettaMP-Internal-MPQuickRelax ]]
- De novo:
    - [[ Helix from sequence | RosettaMP-Internal-HelixFromSequence ]]
- Other:
    - [[ Mutate | RosettaMP-Internal-Mutate]]

#### Membrane Chemical Profiles Project
  
 - [[ Database Organization | RosettaMP-Internal-Chemical-DB ]]
 - [[ Membrane Representation | RosettaMP-Internal-Chemical-Rep ]]
 - [[ Movers for Benchmarking | RosettaMP-Internal-Chemical-Movers ]]
 - [[ Pilot Apps | RosettaMP-Internal-Chemical-Apps ]]


### Design-specific scoring terms ###
- [[Repeat stretch energy (aa_repeat_energy)|Repeat-stretch-energy]] -- A scoring term that penalizes long stretches of repeating sequence (*e.g.* poly-Q sequences).
- [[Residue composition energy (aa_composition)|AACompositionEnergy]] -- A scoring term that penalizes deviation from a desired residue type composition (e.g. no more than 7% alanines; at least one aromatic; at least 40% hydrophobic).

### Cyclic Peptides / Geometrically-Constrained Polymers Project
- [[Peptide structure prediction with the simple_cycpep_predict app|internal_documentation/simple_cycpep_predict_app]]
- [[Workflow]]
- [[PeptideStubMover]]
- [[DeclareBond]]
- [[SetTorsion]] -- updated with new functionality; documentation needs to be written

### Stepwise Assembly and Monte Carlo Project
- [[General application documentation|stepwise]] is publicly viewable.
- [[Overview|stepwise-classes-overview]] of stepwise enumeration and monte carlo, both accessed through `stepwise` application
- [[Monte Carlo Moves|stepwise-classes-moves]] and the move schedule 
- [[SampleAndScreen|stepwise-sample-and-screen]] is a general class for enumerating or stochastically sampling residues (or rigid bodies) 
- [[Samplers|stepwise-samplers]] are concatenated together to define the sampling loop, and can go through millions of poses.
- [[Screeners|stepwise-screeners]] are filters with some specialized features to 'fast-forward' through the sampling loop and prevent memory effects in the pose. 
- [[FullModelInfo|stepwise-fullmodelinfo]] is an important book-keeping object held by the pose used throughout the stepwise code. 
- [[Score terms|stepwise-score]] calculate energies for a full model even if only subpieces are instantiated (other_pose, loop_close, free_side_chain).

### Fragment assembly of RNA (FARNA) renovation, unification with stepwise
- [[FARNA|farna-refactor]] is Rosetta's original RNA de novo modeling code (dating back to Rosetta++). It is undergoing some updates in 2015-2016.

### Antibodies
[[General Antibody Options and Tips]]

Utilities:
- [[CDR Cluster Identification]]
   * Application to Identify North/Dunbrack CDR Clusters 
- [[CDR Cluster Constrained Relax]]
   * Application to Relax CDRs using cluster-based dihedral constraints 

Design:
- [[Rosetta Antibody Designer (RAbD) | RosettaAntibodyDesign]]
  * Application for knowledge-based Antibody Design based on CDR clusters and cellular mimicry
- [[Antibody Design Strategy Analysis]]
  * Methods for analyzing various antibody design strategies
- [[Antibody Design Benchmark Analysis]]
  * Methods for analyzing various antibody design benchmarks

Features Reporters:
- [[Antibody Features]]
- [[CDR Cluster Features]]
- [[Interface Features]]

RosettaScripts Documentation:
- [[Generalized Antibody Design Framework RS]]

Input Files:
- [[CDR Instruction File]]
 * CDR Level control of Antibody Design and CDRSets used for Antibody modeling

### S.E.W.I.N.G. Protocol
- [[SEWING]]
 * [[Model Generation]] 
 * [[Model comparison with geometric hashing]] 
 * [[Assembly of models]] 
- [[Sidechain Design aided by Sewing]]
- [[SEWING Dictionary]]

## Pilot Apps

This is documentation for not-yet-released applications

### General 

- [[multi-residue-ligand-dock]] - Docking of multiple ligand residues

- [[hotspot-hash]] - Documentation for Hotspot hashing
    * [[hshash-utils]] - Utilities for Hotspot hashing

- [[multistate-design-ga]] - DNA interface multistate design  

- [[RosettaPCS]] - Protein folding using Pseudo-Contact-Shift NMR restraints

### Antibodies

[[General Antibody Options and Tips]]

Utilities:
- [[CDR Cluster Identification]]
   * Application to Identify North/Dunbrack CDR Clusters 
- [[CDR Cluster Constrained Relax]]
   * Application to Relax CDRs using cluster-based dihedral constraints 

Design:
- [[Rosetta Antibody Designer (RAbD) | RosettaAntibodyDesign]]
  * Application for knowledge-based Antibody Design based on CDR clusters and cellular mimicry
- [[Antibody Design Strategy Analysis]]
  * Methods for analyzing various antibody design strategies
- [[Antibody Design Benchmark Analysis]]
  * Methods for analyzing various antibody design benchmarks

### Carbohydrates

- [[ GlycanRelax ]]
- [[ GlycanClashCheck ]]
- [[ GlycanInfo ]]

## Pilot RosettaScript Movers/Filters/etc.

### Carbohydrates
- [[ SimpleGlycsylateMover ]]
- [[ GlycanRelaxMover ]]
- [[ GlycanTreeSelector]]
- [[ GlycanResidueSelector]]

### Antibody Design
- [[Generalized Antibody Design Framework RS]]

# Rosetta (not on) GPU
[[internal_documentation/Rosetta-GPU-conversation-transcription]]