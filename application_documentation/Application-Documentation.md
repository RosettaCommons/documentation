#Application Documentation

Below is a list of the currently released applications containing developer documentation. Click on an application to
see a more detailed description of the purpose and for detailed examples. If a released application is missing, please
file a bug in our [issue tracker](http://bugs.rosettacommons.org).

If you are unsure which application best fits your biological problem, you may want to start [[here|Solving-a-Biological-Problem]].

A collection of example command lines can be found [[here|commands-collection]].

**Table of Contents** 

- [[Scripting interfaces to Rosetta functionality|Application Documentation#scripting]]
- [Structure Prediction](Application Documentation#Structure-Prediction)
- [Docking](Application Documentation#Docking)
- [Design](Application Documentation#Design)
- [Membrane Proteins](Application Documentation#Membrane-Proteins)
- [Analysis](Application Documentation#Analysis)
- [UI](Application Documentation#UI)
- [Utilities](Application Documentation#Utilities)
- [Other](Application Documentation#Other)

##Scripting interfaces to Rosetta functionality <a name="scripting" />
- [[RosettaScripts]]: An XML-based scripting interface
- [[The Topology Broker|BrokeredEnvironment]]: Rapid protocol prototyping in C++, [[PyRosetta]], and [[RosettaScripts]]
- [[PyRosetta]]: Python wrappings for Rosetta

##Structure Prediction <a name="Structure-Prediction" />
While most of these applications focus on prediction, many have options which will also allow design.

- [[Ab initio modeling|abinitio-relax]] - Predict 3-dimensional structures of proteins from their amino acid sequences.  
    * [[Membrane abinitio]] - Ab initio for membrane proteins.  
    * [[Metalloprotein ab initio|metalloprotein-abrelax]] - Ab inito modeling of metalloproteins.  
- [[Backrub]] - Create backbone ensembles using small, local backbone changes.  
- Comparative modeling - Build structural models of proteins using one or more known structures as templates for modeling.  
    * [[Original protocol | minirosetta-comparative-modeling]]
    * [[RosettaCM]]   
    * [[IterativeHybridize]]

- [[Floppy tail]] - Predict structures of long, flexible N-terminal or C-terminal regions.
- [[Fold-and-dock]] - Predict 3-dimensional structures of symmetric homooligomers.  
- [[Molecular replacement protocols|mr-protocols]] - Use Rosetta to build models for use in X-ray crystrallography molecular replacement.  
    * [[Prepare template for MR]] - Setup script for molecular replacement protocols.  
- [[Relax]] - "Locally" optimize structures, including assigning sidechain positions.
- [ RNA ](#RNA) - see below for apps, including FARFAR & ERRASER (crystallographic refinement).  
- [[Simple Cyclic Peptide Prediction|simple_cycpep_predict]] - Prediction of structures of small (~5-20 residue) backbone-cyclized peptides consisting of any mixture of L- and D-amino acids.
  
--------------------------

###Antibody Modeling
- [[Antibody protocol]] (RosettaAntibody3) - Overview of the antibody modeling protocol.  
    * [[Grafting CDR loops|antibody-assemble-cdrs]] - Graft antibody CDR templates on the framework template to create a rough antibody model.  
    * [[Modeling CDR H3|antibody-model-CDR-H3]] - Determine antibody structures by combining VL-VH docking and H3 loop modeling.


------------------------

###Carbohydrate Modeling
* [[WorkingWithGlycans]]

#### Apps

Application | Description
------------ | -------------
[[GlycanRelax]] | Model glycan trees using known carbohydrate information.  Works for full denovo modeling or refinement.
[[GlycanInfo]] | Get information on all glycan trees within a pose
[[GlycanClashCheck]] | Obtain data on model clashes with and between glycans, or between glycans and other protein chains.

#### RosettaScript Components

Component | Description
------------ | -------------
[[GlycanRelaxMover]] | Model glycan trees using known carbohydrate information.  Works for full denovo modeling or refinement.
[[SimpleGlycosylateMover]] | Glycosylate poses with glycan trees.  
[[GlycanTreeSelector]] | Select individual glcyan trees or all of them
[[GlycanResidueSelector]] | Select specific residues of each glycan tree of interest.

---------------------------

###Loop Modeling
-  [[Loop modeling overview|loopmodel]]
-  [[CCD loop modeling|loopmodel-ccd]] - Sample loop conformations using fragments and the CCD closure algorithm.
-  [[Kinematic loop modeling|loopmodel-kinematic]] - Sample loop conformations using the kinematic closure algorithm.
-  [[Next-generation KIC]] - A newer version of loop modeling with kinematic closure.
-  [[KIC with fragments|KIC_with_fragments]] - The latest version of loop modeling, combining kinematic closure with sampling of coupled degrees of freedom from fragments.
-  [[Stepwise assembly of protein loops|swa-protein-main]] - Generate three-dimensional de novo models of protein segments     -  [[Stepwise assembly of long loops|swa-protein-long-loop]] - For loops greater than 4-5 residues. See also  [[Stepwise monte carlo|stepwise]].
-  [[Stepwise monte carlo|stepwise]] - Generate 3D models of protein, RNA, and protein/RNA loops, motifs, and interfaces. Stochastic version of stepwise assembly. 

-----------------------------

###RNA and RNA/protein
-  [[RNA structure prediction|rna-denovo-setup]] - Predict 3-dimensional structures of RNA from their nucleotide sequence. Read this first. 
 *  [[RNA tools]] - Tools useful for RNA and RNA/proteinm including general PDB editing, cluster submission, job setup.
 *  [[RNA threading|rna-thread]] - Thread a new nucleotide sequence on an existing RNA structure.  
 *  [[RNA motif prediction|rna denovo]] - Model RNA motifs with fragment assembly of RNA with full atom refinement (FARFAR).
 * [[CS Rosetta RNA]]: Refines and scores an RNA structure using NMR chemical shift data.
-  [[RNA stepwise loop enumeration|swa-rna-loop]] - Build RNA loops using deterministic stepwise assembly. See also  [[Stepwise monte carlo|stepwise]].
-  [[Stepwise monte carlo|stepwise]] - Generate 3D models of protein, RNA, and protein/RNA loops, motifs, and interfaces. Stochastic version of stepwise assembly. 
-  [[RNA assembly with experimental constraints|rna-assembly]] - Predict 3-dimensional structures of large RNAs with the help of experimental constraints. Note – largely deprecated by newer pipeline (documentation coming soon).
-  [[ERRASER]] - Refine an RNA structure given electron density constraints.  
-  [[DRRAFTER]] - Build RNA coordinates into cryoEM maps of RNA-protein assemblies.
-  [[Sample around nucleobase]] - Visualizing energy functions by scanning probe molecules around a nucleobase.
-  [[RECCES]] - RNA free energy calculation with comprehensive sampling.
-  [[RNA pharmacophore]] - Extract and cluster the key features present in RNA (rings, hbond donors & acceptors) from the structure of a protein-RNA complex.


---------------------------------

##Docking <a name="Docking" />

###Antibody Docking
- [[Camelid antibody docking|antibody-mode-camelid]] - Dock camelid antibodies to their antigens.
- [[SnugDock | snugdock]] - Paratope structure optimization during antibody-antigen docking

###Ligand Docking
- [[Ligand docking|ligand-dock]] (RosettaLigand) - Determine the structure of protein-small molecule complexes.  
   * [[Extract atomtree diffs]] - Extract structures from the AtomTreeDiff file format.

- [[Docking Approach using Ray-Casting|DARC]] (DARC) - Docking method to specifically target protein interaction sites.
 
###Peptide Docking
- [[Flexible peptide docking|flex-pep-dock]] - Dock a flexible peptide to a protein.

###Protein-Protein Docking
- [[Protein-Protein docking|docking-protocol]] (RosettaDock) - Determine the structures of protein-protein complexes by using rigid body perturbations.  
    * [[Docking prepack protocol]] - Prepare structures for protein-protein docking.  
    * [[Motif Dock Score]] - Efficient low-resolution protein-protein docking.

- [[Symmetric docking|sym-dock]] - Determine the structure of symmetric homooligomers.  

- [[Chemically conjugated docking|ubq-conjugated]] - Determine the structures of ubiquitin conjugated proteins.  

###Ion docking
- [[ Mg(2+) modeling | mg-modeler ]] - Basic code for docking Mg(2+) -- with or without explicit waters -- initially tested for RNA.

###Protein-Surface Docking
- [[Surface Docking|surface-docking]] - Dock a protein to a metal or mineral surface.
 
------------------------------

##Design <a name="Design" />

### General 

- [[Fixed backbone design|fixbb]] - Optimize sidechain-rotamer placement and identity on fixed backbones.  
   * [[Fixed backbone design with hpatch|fixbb-with-hpatch]] - Fixed backbone design with a penalty for hydrophobic surface patches.  

- [[Multistate design|mpi-msd]] - Optimize proteins for multiple desired and undesired contexts.

-------------------------------------------

- [[Anchored design]] - Design interfaces using an "anchor" of known interactions.  
    * [[Anchored pdb creator]] - Prepare starting files for AnchoredDesign.  
    * [[Anchor finder]] - Find interactions which can serve as "anchors" for AnchoredDesign. 

- [[Create clash-based repack shell]] -- Supplement a design resfile with residues which may clash. 

- [[RosettaAntibodyDesign]] - Design Antibodies and Antibody-Antigen complexes

- [[revert-design-to-native]] - Get energetic contribution of designed residues to predicted binding energy

- [[RosettaRemodel]] - Redesign backbone and sequence of protein loops and secondary structure elements. 
    * [[Remodel]] - Additional remodel documentation

- [[curvedsheetdesign]] - Design backbones for curved beta sheets

- [[Sequence tolerance]] - Optimize proteins for library applications (e.g. phage or yeast display).  

-  [[Stepwise design|stepwise]] - Simultaneously optimize sequence and structure for small RNA and protein segments. Part of the stepwise application.

- [[Zinc heterodimer design]] - Design zinc-mediated heterodimers.  

### Stability Improvement

- [[Point mutation scan|pmut-scan-parallel]] - Identifiy stabilizing point mutants.  

- [[Supercharge]] - Reengineer proteins for high net surface charges, to counter aggregation.

- [[Void Identification and Packing|vip-app]] (RosettaVIP) - Identify and fill cavities in a protein.

### Enzymes

- [[Enzyme Design]] - Design a protein around a small molecule, with catalytic constraints. 

### Peptides
- [[Pepspec]] - Evaluate and design peptide-protein interactions.

### Small Molecules

- [[Match]] - Place a small molecule into a protein pocket so it satisfies given geometric constraints.  

- [[OOP design]] - Design proteins with oligooxopiperazine residues.  

- [[DougsDockDesignMinimize|doug-dock-design-min-mod2-cal-cal]] - Redesign the protein/peptide interface of Calpain and a fragment of its inhibitory peptide calpastatin.

- [[theta ligand]] - Calculate the fraction of ligand that is exposed to the solvent in a protein-ligan complex.
 
  
### RNA

- [[RNA design]] - Optimize RNA sequence for fixed backbones.  

-  [[Stepwise design|stepwise]] - Simultaneously optimize sequence and structure for small RNA and protein segments. Part of the stepwise application.

### DNA

- [[Rosetta DNA]] (RosettaDNA) - Design and model protein interactions to DNA. 

### Secondary Structure

- [[Hydrogen bond surrogate design|hbs-design]] - Design stabilized alpha helical binders.

- [[Beta strand homodimer design]] - Find proteins with surface exposed beta-strands, then design a homodimer that will form via that beta-strand.  

--------------------------------

##Membrane Proteins <a name="Membrane-Proteins" />

### Getting Started
- [[ Overview | RosettaMP-GettingStarted-Overview]]
- [[ Preparing Inputs | RosettaMP-GettingStarted-PreparingInputs]]
- [[ Options (Flags) | RosettaMP-GettingStarted-Options]]

### Key Elements in RosettaMP
- [[ Membrane Representation (Residue) | RosettaMP-KeyElements-MembraneRsd ]]
- [[ Embedding | RosettaMP-KeyElements-Embedding ]]
- [[ Movers | RosettaMP-KeyElements-Movers ]]
- [[ Energy Functions | RosettaMP-KeyElements-EnergyFunction ]]
- [[ Visualization | RosettaMP-KeyElements-Visualization ]]

### Applications
 - Relax:
    * [[mp_relax|RosettaMP-App-MPFastRelax]] - High-resolution refinement of membrane protein structures with optimization of the membrane position using minimization (uses membrane framework and FastRelax)
 - ddG:
    * [[mp_ddG|RosettaMP-App-MPddG]] - Prediction of free energy changes upon mutation using the membrane framework
 - Docking:
    * [[mp_dock|RosettaMP-App-MPDock]] - Protein-protein docking in the membrane (uses membrane framework)
    * [[mp_dock_setup|RosettaMP-App-MPDockSetup]] - Setup tools required to run MPDock
    * [[mp_symdock|RosettaMP-App-MPSymDock]] - Assemble symmetric complexes in the membrane environment (uses membrane framework)
 - Viewer:
    * [[mp_viewer|RosettaMP-App-MPPyMOLViewer]] - Standalone application for visualization of membrane protein simulations in real-time using pymol (uses membrane framework)
 - Tools:
    * [[score_jd2|RosettaMP-App-MPScoring]] - Settings for using score_jd2 with the RosettaMP scoring functions. 
    * [[mp_span_from_pdb|RosettaMP-App-MPSpanFromPDB]] - Calculate trans-membrane spans from the PDB structure
    * [[mp_transform|RosettaMP-App-MPTransform]] - Transforming the protein into membrane coordinates.

##Utilities

- [[mp_utilities | RosettaMP-Utilities]] - Various utilities with membrane options.

----------------------------------

##Analysis <a name="Analysis" />

### Scoring 

- [[Score|score-commands]] - Calculate Rosetta energy for structures.

- [[Residue energy breakdown]] - Decompose scores into intra-residue and residue pair interactions.

- [[ddG monomer]] - Predict the change in stability (the ddG) of a monomeric protein induced by a point mutation.

- [[flex ddG]] - Predict change in interaction energy at a protein-protein interface post-mutation. Benchmarked to work for single point mutations or sets of multiple mutations. Slower than some other protocols since more sampling is included, but is particularly useful for multiple mutations or small-to-large mutations in interfaces.

- [[cartesian-ddg]] - A different version of ddg calculation, using Cartesian space sampling

- [[Density map scoring]] - Score structures with electron density information.  

### Clustering 

- [[calibur|calibur-clustering]] - (Preferred application) Cluster structures using a port of [calibur](http://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-11-25) into Rosetta .   

- [[cluster |Cluster]] - Original Rosetta++ app. Fails (_i.e_ silently produces meaningless results) at large number of decoys.

- [[energy_based_clustering|energy_based_clustering_application]] - A fast energy-based clustering approach optimized for large numbers of structures.

 

### Constraints

- [[Constraint Info]] - Get information about how a structure matches Rosetta constraints.

### Feature Reporter Framework
 - [[FeatureReporters]] - Framework for the analysis, and comparison of various features of PDB structures
 - [[FeaturesTutorials]] - Tutorials for the Feature Reporter Analysis Framework

### Interfaces

- [[Interface analyzer]] - Calculate metrics evaluating interfaces. 

### Peptides

- [[PeptiDerive]] - derives from a given interface the linear stretch that contributes most of the binding energy.

### Packing Quality
- [[RosettaHoles]] - Rapid assessment of protein core packing for structure prediction, design, and validation

### Surface pockets
- [[Pocket measure|pocket-measure]] - Measure the "deep volume" of a surface pocket.

### Buried unsatisfied polar atoms
- [[shobuns|shobuns]] - Identifies polar atoms that are buried unsatisfied for the SHO model of polar solvation

### Residue disorder prediction
- [[ResidueDisorder|ResidueDisorder]] - Predict order/disorder of each residue in a protein.

### Residue Solvent Exposure
- [[PerResidueSolventExposure|PerResidueSolventExposure]] - Calculate the per residue solvent exposure in the form of a neighbor count

##UI <a name="UI" />

[[Workbench|/internal_documentation/ui/workbench]] - UI front end to submit Rosetta jobs from desktop client

##Utilities <a name="Utilities" />

These applications serve mainly to support other Rosetta applications, or to assist in setting up or analyzing Rosetta runs.

### General
- [[Build peptide]] - Build extended peptides or protein structures from sequences. 

- [[Dump a capped residue|dump-capped-residue]] - Output a PDB file containing a residue (specifiable by name), with options that can control polymeric patch state

- [[CA to allatom]] - Build fullatom models from C-alpha-only traces.  

- [[Create symmetry definition|make-symmdef-file-denovo]] - Create Rosetta symmetry definition files for a point group.  
    * [[Create symmetry definition from structure|make-symmdef-file]] - Create Rosetta symmetry definition files from template PDBs. 

- [[Batch distances]] - Calculate the closest approach for residue-residue pairs.
 
- [[Fragment picker|app-fragment-picker]] - Pick fragments to be used in conjunction with other fragment-aware Rosetta applications.  
    * [[Old fragment picker|fragment-picking-old]] - The older version of the fragment picker.  
    * [[Structure Set Fragment Picker|Structure-Set-Fragment-Picker]] - Pick fragments from a provided set of pdb files

- [[Make exemplars|make-exemplar]] - Create an exemplar for surface pockets on a protein that touch a target residue.

- [[OptE|opt-e-parallel-doc]] - Refit reference weights in a scorefunction to optimize given metrics.  

- [[Pocket target residue suggestion|pocket-suggest-targets]] - Suggest the best pair of target residues for pocket optimization for the purpose of inhibiting a protein-protein interaction.

- [[Pocket relax|pocket-relax]] - Relax followed by full atom minimization and scoring with no PocketConstraint. Useful when performing pocket optimization.

- [[PyMol server]] - Observe what a running Rosetta program is doing by using PyMol.

- [[Sequence recovery]] - Calculate the mutations and native recovery from Rosetta design runs.

- [[Torsional potential correction|torsional-potential-corrections]] - Remove double counting interactions from the sidechain torsional potential

###Non-canonical amino acids
 - [[Make rotamer library|make-rot-lib]] - Generate rotamer libraries for non-canonical amino acids.  
 - [[Unfolded state energy calculator]] - Determine the baseline energy of non-canonical amino acids in the unfolded state.  

  
## Other <a name="Other" />

- [[Collection of example commandlines|commands-collection]]

- [[minirosetta]] - The "minirosetta" boinc wrapper application.

* [[Tools]]: List of useful accessory scripts included with Rosetta

##See Also

* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Rosetta Servers]]: Web-based servers for Rosetta applications
* [[Commands collection]]: A list of example command lines for running Rosetta executable files
* [[Getting Started]]: A page for people new to Rosetta
* [[Scripting Documentation]]: Scripting interfaces to Rosetta
* [[RosettaScripts]]: The RosettaScripts home page
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Comparing structures]]: Essay on comparing structures
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[TACC]]: Information for running Rosetta on the TACC/Stampede cluster.