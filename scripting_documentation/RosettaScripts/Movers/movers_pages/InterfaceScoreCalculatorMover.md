# InterfaceScoreCalculator
*Back to [[Mover|Movers-RosettaScripts]] page.*
## InterfaceScoreCalculator

```
<InterfaceScoreCalculator name="(string)" chains="(comma" separated chars) scorefxn="(string)" native="(string)" compute_grid_scores="(bool)"/>
```

InterfaceScoreCalculator calculates a myriad of ligand specific scores and appends them to the output file. After scoring the complex the ligand is moved 1000 Å away from the protein. The model is then scored again. An interface score is calculated for each score term by subtracting separated energy from complex energy. If compute\_grid\_scores is true, the scores for each grid will be calculated. This may result in the regeneration of the scoring grids, which can be slow. If a native structure is specified, 4 additional score terms are calculated:

1.  ligand\_centroid\_travel. The distance between the native ligand and the ligand in our docked model.
2.  ligand\_radious\_of\_gyration. An outstretched conformation would have a high radius of gyration. Ligands tend to bind in outstretched conformations.
3.  ligand\_rms\_no\_super. RMSD between the native ligand and the docked ligand.
4.  ligand\_rms\_with\_super. RMSD between the native ligand and the docked ligand after aligning the two in XYZ space. This is useful for evaluating how much ligand flexibility was sampled.


##See Also

* [[ProteinInterfaceMSMover]]: Mover for multistate design of protein interfaces
* [[DnaInterfacePackerMover]]
* [[InterfaceAnalyzerMover]]
* [[InterfaceRecapitulationMover]]
* [[I want to do x]]: Guide to choosing a mover