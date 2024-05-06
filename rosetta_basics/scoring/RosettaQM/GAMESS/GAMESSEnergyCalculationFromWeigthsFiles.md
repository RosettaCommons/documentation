[ This page is temporary to avoid conflicts on branches. The content will be moved to single point scoring with gamess]

## 

There are different ways to set a scoring function. One can also use a weights file for this purpose. You will need to create a file with `.wts` format in directory `<path-to-Rostta>/main/database/scoring/weights`. Here is an example of content in this file:

```
BEGIN_GAMESS_SETTINGS
gamess_threads="2" 
gamess_basis_set="N31" 
gamess_ngaussian="4" 
gamess_dft_functional="B3LYPV3"
gamess_electron_correlation_treatment="DFT" 
gamess_max_scf_iterations="100"
gamess_fmo_calculation="true"
gamess_max_fmo_monomer_scf_iterations="100"
gamess_hybrid_molecular_orbital="4-31G"
gamess_hybrid_molecular_orbital_file="tools/fmo/HMO/c.txt"
END_GAMESS_SETTINGS

BEGIN_GAMESS_QM_CONFIGURATION
fmo_fragmentation_method="carbon_carbon_favouring_residue_based_fragments"
END_GAMESS_QM_CONFIGURATION

gamess_qm_energy 1.0
```

In the first block, `BEGIN_GAMESS_SETTINGS ... END_GAMESS_SETTINGS` you can use any tag that is used in `<Set/>` section in Rosetta scripts. 

In the second block, `BEGIN_GAMESS_QM_CONFIGURATION ... END_GAMESS_QM_CONFIGURATION` you can use any tag that is used in `<QMConfiguration …/>` section in Rosetta scripts. 

The last section `gamess_qm_energy 1.0` set a weight of `1.0` for `gamess_qm_energy` score term. This number will be multiplied by the output of `gamess_qm_energy` to give a final score. Therefore, setting it to `1.0` will give the original score. One might change it to change the scale of score for different reasons. Note that the output of RosettaQM has a unit of **kcal/mol**.