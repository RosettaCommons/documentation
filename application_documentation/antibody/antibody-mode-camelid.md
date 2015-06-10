#Camelid Antibody Modeling

Metadata
========

Author: Aroop Sircar and Sergey Lyskov

Last edited 7/20/2011. Corresponding PI Jeffrey Gray (jgray@jhu.edu).

Code and Demo
=============

-   Application source code: `        rosetta/rosetta_source/src/apps/public/antibody/antibody_mode.cc       `
-   Main mover source code: `        rosetta/rosetta_source/src/protocols/antibody/AntibodyModeler.hh       `
-   To see demos of some different use cases see integration tests located in `        rosetta/rosetta_tests/integration/tests/antibody*       ` .

To run Antibody modeler, perform the following:

```
1. Checkout antibody directrory.
2. Change ~/antibody/scripts/rampaths.txt to set the paths to
   match your directory structure
3. Copy the following files to directory where simulation will be run:
     i.  ~/antibody/scripts/rampaths.txt
     ii. ~/antibody/scripts/utilities.txt
4. Have the following files ready for input in the simulation directory:
     i.  query_l.fasta: sequence of light chain (not required for camelid VHH antibody)
     ii. query_h.fasta: sequence of heavy chain
         Note: The fasta files should conform to the following format:
         a. The header line with > should not be there
         b. There should not be any hyphens for breaks
         c. There should not be any newline charchter - all on one line
5. Make sure that Profit is installed on your system and it is set up
   such that it can be called from any subfolder by typing "profit".
6. Change the paths.txt in  ~/antibody/scripts/paths.txt
   such that in all cases it points to your local copy of the
   rosetta_database directory
7. Change the hardcoded paths in the file ~/antibody/scripts/ram_blankcdrs.pl
   They should point to two files located in ~/antibody/scripts/. Make
   sure that the full absolute paths (non-relative) are provided. For
   some strange reason incorporating rampaths.txt does not work here,
   more details are provided in ram_blankcdrs.pl
8. Change the hardcoded paths in the following file to match your directory
   structure:
   ~/antibody/scripts/get_top10_scoring.pl
9. Also ensure that you have the most updated version of the rosetta_database
   directory
10. Change paths for sam/jufo/blosum etc in the following file:
    ~antibody/scripts/make_rosetta_fragments.pl
11.In the folder in which simulations will be run,which already contains:
         i.   rampaths.txt
     ii.  utilities.txt
     iii. query_l.fasta (not present for camelid VHH antibody)
     iv.  quary_h.fasta
     Launch the following command for classical antibody:
     perl -P ~/antibody/scripts/ram_buildloop_wrapper.pl pdb1xyz_chothia.pdb bit 1 1 1 1 1 1 1 2000 query_l.fasta query_h.fasta
     Launch the following command for camelid VHH antibody:
     perl -P ~/antibody/scripts/ram_buildloop_wrapper.pl pdb1xyz_chothia.pdb bit 1 1 1 1 1 1 1 2000 query_l.fasta query_h.fasta camelid
12.The simulations folder will have a new directory named "build". Some of the
   important files in the directory are:
     i.   FR02.pdb: The framework region with the non-H3 CDRs grafted in
     ii.  H3_CTERM: Fragment files for the CDR H3 base region
     iii. aaFR02_03_05.200_v1_3: 3-mer fragment file for the H3 loop region with antibody fragments appended
     iv.  aaFR02_09_05.200_v1_3: 9-mer standard rosetta fragment
         v.   lfr.pdb: light chain template from which light chain of FR02.pdb has been obtained (not present for camelid VHH antibody)
     vi.  hfr.pdb: heavy chain template from which heavy chain of FR02.pdb has been obtained
     vii. 1xyz_build_loops.con: The condor script file containing headers. This is used for launching jobs on the cluster using the command: "condor_submit 1xyz_build_loops.con"
         viii.1xyz_build_loops.bash: This is called by the .con file (above) and contains the actual rosetta command line needed for launching a job with 2000 decoys.
13.Post processing: In the directory one level above the "build" directory launch the script:
   ~/antibody/scripts/get_top10_scoring.pl
   The top ten models are outputted: model1.pdb.....model10.pdb
   The processed scorefile void of any redundancies and containing
   decoys which do not have broken CDR H3s is also outputted as:
   aaFR02_unbroken.fasc

After all the scripts and supporting files are in place untar the
"camelid_example.tgz" file. A description of the key files in tar
archieve is provided in input_files_section

Make sure that camelid.bash and rampaths.txt are modified to match
your paths. You should have completed this already if you have read
"antibody_readme.txt" in the "antibody" directory. You can merely copy
the rampaths.txt from "antibody/scripts/rampaths.txt" to overwrite
this local copy.

Once you have modified the "camelid.bash", after the run finishes,
you should have a build directory.

Finally, on execution of the "1xyz_build_loops.bash" script, we
actually generate the final homology models. We generally build 2000
of this (in this example, we build just one) and choose the top ten.
```

