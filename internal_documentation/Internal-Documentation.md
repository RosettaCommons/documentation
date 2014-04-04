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

## RosettaMembrane: Membrane Protein Framework Project

**Current Main page**
- [[RosettaMembrane Framework Overview]]

## Cyclic Peptides Project
[[GeneralizedKIC]]

## Pilot Apps Documentation

This is documentation for not-yet-released applications.

- [[multi-residue-ligand-dock]] - Docking of multiple ligand residues

- [[hotspot-hash]] - Documentation for Hotspot hashing
    * [[hshash-utils]] - Utilities for Hotspot hashing

- [[multistate-design-ga]] - DNA interface multistate design  

- [[RosettaPCS]] - Protein folding using Pseudo-Contact-Shift NMR restraints

### Antibodies:

[[CDR Cluster Identification]]
- Identify North/Dunbrack CDR Clusters 

[[CDR Cluster Constrained Relax]]
- Relax CDRs using cluster-based dihedral constraints 

[[RosettaAntibodyDesign]]
- Design Antibodies based on clusters and cellular mimicry
