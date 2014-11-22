# Internal Documentation

This is the "front page" for the internal portion of the Rosetta documentation wiki.

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

## Overview Documentation
- [[RosettaAcademy (or "Rosetta for Newbies")|RosettaAcademy]] - An intro guide for new RosettaCommons users and developers.

- [[A guide to developing in Rosetta]] - Outdated, RosettaCommons centric developer overview.
- [[Before commit check]] - Things to check before submission.
- [[App name]] - Template for Rosetta application documentation.
    - [[Template app documenation page]] - Alternative application documentation template.
- [[ReviewerTemplate]] - A template for reviewers of application documentation.

## Rosetta Build System 

- [[Scons Overview and Specifics]]
- [[Cmake Overview and Specifics]]


## Documentation for Specific Projects

### Rosetta Membrane Framework Project

Not ready for prime time...just writing for now!

_User Facing Documentation_
- [[Overview Modeling Membrane Proteins in Rosetta]]
- [[Visualizing Membrane Geometry with the PyMOLMover]]
- Membrane Framework Applications
     - [[Membrane Relax]]
     - [[Membrane ddG]]
     - [[Membrane Protein-Protein Docking ]]
     - [[Membrane Symmetric Protein-Protein Docking]]
- [[Guide to Developing new Membrane Framework Applications]] RosettaScripts/PyRosetta Version

_Developer facing documentation_
- [[About Membrane Framework Architecture]]
- [[Guide to Developing new Membrane Framework Applications]] C++ Version
- [[Relevant Unit, Fingerprint, and Integration Tests]]

Outdated.... (wil deprecate 9/29/14)
- [[RosettaMembrane Framework Overview]]

### Cyclic Peptides / Geometrically-Constrained Polymers Project
- [[Workflow]]
- [[PeptideStubMover]]
- [[DeclareBond]]
- [[SetTorsion]] -- updated with new functionality; documentation needs to be written

### Parametric Design
- [[PerturbBundle]] mover.  (Will be moved into RosettaScripts documentation when this branch is merged.)

### Stepwise Assembly and Monte Carlo Project
- [[General application documentation|stepwise]] is publicly viewable.
- [[Overview|stepwise-classes-overview]] of stepwise enumeration and monte carlo, both accessed through `stepwise` application
- [[Monte Carlo Moves|stepwise-classes-moves]] and the move schedule 
- [[SampleAndScreen|stepwise-sample-and-screen]] is a general class for enumerating or stochastically sampling residues (or rigid bodies) 
- [[Samplers|stepwise-samplers]] are concatenated together to define the sampling loop, and can go through millions of poses.
- [[Screeners|stepwise-screeners]] are filters with some specialized features to 'fast-forward' through the sampling loop and prevent memory effects in the pose. 
- [[FullModelInfo|stepwise-fullmodelinfo]] is an important book-keeping object held by the pose used throughout the stepwise code. 
- [[Score terms|stepwise-score]] calculate energies for a full model even if only subpieces are instantiated (other_pose, loop_close, free_side_chain).

### Pilot Apps + Code Documentation

This is documentation for not-yet-released applications and code frameworks.

- [[multi-residue-ligand-dock]] - Docking of multiple ligand residues

- [[hotspot-hash]] - Documentation for Hotspot hashing
    * [[hshash-utils]] - Utilities for Hotspot hashing

- [[multistate-design-ga]] - DNA interface multistate design  

- [[RosettaPCS]] - Protein folding using Pseudo-Contact-Shift NMR restraints

#### Antibodies:

[[CDR Cluster Identification]]
- Identify North/Dunbrack CDR Clusters 

[[CDR Cluster Constrained Relax]]
- Relax CDRs using cluster-based dihedral constraints 

[[RosettaAntibodyDesign]]
- Design Antibodies based on clusters and cellular mimicry

#### S.E.W.I.N.G. Protocol
[[SEWING]]

#### Methods
[[Computing SASA in Rosetta]]
 - Method for computing SASA in Rosetta written by Jared

[[Global Objects-Singletons in Rosetta | internal_documentation/singletons]]
 - Creating singletons that are threadsafe. Andrew