References
==========

For camelid VHH antibody modeling: Aroop Sircar, Kayode A. Sanni, Jiye Shi & Jeffrey J. Gray, "Analysis and Modeling of the Variable Region of Camelid Single Domain Antibodies," J. Immunology, 186(11), 6357-6367 (2011).

For classical Fv modeling: Arvind Sivasubramanian\*, Aroop Sircar\*, Sidhartha Chaudhury & Jeffrey J. Gray, "Toward high-resolution homology modeling of antibody Fv regions and application to antibody-antigen docking," Proteins: Structure, Function and Bioinformatics, 74(2), 497-514 (2009).

Application purpose
===========================================

To create high-resolution cAb VHH homology models. The paucity in cAb VHH structures combined with the reliance on homology modeling for computational design of humanized Abs for production of at least 11 marketed classical Abs, including Herceptin (trastuzumab or humanized anti-HER2), Zenapax (daclizumab or humanized anti-Tac), and Avastin (bevacizumab or humanized anti-vascular endothelial growth factor), highlights the need for such a high-resolution cAb VHH homology modeling tool.

Algorithm
=========

The homology modeling protocol follows RosettaAntibody to create models by 1) identifying homologous framework and loop templates from the RosettaAntibody database by maximum basic local alignment search tool (BLAST) bit score, 2) grafting CDR templates onto the framework, 3) building the CDR H3 loop, and 4) globally refining the paratope. The main differences from the standard RosettaAntibody protocol are highlighted. The cAb VHH structures were appended to the RosettaAntibody Ab database. Similar to the four-residue C-terminal CDR H3 fragment library used in modeling CDR H3 loops in VH Abs, we created a six- residue C-terminal CDR H3 fragment library specific to cAbs. The six-residue fragments have been classified as “stretched” or “twisted”, and those that could not be classified are referred to as “neutral”. The template identification is similar to that in RosettaAntibody. Because of the absence of the light chain, templates for the light chain framework and CDRs are omitted, and VL–VH assembly is unnecessary. On successful identification of the respective templates, the CDRs are grafted into the framework as described previously. Side-chain conformations of the grafted loop and the neighboring residues are optimized by rotamer packing. In a few cases, grafting creates a broken loop because of framework deviations [also observed in a few cases in canonical Abs submitted to the RosettaAntibody server]. When grafting breaks loops, the loops are repaired by minimal refinement using a combination of small, shear, and cyclic coordinate descent moves with sidechain packing following the high-resolution CDR H3 loop refinement in RosettaAntibody without side-chain minimization. The loop modeling algorithm follows that in the RosettaAntibody protocol composed of 1) a centroid pseudo-atom side-chain representation low-resolution Monte Carlo stage where diverse loop conformations are sampled by large perturbations by fragment insertion (including the stretched-twisted and twisted fragments), and 2) an all-atom high-resolution Monte Carlo-plus-minimization stage where all the side-chain conformations are optimized and the loop backbone dihedral angles are perturbed minimally to relieve steric clashes. To model cAb VHH domains with extremely long CDR H3 loops and the larger diversity of CDR H1 loops, the RosettaAntibody protocol was enhanced as follows. Two bounded harmonic potential terms are added to the scoring function. The first constraint enforces the disulfide bond if cystines are present in CDR H1 and H3 loops. The second ensures that stretched-twisted structures fold such that the n-5 residue of CDR H3 is near to residue 46 in the heavy chain framework. The term penalizes deviations from observed structural features during the course of the search but is not included for final discrimination and ranking of homology models. Similar to RosettaAntibody, the algorithm initializes a loop by assuming ideal CDR H3 bond lengths and bond angles and stretched torsion angles (Φ = - 150°, Ψ = 150°, and ω = 180°). The six C-terminal residues are given backbone

