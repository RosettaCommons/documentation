_Question: What is ToxDock?_

**Answer:** ToxDock is an application geared towards docking toxin peptides to homology models of ion channels (Leffler et al. 2017) and it is available on the [ROSIE server](https://rosie.graylab.jhu.edu/tox_dock). Detailed information on its use can be found at [https://rosie.graylab.jhu.edu/tox_dock/documentation](https://rosie.graylab.jhu.edu/tox_dock/documentation).

_Question: Why isn’t there a Rosetta protocol for the ToxDock application?_

**Answer:** Ensembles were not implemented in the Job Distributor back in the time, which may or may not be the case now, so the protocol was not merged to the master. 

_Question: Is it possible to use ToxDock outside the ROSIE server?_

**Answer:** Yes. The supplementary information section of the original paper https://www.pnas.org/content/pnas/suppl/2017/09/04/1703952114.DCSupplemental/pnas.1703952114.sapp.pdf

ToxDock first consists of a step in which the entire peptide: receptor complex is relaxed 200 times using Rosetta FastRelax. This results in an ensemble of 200 structures in which the backbones of the receptor and peptide have been allowed to move as well as adjust their positions relative to each other. Side chains are repacked as well. Then, the top five complexes by total Rosetta score are selected. To refine the interface between the peptide and complex, as well as search for lower-energy peptide binding modes, docking is then carried out on the relaxed complexes. This consisted of running 500 docking simulations for each complex with Rosetta’s flexible peptide docking application, FlexPepDock. The refinement mode of the docking application is used, including a low-resolution preoptimization docking phase and rotamers from a homologous, apo receptor structure. Additional rotamers are included as well with the ex1 and ex2 flags. Finally, the reweighted scores from the 2500 docked complexes are pooled and the average and standard error computed over the 1% best scoring structures; this score is the ensemble docking score. The talaris2013 weight set was used for all calculations. 

The command line used for the FastRelax application is: 

mpiexec -np 80 /path/to/Rosetta/source/bin/relax.mpi.linuxiccrelease -in:file:l /path/to/file/list -database /path/to/Rosetta/database/ -score:weights talaris2013 -use_input_sc -ex1 -ex2 -relax:fast -in:file:fullatom -nstruct 200 -out:suffix ".FastRelaxApp" -overwrite -mpi_tracer_to_file out_mpi.log 
The command line used for FlexPepDock is: mpiexec -np 80 

/path/to/Rosetta/source/bin/FlexPepDocking.mpi.linuxiccrelease - database /path/to/Rosetta/database -l /path/to/file/list -score:weights talaris2013 -pep_refine -ex1 -ex2 -use_input_sc -nstruct 500 -unboundrot /path/to/apo/pdb - receptor_chain AB -peptide_chain F -lowres_preoptimize 1 -out:suffix ".FPD-refine" 

A typical chemical system used for ToxDock contained more than 400 receptor residues and 15-20 peptide residues. For a system of this size, the first stage of the ensemble docking protocol required approximately 90 hrs of CPU time (about 1 hour of wall time on a cluster using 80 processors), while the second step used around 150 hours of CPU time (about 2 hours of wall time on 80 processors). Thus, on a reasonable sized cluster the run time is about 3 hours per peptide. These simulations were conducted using Rosetta revision 57232 compiled with support for MPI.

_Question: The score function used in the paper was talaris2013, but the current score function is ref2015. Which score function to use now?_

**Answer:** Talaris2013 performed better in FlexPepDock calculations compared to ref2015.

_Question: The ToxDock protocol involves post-check steps to determine feasibility of a mutation based on conserved sequences. How to run these steps when the protocol is not run on ROSIE?_

**Answer:** The post-check steps are optional. They can be ignored or applied as post-processing steps. 


**References**
***
1) Leffler, A. E., Kuryatov, A., Zebroski, H. A., Powell, S. R., Filipenko, P., Hussein, A. K., . . . Holford, M. (2017). Discovery of peptide ligands through docking and virtual screening at nicotinic acetylcholine receptor homology models. Proc Natl Acad Sci U S A, 114(38), E8100-E8109. doi: 10.1073/pnas.1703952114  