#Application Documentation

Below is a list of the currently released applications containing developer documentation. Click on an application to
see a more detailed description of the purpose and for detailed examples. If a released application is missing, please
file a bug in our [issue tracker](http://bugs.rosettacommons.org).

**Table of Contents** 

- [[Scripting interfaces to Rosetta functionality|Application Documentation#Scripting-interfaces-to-Rosetta-functionality]]
- [Structure Prediction](#Structure-Prediction)
- [Docking](#Docking)
- [Design](#Design)
- [Analysis](#Analysis)
- [Utilities](#Utilities)
- [Other](#Other)

##Scripting interfaces to Rosetta functionality
- [[RosettaScripts]]: An XML-based scripting interface
- [[PyRosetta]]: Python wrappings for Rosetta

##Structure Prediction
While most of these applications focus on prediction, many have options which will also allow design.

- [[Ab initio modeling|abinitio-relax]] - Predict 3-dimensional structures of proteins from their amino acid sequences.  
    * [[Membrane abinitio]] - Ab initio for membrane proteins.  
    * [[Metalloprotein ab initio|metalloprotein-abrelax]] - Ab inito modeling of metalloproteins.  
- [[Comparative modeling|minirosetta-comparative-modeling]] - Build structural models of proteins using one or more known structures as templates for modeling.  
- [[Fold-and-dock]] - Predict 3-dimensional structures of symetric homooligomers.  
- [ RNA ](#RNA) - see below for apps, including FARFAR & ERRASER.
- [[Molecular replacement protocols|mr-protocols]] - Use Rosetta to build models for use in X-ray crystrallography molecular replacement.  
    * [[Prepare template for MR]] - Setup script for molecular replacement protocols.  
- [[Relax]] - "Locally" optimize structures, including assigning sidechain positions.  
- [[Backrub]] - Create backbone ensembles using small, local backbone changes.  
- [[Floppy tail]] - Predict structures of long, flexible N-terminal or C-terminal regions.  

###Loop Modeling
-  [[Loop modeling overview|loopmodel]]
-  [[CCD loop modeling|loopmodel-ccd]] - Sample loop conformations using fragments and the CCD closure algorithm.
-  [[Kinematic loop modeling|loopmodel-kinematic]] - Sample loop conformations using the kinematic closure algorithm.
-  [[Next-generation KIC]] - A newer version of loop modeling with kinematic closure.
-  [[KIC with fragments|KIC_with_fragments]] - The latest version of loop modeling, combining kinematic closure with sampling of coupled degrees of freedom from fragments.
-  [[Stepwise assembly of protein loops|swa-protein-main]] - Generate three-dimensional de novo models of protein segments without surrounding sidechains.  
    * [[Stepwise assembly of long loops|swa-protein-long-loop]] - For loops greater than 4-5 residues.  

###RNA
-  [[RNA denovo]] - Predict 3-dimensional structures of RNA from their nucleotide sequence with fragment assembly of RNA with full atom refinement (FARFAR).
-  [[RNA threading|rna-thread]] - Thread a new nucleotide sequence on an existing RNA structure.  
-  [[RNA stepwise loop enumeration|swa-rna-loop]] - Build RNA loops using deterministic stepwise assembly.
-  [[RNA assembly with experimental constraints|rna-assembly]] - Predict 3-dimensional structures of large RNAs with the help of experimental constraints. Note – largely deprecated by newer pipeline (documentation coming soon).
-  [[ERRASER]] - Refine an RNA structure given electron density constraints.  

##Docking
###Protein-Protein Docking
- [[Protein-Protein docking|docking-protocol]] (RosettaDock) - Determine the structures of protein-protein complexes by using rigid body perturbations.  
    * [[Docking prepack protocol]] - Prepare structures for protein-protein docking.  

- [[Symmetric docking|sym-dock]] - Determine the structure of symmetric homooligomers.  

- [[Chemically conjugated docking|ubq-conjugated]] - Determine the structures of ubiquitin conjugated proteins.  
 
###Antibody Docking
- [[Antibody protocol]] (RosettaAntibody3) - Overview of the antibody modeling protocol.  
    * [[Antibody Python script]] - The setup script.  
    * [[Grafting CDR loops|antibody-assemble-cdrs]] - Graft antibody CDR templates on the framework template to create a rough antibody model.  
    * [[Modeling CDR H3|antibody-model-CDR-H3]] - Determine antibody structures by combining VL-VH docking and H3 loop modeling.

- [[Camelid antibody docking|antibody-mode-camelid]] - Dock camelid antibodies to their antigens.

###Ligand Docking
- [[Ligand docking|ligand-dock]] (RosettaLigand) - Determine the structure of protien-small molecule complexes.  
   * [[Extract atomtree diffs]] - Extract structures from the AtomTreeDiff file format.  

###Peptide Docking
- [[Flexible peptide docking|flex-pep-dock]] - Dock a flexible peptide to a protein.

##Design
- [[Fixed backbone design|fixbb]] - Optimize sidechain-rotamer placement and identity on fixed backbones.  
   * [[Fixed backbone design with hpatch|fixbb-with-hpatch]] - Fixed backbone design with a penalty for hydrophobic surface patches.  

- [[Void Identification and Packing|vip-app]] (RosettaVIP) - Identify and fill cavities in a protein.
- [[Point mutation scan|pmut-scan-parallel]] - Identifiy stabilizing point mutants.  

- [[Protein-protein design|app-dock-design]] - Protein-protein interface design with RosettaScripts.  
 
- [[Match]] - Place a small molecule into a protein pocket so it satisfies given geometric constraints.  
- [[Enzyme Design]] - Design a protein around a small molecule, with catalytic constraints.  

- [[RosettaRemodel]] - Redesign backbone and sequence of protein loops and secondary structure elements. 
    * [[Remodel]] - Additional remodel documentation

- [[Pepspec]] - Evaluate and design peptide-protein interactions.  

- [[Rosetta DNA]] (RosettaDNA) - Design and modle protein interactions to DNA.  

- [[RNA design]] - Optimize RNA sequence for fixed backbones.  

- [[Hydrogen bond surrogate design|hbs-design]] - Design stabilized alpha helical binders.
- [[OOP design]] - Design proteins with oligooxopiperazine residues.  

- [[Multistate design|mpi-msd]] - Optimize proteins for multiple desired and undesired contexts.

- [[Sequence tolerance]] - Optimize proteins for library applications (e.g. phage or yeast display).  

- [[Anchored design]] - Design interfaces using an "anchor" of known interactions.  
    * [[Anchored pdb creator]] - Prepare starting files for AnchoredDesign.  
    * [[Anchor finder]] - Find interactions which can serve as "anchors" for AnchoredDesign.  

- [[Supercharge]] - Reengineer proteins for high net surface charges, to counter aggregation.  

- [[Zinc heterodimer design]] - Design zinc-mediated heterodimers.  

- [[Beta strand homodimer design]] - Find proteins with surface exposed beta-strands, then design a homodimer that will form via that beta-strand.  

- [[DougsDockDesignMinimize|doug-dock-design-min-mod2-cal-cal]] - Redesign the protein/peptide interface of Calpain and a fragment of its inhibitory peptide calpastatin.

##Analysis

- [[Score|score-commands]] - Calculate Rosetta energy for structures.
- [[Residue energy breakdown]] - Decompose scores into intra-residue and residue pair interactions.

- [[Density map scoring]] - Score structures with electron density information.  

- [[ddG monomer]] - Predict the change in stability (the ddG) of a monomeric protein induced by a point mutation. 

- [[Interface analyzer]] - Calculate metrics evaluating interfaces.  

##Utilities

These applications serve mainly to support other Rosetta applications, or to assist in setting up or analyzing Rosetta runs.

- [[Fragment picker|app-fragment-picker]] - Pick fragments to be used in conjunction with other fragment-aware Rosetta applications.  
    * [[Old fragment picker|fragment-picking-old]] - The older version of the fragment picker.  

- [[Cluster]] - Cluster structures by structural similarity.  

- [[PyMol server]] - Observe what a running Rosetta program is doing by using PyMol.

- [[Build peptide]] - Build extended peptides or protein structures from sequences.  

- [[CA to allatom]] - Build fullatom models from C-alpha-only traces.  

- [[Create symmetry definition|make-symmdef-file-denovo]] - Create Rosetta symmetry definition files for a point group.  
    * [[Create symmetry definition from structure|make-symmdef-file]] - Create Rosetta symmetry definition files from template PDBs.  

- Non-canonical amino acids
    * [[Make rotamer library|make-rot-lib]] - Generate rotamer libraries for non-canonical amino acids.  
    * [[Unfolded state energy calculator]] - Determine the baseline energy of non-canonical amino acids in the unfolded state.  

- [[Loops from density]] - Create Rosetta loop files for regions of a protein with poor local fit to electron density.  

- [[Sequence recovery]] - Calculate the mutations and native recovery from Rosetta design runs.

- [[OptE|opt-e-parallel-doc]] - Refit weights in a scorefunction to optimize given metrics.  

## Other

- [[Collection of example commandlines|commands-collection]]

- [[minirosetta]] - The "minirosetta" boinc wrapper application.