torsion angles from a cAb CDR H3 C terminus depending on the loop classification (twist, stretched-twist, or neutral). For CDR H3 loops shorter than 16 residues, the loop is built using a three-residue fragment library, and longer loops are built first using a nine-residue fragment library and then using a three-residue fragment library. Subsequently, a CDR H1 loop is perturbed by 5nH1 cycles of low-resolution steps, each step composed of max(5, nH1/2) small and shear move perturbations and cyclic coordinate descent loop closure, where nH1 is the length of the H1 loop. The high-resolution CDR H3 loop refinement is similar to RosettaAntibody’s high- resolution stage and is followed by a similar H3-like refinement of the CDR H1 loop. Finally, the backbone dihedral angles of all the CDR loops are simultaneously optimized, using gradient-based minimization in backbone torsion angles and side- chain packing throughout the paratope, but obviously without optimization of the relative orientation of the light and heavy chains. Unlike RosettaAntibody, the high- resolution stage of CDR H3 loop building does not involve minimization of side- chain positions, but side chains are minimized as a final stage before a model is output. In the standard protocol, 5000 models are independently built for each target.

Limitations
===========

This version does not include all the features of the original RosettaAntibody. Thus this release cannot model classical antibody variable regions.

Modes
=====

The protocol is divided into two stages. The first stage (Grafting phase) involves building a crude model of the VHH by incorporating all the templates. The second stage (Loop Building phase) involves ab initio loop building of the CDR H3, explicit perturbation of the CDR H1 loop and minimization of the CDR H2.

Input Files
===========

The input file comprises the amino acid sequence of the camelid VHH antibody’s amino acid sequence in FASTA format. All supporting files like fragment files and template files are created by included Perl scripts using only the aforementioned FASTA file.

1. grafting\_input \<directory\> This contains all the fasta sequence files for the query. 
    1. camelid.bash A bash file to invoke the master wrapper script. The script takes the fasta files as an input and outputs a framework with everything except the CDR-H3. It also generates the fragment files for H3 modeling. It also creates build directory with a condor script to actually build \<nstruct\> number of homology models. 
    2. query\_h.fasta Fasta file containing the heavy chain sequence 
    4. rampaths.txt Paths for various files needed by scripts 
    5. utilities.txt Supporting file 
2. build\_input \<directory\> This contains the files needed for modeling the CDR H3. These files are the output files generated by "camelid.bash". 
    1. 1xyz\_build\_loops.bash Bash script that invokes rosetta to actually model the CDR-H3 loops. This is the most time consuming part of the protocol. For simplicity the nstruct is set to 1. However, for a normal run it should be 2000. The file created by "camelid.bash" actually has nstruct 1. I manually changed it to 1 for the purposes of this example. 
    2. aaFR02\_09\_05.200\_v1\_3 Standard rosetta 9-mer fragment file 
    3. aaFR02\_03\_05.200\_v1\_3 Rosetta 3-mer fragment file appended with antibody fragments 
    4. H3\_CTERM Special fragment file containing H3 base fragments 
    5. hfr.pdb Template structure from which heavy chain of query has been obtained 
    7. paths.txt Standard rosetta paths file. Make sure this matches with your paths. Once again this should be set if you have followed instructions in "antibody\_readme.txt" 
    8.FR02.pdb The output file of "camelid.bash" which has the all non-H3 CDRs grafted onto the framework regions. It contains the CDR-H3 region with the coordinates blanked out.

