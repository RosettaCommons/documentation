# energy_based_clustering

This page was created 23 October 2017 by Vikram K. Mulligan (vmullig@uw.edu).  It was last modified on 8 May 2019 by Vikram K. Mulligan (vmulligan@flatironinstitute.org).

Back to [[Application Documentation]].

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
     * Optional Ramachandran bin analysis, carried out concurrently with clustering (only for alpha-amino acids and peptoids).
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

The output is, by default, a set of PDB files with names of format `c.<cluster #>.<struct #>.pdb`.  If the `-cluster:energy_based_clustering:silent_output` flag is used, the output is two Rosetta binary silent files, the first containing only cluster centres, and the second containing all structures.

# All options

| Flag | Description | Default |
| ---- | ----------- | ------- |
| cluster:<br/>energy_based_clustering:<br/>cluster_radius | (real) The radius for clustering, in Angstroms for Cartesian clustering and degrees for dihedral clustering. | 1.0 |
| cluster:<br/>energy_based_clustering:<br/>cluster_by | (string) What should I use as the basis for clustering?  Options are "bb_cartesian" (xyz coordinates of backbone atoms) and "bb_dihedral" (phi, psi, omega angles). | "bb_cartesian" |
| cluster:<br/>energy_based_clustering:<br/>use_CB | (boolean) If clustering by backbone Cartesian coordinates, should beta carbons be included?  Note that if this option is used, none of the input structures can contain glycine. | false |
| cluster:<br/>energy_based_clustering:<br/>residues_to_ignore | (integer vector) List of residues to ignore in alignments for clustering. | \<empty vector\> |
| cluster:<br/>energy_based_clustering:<br/>chains_to_ignore | (integer vector) List of chains to ignore in alignments for clustering. | \<empty vector\> |
| cluster:<br/>energy_based_clustering:<br/>limit_structures_per_cluster | (integer) Maximum number of structures to output per cluster.  The default value of zero means no limit.  Note that more structures might be _assigned_ to a cluster, but only the first N will be written to disk if this option is used. | 0 |
| cluster:<br/>energy_based_clustering:<br/>limit_clusters | (integer) Maximum number of clusters to output.  The default value of zero means no limit.  Note that more clusters might be _generated_ but only the first N will be written to disk if this option is used. | 0 |
| cluster:<br/>energy_based_clustering:<br/>cyclic | (boolean) If true, constraints are added to make a peptide bond between the N- and C-termini.  If false (default), the termini are free. | false |
| cluster:<br/>energy_based_clustering:<br/>cyclic_symmetry | (integer) If provided, structures that do not have the desired symmetry are filtered out.  Set to 2 for C2 or S2 symmetry, 3 for C3 symmetry, 4 for C4 or S4 symmetry, etc.  Unused (0) if not specified.  Can only be used with the -cyclic flag. | 0 |
| cluster:<br/>energy_based_clustering:<br/>cyclic_symmetry_mirroring | (boolean) If true, then SN symmetry is used instead of CN.  Unused if not specified.  Can only be used with the -cyclic and -cyclic_symmetry flags. | false |
| cluster:<br/>energy_based_clustering:<br/>cyclic_symmetry_threshold | (real) The angle threshold, in degrees, for determining whether a cyclic peptide is symmetric.  Can only be used with the -cyclic and -cyclic_symmetry flags. | 10.0 |
| cluster:<br/>energy_based_clustering:<br/>cluster_cyclic_permutations | (boolean) If true, all cyclic permutations are tried when comparing two structures for clustering.  Requires -cyclic. | false |
| cluster:<br/>energy_based_clustering:<br/>cyclic_permutation_offset | (integer) 1 by default, meaning that every cyclic permutation is clustered if -cluster_cyclic_permutations is true.  Values X > 1 mean that cyclic permutations shifted by X residues will be clustered. | 1 |
| cluster:<br/>energy_based_clustering:<br/>perform_ABOXYZ_bin_analysis | (boolean) If true, Ramachandran bin analysis is performed on all clusters using the A, B, X, Y, and O bins as defined in Hosseinzadeh, Bhardwaj, Mulligan et al. (2018).  Inputs must be all-alpha amino acid or peptoid structures. | false |
| cluster:<br/>energy_based_clustering:<br/>mutate_to_ala | (boolean) If true, the input structures will be converted to a chain of alanines (L- or D-) before scoring. | false |
| cluster:<br/>energy_based_clustering:<br/>disulfide_positions | (integer vector) A space-separated list of positions that are disulfide-bonded.  For example, -disulfide_positions 3 8 6 23 would mean that residues 3 and 8 are disulfide-bonded, as are residues 6 and 23.  Defaults to an empty list of the option is not specified, in which case disulfides are auto-detected. | \<empty vector\> |
| cluster:<br/>energy_based_clustering:<br/>homooligomer_swap | (boolean) If the structures contain multiple chains with identical sequence, setting this to true will test all permutations of chains when clustering. | false |
| cluster:<br/>energy_based_clustering:<br/>silent_output | (boolean) Write output to a silent file instead of to separate PDBs.  This will create two files: one that only contains the first member of each cluster, and one that contains everything. | false |
| cluster:<br/>energy_based_clustering:<br/>cst_file | (string vector) An optional, user-specified list of one or more constraints files.  Used for relaxation and scoring.  Unused if not specified. | \<empty vector\> |
| cluster:<br/>energy_based_clustering:<br/>extra_rms_atoms | (string vector) A list of additional atoms to use in the RMSD calculation, each in the format residue:atomname separated by whitespace.  For example, -extra_rms_atoms 7:SG 12:CG 12:CD 12:CE 12:NZ 14:OG.  Unused if not specified. | \<empty vector\> |
| cluster:<br/>energy_based_clustering:<br/>rebuild_all_in_dihedral_mode | (boolean) If true, full poses are rebuilt for output when clustering in dihedral mode.  If false, only backbones are written out.  True by default. | true |
| cluster:<br/>energy_based_clustering:<br/>prerelax | (boolean) Should imported structures be subjected to a round of fast relaxation? | false |
| cluster:<br/>energy_based_clustering:<br/>relax_rounds | (integer) The number of fastrelax rounds to apply if the -prerelax option is used. | 1 |
| in:<br/>file:<br/>s | (string vector) List of PDB files to import. | \<empty vector\> |
| in:<br/>file:<br/>l | (string vector) List of text files containing lists of PDB files to import. | \<empty vector\> |
| in:<br/>file:<br/>silent | (string vector) List of Rosetta silent files to import. | \<empty vector\> |
| out:<br/>prefix | (string) A string to prepend to all output PDB file names, or to all tags contained in an output Rosetta silent file. | \<empty string\> |

