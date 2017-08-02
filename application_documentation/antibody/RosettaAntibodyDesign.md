#Rosetta Antibody Design (RAbD) Manual

Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)
PI: Roland Dunbrack

Last Doc Update: 7/20/2017

[[_TOC_]]

# Overview
This app is a generalized framework for the design of antibodies using Rosetta.  It can be used for denovo design to redesigns that improve binding affinity, optimize stability, or manipulate function.  It is a knowledge-based framework, rooted very much on our recent clustering of antibody CDR regions.  It uses the North/Dunbrack CDR definition.  If you have a request for new functionality, please email me - I'm sure we can incorporate it. 

# Setup
This app requires the Rosetta Antibody Design Database.  A database of antibodies from the original North Clustering paper is included in Rosetta and is used as the default .  An updated database (which is currently updated monthly) can be downloaded here: http://dunbrack2.fccc.edu/PyIgClassify/.  

It should be placed in <code> Rosetta/main/database/sampling/antibodies/ </code>  It is recommended to use this up-to-date database.

Designs should start with an antibody bound to a target antigen (however optimizing just the antibody without the complex is also possible).  Camelid antibodies are fully supported.  The antibody to start with can be a model of the framework required for a denovo design, or an antibody that is being affinity matured.  An antigen should also be included in the starting PDB file at a target epitope.  The program CAN computationally design an antibody to anywhere on the target protein, but a target epitope will increase the probability that the final design will work.  It is beyond the scope of this program to determine potential epitopes for binding, however servers and programs exist to predict these.  Site Constraints can be used to further limit the design.

# Algorithm
The algorithm is meant to sample the diverse sequence, structure, and binding space of an antibody-antigen complex.  It can be tailored for a variety of design strategies and design projects.  The protocol begins with the three-dimensional structure of an antibody–antigen complex. This structure may be an experimental structure of an existing antibody in complex with its antigen, a predicted structure of an existing antibody docked computationally to its antigen, or even the best scoring result of low-resolution docking a large number of unrelated antibodies to a desired epitope on the structure of a target antigen as a prelude to de novo design. The variable domains of the input structure must first be renumbered according to the AHo numbering scheme77, which can be accomplished through the PyIgClassify server53. On input into the program, Rosetta assigns our CDR clusters using the same methodology as PyIgClassify. The RosettaAntibodyDesign protocol is then driven by a set of command-line options and a set of design instructions provided as an input file that controls which CDR(s) are designed and how. Details and example command lines and instruction files are provided below.

Broadly, the RAbD protocol consists of alternating outer and inner Monte Carlo cycles. Each outer cycle consists of randomly choosing a CDR (L1, L2, etc…) from those CDRs set to design, randomly choosing a cluster and then a structure from that cluster from the database according to the input instructions, and grafting that CDR’s structure, onto the antibody framework in place of the existing CDR (GraftDesign). The program then performs N rounds of the inner cycle, consisting of sequence design (SeqDesign), energy minimization, and optional docking. Each inner cycle structurally optimizes the backbone and repacks side chains of the CDR chosen in the outer cycle as well as optional neighbors in order to optimize interactions of the CDR with the antigen and other CDRs. Backbone dihedral angle constraints derived from the cluster data are applied to limit deleterious structural perturbations. Amino acid changes are typically sampled from profiles derived for each CDR cluster in PyIgClassify. Conservative amino acid substitutions (according to the BLOSUM62 substitution matrix) may be performed when too few sequences are available to produce a profile (e.g., for H3). After each inner cycle is completed, the new sequence and structure are accepted according to the Metropolis Monte Carlo criterion. After N rounds within the inner cycle, the program returns to the outer cycle, at which point the energy of the resulting design is compared to the previous design in the outer cycle. The new design is accepted or rejected according to the Monte Carlo criterion.

More detail on the algorithm can be found in the published paper. 

# Command-line Examples

## Basic
The command-line can be as simple as:

`antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 -graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda`

This makes the H3 loop the primary CDR chosen in the outer cycle, running graft-based design on H3, while simultaneously designing H1 and H2. 

Here, we want to do a denovo-run, starting with random CDRs grafted in instead of whatever we have in antibody to start with (only for the CDRs that are actually undergoing graft-design).  This is useful, as we start the design with very high energy and work our way down.

` antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 -graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -random_start`

## With Antibody-Antigen Rigid-Body optimization (docking)


Here, we don't care where the antibody binds to the antigen.  Just that it binds. The RAbD protocol always has at least Paratope SiteConstraints enabled to make sure any docking is contained to the paratope (like most good docking programs).

`antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 -graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -do_dock`

Allow Dock-Design, incorporating auto-generated SiteConstraints to keep the antibody around the starting interface residues.  These residues are determined by being within 6A to the CDR residues.  

`antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 -graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -do_dock -use_epitope_constraints`
Allow Dock-Design, as above, but specify the Epitope Residues and Paratope CDRs to guide design to have these interact.

`antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 -graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -do_dock -use_epitope_constraints -paratope_cdrs H3 -epitope 63A 63A:A 64`

