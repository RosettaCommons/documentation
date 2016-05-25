#Applications for Macromolecule Design

##General Protein Design
* [[Fixed backbone design|fixbb]]: Optimize sidechain-rotamer placement and identity on fixed backbones.
* [[Fixed backbone design with hpatch|fixbb-with-hpatch]]: Fixed backone design with a penalty for hydrophobic survace patches.
* [[Relax]]: When supplied with a resfile and the `-relax:respect_resfile` option, the relax application can be used for design. 
* [[Multistate design|mpi-msd]]: Optimize proteins for multiple desired and undesired contexts.
* [[Anchored design]]: Design interfaces using an "anchor" of known interactions.  
    * [[Anchored pdb creator]]: Prepare starting files for AnchoredDesign.  
    * [[Anchor finder]]: Find interactions which can serve as "anchors" for AnchoredDesign. 
- [[RosettaRemodel]]: Redesign backbone and sequence of protein loops and secondary structure elements. 
    * [[Remodel]]: Additional remodel documentation
-  [[Stepwise design|stepwise]]: Simultaneously optimize sequence and structure for small RNA and protein segments. Part of the stepwise application.
-  [[SEWING]]: Build new protein structures from large elements (e.g. helix-loop-helix motifs) of native proteins.

##Library Design

* [[Sequence tolerance]]: Optimize proteins for library applications (e.g. phage or yeast display).  
* [[SwiftLib server|http://rosettadesign.med.unc.edu/SwiftLib/]]: Web-based tool for rapid optimization of degenerate codons.

##Stability Improvement

* [[Point mutation scan|pmut-scan-parallel]]: Identifiy stabilizing point mutants.  
* [[Supercharge]]: Reengineer proteins for high net surface charges, to counter aggregation.
* [[Void Identification and Packing|vip-app]] (RosettaVIP): Identify and fill cavities in a protein.

##Secondary Structure

* [[Hydrogen bond surrogate design|hbs-design]]: Design stabilized alpha helical binders.
* [[Beta strand homodimer design]]: Find proteins with surface exposed beta-strands, then design a homodimer that will form via that beta-strand.  

##Protein-Protein Interface Design

* [[Protein-protein design|docking-protocol]]: Protein-protein interface design with RosettaScripts.
* [[Zinc heterodimer design]]: Design zinc-mediated heterodimers.  

##Enzymes

* [[Enzyme Design]]: Design a protein around a small molecule, with catalytic constraints. 

##Peptides

* [[Pepspec]]: Evaluate and design peptide-protein interactions.

##Small Molecules

* [[Match]]: Place a small molecule into a protein pocket so it satisfies given geometric constraints.  

* [[OOP design]]: Design proteins with oligooxopiperazine residues.  

* [[DougsDockDesignMinimize|doug-dock-design-min-mod2-cal-cal]]: Redesign the protein/peptide interface of Calpain and a fragment of its inhibitory peptide calpastatin.

* [[theta ligand]]: Calculate the fraction of ligand that is exposed to the solvent in a protein-ligand complex.

##RNA

* [[RNA design]]: Optimize RNA sequence for fixed backbones.  
*  [[Stepwise design|stepwise]]: Simultaneously optimize sequence and structure for small RNA and protein segments. Part of the stepwise application.

##DNA

* [[Rosetta DNA]] (RosettaDNA): Design and model protein interactions to DNA. 

##See Also

##See Also

* [[Rosetta Design Server (external link)o|http://rosettadesign.med.unc.edu/]]: Web-based server for fixed backbone design
* [[Rosetta Servers]]: Servers that provide access to some Rosetta applications
* [[Application Documentation]]: List of Rosetta applications
* [[RosettaScripts]]
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files