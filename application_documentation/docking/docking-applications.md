#List of docking applications


###Antibody Docking
- [[Camelid antibody docking|antibody-mode-camelid]]: Dock camelid antibodies to their antigens.
- [[SnugDock | snugdock]]: Paratope structure optimization during antibody-antigen docking

##NOTE: Use of command line apps is no longer recommended for ligand docking. Use [[RosettaScripts]] instead. See [[HighResDockerMover]] for example.

###Ligand Docking
- [[Ligand docking|ligand-dock]] (RosettaLigand): Determine the structure of protein-small molecule complexes.  
   * [[Extract atomtree diffs]]: Extract structures from the AtomTreeDiff file format.

- [[Docking Approach using Ray-Casting|DARC]] (DARC): Docking method to specifically target protein interaction sites.
 
###Peptide Docking
- [[Flexible peptide docking|flex-pep-dock]]: Dock a flexible peptide to a protein.

###Protein-Protein Docking
- [[Protein-Protein docking|docking-protocol]] (RosettaDock): Determine the structures of protein-protein complexes by using rigid body perturbations.  
    * [[Docking prepack protocol]]: Prepare structures for protein-protein docking.  
    * [[Motif Dock Score]]: Efficient low-resolution protein-protein docking.

- [[Symmetric docking|sym-dock]]: Determine the structure of symmetric homooligomers.  

- [[Chemically conjugated docking|ubq-conjugated]]: Determine the structures of ubiquitin conjugated proteins.  

##See Also

* [[FunHunt|http://funhunt.furmanlab.cs.huji.ac.il/]], short for funnel hunt, tries to distinguish correct protein-protein complex orientations from decoy orientations.
* [[Application Documentation]]: List of Rosetta applications
* [[Rosetta Servers]]: Web-based interfaces to run some Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[RosettaScripts]]: Homepage for the RosettaScripts interface to Rosetta
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files