#Structure Prediction Applications

While most of these applications focus on prediction, many have options which will also allow design.

- [[Ab initio modeling|abinitio-relax]]: Predict 3-dimensional structures of proteins from their amino acid sequences.
    * [[Abinitio]]: Further documentation on the abinitio protocol
    * [[NonlocalAbinitio]]: Application for predicting protein structure given some information about the protein's structure.
    * [[Membrane abinitio]]: Ab initio for membrane proteins.  
    * [[Metalloprotein ab initio|metalloprotein-abrelax]]: Ab inito modeling of metalloproteins.  
- [[Backrub]]: Create backbone ensembles using small, local backbone changes.  
- [[Comparative modeling|minirosetta-comparative-modeling]]: Build structural models of proteins using one or more known structures as templates for modeling.  
- [[Floppy tail]]: Predict structures of long, flexible N-terminal or C-terminal regions.
- [[Fold-and-dock]]: Predict 3-dimensional structures of symmetric homooligomers.  
- [[Molecular replacement protocols|mr-protocols]]: Use Rosetta to build models for use in X-ray crystallography molecular replacement.  
    * [[Prepare template for MR]]: Setup script for molecular replacement protocols.  
- [[Relax]]: "Locally" optimize structures, including assigning sidechain positions.
- [ RNA ](#RNA): see below for apps, including FARFAR & ERRASER (crystallographic refinement).  
- [[RosettaNMR with Paramagnetic Restraints|RosettaNMR with Paramagnetic Restraints]]: Structure prediction in RosettaNMR using backbone chemical shifts and paramagnetic restraints derived from metal ion tags.
  

###Loop Modeling
-  [[Loop modeling overview|loopmodel]]
-  [[CCD loop modeling|loopmodel-ccd]]: Sample loop conformations using fragments and the CCD closure algorithm.
-  [[Kinematic loop modeling|loopmodel-kinematic]]: Sample loop conformations using the kinematic closure algorithm.
-  [[Next-generation KIC]]: A newer version of loop modeling with kinematic closure.
-  [[KIC with fragments|KIC_with_fragments]]: The latest version of loop modeling, combining kinematic closure with sampling of coupled degrees of freedom from fragments.
-  [[Loop closing]]: Closing chainbreaks introduced during modeling.
-  [[Stepwise assembly of protein loops|swa-protein-main]]: Generate three-dimensional de novo models of protein segments    :  [[Stepwise assembly of long loops|swa-protein-long-loop]]: For loops greater than 4-5 residues. See also  [[Stepwise monte carlo|stepwise]].
-  [[Stepwise monte carlo|stepwise]]: Generate 3D models of protein, RNA, and protein/RNA loops, motifs, and interfaces. Stochastic version of stepwise assembly. 

###RNA and RNA/protein <a name="RNA" />
-  [[RNA structure prediction|rna-denovo-setup]]: Predict 3-dimensional structures of RNA from their nucleotide sequence. Read this first. 
 *  [[RNA tools]]: Tools useful for RNA and RNA/proteinm including general PDB editing, cluster submission, job setup.
 *  [[RNA threading|rna-thread]]: Thread a new nucleotide sequence on an existing RNA structure.  
 *  [[RNA motif prediction|rna denovo]]: Model RNA motifs with fragment assembly of RNA with full atom refinement (FARFAR).
-  [[RNA stepwise loop enumeration|swa-rna-loop]]: Build RNA loops using deterministic stepwise assembly. See also  [[Stepwise monte carlo|stepwise]].
-  [[Stepwise monte carlo|stepwise]]: Generate 3D models of protein, RNA, and protein/RNA loops, motifs, and interfaces. Stochastic version of stepwise assembly. 
-  [[RNA assembly with experimental constraints|rna-assembly]]: Predict 3-dimensional structures of large RNAs with the help of experimental constraints. Note – largely deprecated by newer pipeline (documentation coming soon).
-  [[ERRASER]]: Refine an RNA structure given electron density constraints.  
-  [[Sample around nucleobase]]: Visualizing energy functions by scanning probe molecules around a nucleobase.
-  [[RECCES]]: RNA free energy calculation with comprehensive sampling.
-  [[RNA pharmacophore]]: Extract and cluster the key features present in RNA (rings, hbond donors & acceptors) from the structure of a protein-RNA complex.

###Antibody Modeling
- [[Antibody protocol]] (RosettaAntibody3): Overview of the antibody modeling protocol.  
    * [[Antibody Python script]]: The setup script.  
    * [[Grafting CDR loops|antibody-assemble-cdrs]]: Graft antibody CDR templates on the framework template to create a rough antibody model.  
    * [[Modeling CDR H3|antibody-model-CDR-H3]]: Determine antibody structures by combining VL-VH docking and H3 loop modeling.

###TCR Modeling
- [[TCRmodel protocol|TCRmodel]]: Application for modeling T cell receptors from sequence.  

##See Also

* [[Minirosetta]]: More information on the MiniRosetta app
* [[Rosetta Servers]]: Servers that provide access to some Rosetta applications
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files