# energy_based_clustering

This page was created 23 October 2017 by Vikram K. Mulligan (vmullig@uw.edu).

**If you use this application, please cite:  Hosseinzadeh P, Bhardwaj G, Mulligan VK, Shortridge MD, Craven TW, Pardo-Avila F, Rettie S, Kim DE, Silva D-A, Ibrahim YM, Webb IK, Cort JR, Adkins JN, Varani G, and Baker D.  2017.  Comprehensive computational design of ordered peptide macrocycles.  Manuscript in revision.**

[[_TOC_]]

# Introduction

Clustering is the process of taking a large group of structures and sorting them into smaller groups based on some shared property -- in most cases, structural similarity.  This application was written as an alternative to the legacy Rosetta `cluster` application, and addresses several of its limitations.  The advantages of the `energy_based_clustering` application include:

* Reliability regardless the number of structures.
* Ability to handle up to ~tens of millions of structures without crashing.
* Reasonable speed, even with ~tens of millions of structures.
* Various features for specialized usage cases, including:
  * Peptides and other synthetic heteropolymers:
     * Support for alpha-amino acids (with and without N-methylation), beta-amino acids, gamma-amino acids, oligoureas, and peptoids.
     * Support for cyclic geometry.
     * Support for disulfides.
     * Support for exotic cross-linkers like 1,3,5-tris(bromomethyl)benzene.
     * Support for cyclic permutations during clustering.
     * Filtering for symmetry prior to clustering.
  * Homo-oligomers:
     * Support for considering all permutations of oligomers during clustering.

# The algorithm

The `energy_based_clustering` application imports a list of structures from any Rosetta-compatible file format (currently mmCIF, PDB, or Rosetta silent format), scores each, and stores only the information relevant for clustering (thereby conserving memory) in an unclustered structure list.  It then uses a very simple "cookie-cutter" algorithm to cluster the structures.  The steps are:

1.  Select the lowest-energy structure remaining in the unclustered list as the centre of the current cluster.  This structure is removed from the unclustered list.
2.  Construct an RMSD vector between the current cluster centre and all remaining structures in the unclustered list.  The RMSD can be based on mainchain Cartesian coordinates or on backbone dihedral values.
3.  Select all structures with RMSD values below a user-specified cutoff, group these into the current cluster, and remove them from the unclustered list.
4.  Repeat steps 1, 2, and 3 for the next cluster, until there are no structures remaining in the unclustered list.

Although simple, this approach has the advantages of (a) biasing the clusters towards the lowest-energy structures (which is desirable for many applications), (b) scaling roughly linearly with the total number of structures, and (c) being fully deterministic (_i.e._ repeated runs on the same dataset will always produce the same output).

# Inputs and outputs

To run this application, a user must supply:

* A set of structures to be clustered, in any import format supported by Rosetta.
* A cluster radius.
* Optionally, other settings controlling the details of clustering (see below).

The output is, by default, a set of PDB files.  If the `-cluster:energy_based_clustering:silent_output` flag is used, the output is two Rosetta binary silent files, the first containing only cluster centres, and the second containing all structures.

# All options



# Example

# References

Hosseinzadeh P, Bhardwaj G, Mulligan VK, Shortridge MD, Craven TW, Pardo-Avila F, Rettie S, Kim DE, Silva D-A, Ibrahim YM, Webb IK, Cort JR, Adkins JN, Varani G, and Baker D.  2017.  Comprehensive computational design of ordered peptide macrocycles.  Manuscript in revision.

# See also

* [[Calibur clustering application|calibur-clustering]]
* [[Legacy cluster application|cluster]]