# Example

Given the following inputs:

* A Rosetta binary silent file containing a number of cyclic peptide backbones in `inputs/backbones.silent`.
* A Rosetta flags file in `inputs/rosetta.flags`.

The following command line will cluster the backbones:

```
<path_to_Rosetta>/main/source/bin/energy_based_clustering.default.linuxgccrelease @inputs/rosetta.flags
```

The contents of `inputs/rosetta.flags` is as follows:

```
-in:file:silent inputs/backbones.silent
-in:file:fullatom
-cluster:energy_based_clustering:cluster_radius 1.0
-cluster:energy_based_clustering:limit_structures_per_cluster 10
-cluster:energy_based_clustering:cluster_by bb_cartesian
-cluster:energy_based_clustering:use_CB false
-cluster:energy_based_clustering:cyclic true
-cluster:energy_based_clustering:cluster_cyclic_permutations true
```

# Notes on development history

This application began life as `vmullig/bettercluster.cc`, a pilot application created on 6 May 2013.  Many features have been added since then, including cyclic permutations, support for internal peptide symmetry, and support for non-canonicals.  A few features have also been removed, such as principal component analysis (PCA) on each cluster.  On 23 October 2017, a heavily cleaned-up version was added to the Rosetta public applications repository for general use.  On 8 May 2019, an option was added to allow Ramachandran bin analysis to be performed on-the-fly, during clustering.  (Previously, this analysis was performed after the fact with a Python script.)

# References

Hosseinzadeh P, Bhardwaj G, Mulligan VK, Shortridge MD, Craven TW, Pardo-Avila F, Rettie S, Kim DE, Silva D-A, Ibrahim YM, Webb IK, Cort JR, Adkins JN, Varani G, and Baker D.  2017.  Comprehensive computational design of ordered peptide macrocycles.  Manuscript in revision.

# See also

* [[Calibur clustering application|calibur-clustering]]
* [[Legacy cluster application|cluster]]
* [[Application Documentation]]: Application documentation home page