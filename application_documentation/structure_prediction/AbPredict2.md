#AbPredict

Metadata
========

Authors: Gideon Lapidoth (glapidoth@gmail.com), Chris Norn (ch.norn@gmail.com), Sarel Fleishman (sarel.fleishman@weizmann.ac.il )

Corresponding PI Sarel Fleishman (sarel.fleishman@weizmann.ac.il ).

Last edited 4/19/2018 by Gideon Lapidoth (glapidoth@gmail.com) 


References
==========

1. Baran, Dror, M. Gabriele Pszolla, Gideon D. Lapidoth, Christoffer Norn, Orly Dym, Tamar Unger, Shira Albeck, Michael D. Tyka, and Sarel J. Fleishman. 2017. “Principles for Computational Design of Binding Antibodies.” Proceedings of the National Academy of Sciences of the United States of America 114 (41): 10900–905.
2. Lapidoth, Gideon D., Dror Baran, Gabriele M. Pszolla, Christoffer Norn, Assaf Alon, Michael D. Tyka, and Sarel J. Fleishman. 2015. “AbDesign: An Algorithm for Combinatorial Backbone Design Guided by Natural Conformations and Sequences.” Proteins 83 (8): 1385–1406.
3. Norn, Christoffer H., Gideon Lapidoth, and Sarel J. Fleishman. 2017. “High-Accuracy Modeling of Antibody Structures by a Search for Minimum-Energy Recombination of Backbone Fragments.” Proteins 85 (1): 30–38.

