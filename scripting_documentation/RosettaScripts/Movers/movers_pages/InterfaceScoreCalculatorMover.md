# InterfaceScoreCalculator
*Back to [[Mover|Movers-RosettaScripts]] page.*
## InterfaceScoreCalculator

[[include:mover_InterfaceScoreCalculator_type]]

The major terms calculated by this mover are the interface terms. The overall interface value is the 
`interface_delta_X` term, where `X` is replaced by the chain of the ligand being used, as specified by the `chains` option. Other score terms calculated are the component-wise scores in the `if_X_scoreterm` terms, where `X` is the chain letter, and the `scoreterm` is each active scoreterm in the associated scorefunction. Additionally, the `ligand_is_touching_X` is a crude metric of if the ligand is in contact with the protein.

If the "native" is specified, either in tag or with the `-in:file:native` option, the following additional terms are calculated: 

1.  ligand\_centroid\_travel. The distance between the native ligand and the ligand in our docked model.
2.  ligand\_radius\_of\_gyration. An outstretched conformation would have a high radius of gyration. Ligands tend to bind in outstretched conformations.
3.  ligand\_rms\_no\_super. RMSD between the native ligand and the docked ligand.
4.  ligand\_rms\_with\_super. RMSD between the native ligand and the docked ligand after rigid-body aligning the two in XYZ space. This is useful for evaluating how much internal ligand flexibility was sampled.

RMSD calculations use an "automorphic" rmsd, which accounts for internal symmetries and equivalent atoms in the ligand (e.g. 180 degree phenyl ring flips).

For the ligand_centroid_travel and ligand_rms_no_super terms, it is assumed that the native has already been aligned with the input protein -- the ligand coordinates are used as-is, and no protein/protein alignment is done prior to the travel and rmsd calculation.

If the `native_ensemble_best` option is enabled, it is assumed the working pose has only a single residue on the relevant chain, and the "native" pose has one or more residues on the corresponding chain. The travel and rmsd values will be calculated separately for each of the residues in the corresponding chain, and the lowest value will be reported. This can be useful if there are multiple native states which can all be considered "correct". 

##See Also

* [[ProteinInterfaceMSMover]]: Mover for multistate design of protein interfaces
* [[DnaInterfacePackerMover]]
* [[InterfaceAnalyzerMover]]
* [[InterfaceRecapitulationMover]]
* [[I want to do x]]: Guide to choosing a mover