Options
=======

Grafting Flags:

-camelid Informs RosettaAntibody that this is a camelid VHH antibody as opposed to a classical antibody

-graft\_h1 Graft CDR H1 from template file h1.pdb

-graft\_h2 Graft CDR H2 from template file h2.pdb

-graft\_h3 Graft CDR H3 from template file h3.pdb

CDR H3 Loop Building Flags:

-camelid Informs RosettaAntibody that this is a camelid VHH antibody as opposed to a classical antibody

-constraints::cst\_file \<filename\> File containing constraints for the harmonic potentials, eg. camelid.cst

-model\_h3 Enable ab initio loop building for CDR H3

Tips
====

UPDATING THE ANTIBODY DATABASE: Use the script: \~/antibody/scripts/update\_RosettaAntibody\_database.pl (follow instructions in the script)

Expected Outputs
================

3. build\_output \<directory\> Files generated by the "1xyz\_build\_loops.bash" 
    1. aaFR02\_0001.pdb Output decoy with ab initio built CDR H1 and H3. 
    2. aaFR02.fasc Scorefile with special columns: 
        1. AA\_H3 Global rmsd of CDR H3 compared to input structure 
        2. AB\_H1 Global rmsd of CDR H1 compared to input structure 
        3. AB\_H2 Global rmsd of CDR H2 compared to input structure 
        4. AF\_constraint Constraint score that rewards di-sulfide formation between cystines in CDRs H1 & H3. Also rewards atomic contacts for stretched-twisted CDR H3s.

Post Processing
===============

Post processing for antibody modeler: In the directory one level above the "build" directory launch the script: \~/antibody/scripts/get\_top10\_scoring.pl The top ten models are outputted: model1.pdb.....model10.pdb The processed scorefile void of any redundancies and containing decoys which do not have broken CDR H3s is also outputted as: aaFR02\_unbroken.fasc

New things since last release
=============================

This is initial release of this protocol so everything is new.


##See Also

* [[General Antibody Options and Tips]]
* [[Antibody Applications]]: Homepage for antibody applications
    * [[Antibody protocol]]: The main antibody modeling application
    * [[Antibody Python script]]: Setup script for this application
    * [[Grafting CDR loops|antibody-assemble-cdrs]]: Graft antibody CDR templates on the framework template to create a rough antibody model.  
    * [[Modeling CDR H3|antibody-model-CDR-H3]]: Determine antibody structures by combining VL-VH docking and H3 loop modeling.
    - [[SnugDock | snugdock]]: Paratope structure optimization during antibody-antigen docking
    * [[Antibody Design Strategy Analysis]]: A PyRosetta-based tool to analyze and/or compare antibody design strategies.
    * [[CDR Cluster Identification]]: An application that matches each CDR of an antibody to North/Dunbrack CDR clusters based on the lowest dihedral distance to each cluster center.
     * [[CDR Cluster Constrained Relax]]: An application to relax CDRs using circular harmonic constraints based on identified CDR clusters.
* [[Docking Applications]]: Homepage for docking applications
  - [[SnugDock | snugdock]]: Paratope structure optimization during antibody-antigen docking
  - [[Ligand docking|ligand-dock]] (RosettaLigand): Determine the structure of protein-small molecule complexes.  
    * [[Extract atomtree diffs]]: Extract structures from the AtomTreeDiff file format.
    - [[Docking Approach using Ray-Casting|DARC]] (DARC): Docking method to specifically target protein interaction sites.
    - [[Flexible peptide docking|flex-pep-dock]]: Dock a flexible peptide to a protein.
    - [[Protein-Protein docking|docking-protocol]] (RosettaDock): Determine the structures of protein-protein complexes by using rigid body perturbations.  
      * [[Docking prepack protocol]]: Prepare structures for protein-protein docking.  
    - [[Symmetric docking|sym-dock]]: Determine the structure of symmetric homooligomers.  
    - [[Chemically conjugated docking|ubq-conjugated]]: Determine the structures of ubiquitin conjugated proteins.  
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs