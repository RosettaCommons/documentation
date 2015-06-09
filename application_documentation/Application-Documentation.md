#Application Documentation

Below is a list of the currently released applications containing developer documentation. Click on an application to
see a more detailed description of the purpose and for detailed examples. If a released application is missing, please
file a bug in our [issue tracker](http://bugs.rosettacommons.org).

**Table of Contents** 

- [[Scripting interfaces to Rosetta functionality|Application Documentation#Scripting-interfaces-to-Rosetta-functionality]]
- [Structure Prediction](#Structure-Prediction)
- [Docking](#Docking)
- [Design](#Design)
- [Membrane Proteins](#Membrane Proteins)
- [Analysis](#Analysis)
- [Utilities](#Utilities)
- [Other](#Other)

##Scripting interfaces to Rosetta functionality
- [[RosettaScripts]]: An XML-based scripting interface
- [[The Topology Broker|BrokeredEnvironment]]: Rapid protocol prototyping in C++, [[PyRosetta]], and [[RosettaScripts]]
- [[PyRosetta]]: Python wrappings for Rosetta

##Structure Prediction
While most of these applications focus on prediction, many have options which will also allow design.

- [[Ab initio modeling|abinitio-relax]] - Predict 3-dimensional structures of proteins from their amino acid sequences.  
    * [[Membrane abinitio]] - Ab initio for membrane proteins.  
    * [[Metalloprotein ab initio|metalloprotein-abrelax]] - Ab inito modeling of metalloproteins.  
- [[Backrub]] - Create backbone ensembles using small, local backbone changes.  
- [[Comparative modeling|minirosetta-comparative-modeling]] - Build structural models of proteins using one or more known structures as templates for modeling.  
- [[Floppy tail]] - Predict structures of long, flexible N-terminal or C-terminal regions.
- [[Fold-and-dock]] - Predict 3-dimensional structures of symmetric homooligomers.  
- [[Molecular replacement protocols|mr-protocols]] - Use Rosetta to build models for use in X-ray crystrallography molecular replacement.  
    * [[Prepare template for MR]] - Setup script for molecular replacement protocols.  
- [[Relax]] - "Locally" optimize structures, including assigning sidechain positions.
- [ RNA ](#RNA) - see below for apps, including FARFAR & ERRASER (crystallographic refinement).  

  

###Loop Modeling
-  [[Loop modeling overview|loopmodel]]
-  [[CCD loop modeling|loopmodel-ccd]] - Sample loop conformations using fragments and the CCD closure algorithm.
-  [[Kinematic loop modeling|loopmodel-kinematic]] - Sample loop conformations using the kinematic closure algorithm.
-  [[Next-generation KIC]] - A newer version of loop modeling with kinematic closure.
-  [[KIC with fragments|KIC_with_fragments]] - The latest version of loop modeling, combining kinematic closure with sampling of coupled degrees of freedom from fragments.
-  [[Stepwise assembly of protein loops|swa-protein-main]] - Generate three-dimensional de novo models of protein segments     -  [[Stepwise assembly of long loops|swa-protein-long-loop]] - For loops greater than 4-5 residues. See also  [[Stepwise monte carlo|stepwise]].
-  [[Stepwise monte carlo|stepwise]] - Generate 3D models of protein, RNA, and protein/RNA loops, motifs, and interfaces. Stochastic version of stepwise assembly. 

###RNA and RNA/protein
-  [[RNA structure prediction|rna-denovo-setup]] - Predict 3-dimensional structures of RNA from their nucleotide sequence. Read this first. 
 *  [[RNA tools]] - Tools useful for RNA and RNA/proteinm including general PDB editing, cluster submission, job setup.
 *  [[RNA threading|rna-thread]] - Thread a new nucleotide sequence on an existing RNA structure.  
 *  [[RNA motif prediction|rna denovo]] - Model RNA motifs with fragment assembly of RNA with full atom refinement (FARFAR).
-  [[RNA stepwise loop enumeration|swa-rna-loop]] - Build RNA loops using deterministic stepwise assembly. See also  [[Stepwise monte carlo|stepwise]].
-  [[Stepwise monte carlo|stepwise]] - Generate 3D models of protein, RNA, and protein/RNA loops, motifs, and interfaces. Stochastic version of stepwise assembly. 
-  [[RNA assembly with experimental constraints|rna-assembly]] - Predict 3-dimensional structures of large RNAs with the help of experimental constraints. Note – largely deprecated by newer pipeline (documentation coming soon).
-  [[ERRASER]] - Refine an RNA structure given electron density constraints.  
-  [[Sample around nucleobase]] - Visualizing energy functions by scanning probe molecules around a nucleobase.
-  [[RECCES]] - RNA free energy calculation with comprehensive sampling.
-  [[RNA pharmacophore]] - Extract and cluster the key features present in RNA (rings, hbond donors & acceptors) from the structure of a protein-RNA complex.

###Antibody Modeling
- [[Antibody protocol]] (RosettaAntibody3) - Overview of the antibody modeling protocol.  
    * [[Antibody Python script]] - The setup script.  
    * [[Grafting CDR loops|antibody-assemble-cdrs]] - Graft antibody CDR templates on the framework template to create a rough antibody model.  
    * [[Modeling CDR H3|antibody-model-CDR-H3]] - Determine antibody structures by combining VL-VH docking and H3 loop modeling.

##Docking

###Antibody Docking
- [[Camelid antibody docking|antibody-mode-camelid]] - Dock camelid antibodies to their antigens.
- [[SnugDock | snugdock]] - Paratope structure optimization during antibody-antigen docking

###Ligand Docking
- [[Ligand docking|ligand-dock]] (RosettaLigand) - Determine the structure of protien-small molecule complexes.  
   * [[Extract atomtree diffs]] - Extract structures from the AtomTreeDiff file format.

- [[Docking Approach using Ray-Casting|DARC]] (DARC) - Docking method to specifically target protein interaction sites.
 
###Peptide Docking
- [[Flexible peptide docking|flex-pep-dock]] - Dock a flexible peptide to a protein.

###Protein-Protein Docking
- [[Protein-Protein docking|docking-protocol]] (RosettaDock) - Determine the structures of protein-protein complexes by using rigid body perturbations.  
    * [[Docking prepack protocol]] - Prepare structures for protein-protein docking.  

- [[Symmetric docking|sym-dock]] - Determine the structure of symmetric homooligomers.  

- [[Chemically conjugated docking|ubq-conjugated]] - Determine the structures of ubiquitin conjugated proteins.  


##Design

### General 

- [[Fixed backbone design|fixbb]] - Optimize sidechain-rotamer placement and identity on fixed backbones.  
   * [[Fixed backbone design with hpatch|fixbb-with-hpatch]] - Fixed backbone design with a penalty for hydrophobic surface patches.  

- [[Sequence tolerance]] - Optimize proteins for library applications (e.g. phage or yeast display).  

- [[Multistate design|mpi-msd]] - Optimize proteins for multiple desired and undesired contexts.

- [[Anchored design]] - Design interfaces using an "anchor" of known interactions.  
    * [[Anchored pdb creator]] - Prepare starting files for AnchoredDesign.  
    * [[Anchor finder]] - Find interactions which can serve as "anchors" for AnchoredDesign. 

- [[RosettaRemodel]] - Redesign backbone and sequence of protein loops and secondary structure elements. 
    * [[Remodel]] - Additional remodel documentation

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

- [[Rosetta DNA]] (RosettaDNA) - Design and modle protein interactions to DNA. 

### Secondary Structure

- [[Hydrogen bond surrogate design|hbs-design]] - Design stabilized alpha helical binders.

- [[Beta strand homodimer design]] - Find proteins with surface exposed beta-strands, then design a homodimer that will form via that beta-strand.  

### Protein-Protein Interfaces

- [[Protein-protein design|app-dock-design]] - Protein-protein interface design with RosettaScripts.

##Membrane Proteins
 - [[Membrane Fast Relax|Membrane-Fast-Relax]] - High-resolution refinement of membrane protein structures with optimization of the membrane position using minimization (uses membrane framework)
 - [[Membrane ddG|Membrane-DDG]] - Prediction of free energy changes upon mutation using the membrane framework
 - [[Membrane protein-protein docking|Membrane-Protein-Protein-Docking]] - Protein-protein docking in the membrane (uses membrane framework)
 - [[Symmetric membrane protein-protein docking|Symmetric Membrane Protein-Protein Docking]] - Assemble symmetric complexes in the membrane environment (uses membrane framework)
 - [[Membrane Protein PyMOL Viewer|mp-viewer]] - Standalone application for visualization of membrane protein
simulations in real-time using pymol (uses membrane framework)

##Analysis

### Scoring 

- [[Score|score-commands]] - Calculate Rosetta energy for structures.

- [[Residue energy breakdown]] - Decompose scores into intra-residue and residue pair interactions.

- [[ddG monomer]] - Predict the change in stability (the ddG) of a monomeric protein induced by a point mutation.

- [[Density map scoring]] - Score structures with electron density information.  

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

##Utilities

These applications serve mainly to support other Rosetta applications, or to assist in setting up or analyzing Rosetta runs.

### General
- [[Build peptide]] - Build extended peptides or protein structures from sequences. 

- [[CA to allatom]] - Build fullatom models from C-alpha-only traces.  

- [[Cluster]] - Cluster structures by structural similarity.  

- [[Create symmetry definition|make-symmdef-file-denovo]] - Create Rosetta symmetry definition files for a point group.  
    * [[Create symmetry definition from structure|make-symmdef-file]] - Create Rosetta symmetry definition files from template PDBs. 

- [[Fragment picker|app-fragment-picker]] - Pick fragments to be used in conjunction with other fragment-aware Rosetta applications.  
    * [[Old fragment picker|fragment-picking-old]] - The older version of the fragment picker.  

- [[Loops from density]] - Create Rosetta loop files for regions of a protein with poor local fit to electron density.

- [[Make exemplars|make-exemplar]] - Create an exemplar for surface pockets on a protein that touch a target residue.

- [[OptE|opt-e-parallel-doc]] - Refit reference weights in a scorefunction to optimize given metrics.  

- [[Pocket target residue suggestion|pocket-suggest-targets]] - Suggest the best pair of target residues for pocket optimization for the purpose of inhibiting a protein-protein interaction.

- [[PyMol server]] - Observe what a running Rosetta program is doing by using PyMol.

- [[Sequence recovery]] - Calculate the mutations and native recovery from Rosetta design runs.

###Non-canonical amino acids
 - [[Make rotamer library|make-rot-lib]] - Generate rotamer libraries for non-canonical amino acids.  
 - [[Unfolded state energy calculator]] - Determine the baseline energy of non-canonical amino acids in the unfolded state.  

  
## Other

- [[Collection of example commandlines|commands-collection]]

- [[minirosetta]] - The "minirosetta" boinc wrapper application.

- [[Pocket relax|pocket-relax]] - Relax followed by full atom minimization and scoring with no PocketConstraint. Useful when performing pocket optimization.



##Documentation Quick Links

|[[Build Documentation]]|[[Rosetta Basics]]        |[[Development Documentation]]|
|:---------------------:|:------------------------:|:---------------------------:|:---------------------------:|
|[[/images/hammer.png|align=center]] |[[/images/start_flag.png|align=center]]|[[/images/wrench.png|align=center]]|

<!--- BEGIN_INTERNAL -->
|[[Internal Documentation]]|
|:------------------------:|
|[[/images/logo.png|align=center]]      |
<!--- END_INTERNAL --> 