Overview
========
Methods for antibody structure prediction rely on sequence homology to experimentally determined structures. Resulting models may be accurate, but they are often stereochemically strained, limiting their usefulness in modeling and design workflows. Instead of using sequence homology, AbPredict conducts a Monte Carlo based search for low-energy combinations of backbone conformations, derived from experimentally solved antibody structures, to yield accurate and unstrained antibody structures.
ABpredict uses a combinatorial backbone optimization algorithm, which leverages the large number of experimentally determined molecular structures of antibodies to construct new antibody models. Briefly, all the experimentally determined antibody structures are downloaded from the Protein Data Bank (PDB) and segmented along structurally conserved positions: the disulfide cysteines at the core of the variable domain's light and heavy chains, creating 4 segments comprising of CDR's 1&2 and the intervening scaffold (VH and VL)  and CDR 3 (H3 and L3). These four segments are then recombined combinatorially to produce a highly conformationally diverse set of novel antibody models. The input sequence for modeling is then thread onto the starting set of models. The models are then energetically optimized using Monte-Carlo sampling. At each step a random segment conformation is sampled from a pre-computed database (See [SpliceOutAntiBody](https://www.rosettacommons.org/docs/latest/scripting_documentation/RosettaScripts/Movers/SpliceOutAntibody)).
The final models are then ranked by energy.

AbPredict is implemented as a rosetta scripts protocol. An example of this protocol can be found here:
\<Rosetta_Directory\>/demos/tutorials/AbPredict/AbPredict_xsd.xml

####How to set up a modeling run
1. The protocol is set up to model the variable region of an antibody (Fv)
2. The input sequence should be passed as a script var in the following syntax, either as a command line argument or added to the flags file:
```
-parser:script_vars sequence=IKMTQSPSSMYASLGERVTITCKASQDIRKYLNWYQQKPWKSPKTLIYYATSLADGVPSRFSGSGSGQDYSLTISSLESDDTATYYCLQHGESPYTFGGGTKLEIQLQQSGAELVRPGALVKLSCKASGFNIKDYYMHWVKQRPEQGLEWIGLIDPENGNTIYDPKFQGKASITADTSSNTAYLQLSSLTSEDTAVYYCARDNSYYFDYWGQGTTLTVS 
```
**Note the following rules concerning the input sequence:**
***
* The N-terminus tail length (the residues before the first disulfide cysteine, not including) of the light chain should be exactly 21 aa's long
* The The N-terminus tail length of the heavy chain (starting from the first residue after the Vl/Vh chain break up to the first disulfide cys, not including) should be exactly 20 aa's
* There should be exactly 7 aa's after the conserved L3 phe (L98 in Chothia numbering)
* There should be exactly 0 aa's after the conserved H3 trp (H103 in Chothia numbering)
***

3. The next step is to create a list of all segments from the precomputed conformation database with the correct length with respect to the input sequence. The Different segment length correspond to rules listed above.
4. To get all the relevant segments from the conformation database you can use this bash script:
`\<Rosetta_Directory\>/demos/tutorials/AbPredict/create_run.sh`

**To run:**
```
./create_run.sh <VL length> <L3 length> <HL length> <L3 length>
```
You should run in the script within the folder \<Rosetta_Directory\>/demos/tutorials/AbPredict/ 

5. The output file "segment_lengths_script_vars" should have 500 lines, with each line looking like this:
```
-parser:script_vars entry_H1_H2="1AHWH" entry_L1_L2="1AHWL" entry_H3="1AHWH" entry_L3="1AHWL"
```
6. Each line in the file corresponds to one modeling trajectory. 500 jobs is sufficient. You can increase the number of modeling jobs by running more "ntrial" in each job or creating more jobs by changing the number of lines in the create_run.sh file.





Rosetta Antibody can model both antibodies (consisting of the heavy and light chain variable region) and nanobodies (consisting of only the heavy chain variable region). To run the protocol, one needs:

1. The sequence of interest in FASTA format, with a description lines preceding the sequence and indicating either ">heavy" or ">light".
2. BLAST+ (version 2.2.28 or later).
3. Rosetta (the latest if possible, officially supported in 3.7).
4. The antibody database contained in the Rosetta/tools repository (as up-to-date as possible).

In Rosetta, antibody modeling is a two stage process. 

**Executable: antibody**

First, the sequences are divided into structurally conserved regions (FRH, H1, H2, H3, FRL, L1, L2, and L3) and templates are selected from the database based on BLAST+ score. Alternatively, manual templates can be specified via PDB code and the -antibody:{region}_template, for example: `-antibody:l1_template 1rzi`. Note that the templates must be present in the database. After selection, template complementarity determining regions are grafted on the template frameworks and the frameworks are assembled according to a template VH&ndash;VL orientation (predicting this orientation is challenging, so ten template orientations used). A highly recommended, but optional, FastRelax with constraints is used to alleviate any clashes introduced by grafting. 

Sample command line: `antibody.macosclangrelease -fasta antibody_chains.fasta | tee grafting.log`.

Here `antibody_chains.fasta` looks like:
```
>heavy
VKLEESGGGLVQPGGSMKLSCATSGFRFADYWMDWVRQSPEKGLEWVAEIRNKANNHATYYAESVKGRFTISRDDSKRRVYLQMNTLRAEDTGIYYCTLIAYBYPWFAYWGQGTLVTVS
>light
DVVMTQTPLSLPVSLGNQASISCRSSQSLVHSNGNTYLHWYLQKPGQSPKLLIYKVSNRFSGVPDRFSGSGSGTDFTLKISRVEAEDLGVYFCSQSTHVPFTFGSGTKLEIKR
```

The typical runtime, with FastRelax, is ~20 mins per model or ~3 hours for 10 models.

**Executable: antibody_h3**

Next, for each grafted model, the CDR H3 is de novo modeled and the relative VH&ndash;VL orientation is refined via local docking. Flags are split into a simulation set and a loop-modeling set. Both sets of flags are shown below (the loop modeling flags can also be found in tools/antibody/abH3.flags). If loop modeling is slow, it can be expedited by decreasing KIC sampling via the flags `-loops:refine_outer_cycles 2` and `-loops:max_inner_cycles 20`, however these flags have not been benchmarked. If using multiple VH&ndash;VL orientations, we recommend 1000 structures be generated for the top grafted model (typically, model-0.relaxed.pdb) and 200 structures be generated for the other orientations.

Sample command line: `antibody_H3.macosclangrelease @flags`.

flags:
```
# input grafted model
-s grafting/model-0.relaxed.pdb

# recommended number of structs
-nstruct 1000 

# recommended kink cst, kink present in 90% of Abs
-antibody:auto_generate_kink_constraint 
-antibody:all_atom_mode_kink_constraint

# necessary if running multiple procs w/o MPI
-multiple_processes_writing_to_one_directory 

# specify output file
-out:file:scorefile H3_modeling_scores.fasc 

# specify output folder
-out:path:pdb H3_modeling 

@abH3.flags
```

abH3.flags:
```
#how to run antibody mode -- these are the current best-practices
-antibody::remodel              perturb_kic
-antibody::snugfit              true
-antibody::refine               refine_kic
-antibody::cter_insert          false
-antibody::flank_residue_min    true
-antibody::bad_nter             false
-antibody::h3_filter            false
-antibody::h3_filter_tolerance  5
-antibody:constrain_vlvh_qq

#more standard settings, for packages used by antibody_H3
-ex1
-ex2
-extrachi_cutoff 0

#these are standard settings for kic/ngk
-loops:legacy_kic false
-loops:kic_min_after_repack true
-loops:kic_omega_sampling
-loops:allow_omega_move true    ### remove 'true' and loop::?
-kic_bump_overlap_factor 0.36
-loops:ramp_fa_rep
-loops:ramp_rama
-loops:refine_outer_cycles 5

#These enable the kink constraints.  Increase the weight if you want tighter kink constraints.
-antibody:constrain_cter
-constraints:cst_weight 1.0
```

The typical runtime varies, based on CDR H3 length (due to KIC). In our benchmark, the runtime was ~1 hour per model. We highly recommend using a cluster to speed up calculations. 

Additionally, models should be validated for a reasonable VH&ndash;VL orientation. This can be done with following command: `python $ROSETTA/main/source/scripts/python/public/plot_VL_VH_orientational_coordinates/plot_LHOC.py`.

Deprecated Python-Based Grafting Approach
=========================================


* [[RosettaAntibody3 application: the Python Pre-Processing Script|antibody-python-script]]
* [[RosettaAntibody3 application: Antibody CDR Grafting Protocol|antibody-assemble-CDRs]]
* [[RosettaAntibody3 application: Antibody Modeler Protocol (Loop H3 and VL-VH)|antibody-model-CDR-H3]]

To build an antibody model from sequences of its light chain and heavy chain, you need

1.  your input Fv sequences
2.  antibody.py (Downloading antibody.py from developer-only repository: [https://svn.rosettacommons.org/source/trunk/antibody/scripts.v2/](https://svn.rosettacommons.org/source/trunk/antibody/scripts.v2/) )
3.  ProFit (Installing ProFit3.1: [http://www.bioinf.org.uk/software/profit/](http://www.bioinf.org.uk/software/profit/) )
4.  BLAST (C++ version) (Installing BLAST: [http://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&PAGE\_TYPE=BlastDocs&DOC\_TYPE=Download](http://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&PAGE_TYPE=BlastDocs&DOC_TYPE=Download) )
5.  Rosetta

Currently, antibody homology modelling is a 3 step process:

1.  Template selections by BLAST
2.  Grafting of CDR templates onto a FR template and Fv refinement
3.  Intensive H3 modeling and VL/VH refinement

**Steps 1 and 2:**

This command should be all in one line.  Separated for documentation
```
./antibody.py --light-chain <input_l.fasta> --heavy-chain <input_h.fasta> 
--superimpose_profit <ProFit path> 
--blast <blastp path> 
--blast-database <blast_database path (in tools/antibody)> 
--antibody-database <antibody_database path (in tools/antibody)> 
--rosetta-bin <rosetta/rosetta_sourse/bin> 
--rosetta-database <rosetta_database> 
--rosetta-platform <rosetta binary extension if not gcc. Example: linuxclangrelease or static.linuxclangrelease>
```

\<input\_l.fasta\> and \<input\_h.fasta\> are the files having sequences of the light and heavy chains, respectively, which you want to model.

Inputs:

1.  Sequence of the light chain Fv in FASTA format
2.  Sequence of the heavy chain Fv in FASTA format

Outputs:

1.  Sequence-grafted and refined Fv pdb: grafted.pdb, grafted.relaxed.pdb
2.  Constraints file for optional use in Step 3: cter\_constraint

The script calls two Rosetta executable (relax and antibody\_assemble\_CDRs) for grafting and refinement, respectively, by specifying “–rosetta-bin” option. You can see other options by typing: ./antibody.py –help

**Step 3:**

```
[path to executable] /antibody_model_CDR_H3.[platform|linux/mac][compile|gcc/ ixx]release –database [path to database] @options
```

Sample options for a production run may look like: (this is an example, see details in [[RosettaAntibody3 application: Antibody Modeler Protocol (Loop H3 and VL-VH)|antibody-model-CDR-H3]] .

Flags starting from "-kic\_bump\_overlap\_factor 0.36" to "-loops:outer\_cycles 5" will turn on the NGK or KIC2 for H3 loop modeling. Without these flags, the code is running KIC1 for H3

```
    -nstruct 2000   
    -s grafted.relaxed.pdb                             # Output of the antibody.py
    -antibody::remodel              perturb_kic        # low-res H3 modeling
    -antibody::snugfit              true               # VL-VH orientation optimization via docking
    -antibody::refine               refine_kic         # high-res H3 modeling
    -antibody::cter_insert          false              # H3 cterminal insertion using Kink/Extend fragments
    -antibody::flank_residue_min    true               # minimize 2 stem residues each side of H3 during modeling
    -antibody::bad_nter             false              # if n-terminal stem of H3 is bad and you have a pdb file with correct stem to copy
    -antibody::h3_filter            true               # using bioinformatics rules of Kink/Extend to filter out bad H3 decoys
    -antibody::h3_filter_tolerance  20                 # the maximum number of filtering is set to 20
    -ex1 -ex2 -extrachi_cutoff 0                       # packing options
    -constraints:cst_file cter_constraint              # constraint file which can include one or two lines of below optional constraints: 
    -antibody:constrain_cter                           #   optional constraint (a) the H3 cterminus to be Kink/Extend
    -antibody:constrain_vlvh_qq                        #   optional constraint (b) the distance between two GLN-GLN residues one L and H chains
    -kic_bump_overlap_factor 0.36                      # KIC1 become KIC2 (or NGK) after turning on the flags from here
    -corrections:score:use_bicubic_interpolation false
    -loops:legacy_kic false
    -loops:kic_min_after_repack true
    -loops:kic_omega_sampling
    -loops:allow_omega_move true
    -loops:ramp_fa_rep
    -loops:ramp_rama
    -loops:outer_cycles 5
```

Inputs:

1.  Sequence-grafted and refined Fv pdb: grafted.relaxed.pdb
2.  Constraints file for optional use, output from steps 1 and 2: cter\_constraint

Outputs:

1.  Set of modeled and refined Fv pdbs with loop modeled CDH3 loops: \<grafted.relaxed\_000X.pdb\> We recommend generating at least 2000 decoys during this step

Post Processing
===============

You can use a set of decoys simultaneously for antibody-antigen docking simulations, such as SnugDock and EnsembleDock.

##See Also

* [[General Antibody Options and Tips]]
* [[Antibody Applications]]: Homepage for antibody applications
    - [[RosettaAntibodyDesign]]: Design antibodies and antibody-antigen complexes
    - [[Camelid antibody docking|antibody-mode-camelid]]: Dock camelid antibodies to their antigens.
    - [[SnugDock | snugdock]]: Paratope structure optimization during antibody-antigen docking
    * [[Antibody Design Strategy Analysis]]: A PyRosetta-based tool to analyze and/or compare antibody design strategies.
    * [[CDR Cluster Identification]]: An application that matches each CDR of an antibody to North/Dunbrack CDR clusters based on the lowest dihedral distance to each cluster center.
    * [[CDR Cluster Constrained Relax]]: An application to relax CDRs using circular harmonic constraints based on identified CDR clusters.
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs