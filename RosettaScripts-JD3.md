## RosettaScripts JD3

This app uses a file called the `job_definition_file` to run a RosettaScript with different inputs or settings in a single job.  It is extremely useful for benchmarking. 

## Reference


**Growing Glycans in Rosetta: Accurate de novo glycan modeling, density fitting, and rational sequon design**
Jared Adolf-Bryfogle, J. W Labonte, J. C Kraft, M. Shapavolov, S. Raemisch, T. Lutteke, F. Dimaio, C. D Bahl, J. Pallesen, N. P King, J. J Gray, D. W Kulp, W. R Schief
_bioRxiv_ 2021.09.27.462000; [[https://doi.org/10.1101/2021.09.27.462000]]


[[_TOC_]]

## Example Command


```rosetta_scripts_jd3.macosclangrelease -job_definition_file my_job_definition_file.xml```

## Job Definition File


This file lists the per-job settings and xml files used.  You can mix and match.  Only certain global options are allowed to change.  If you wish to try different settings, use the script_vars option for the XML to control different jobs. 

Here is an example with different PDBs, script vars, etc. 
In general, you should have Input and Output for each job as well as the parser protocol listed. 

### Example

```xml

<JobDefinitionFile>
   <Job>
      <Input>
         <PDB filename="pdbs/pareto/1gai_refined.pdb.gz"/>
      </Input>
      <Output>
         <PDB filename_pattern="glycan-build_100_hybrid-build-two_171A/glycan-build_100_hybrid-build-two_171A_$"/>
      </Output>
      <Options>
         <parser__protocol value="xmls/glycan_tree_relax.xml"/>
         <parser__script_vars value="branch=171A cartmin=0 layer_size=2 window_size=0 glycan_sampler_rounds=100 quench_mode=0 map=maps/1gai_2mFo-DFc_map.ccp4 symmdef=pdbs/symmetrized_structures/1gai_crys.symm shear=1 rounds=1 conformer_probs=0 gaussian_sampling=1 hybrid_protocol=1 exp=hybrid-conformer-build-two match=1"/>
         <in__file__native value="pdbs/pareto/1gai_refined.pdb.gz" />
      </Options>
   </Job>
   <Job>
      <Input>
         <PDB filename="pdbs/pareto/1gai_refined.pdb.gz"/>
      </Input>
      <Output>
         <PDB filename_pattern="glycan-build_100_hybrid-build-one_171A/glycan-build_100_hybrid-build-one_171A_$"/>
      </Output>
      <Options>
         <parser__protocol value="xmls/glycan_tree_relax.xml"/>
         <parser__script_vars value="branch=171A cartmin=0 layer_size=1 window_size=0 glycan_sampler_rounds=100 quench_mode=0 map=maps/1gai_2mFo-DFc_map.ccp4 symmdef=pdbs/symmetrized_structures/1gai_crys.symm shear=1 rounds=1 conformer_probs=0 gaussian_sampling=1 hybrid_protocol=1 exp=hybrid-conformer-build-one match=1"/>
         <in__file__native value="pdbs/pareto/1gai_refined.pdb.gz" />
      </Options>
   </Job>
   <Job>
      <Input>
         <PDB filename="pdbs/pareto/1jnd_refined.pdb.gz"/>
      </Input>
      <Output>
         <PDB filename_pattern="glycan-build_100_gs-final_200A/glycan-build_100_gs2_200A_$"/>
      </Output>
      <Options>
         <parser__protocol value="xmls/gs.xml"/>
         <parser__script_vars value="branch=200A cartmin=0 layer_size=2 window_size=1 glycan_sampler_rounds=100 quench_mode=0 map=maps/1jnd_2mFo-DFc_map.ccp4 symmdef=pdbs/symmetrized_structures/1jnd_crys.symm shear=1 rounds=1 conformer_probs=0 gaussian_sampling=1 exp=gs-final"/>
         <in__file__native value="pdbs/pareto/1jnd_refined.pdb.gz" />
      </Options>
   </Job>
   <Job>
      <Input>
         <PDB filename="pdbs/pareto/1jnd_refined.pdb.gz"/>
      </Input>
      <Output>
         <PDB filename_pattern="glycan-build_50_hybrid-gs-even-final_200A/glycan-build_50_hybrid-gs-even2_200A_$"/>
      </Output>
      <Options>
         <parser__protocol value="xmls/gtm_gs.xml"/>
         <parser__script_vars value="branch=200A cartmin=0 layer_size=2 window_size=1 glycan_sampler_rounds=50 quench_mode=0 map=maps/1jnd_2mFo-DFc_map.ccp4 symmdef=pdbs/symmetrized_structures/1jnd_crys.symm shear=1 rounds=1 conformer_probs=0 gaussian_sampling=1 exp=hybrid-gs-even-final"/>
         <in__file__native value="pdbs/pareto/1jnd_refined.pdb.gz" />
      </Options>
   </Job>
</JobDefinitionFile>

### Input

### Output

### Options Accepted