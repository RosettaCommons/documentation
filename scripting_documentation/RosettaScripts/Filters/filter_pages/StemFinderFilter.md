# StemFinder
*Back to [[Filters|Filters-RosettaScripts]] page.*
## StemFinder

Compare a set of homologous but structurally heterogeneous PDBs to a template PDB and find structurally highly conserved sites that can serve as stems for splicing segments.
```xml
<StemFinder name="(&string)" from_res="(1&int)" to_res="(pose.total_residue()&int)" rmsd="(0.7&float)" stems_on_sse="(false&bool)" stems_are_neighbors="(true&bool)" neighbor_distance="(4.0&float)" neighbor_separation="(10&int)" filenames="(&comma-separated list of pdb file names)"/>
```
- from_res, to_res: template positions (in rosetta numbering) in which to search for stems. (positions out of range will be ignored).
- rmsd: cutoff for the average rmsd between a given position in the template and all of the closest positions in the homologs.
- stems_on_sse: demand that in each of the homologs the candidate stems are on 2ary structural elements. This isn't a good idea, b/c DSSP is a bit noisy
- stems_are_neighbors: should we eliminate stems that are farther than neighbor_distance from one another?
- neighbor_distance: minimal atomic distance between any pair of atoms on each of the residues.
- neighbor_separation: minimal aa separation between candidate stem sites
- filenames: PDB structures that are well aligned to the template. Use align or cealign.

## See also

* [[Loop Modeling|loopmodel]]
* [[AbInitio Modeling|abinitio-relax]]
* [[SpliceMover]]
