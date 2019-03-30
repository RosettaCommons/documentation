#FlexPepDock

Metadata
========

Author: Barak Raveh, Nir London, Nawsad Alam, Ora Schueler-Furman

Last updated March 11, 2019 by Alisa Khramushin; PI: Ora Schueler-Furman (ora.furman-schueler@mail.huji.ac.il).

Code and Demo
=============

-   Application source code: `        rosetta/main/source/src/apps/public/flexpep_docking/FlexPepDocking.cc       `
-   Main mover source code: `        rosetta/main/source/src/protocols/flexpep_docking/FlexPepDockingProtocol.cc       `
-   For a demonstration of a basic run of the refinement protocol and of a run with an alternative anchor with low-resolution optimization, see integration folder ( `        rosetta/main/tests/integration/tests/flexpepdock/       ` ).
-   For a demonstration of a basic run of the ab-initio protocol see the protocol capture folder `        rosetta/demos/protocol_capture/flex_pep_dock_abinitio       ` . The README file contains all the information that is needed in order to make a new run on a query peptide-protein interaction.

References
==========

The main references for the FlexPepDock Refinement, FlexPepDock *ab-initio* and PIPER-FlexPepDock protocols include additional scientific background, in-depth technical details about the protocols, and an assessment of their performance over different datasets of peptide-protein complexes:

Refinement protocol:

```
Raveh B*, London N* and Schueler-Furman O
Sub-angstrom Modeling of Complexes between Flexible Peptides and Globular Proteins.
Proteins, 78(9):2029–2040 (2010).
```

*ab-initio* protocol:

```
Raveh B, London N, Zimmerman L and Schueler-Furman O
Rosetta FlexPepDockab-initio: Simultaneous Folding, Docking and Refinement of Peptides onto Their Receptors.
PLoS ONE, 6(4): e18934 (2011).
```

PIPER-FlexPepDock (Global docking protocol):

```
Alam N, Goldstein O, Xia B, Porter KA, Kozakov D, Schueler-Furman O 
High-resolution global peptide-protein docking using fragments-based PIPER-FlexPepDock. PLoS Comput Biol 13(12): e1005905 (2017).
```

Application purpose
===========================================

