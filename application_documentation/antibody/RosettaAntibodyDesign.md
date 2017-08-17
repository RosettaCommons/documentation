#Rosetta Antibody Design (RAbD) Manual

Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)
PI: Roland Dunbrack

Last Doc Update: 7/20/2017

[[_TOC_]]

# Overview
**RosettaAntibodyDesign (RAbD)** has been created as a generalized framework for the design of antibodies using Rosetta in which a user can easily tailor the run to their needs.  **The algorithm is meant to sample the diverse sequence, structure, and binding space of an antibody-antigen complex.** It can be used for a multitude of project types, from denovo design to redesigns that improve binding affinity, optimize stability, or manipulate function.  

The framework is based on rigorous bioinformatic analysis and rooted very much on our [recent clustering](https://www.ncbi.nlm.nih.gov/pubmed/21035459) of antibody CDR regions.  It uses the **North/Dunbrack CDR definition** as outlined in the North/Dunbrack clustering paper. 

The supplemental methods section of the published paper has all details of the RosettaAntibodyDesign method.  This manual serves to get you started running RAbD in typical use fashions. 

# Algorithm
  
Broadly, the RAbD protocol consists of alternating outer and inner Monte Carlo cycles. Each outer cycle consists of randomly choosing a CDR (L1, L2, etc…) from those CDRs set to design, randomly choosing a cluster and then a structure from that cluster from the database according to the input instructions, and grafting that CDR’s structure, onto the antibody framework in place of the existing CDR (**GraftDesign**). The program then performs N rounds of the inner cycle, consisting of sequence design (**SeqDesign**), energy minimization, and optional docking. Each inner cycle structurally optimizes the backbone and repacks side chains of the CDR chosen in the outer cycle as well as optional neighbors in order to optimize interactions of the CDR with the antigen and other CDRs. 

**Backbone dihedral angle (CircularHarmonic) constraints** derived from the cluster data are applied to each CDR to limit deleterious structural perturbations. Amino acid changes are typically sampled from **profiles derived for each CDR cluster in PyIgClassify**. Conservative amino acid substitutions (according to the BLOSUM62 substitution matrix) may be performed when too few sequences are available to produce a profile (e.g., for H3). After each inner cycle is completed, the new sequence and structure are accepted according to the Metropolis Monte Carlo criterion. After N rounds within the inner cycle, the program returns to the outer cycle, at which point the energy of the resulting design is compared to the previous design in the outer cycle. The new design is accepted or rejected according to the Monte Carlo criterion.

If optimizing the antibody-antigen orientation during the design (dock), SiteConstraints are automatically used to keep the CDRs (paratope) facing the antigen surface.  These are termed **ParateopSiteConstraints**.   Optionally, one can enable constraints that keep the paratope of the antibody around a target epitope (antigen binding site).  These are called **ParatopeEpitopeSiteConstraints** as the constraints are between the paratope and the epitope. The epitope is automatically determined as the interface residues around the paratope on input into the program, however, any residue(s) can be set as the epitope to limit unwanted movement and sampling of the antibody.  See the examples and options below. 

More detail on the algorithm can be found in the published paper. 

# Setup and Inputs

**Antibody Design Database**

This app requires the Rosetta Antibody Design Database.  A database of antibodies from the original North Clustering paper is included in Rosetta and is used as the default .  An updated database (which is currently updated monthly) can be downloaded here: http://dunbrack2.fccc.edu/PyIgClassify/.  

It should be placed in <code> Rosetta/main/database/sampling/antibodies/ </code>  It is recommended to use this up-to-date database.

------------------------------

**Starting Structure**

The protocol begins with the three-dimensional structure of an antibody–antigen complex. Designs should start with an antibody bound to a target antigen (however optimizing just the antibody without the complex is also possible).  Camelid antibodies are fully supported.  This structure may be an experimental structure of an existing antibody in complex with its antigen, a predicted structure of an existing antibody docked computationally to its antigen, or even the best scoring result of low-resolution docking a large number of unrelated antibodies to a desired epitope on the structure of a target antigen as a prelude to de novo design.

The program CAN computationally design an antibody to anywhere on the target protein, but it is recommended to place the antibody at the target epitope.  It is beyond the scope of this program to determine potential epitopes for binding, however servers and programs exist to predict these. Automatic SiteConstraints can be used to further limit the design to target regions.

-------------------------

**Model Numbering**

Finally, the input PDB file must be renumbered to the AHo Scheme.  This can be done through the [PyIgClassify Server](http://dunbrack2.fccc.edu/pyigclassify/).  The PyIgClassify code can also be downloaded and run separately for local renumbering/analysis. 

On input into the program, Rosetta assigns our CDR clusters using the same methodology as PyIgClassify. The RosettaAntibodyDesign protocol is then driven by a set of command-line options and a set of design instructions provided as an input file that controls which CDR(s) are designed and how. Details and example command lines and instruction files are provided below.

# Command-line Examples

## Basic Settings

### General Design

**Example 1**

The command-line can be as simple as:

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda
```

This makes the H3 loop the primary CDR chosen in the outer cycle, running graft-based design on H3, while simultaneously sequence designing H1 and H2. 

----------------

**Example 2**

Here, we want to do a denovo-run, starting with random CDRs grafted in instead of whatever we have in antibody to start with (only for the CDRs that are actually undergoing graft-design).  This is useful, as we start the design with very high energy and work our way down.

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -random_start
```

### Docked Design

**Example 1**

In this example, we use integrated RosettaDock (with sequence design during the high-res step) to sample the antibody-antigen orientation, but we don't care where the antibody binds to the antigen.  Just that it binds. IE - No Constraints. The RAbD protocol always has at least Paratope SiteConstraints enabled to make sure any docking is contained to the paratope (like most good docking programs).

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -do_dock
```

------------------------

**Example 2**

Allow Dock-Design, incorporating auto-generated SiteConstraints to keep the antibody around the starting interface residues.  These residues are determined by being within 6A to the CDR residues.  

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -do_dock -use_epitope_constraints
```

----------------

**Example 3**

Allow Dock-Design, as above, but specify the Epitope Residues and Paratope CDRs to guide design to have these interact.

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -do_dock -use_epitope_constraints \
-paratope_cdrs H3 -epitope 63A 63A:A 64
```

-----------------------

**Example 4**

Here, we want to do a denovo-run, creating an interface at the light-chain, starting with random CDRs grafted in instead of whatever we have in the antibody to start with (for the designing CDRs).  

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs L1 L2 L3 \
-graft_design_cdrs L1 L2 L3 -seq_design_cdrs L1 L2 L3 -light_chain lambda -do_dock \
-use_epitope_constraints -paratope_cdrs L1 L2 L3 -epitope 63A 63A:A 64 -random_start
```

### Instruction File Customization
More complicated design runs can be created by using the Antibody Design Instruction file.  This file allows complete customization of the design run. See below for a review of the syntax of the file and possible customization.

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda \
-instruction_file my_instruction_file.txt
```

## Advanced Settings

**Example 1**

Here, we will disallow ANY sequence design into Proline residues and Cysteine residues, while giving a resfile to further LIMIT design and packing as specific positions. These can be given as 3 or 1 letter codes and mixed codes such as PRO and C are accepted. Note that the resfile does NOT turn any residues ON, it is simply used to optionally LIMIT design residue types and design and packing positions.

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda \
-resfile my_resfile.resfile -dissallow_aa PRO CYS
```

------------------------

**Example 2**

Here, we will change the mintype to relax.  This mintype enables Flexible-Backbone design.  Our default is to use min/pack cycles, but relax typically works better.  However, it also takes considerably more time!

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda \
-resfile my_resfile.resfile -dissallow_aa PRO CYS -mintype relax
```

-------------------------

**Example 3**

Finally, we want to allow the framework residues AROUND the CDRs we will be designing and any interacting antigen residues to design as well here.  We will disable conservative framework design as we want something funky (this is not typically recommended and is used here to indicate what you CAN do.

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda \
-resfile my_resfile.resfile -dissallow_aa PRO CYS -mintype relax \
-design_antigen -design_framework -conservative_framework_design false
```

## Expert Settings

**Example 1**

Now, we will spice things up even further.  We are feeling daring and we have LOTS of money for designs (I can dream, right! ;)

We will enable H3 Stem design here, which can cause a flipping of the H3 stem type from bulged to non-bulged and vice-versa.  

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -design_H3_stem
```

Cool.  That should make some interesting antibodies for our experiment.  

------------------
**Example 3**

Now, we will change around the KT to get more interesting samplings (from our 1.0 default).

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda \
-design_H3_stem -inner_KT 2.0 -outer_KT 2.0
```

----------------

**Example 4**

Finally, we want increased variability for our sequence designs.  So, we will increase number of sampling rounds for our lovely cluster profiles using the `-seq_design_profile_samples` option.  

Description of the option (default 1): "If designing using profiles, this is the number of times the profile is sampled each time packing done.  Increase this number to increase variability of designs - especially if not using relax as the mintype."

```
antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 \
-graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda \
-design_H3_stem -inner_KT 2.0 -outer_KT 2.0 -seq_design_profile_samples 5
```

# Antibody Design Instruction File
The Antibody Design Instruction File handles CDR-level control of the algorithm and design.  It is used to create the CDRSet for sampling whole CDRs from the PDB, as well as fine-tuning the minimization steps and sequence design strategies.  For each option, 'ALL' can be given to control all of the CDRs at once.  Specific capitalization of commands are not needed, and are used for style. Commands are broken down into 4 types, each controlling different aspects of the protocol including the GraftDesign stage, SeqDesign Stage, the Minimization type, and specific sequence design settings.

## Syntax

 - GraftDesign
 - SeqDesign
 - CDRSet
 - MinProtocol

## Default Settings

# GraftDesign Sampling Algorithms
These change the way CDRs are sampled from the antibody design database.   They can be specified using the <code>-design_protocol</code> flag.

- **Even Cluster Monte Carlo (DEFAULT)** 
 - `-design_protocol even_cluster_mc`
 - Evenly sample clusters during the GraftDesign stage by first choosing a cluster from all the clusters set to design for the chosen Primary CDR and then choosing a structure within that cluster.

- **Even Length and Cluster Monte Carlo** 
 - `-design_protocol even_length_cluster_mc`
 - Evenly sample lengths and clusters during the GraftDesign stage by first choosing a length from the set of lengths for the chosen Primary CDR and the a cluster from the set of clusters, and then finally a structure within that cluster.  Useful to broaden set of lengths sampled during the protocol.

- **Generalized Monte Carlo** 
 - `-design_protocol gen_mc`
 - Sample CDRs to GraftDesign according to their distribution in the database.  This results in common clusters and lengths being sampled more frequently.  However, these lengths/clusters may not be those regularly seen in nature vs regularly crystalized.  AKA - they are biased towards crystals, however, they have more profile data associated with them.


- **Deterministic Graft**
 - `-design_protocol deterministic_graft`
 - Deterministic Graft is meant to try every CDR combination from the CDRSet (the set of clusters and structures).  The outer loop is done deterministically for each CDR in a set.  It is very useful for trying small numbers of combinations - such as all loop lengths >=12 for H2 or all CDRs of a particular cluster.  Note that there is no outer monte carlo, so the final designs are the best found by the protocol, and each sampling is independent from the others. If you have too many structures in your CDRSet (such as all L1) and you try combos that are beyond a certain limit (AKA - they will never finish), you will error out.  Once a Multi-Threaded Rosetta is working (should be early 2018), trying all possibilities is certainly something that is more plausible.  If you are interested in using something like this, please email the author.

# Structure Optimization Types (mintypes)
These Mintypes can be independently set for each CDR through the instruction file or generally set using the command line option `-mintype` option.  The default is `min` as this has some optimization and does not take a very long time.  Although we refer to 'design' we mean side-chain packing, with any residues/CDRs set to design as designing, any residues set to design will design during packing as this is how Rosetta designs sequences.  For further information on the algorithm and strategies used for sequence design, please see the instruction file overview and the methods section of the paper. 

Circular Harmonic Dihedral Constraints are added to each CDR according the cluster of the CDR or the starting dihedrals if this is a rare cluster that has no data.  These ensure that minimization and design does not destroy the loop.

- **Min (DEFAULT)** 
 - `-mintype min`
 - Cycle of design->min->design->min
 - Results in good structures, however not as good as relax in recovering native physical characteristics.  Significantly faster.

- **Cartesian Min** 
 - `-mintype cartmin`
 - Cycle of design->min->design->min
 - Cartesian Space.
 - Automatically adds cart_bonded term if not present and turns off pro_close

- **Relax** 
 - `-mintype relax`
 - Flexible Backbone design using `RelaxedDesign`, which is neighbor-aware design during FastRelax where the packing shell to the designing CDRs is updated at every packing iteration. 
 - Results in lower energies and closer physical characteristics to native, but takes significantly longer.  It is recommended to first run min and then relax mintype on the top resulting models.
 - [(Citation)](https://www.ncbi.nlm.nih.gov/pubmed/21073878)

- **Dualspace Relax** 
 - `-mintype dualspace_relax`
 - Flexible Backbone design using 'RelaxedDesign' while optimizing both Dihedral and Cartesian space.  [Dualspace Relax Protocol Paper](https://www.ncbi.nlm.nih.gov/pubmed/24265211)

- **Backrub** 
 - `-mintype backrub`
 - Use backrub to optimize the CDRs.  backrub->design
 - Use the `-add_backrub_pivots 11A 12A 12A:B ` option to add additional sets of back rub pivots, such as to add flexibility to the antigen interface 
 - Flexibility is extremely minimal, but in some cases may be useful. 
 - [(Original Backrub Citation)](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1000393)

#RosettaScripts and PyRosetta

The Full protocol that is the application is available to RosettaScripts as the [[AntibodyDesignProtocol]].  This just has a few extra options before and after design such as running fast relax and or snug dock. 

The Configurable main Mover is available as the [[AntibodyDesignMover]].

[[Individual components | Movers-RosettaScripts#antibody-modeling-and-design-movers]] of RAbD can be used to create your own custom antibody modeling and design protocols in RosettaScripts (or PyRosetta). 

# Command-line Options

**General Options**

Option | Description
------------ | -------------
`-view`| _Enable viewing of the antibody design run. Must have built using extras=graphics and run with antibody_designer.graphics executable_ (**Default=False**)	
`-cdr_instructions` | _Path to CDR Instruction File_
`-antibody_database` | _Path to the current Antibody Database, updated weekly.  Download from http://dunbrack2.fccc.edu/PyIgClassify/ _ (**Default=/sampling/antibodies/antibody_database_rosetta_design.db**)			
`-paper_ab_db` | _Force the use the Antibody Database with data from the North clustering paper.  This is included in Rosetta. If a newer antibody database is not found, we will use this. The full ab db is available at [Through PyIgClassify](http://dunbrack2.fccc.edu/PyIgClassify/)_ (**Default = false**)

---------------------------------------------


**Basic settings for an easy-to-setup run**

Option | Description
------------ | -------------
`-seq_design_cdrs`| _Enable these CDRs for Sequence-Design.  (Can be set here or in the instructions file. Overrides any set in instructions file if given ) Ex -seq_design_cdrs L1 L2 L3 h1_
`-graft_design_cdrs` | _Enable these CDRs for Graft-Design.  (Can be set here or in the instructions file. Overrides any set in instructions file if given) Ex -graft_design_cdrs L1 L2 L3 h1_		
`-primary_cdrs` | _Manually set the CDRs which can be chosen in the outer cycle. Normally, we pick any that are sequence-designing._		
`-mintype`| _The default mintype for all CDRs.  Individual CDRs may be set via the instructions file_ (_Options = min, cartmin, relax, backrub, pack, dualspace_relax, cen_relax, none_) (**Default=min**)
`-disallow_aa` | _Disallow certain amino acids while sequence-designing (could still be in the graft-designed sequence, however).  Useful for optimizing without, for example, cysteines and prolines. Applies to all sequence design profiles and residues from any region (cdrs, framework, antigen).  You can control this per-cdr (or only for the CDRs) through the CDR-instruction file. A resfile is also accepted if you wish to limit specific positions directly._ (Three or One letter codes)
`-top_designs`| _Number of top designs to keep (ensemble).  These will be written to a PDB and each move onto the next step in the protocol_. (**Default=1**)
`-do_dock` | Run a short lowres + highres docking step in the inner cycles.  (dock/min).  Recommended 2 inner cycles for better coverage. (dock/min/dock/min). Inner/Outer loops for highres are hard coded, while low-res can be changed through regular low_res options.  If sequence design is enabled, will design regions/CDRs set during the high-res dock (**Default=false**)


-------------------------------------

**Protocol Rounds**

Option | Description
------------ | -------------
`outer_cycle_rounds` | Rounds for outer loop of the protocol (not for deterministic_graft ).  Each round chooses a CDR and designs. One run of 100 cycles with relax takes about 12 hours. If you decrease this number, you will decrease your run time significantly, but your final decoys will be higher energy.  Make sure to increase the total number of output structures (nstruct) if you use lower than this number.  Typically about 500 - 1000 nstruct is more than sufficient.  Full DeNovo design will require significantly more rounds and nstruct.  If you are docking, runs take about 30 percent longer. (**Default=25**)
`-inner_cycle_rounds` | Number of times to run the inner minimization protocol after each graft.  Higher (2-3) rounds recommended for pack/min/backrub mintypes or if including dock in the protocol. (**Default = 1**)
`-dock_cycle_rounds` | Number of rounds for any docking.  If you are seeing badly docked structures, increase this value. (**Default=1**)

----------------------------

**Distance Detection**

Option | Description
------------ | -------------
`-interface_dis` | Interface distance cutoff.  Used for repacking of interface, epitope detection, etc. (**Default=8.0**)
`-neighbor_dis` | Neighbor distance cutoff.  Used for repacking after graft, minimization, etc. (**Default=6.0**)


---------------------------


**Paratope + Epitope**


Option | Description
------------ | -------------
`-paratope` | Use these CDRs as the paratope. Default is all of them.  Currently only used for SiteConstraints. Note that these site constraints are only scored docking unless _-enable_full_protocol_atom_pair_cst_ is set (Ex -paratope L1 h1)
`-epitope` | Use these residues as the antigen epitope.  Default is to auto-identify them within the set interface distance at protocol start if epitope constraints are enabled. Currently only used for constraints.  PDB Numbering. Optional insertion code. Example: 1A 1B 1B:A. Note that these site constraints are only used during docking unless -enable_full_protocol_atom_pair_cst is set.
`-use_epitope_constraints` | Enable use of epitope constraints to add SiteConstraints between the epitope and paratope.  Note that paratope constraints are always used.  Note that these site constraints are only used during docking unless -global_atom_pair_cst_scoring is set.(**Default = false**)

------------------------------


**Regional Sequence Design**

Option | Description
------------ | -------------
`-design_antigen` | Design antigen residues during sequence design.  Intelligently.  Typically, only the neighbor antigen residues of designing cdrs or interfaces will be co-designed.  Useful for specific applications.(**Default = false**)
`-design_framework` | Design framework residues during sequence design.  Typically done with only neighbor residues of designing CDRs or during interface minimization. (**Default = false**)
`-conservative_framework_design` | 'If designing Framework positions, use conservative mutations instead of all of them.'(**Default=true**)


---------------------------


**Seq Design Control**

Option | Description
------------ | -------------
`-resfile` | Use a resfile to further limit which residues are packed/designed, and can further limit residue types for design.
`-design_H3_stem` | Enable design of the first 2 and last 3 residues of the H3 loop if sequence designing H3.  These residues play a role in the extended vs kinked H3 conformation.  Designing these residues may negatively effect the overall H3 structure by potentially switching a kinked loop to an extended and vice versa.  Rosetta may get it right.  But it is off by default to err on the cautious side of design. Sequence designing H3 may be already risky. (**Default=false**)
`-design_proline` | Enable proline design.  Profiles for proline are very good, but designing them is a bit risky.  Enable this if you are feeling daring. (**Default=false**)
`-sample_zero_probs_at` | Value for probabilstic design.  Probability that a normally zero prob will be chosen as a potential residue each time packer task is called.  Increase to increase variablility of positions. (**Default=0**)

------------------------------

**Profile Stats**

Option | Description
------------ | -------------
`-seq_design_stats_cutoff` | Value for probabilistic -> conservative sequence design switch.  If number of total sequences used for probabilistic design for a particular cdr cluster being designed is less than this value, conservative design will occur. More data = better predictability. (**Default=10**)
`-seq_design_profile_samples` | If designing using profiles, this is the number of times the profile is sampled each time packing done.  Increase this number to increase variability of designs - especially if not using relax as the mintype. (**Default=1**)


---------------------------


**Constraint Control**

Option | Description
------------ | -------------
`-dihedral_cst_weight` | Weight to use for CDR CircularHarmonic cluster-based or general constraints that are automatically added to each structure and updated after each graft. Set to zero if you dont want to use these constraints. Note that they are not used for the backrub mintype. Overrides weight/patch settings.(**Default = .3**)
`-atom_pair_cst_weight` | Weight to use for Epitope/Paratope SiteConstraints.  Paratope Side contraints are always used.  Set to zero to completely abbrogate these constraints. Overrides weight/patch settings.'Real' (**Default = 0.01**)
`-global_dihedral_cst_scoring` | Use the dihedral cst score throughout the protocol, including final scoring of the poses instead of just during minimization step (**Default = false**)
`-global_atom_pair_cst_scoring` | Use the atom pair cst score throughout the protocol, including final scoring of the poses instead of just during docking. Typically, the scoreterm is set to zero for scorefxns other than docking to decrease bias via loop lengths, relax, etc.  It may indeed help to target a particular epitope quicker during monte carlo design if epitope constraints are in use, as well for filtering final models on score towards a particular epitope if docking. (**Default = true**)

------------------------------------


**Fine Control**

Option | Description
------------ | -------------  			
`-idealize_graft_cdrs` | Idealize the CDR before grafting.  May help or hinder. (**Default = false**)
`-add_backrub_pivots` | 'Additional backrub pivot residues if running backrub as the MinType. PDB Numbering. Optional insertion code. Example: 1A 1B 1B:A.  Can also specify ranges: 1A-10:A.  Note no spaces in the range.
`-inner_kt` | KT used in the inner min monte carlo after each graft. (**default = 1.0)**,
`-outer_kt` | KT used for the outer graft Monte Carlo.  Each graft step will use this value (**Default = 1.0**),

------------------------------


**Outlier Control**

Option | Description
------------ | -------------
`-use_outliers` | Include outlier data for GraftDesign, profile-based sequence design stats, and cluster-based dihedral constraints.  Outliers are defined as having a dihedral distance of > 40 degrees and an RMSD of >1.5 A to the cluster center.  Use to increase sampling of small or rare clusters. (**Default=false**)
`-use_H3_graft_outliers` | Include outliers when grafting H3.  H3 does not cluster well, so most structures have high dihedral distance and RMSD to the cluster center.  Due to this, cluster-based dihedral constraints for H3 are not used.  Sequence profiles can be used for clusters, but not usually. (**Default = true**)
`-use_only_H3_kinked` | Remove any non-kinked CDRs from the CDRSet if grafting H3.  For now, the match is based on the ramachandran area of the last two residues of the H3. Kinked in this case is defined as having AB or DB regions at the end.  Will be improved for detection (**Default = false**)

-----------------------------------

**Protocol Steps**

Option | Description
------------ | -------------
`-design_protocol` | Set the main protocol to use.  Note that deterministic is currently only available for the grafting of one CDR. (_Options = gen_mc, even_cluster_mc, even_length_cluster_mc, deterministic_graft_)(**Default=even_cluster_mc**)
`-run_snugdock` | Run snugdock on each ensemble after designing. (**Default=false**)
`-run_relax` | Run Dualspace Relax on each ensemble after designing (after snugdock if run). Also output pre-relaxed structures (**Default = false**)
`-run_interface_analyzer`| Run the Interface Analyzer and add the information to the resulting score function for each top design output. (**Default = true**)

--------------------------------------

**Memory management / CDRSet caching**

Option | Description
------------ | -------------
`-high_mem_mode` | If false, we load the CDRSet (CDRs loaded from the database that could be grafted) on-the-fly for a CDR if it has more than 50 graft-design members.  If true, then we cache the CDRSet before the start of the protocol.  Typically, this will really only to come into play when designing all CDRs.  For de-novo design of 5/6 CDRs, without limiting the CDRSet in the instructions file, you will need 3-4 gb per process for this option. (**default = false**)
`-cdr_set_cache_limit` | If high_mem_mode is false, this is the limit of CDRSet cacheing we do before we begin load them on-the-fly instead.  If high_mem_mode is true, then we ignore this setting.  If you have extremely low memory per-process, lower this number (**default = 300**)


---------------------------------


**Benchmarking**

Option | Description
------------ | -------------
`-random_start` | Start graft design (currently) with a new set of CDRs from the CDRSets as to not bias the run with native CDRs. (**Default=false**)
`-remove_antigen` | Remove the antigen from the pose before doing any design on it (**Default = false**)
`add_graft_log_to_pdb` | Add the full graft log to the output pose.  Must also pass -pdb_comments option. (**Default = 'true'**)




#See Also

* [[Rosetta Antibody Design (RAbD) Manual | RosettaAntibodyDesign]]
* [[General Antibody Tips | General-Antibody-Options-and-Tips]]
* [[AntibodyDesignProtocol]]
* [[AntibodyDesignMover]]
* [[Antibody Movers | Movers-RosettaScripts#antibody-modeling-and-design-movers]]
* [[Antibody TaskOperations | TaskOperations-RosettaScripts#antibody-and-cdr-specific-operations]]
* [[I want to do x]]: Guide to choosing a mover