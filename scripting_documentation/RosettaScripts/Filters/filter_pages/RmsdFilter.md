# Rmsd
*Back to [[Filters|Filters-RosettaScripts]] page.*
## Rmsd

[[include:filter_Rmsd_type]]


Calculates the Calpha RMSD over a user-specified set of residues. Superimposition is optional. Selections are additive, so choosing a chain, and individual residue, and span will result in RMSD calculation over all residues selected. If no residues are selected, the filter uses all residues in the pose. 

By default, the RMSD will be calculated to the input pose (pose at parse time). Use -in:file:native \<filename\> or reference_name= to choose an alternate reference pose.

-   chains: list of chains (eg - "AC") to use for RMSD calculation
-   pdb\_num/res\_num: see [[RosettaScripts#rosettascripts-conventions_specifying-residues]]
-   residue: add a new leaf for each residue to include (can use rosetta index or pdb number)
-   span: contiguous span of residues to include (rosetta index or pdb number)
-   threshold: accept at this rmsd or lower
-   superimpose: perform superimposition before rmsd calculation?
-   reference_name: If given, use the pose saved with the SavePoseMover under the given reference_name as the reference.
- by_aln: align pose to the relative pose according to a sequence alignment. 
- aln_files: fasta format alignment files with the query and the template
- template_names: name of the relative pose, as is written in the aln_files
- query_names: name of the query pose, as is written in the aln_files

## See also

* [[IRmsdFilter]]
* [[SidechainRmsdFilter]]