A wide range of regulatory processes in the cell are mediated by flexible peptides that fold upon binding to globular proteins. The FlexPepDock Refinement protocol and the FlexPepDock *ab-initio* protocols are designed to create high-resolution models of complexes between flexible peptides and globular proteins. Both protocols were benchmarked over a large dataset of peptide-protein interactions, including challenging cases such as docking to unbound (free-form) receptor models (see [References](#References) ).

In addition, PIPER-FlexPepDock protocol was developed for cases, when no information about the peptide beyond its sequence is available. In this protocol the folding of the peptide is decoupled from its docking to the receptor. The protocol was validated on a representative benchmark set of crystallographically solved high-resolution peptide-protein complexes (see [References](#References) ).

**Refinement, *ab-initio* and global docking protocols:**

-   The Refinement protocol is intended for cases where an approximate, coarse-grain model of the interaction is available. The protocol iteratively optimizes the peptide backbone and its rigid-body orientation relative to the receptor protein, in addition to on-the-fly side-chain optimization.

-   The *ab-initio* protocol extends the refinement protocol considerably, and is intended for cases where no information is available about the peptide backbone conformation. It simultaneously folds and docks the peptide over the receptor surface, starting from any arbitrary (e.g., extended) backbone conformation. It is assumed that the peptide is initially positioned close to the correct binding site, but the protocol is robust to the exact starting orientation.

-   PIPER-FlexPepDock is designed for cases where the binding site is unknown, starting with a receptor in PDB format and a peptide sequence only. A set of fragments representing the peptide conformational ensemble is rigid body docked to the receptor and further refined to high resolution with the Refinement protocol.

Algorithm
=========

**Refinement protocol:** The input to the protocol is an initial coarse model of the peptide-protein complex in PDB format (approximate backbone coordinates for peptide in the receptor binding site). Initial side-chain coordinates (such as the crystallographic side-chains of an unbound receptor) can be optionally provided as part of the input model. A preliminary step in the Refinement protocol involves the pre-packing of the input structure, to remove internal clashes in the protein monomer and the peptide (see prepack mode below). In the main part of the protocol, the peptide backbone and its rigid-body orientation are optimized relative to the receptor protein using the Monte-Carlo with Minimization approach, in addition to on-the-fly side-chain optimization. An optional low-resolution (centroid) pre-optimization may improve performance further. The main part of the protocol is repeated *k* times. The output models are then ranked by the user based on their energy score. The Refinement protocol is described in detail in the Methods section in Raveh, London et al., Proteins 2010 (see [References](#References) ).

***ab-initio* protocol:** The input to the *ab-initio* protocol is: (1) A model of the peptide-protein complex in PDB format similar to the Refinement protocol, but starting from arbitrary (e.g., extended) peptide backbone conformation. It is required that the peptide is initially positioned in some proximity to the true binding pocket, but the exact starting orientation may vary. A preiminary step for the *ab-initio* protocol is the generation of fragment libraries for the peptide sequence, with 3-mer, 5-mer and 9-mer fragments (these can be generated automatically via a script from the starting structure, as shown in `       rosetta/main/demos/protocol_capture/flex_pep_dock_abinitio/      ` demo files). Another preliminary step is pre-packing, as in the Refinement protocol. The first step in the main part of the protocol involves a Monte-Carlo simulation for *de-novo* folding and docking of the peptide over the protein surface in low-resolution (centroid) mode, using a combination of fragment insertions, random backbone perturbations and rigid-body transformation moves. In the second step, the resulting low-resolution model is refined with FlexPepDock Refinement. As in the independent refinement protocol, the output models are then ranked by the used based on their energy score, or also subjected to clustering for improved performance. Our *ab-initio* protocol is described in detail in the Methods section in Raveh, London, Zimmerman et al., PLoS ONE 2011 (see [References](#References) ).

**PIPER-FlexPepDock**: the input to the protocol is a receptor in PDB format and a FASTA file with peptide sequence containing the binding motif. The protocol consists of 3 main steps: fragment ensemble generation using Rosetta Fragment picker (note that the fragments are cut out from the PDB, including side-chains), FFT based exhaustive rigid body docking of these fragments using PIPER, and high-resolution flexible refinement performed by FlexPepDock, followed by clustering and selection of top ranking representatives. For more detailed description see [References](#References)

For more information, see the following tips about [correct usage of FlexPepDock](#When-you-should-/-should-not-use-FlexPepDock:).

Modes
-----

-   **Pre-pack mode** ( -flexpep\_prepack flag):
     The pre-packing mode optimizes the side-chains of each monomer according to the [[Rosetta energy function|score-types]]. Unless you know what you are doing, we strongly recommend pre-packing the input structures, and applying one of the peptide docking protocols to the resulting pre-packed structures, as this can improve model selection considerably (see below). However, in cases where side-chains have been previously optimized by Rosetta using the same scoring function, this step can be skipped.

-   **Low-resolution *ab-initio* mode** (-lowres\_abinitio flag):
     This is the main part of the *ab-initio* peptide docking protocol, for simultaneous *ab-initio* folding and docking of the peptide over the protein surface. This mode is typicalled used together with the refinement mode ( -pep\_refine flag) - in this case, the peptide is first folded *de-novo* and then refined.

-   **Refinement mode** ( -pep\_refine flag)
     High-resolution refinement, starting from a coarse model of the complex. This protocol may be used together with the lowres\_preoptimize flag, see below. It is also used for refining the low-resolution structure that results from the low-resolution *ab-initio* protocol (these two modes can be used together)
     Important note: for most input files, we strongly recommend running the prepack mode (below) before running the *ab-initio* or Refinement protocols.

-   **Rescoring mode** (-flexpep\_score\_only)
     This mode rescores the input PDB structures, and outputs elaborate statistics about them in the score file.

-   **Minimization mode** (-flexPepDockingMinimizeOnly)
     Perform a short minimization of the peptide protein interface without going into the docking simulation (including all side-chain torsion angles ; all peptide backbone torsion angles ; and the rigid body orientation of the peptide relative to the receptor)

For the refinement step in PIPER-FlexPepDock use:

-    **Refinement mode** (-lowres_preoptimize, -flexPepDocking:pep_refine)

-    **Rescoring mode** (-flexPepDocking:flexpep_score_only)

-    **Minimization** (-min_receptor_bb)

Input Files
===========

FlexPepDock requires the following inputs:

-   **Starting structure:**
     An initial approximate structure of a peptide-protein complex, either with or without side-chain coordinates. In *ab-initio* mode, the starting backbone conformation of the peptide may be arbitrary (e.g., extended). See `        main/tests/integration/tests/flexpepdock/input/1ER8_rb1_tor10_5.pdb       ` for an example for an initial structure in Refinement mode, or `       main/demos/protocol_capture/flex_pep_dock_abinitio/input_file/2b1z.start.pdb       ` for *ab-initio* mode. The exact way in which the starting conformation is created may vary depending on the specific application. For example, if similar structures exist (this is common in peptide binders with multiple specificity, as in PDZ domains and many signal peptides), the initial structure can be constructed from an homology model of a similar structure using the Rosetta tool for comparative modeling, or any other homology modeling tools. If only the binding site is known, the initial peptide chain can be created from a FASTA file using the [[BuildPeptide Rosetta utility|build-peptide]] or using external tools such as PyMol Builder. The chain can then be positioned manually in the vicinity of the binding site (e.g., in an extended backbone conformation) using external tools like PyMol and Chimera. Alternatively, the peptide may be positioned manually in a completely arbitrary orientation relative to the receptor protein, and brought to the vicinity of the binding site using FlexPepDock or Rosetta docking application, together with a constraint file to position the peptide close to the specified binding site, using appropriate distance constraints.

-   **Native structure:**
     This is a reference structure for RMSD comparisons and statistics of final models, in case a native structure is available. If a native is not supplied, the starting structure is used for reference instead.
     See `        rosetta/main/tests/integration/tests/flexpepdock/input/1ER8.pdb       ` for an example in Refinement mode, or `        rosetta/demos/protocol_capture/flex_pep_dock_abinitio/input_file/2b1z.native.pdb       ` for *ab-initio* mode.

-   **Fragment files (for *ab-initio* docking):**
     3-mer, 5-mer and 9-mer Rosetta fragment files should be provided for the peptide sequence when using the *ab-initio* protocol (if the peptide length is smaller than 9, use 3-mer and 5-mer libraries). Note that fragments are not required for the receptor, but the fragment files for the peptide should be reindexed to account for the preceding receptor residues. For instance, if the receptor has 100 residues, the first resiude index in the fragment file for the peptide should be 101. The protocol capture script `        rosetta/demos/protocol_capture/flex_pep_dock_abinitio/scripts/frags/shift.sh       ` can be used to offset a fragment file. The protocol capture also enables automatic generation and offsetting of the entire fragment file (see README file). See example runs below in the [Tips](#Tips) section.

-   **Constraint file (optional):**
     As in any other Rosetta protocol, please refer to the [[constraint file]] documentation page for more information.

PIPER-FlexPepDock requires:
-   **Starting structure:**
    Free receptor structure (bound or unbound conformation).

-   **Peptide sequence:**
    In FASTA or in simple text file format. Peptides up to 13 amino acids were used for benchmarking.

-   **Native structure (optional):**
    In case the complex structure is known, it can be provided as 'native' structure. Otherwise, after refinement step the top-scoring structure will be used as a reference structure for the RMSD calculation.

-   **Peptide secondary structure (optional):**
    In case the secondary structure of the peptide is known or was predicted using another tool, it can be given as an input to the protocol as a text file consisting only of C, H or E letters (for coil, helix or beta-strand accordingly).

Options
=======

Note that the -flexpep\_prepack and -flexPepDockingMinimizeOnly' flags are mutually exclusive with respect to the -lowres\_abinitio and -pep\_refine, as they denote completely different modes of functionally (-pep\_refine and -lowres\_abinitio are commonly used together, for ab-initio peptide modeling followed by refinement).

I. Common FlexPepDock flags:
----------------------------

|  Flag  |  Description  |  Type  |  Default  |
|:-------|:--------------|:-------|:----------|
| -receptor_chain| chain-id of receptor protein. Multichain receptor is supported (please note: if using this flag for a multichain receptor, the PDB file must contain first the recetor chains in a consecutive manner, only then followed by the peptide chain).| String| first chain in input|
| -peptide_chain| chain-id of peptide protein|  String| second chain in input|
|-lowres_abinitio| Low-resolution ab-initio folding and docking model.| Boolean| false|
|-pep_refine|Refinement mode. (equivalent to obsolete -rbMCM -torsionsMCM flags)| Boolean| false|
|-lowres_preoptimize| Perform a preliminary round of centroid mode optimization before Refinement. See more details in [Tips](#Tips).| Boolean| false|
|-flexpep_prepack|Prepacking mode. Optimize the side-chains of each monomer separately (without any docking).| Boolean|false|
|-flexpep_score_only| Read in a complex, score it and output interface statistics| Boolean| false|
|-flexPepDockingMinimizeOnly| Minimization mode. Perform only a short minimization of the input complex|Boolean|false|
| -ref_startstruct| Alternative start structure for scoring statistics,instead of the original start structure (useful as reference for rescoring previous runs with the -flexpep_score_only flag.)| File| N/A|
|-peptide_anchor| Set the peptide anchor residue manually. It is recommended to override the default value only if one strongly suspects the critical region for peptide binding is extremely remote from its center of mass.| Integer| Residue nearest to the peptide center of mass.|

II. Relevant Common Rosetta flags
---------------------------------

More information on common Rosetta flags can be found in the [[relevant rosetta manual pages|Rosetta-Basics]]. In particular, flags related to the job-distributor (jd2), scoring function, constraint files and packing resfiles are identical to those in any other Rosetta protocol).

|  Flag  |  Description  |
|:-------|:--------------|
| -in::file::s  Or -in:file:silent| Specify starting structure (in::file::s for PDB format, in:file:silent for silent file format).|
| -in::file::silent_struct_type  -out::file::silent_struct_type|Format of silent file to be read in/out. For silent output, use the binary file type since other types may not support ideal form|
|-native|Specify the native structure for which to compare in RMSD calculations. This is a required flag. When the native is not given, the starting structure is used for reference.|
|-nstruct|Number of models to create in the simulation|
|-unboundrot|Add the position-sepcific rotamers of the specified structure to the rotamer library (usually used to include rotamers of unbound receptor)|
|-use_input_sc|Include rotamer conformations from the input structure during side-chain repacking. Unlike the -unboundrot flag, not all rotamers from the input structure are added each time to the rotamer library, only those conformations accepted at the end of each round are kept and the remaining conformations are lost.|
|-ex1/-ex1aro -ex2/-ex2aro -ex3 -ex4|Adding extra side-chain rotamers (highly   recommended). The -ex1 and -ex2aro flags were used in our own tests, and therefore are recommended as default values.|
|-database|The Rosetta database|
|-frag3 / -flexPepDocking:frag5 / -frag9|3mer / 5mer / 9mer fragments files for ab-initio peptide docking (9mer fragments for peptides longer than 9).|

III. Expert flags
-----------------

|  Flag  |  Description  |  Type  |  Default  |
|:-------|:--------------|:-------|:----------|
|-rep_ramp_cycles|The number of outer cycles for the protocol. In each cycle, the repulsive energy of Rosetta is gradually rampped up and the attractive energy is rampped down, before inner-cycles of Monte-Carlo with Minimiation (MCM) are applied.|Integer|10|
|-mcm\_cycles|Number of inner-cycles for both rigid-body and torsion-angle Monte-Carlo with Minimization (MCM) procedures.|Integer|8|
|-smove\_angle\_range|Defines the perturbations size of small/sheer moves.|Real|6.0|
|-extend\_peptide|start the protocol with the peptide in extended conformation (neglect original peptide conformation ; extend from the anchor residue)|Boolean|false|
|-rbMCM|Perform rigid body refinement by Monte-Carlo with Minimization (obsolete)|Boolean|false|
|-torsionsMCM|Perform peptide backbone refinement by Monte-Carlo with Minimization (obsolete)|Boolean|false|
|-frag3/5/9\_weight|Relative weight of different fragment libraries in ab-initio fragment insertion cycles.|Real|1.0 / 0.25 / 0.1|

Tips
====

Examples
------------

-   **Refinement - typical run in three steps:**
    1.  pre-pack your initial complex

        ```
         FlexPepDocking.{ext}
        -database ${rosetta_db} -s start.pdb -native native.pdb -flexpep_prepack
         -ex1 -ex2aro [-unboundrot unbound.pdb]
        ```
    2.  generate 100 (or more) models with the -lowres\_preoptimize flag, and additional 100 models (or more) without this flag, by two separate runs (the low resolution can be skipped if you are in a hurry)

        ```
        FlexPepDocking.{ext}
        -database ${rosetta_db} -s start_0001.pdb -native native.pdb
        -out:file:silent decoys.silent -out:file:silent_struct_type binary
        -pep_refine -ex1 -ex2aro -use_input_sc
        -nstruct 100 -unboundrot unbound_receptor.pdb [ -lowres_preoptimize ]
        ```
    3.  Open the output score file of both runs (score.sc by default), sort it by model score (second column), and choose the top-scoring models as candidate models.

-   **Running the FlexPepDock *ab-initio* protocol:**
     Running the *ab-initio* protocol is a bit more complicated, since fragment files for the peptide need to be generated in advance, and their residue indices need to be offsetted to account for the receptor residues (as fragment files assume continuous indexing of residues between chains). Fortunately, the protocol capture folder `        rosetta/demos/protocol_capture/flex_pep_dock_abinitio/README       ` contains all information on how to automate this process. For manual runs, the following is needed:
    1.  Create your initial complex structure (see [Input files](#Input-Files) section for more information).
    2.  Pre-pack your initial complex as in FlexPepDock Refinement
    3.  Prepare 3-mer, 5-mer and 9-mer fragment files for the peptide using the fragment picker, as in any other Rosetta application (fragment libraries are not required for the receptor).
    4.  Assuming the receptor chain precedes the peptide chain, offset the indexing of the fragment file to account for it. In UNIX, this can be done by running the following sequence of commands:
        ```
        set ifragfile=<input frag file name>
        set ofragfile=<output frag file name>
        set nResReceptor=<# receptor residues>
        awk '{if ( substr ( $0,1,3 ) == "pos" ) {print substr ( $0,0,18 ) sprintf ("%4d",substr ( $0,19,4 ) + '"$nResReceptor"' ) substr ( $0,23,1000 ) ; } else {print ; }}' $ifragfile > $ofragfile
        ```
    5.  Generate 50,000 (or other number of choice) output models using the FlexPepDock *ab-initio* protocol:
        ```
        FlexPepDocking.{ext}
        -database ${rosetta_db} -s start.pdb -native native.pdb
        -out:file:silent decoys.silent -out:file:silent_struct_type binary
        -lowres_abinitio -pep_refine -ex1 -ex2aro -use_input_sc
        -frag3 <frag3 file> -flexPepDocking:frag5 <frag5 file> -frag9 <frag9 file>
        -nstruct 50000 -unboundrot unbound_receptor.pdb
        ```
    6.  You may rank the model according to the default score (second column in score file). However, our benchmarks indicate that ranking the models according to a new score, called *rewighted-score* , may be helpful (look for the column labeled "reweighted\_sc" in the score file).
    7.  We also found that clustering of the top-500 models using the Rosetta clustering application and choosing the clusters with lowest-energy representatives is helpful, and that good solutions are often found within the top 1-10 clusters. Clustering can be done (in UNIX) using the script `           demos/protocol_capture/flex_pep_dock_abinitio/scripts/clustering/cluster.sh          `, assuming the models are stored in a silent file, as follows.
        ```
        cluster.sh pdb-id 500 2 <scorefile> <reference-pdb> <models-silent-file> <score-type-column>
        ```
        The last parameter is the column number of the score according to which you wish to choose the top-500 models. We recommend using the column labeled "reweighted\_sc" for this, as described above.

-   **Running PIPER-FlexPepDock protocol:**
    1. Fragment generation using fragment picker:   
The make_fragments.pl script is used to run PSI-BLAST and PSIPRED to generate the peptide secondary structure and the sequence similarity profile:
    ```
    make_fragments.pl -verbose peptide.fasta
    ```
Rosetta fragment picker is used to assign fragments consistent with the predicted secondary structure and sequence profile to the vall database of high-resolution protein fragments:
    ```
    fragment_picker.linuxgccrelease -database ${rosetta_db} -in:file:vall vall.jul19.2011 -in:file:checkpoint pep_seq.checkpoint -frags:frag_sizes 6 -frags:n_candidates	2000 -frags:n_frags 50 -frags:ss_pred pep_seq.psipred_ss2 psipred -frags:scoring:config psi_L1.cfg -frags:bounded_protocol true
    ```
These assigned fragments are extracted from the Protein Data Bank (including the side-chains). The non-identical residues are mutated using the Rosetta fixbb design protocol:
    ```
    fixbb.linuxgccrelease -database ${rosetta_db} -in:file:s fragment_1.pdb -resfile mutation_resfile -ex1 -ex2 -use_input_sc
    ```
    2. PIPER Docking:

        Step I: preprocessing the input receptor and fragments using pdbprep.pl and pdbnmd.pl:
        ```
        perl pdbprep.pl receptor.pdb
        perl pdbnmd.pl receptor.pdb '?'
        ```
        Each of the 50 fragments is similarly processed.

        Step II: Running PIPER FFT docking:
        ```
        piper.acpharis.omp.20120803 -vv -c1.0 -k4 --msur_k=1.0 --maskr=1.0 -T FFTW_EXHAUSTIVE -R 70000 -t 1 -p atoms.0.0.4.prm.ms.3cap+0.5ace.Hr0rec -f coeffs.0.0.4.motif -r rot70k.0.0.4.prm receptor_nmin.pdb fragment1_nmin.pdb >piper.log
        ```
        Each of the fragments is docked onto the receptor. 

        Step III: Top scoring 250 PIPER models are extracted:
        ```
        python apply_ftresult.py -i PIPER_model_ID ft.000.00 rot70k.0.0.4.prm fragment1_nmin.pdb --out-prefix PIPER_model_ID
        ```
        Where PIPER_model_ID is an integer value assigned to each transformation for a fragment.
    3. FlexPepDock Refinement

        Step I: prepacking the PIPER model

        In the PIPER docked model the receptor is replaced with a prepacked receptor. A single prepacked receptor is used.

        Step II: Running refinement
        ```
        FlexPepDocking.mpi.linuxgccrelease -database ${rosetta_db} -in:file:s PIPER_model_1.pdb -scorefile score.sc -min_receptor_bb -lowres_preoptimize -pep_refine -flexpep_score_only -ex1 -ex2aro -use_input_sc -unboundrot free_receptor.pdb 
        ```
        Where PIPER_model_1.pdb is the prepacked model.

    4. Clustering:
    The top scoring 1% refined models (125) are clustered using the Rosetta cluster application:
    ```
    cluster.linuxgccrelease -in:file:silent decoys.silent top_model_list -in:file:silent_struct_type binary -database ${rosetta_db} -cluster:radius 2.0 -in:file:fullatom -tags `cat top_refined_list` -silent_read_through_errors
    ```
    The clusters are ranked based on the top scoring decoys from each clusters, based on reweighted score, and top ranking 10 clusters are selected as putative models. 

More tips
---------

-   **Always pre-pack:**
     Unless you know what you are doing, always pre-pack the input structure (using the pre-packing mode), before running the peptide docking protocol. Our docking protocol focuses on the interface between the peptide and the receptor. However, we rank the structures based on their overall energy. Therefore, it is important to create a uniform energetic background in non-interface regions. The main cause for irrelevant energetic differences between models is usage of sub-optimal side-chain rotamers in these regions. Therefore, pre-packing the side-chains of each monomer before docking is highly recommended, and may significantly improve the eventual model ranking.

-   **Model Selection:**
     In order to get good results, it is recommended to generate a large number of models (at least 200 for Refinement ; 50,000 or more for *ab-initio* ). The selection of models should be made based on their score. While selection of the single top-scoring model may suffice in some cases, it is recommended to inspect the top-5 or top-10 scoring models. Our tests indicate that at least for *ab-initio* peptide docking, using the score file column labeled "reweighted\_sc" may be better than using the default score (score-12). Clustering may also help (see example runs above and protocol capture of the *ab-initio* protocol).

-   **Low-resolution pre-optimization**
     For refinement, the -lowres\_preoptimize flag can be used to add a preemptive centroid-mode optimization step, before performing full-atom, high-resolution refinement. As a rule of thumb, it is recommended to use this flag when the quality of the initial starting structure is less defined (roughly more than 3A peptide backbone-RMSD), and thus sampling an extended range makes sense. In theory, this flag can be also specified independently (without the -rb\_mcm or torsion\_mcm flags). In this case, only low-resolution sampling followed by side-chain repacking will be performed. This mode of operation was not tested. This step was also not tested when using the *ab-initio* protocol (as it seems redundant).

-   **The unbound rotamers flag:**
     In many cases, the unbound receptor (or peptide) may contain side-chain conformations that are more similar to the final bound structure than those in the rotamer library. In order to save this useful information, it is possible to specify a structure whose side-chain conformations will be appended to the rotamer library during prepacking or docking, and may improve the chances of getting a low-scoring near-native result. This option was originally developed for the RosettaDock protocol.

-   **Extra rotamer flags:**
     It is highly recommended to use the Rosetta extra rotamer flags that increase the number of rotamers used for prepacking (we used the -ex1 and -ex2aro flags in our own runs, but feel free to experiment with other flags if you think you know what you are doing. Otherwise, stick to -ex1 and -ex2aro).

-   **Side-chain modeling quality**
     Our benchmark of the Refinement protocol indicates that side-chains peptide motif residues (conserved residues that allow the peptide to bind) are modelled better than non-motif residue, often with sub-Angstrom resolution (of course, assuming the peptide is modelled correctly in general).

When you should / should not use FlexPepDock:
---------------------------------------------

-   **From refinement to blind docking:**
     Neither refinement nor *ab-initio* protocols are intended for fully blind docking. The *ab-initio* protocol assumes that the peptide is located at the vicinity of the binding site, but does not assume anything about the initial peptide backbone conformation. The Refinement protocol is more restricted - it is intended for obtaining high-resolution peptide models given a coarse-grain starting structure, which should resemble the native solution to some extent (about 5A backbone-RMSD for the native peptide, even though in some cases, the protocol works well for starting structures with up to 12A bb-RMSD from the native). 

    For fully blind docking using PIPER-FlexPepDock is recommended, as it designed specifically to handle these cases, and makes no assumption about neither peptide backbone conformation, nor binding site. 

    Alternatively, the approximate binding site can be estimated from available computational methods for interface prediction, or from experimental procedures such as site-directed mutagenesis or known homologues. For Refinement, a coarse model can be often obtained from e.g., interactions of homologue receptors or peptides with similar sequences. It may be useful to use a constraint file to force the peptide to reach the vicinity of a known binding site or to force specific interactions.

-   **Secondary structure assignment:**
     Formally, neither protocol requires initial secondary structure assignment. The *ab-initio* protocol may benefit implicitly from accurate secondary structure prediction when building the fragment libraris, but this is not necessary. In contrast, while the Refinement protocol is designed to allow substantial peptide backbone flexibility, it does not switch well between secondary structures (from strand to helix conformation, etc.). Hence for refinement, it may be useful to initially assign a canonical secondary structure to the peptide based on prior information (computational predictions, homologue structures, etc.), and experimental information (CD experiments, etc.). Of course the *ab-initio* protocol can be used in cases where such information is not available.

-   **Receptor model:**
     Our protocol allows full receptor side-chain flexibility, and was shown to perform quite well when docking to unbound receptors or to alternative conformations. However, it is assumed that the receptor backbone does not change too much at the interface, as we do not yet model receptor backbone flexibility. We expect receptor backbone flexibility would be added in future extensions to the protocol.

-   **Peptide length:**
     Our benchmarks consist of peptides of length 5-15, and our protocols performed well on this benchmark regardless of peptide length. We experimented sporadically also with larger peptides (up to 30 residues), but we do not have elaborate benchmark results for these.

     For PIPER-FlexPepDock optimal peptide length range is a bit shorter: using peptides of length more than 12 is not recommended, since too long peptides may harbor irrelevant motif surrounding conformations which might hinder site detection during rigid-body docking step, while too short peptides (less than 6 amino acids) might show a weak and noisy signal. 

-   **Typical running time:**
     In our tests, producing 200 models with the Refinement protocol typically takes 10 CPU hours (approximately 3 minutes per model). Substantial speedup gain is obtained by running parrallel proccesses using appropriate [[job-distributor|jd2]] flags (e.g.m for using MPI). The *ab-initio* protocol requires a much larger number of models (we experimented with 50,000 models), but the running time per model is similar (3-4 minutes). The running time may increase or decrease, depending mainly on the receptor size (for peptides of length 5-15).

-   **Multichain receptors:**
     In order for FlexPepDock to correctly handle multichain receptors, the PDB file must contain first the receptor chains in a consecutive manner, followed by the peptide chain and ligand chains come last.
     For PIPER-FlexPepDock, all the chains in a multichain receptor must be called the same as if it was one chain (in order for PIPER to correctly handle it), followed by the peptide chain.

Expected Outputs
================

The output of a FlexPepDock run is a score file (score.sc by default) and k model structures (as specified by the -nstruct flag and the other common Rosetta input and output flags). The score of each model is the second column of the score file. Model selection should be made based on either the score or reweighted-score columns (which exhibited superior performance in the *ab-initio* benchmarks).


**Interpretation of FlexPepDock-specific score terms:** (for the common Rosetta scoring terms, please also see the [[relevant manual page|score-types]]).

|**total\_score** <sup>\*</sup>|**Total score of the complex**|
|:-----------------------------|:-----------------------------|
|**reweighted\_sc** <sup>\*</sup>|Reweighted score of the complex, in which interface residues are given double weight, and peptide residues are given triple weight|
|I\_bsa|Buried surface area of the interface|
|I\_hb|Number of hydrogen bonds across the interface|
|I\_pack|Packing statistics of the interface|
|I\_sc|Interface score (sum over energy contributed by interface residues of both partners)|
|pep\_sc|Peptide score (sum over energy contributed by the peptide to the total score; consists of the internal peptide energy and the interface energy)|
|I\_unsat|Number of buried unsatisfied HB donors and acceptors at the interface.|
|rms (ALL/BB/CA)|RMSD between output model and the native structure, over all peptide (heavy/backbone/C-alpha) atoms|
|rms (ALL/BB/CA)\_if|RMSD between output model and the native structure, over all peptide interface (heavy/backbone/C-alpha) atoms, where interface includes any residue whose C-beta atom (C-alpha for glycine) is within 8 Angstrom of a C-beta atom on the binding partner|
|rms (ALL/BB/CA/SC)\_CAPRI\_if|RMSD between output model and the native structure, over peptide and receptor interface residues, where interface is defined similarly to rms (ALL/BB/CA)\_if|
|rms (ALL/BB/SC)\_allIF| RMSD between output model and the native structure, over peptide and receptor interface residues,where interface includes any two residues on one partner where any non-hydrogen atom is within 4 Angstrom of a non-hydrogen atom in the binding partner|  
|startRMS(all/bb/ca)|RMSD between start and native structures, over all peptide (heavy/backbone/C-alpha) atoms|


Post Processing
===============

Except for model selection by total score or reweighted score, and possibly clustering (see [Tips](#Tips) section), no special post-processing steps are needed. For the *ab-initio* protocol, the protocol capture README file in `   rosetta/demos/protocol_capture/flex_pep_dock_abinitio/  ` contains all the information needed for clustering. However, advanced users may optionally use Rosetta [[Commands for the cluster application|cluster]] directly for assessing whether top-scoring models converge to a consensus solution. For FlexPepDock Refinement, clustering is an optional step, and is not considered an integral part of the Refinement protocol, as described and tested in Raveh *et al.*

##See Also

* [[FlexPepDock Server (external link)|http://flexpepdock.furmanlab.cs.huji.ac.il/]]: Web-based server that performs FlexPepDock for academic users.
* [[Docking Applications]]: Home page for docking applications
* [[Preparing structures]]: Notes on preparing structures for use in Rosetta
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[RosettaScripts]]: Homepage for the RosettaScripts interface to Rosetta
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files