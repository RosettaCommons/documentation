[[include:filter_RmsdFromResidueSelector_type]]

Calculates RMSD over a user-specified set of residues for both the query and the reference pose. RMSD evaluation is performed with the SelectRMSDEvaluator; GDT evaluation is carried out with the SelectGDTEvaluator. Selectors applied to reference and query can be different, as long as they cover the same number of residues. It two TrueSelectors are applied, it will work as a regular RMSD filter.

By default, the RMSD will be calculated to the input pose (pose at parse time). Use -in:file:native \<filename\> or reference_name= to choose an alternate reference pose.