Here, we want to do a denovo-run, creating an interface at the light-chain, starting with random CDRs grafted in instead of whatever we have in the antibody to start with (for the designing CDRs) .  

`antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs L1 L2 L3 -graft_design_cdrs L1 L2 L3 -seq_design_cdrs L1 L2 L3 -light_chain lambda -do_dock -use_epitope_constraints -paratope_cdrs L1 L2 L3 -epitope 63A 63A:A 64 -random_start`

## Advanced Settings

Here, we will disallow ANY sequence design into Proline residues and Cysteine residues, while giving a resfile to further LIMIT design and packing as specific positions. These can be given as 3 or 1 letter codes and mixed codes such as PRO and C are accepted. Note that the resfile does NOT turn any residues ON, it is simply used to optionally LIMIT design residue types and design and packing positions.

`antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 -graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -resfile my_resfile.resfile -dissallow_aa PRO CYS`

Here, we will change the mintype to relax.  This mintype enables Flexible-Backbone design.  Our default is to use min/pack cycles, but relax typically works better.  However, it also takes considerably more time!

`antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 -graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -resfile my_resfile.resfile -dissallow_aa PRO CYS -mintype relax`

Finally, we want to allow the framework residues AROUND the CDRs we will be designing and any interacting antigen residues to design as well here.  We will disable conservative framework design as we want something funky (this is not typically recommended and is used here to indicate what you CAN do.

`antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 -graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -resfile my_resfile.resfile -dissallow_aa PRO CYS -mintype relax -design_antigen -design_framework -conservative_framework_design false`

### Expert Settings

Now, we will spice things up even further.  We are feeling daring and we have LOTS of money for designs (I can dream, right! ;)

We will enable H3 Stem design here, which can cause a flipping of the H3 stem type from bulged to non-bulged and vice-versa.  

`antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 -graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -design_H3_stem `

Cool.  That should make some interesting antibodies for our experiment.  Now, we will change around the KT to get more interesting samplings (from our 1.0 default).

`antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 -graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -design_H3_stem -inner_KT 2.0 -outer_KT 2.0`

Finally, we want increased variability for our sequence designs.  So, we will increase number of sampling rounds for our lovely cluster profiles.  

Description of the option (default 1): "If designing using profiles, this is the number of times the profile is sampled each time packing done.  Increase this number to increase variability of designs - especially if not using relax as the mintype."

`antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 -graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -design_H3_stem -inner_KT 2.0 -outer_KT 2.0 -seq_design_profile_samples 5`

### Instruction File
More complicated design runs can be created by using the Antibody Design Instruction file.  This file allows complete customization of the design run. See below for a review of the syntax of the file and possible customization.

`antibody_designer.macosclangrelease -s my_ab.pdb -primary_cdrs H3 -graft_design_cdrs H3 -seq_design_cdrs H1 H2 -light_chain lambda -instruction_file my_instruction_file.txt`

# Antibody Design Instruction File:
The Antibody Design Instruction File handles CDR-level control of the algorithm and design.  It is used to create the CDRSet for sampling whole CDRs from the PDB, as well as fine-tuning the minimization steps and sequence design strategies.  For each option, 'ALL' can be given to control all of the CDRs at once.  Specific capitalization of commands are not needed, and are used for style. Commands are broken down into 4 types, each controlling different aspects of the protocol:

- GraftDesign
- SeqDesign
- CDRSet
- MinProtocol

##GraftDesign

##SeqDesign

##CDRSet

##MinProtocol


# Sequence Design:

# Constraints:
## Circular Harmonic Dihedral Constraints
## Paratope SiteConstraints
## Epitope SiteConstraints


#FULL Options

# Tips:

# Post-analysis:

## Protocols
There are two main protocols that are currently available.  These can be specified using the <code>-design_protocol</code> flag.


### Generalized Monte Carlo
<code>-design_protocol generalized_monte_carlo</code>

### Deterministic Graft
<code>-design_protocol deterministic_graft</code>
Deterministic Graft is meant to try every CDR combination from a CDRSet.  The outer loop is done deterministically for each CDR in a set.  It is very useful for trying small numbers of combinations - such as all loop lengths >=12 for H2 or all CDRs of a particular cluster.  Note that there is no outer monte carlo, so the final designs are the best found by the protocol, and each sampling is independent from the others. 

## Structure Optimization Types (mintypes)
These Mintypes can be independently set for each CDR through the instruction file.  Each takes a different amount of time to run and is meant to optimize the CDR interaction with antigen, as well as internal between other CDRs and the framework.  Each outer cycle will (currently) optimize the chosen CDR and any other CDRs set to min with the NEIGHBOR_MIN instruction file keyword.  Neighbor residues are always repacked.  Sequence design is done on any time rotamers are optimized.  It is recommended to set -inner_cycles to at least 2 or 3 if not running relax.  For relax and dualspace relax, design has been enabled during the full relax protocol. From our benchmarks, relax and dualspace relax give the best length and cluster recovery, however, they also take the most time to run.  

### Pack

### Min
- Pack->Min

### Cartesian Min
- Pack->Min

### Relax

### Dualspace Relax

### Backrub
- backrub->pack