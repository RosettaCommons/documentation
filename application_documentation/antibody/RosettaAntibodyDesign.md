#Rosetta Antibody Design Manual

Author: Jared Adolf-Bryfogle (jadolfbr@gmail.com)
PI: Roland Dunbrack

Last Doc Update: 2/6/2015

[[_TOC_]]

# Overview:
This app is a generalized framework for the design of antibodies using Rosetta.  It can be used from denovo design to redesigns that improve binding affinity, optimize stability, or manipulate function.  It is a knowledge-based framework, rooted very much on our recent clustering of antibody CDR regions.  It uses the North/Dunbrack CDR definition.  The  [PyIgClassify](http://dunbrack2.fccc.edu/PyIgClassify/) server and databases were created primarily for this application. 

# Setup:
This app requires the Rosetta Antibody Design Database.  A database of antibodies from the original paper is included in the paper.  A weekly updated database can be downloaded here: http://dunbrack2.fccc.edu/PyIgClassify/.  It should be placed in <code> Rosetta/main/database/sampling/antibodies/ </code>  The database contains renumbered CDR coordinates from the entire PDB and associated clusters, distances, sequence statistics, framework statistics, etc. that will be used throughout the protocol.

Designs should start with an antibody bound to a target antigen (however optimizing just the antibody without the complex is also possible).  Camelid antibodies are fully supported.  The antibody to start with can be a model of the framework required for a denovo design, or an antibody that is being affinity matured.  An antigen should also be included in the starting PDB file at a target epitope.  The program CAN computationally design an antibody to anywhere on the target protein, but a target epitope will increase the probability that the final design will work.  It is beyond the scope of this program to determine potential epitopes for binding, however servers and programs exist to predict these.  Site Constraints can be used to further limit the design.

# Algorithm:
The algorithm is meant to sample the diverse sequence, structure, and binding space of an antibody-antigen complex.  It can be tailored for a variety of design strategies and design projects.  Briefly, there consists of an outer and an inner optimization loop; each controlled by a separate monte carlo object.  Each outer cycle of the program chooses a CDR based on set weights.  That CDR can then be optimized by sampling a CDR structure from the given CDRSet (GraftDesign) and/or Sequence designed (SeqDesign), or simply structurally optimized.  The CDRSet, minimization types, and sequence design control is all done through the CDR Design Instruction file.  This file allows CDR-level control of the design process. 

Outer Cycle:
- Choose CDR
- Graft CDR from CDRSet if enabled
- Add CircularHarmonic Cluster-based Dihedral Constraints or general constraints for small clusters
- Add Paratope SiteConstraints
- Add Epitope-Paratope SiteConstraints if enabled.

Inner (Minimization) Cycle:
- Add Sequence design any time rotamers are repacked if enabled. CDRs, the framework, and the antigen may be designed.  See options for more.  
- Dock if enabled (short low-res/high-res dock).  Interface residues set to design will be designed. ( -do_dock )
- Optimize/sample the structure (CDRs currently) according to the instruction file.  Residues from neighboring regions are designed if enabled, essentially a neighbor residue shell is created with the CDR(s) being optimized according to the NEIGHBOR_MIN option in the instruction file, and any residues with a distance to those CDRs.  Any residues within regions set to design will design.  Design is accomplished through the use of Cluster-based Profiles or Conservative design.  The sequence design strategy can be controlled through the instructions file.  See the SequenceDesign section for more information on how these profiles are used during sequence optimization.
- Optimize the Rigid Body orientation of the antigen/antibody complex if enabled ( -do_rb_min ). 


## Protocols:
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

# Outliers and control of data cutoffs

#Options
## Basic Options: 

- Protocol Steps

- Protocol Rounds

- Paratope + Epitope

- Optimization Step

- Regional Sequence Design


## Advanced Options:

- Constraint Control

- Seq Design Control

- Distance Detection

- Outlier Control

- Profile Stats


## Expert Options

- Fine Control

- Benchmarking


# Design Strategies

# Tips:

# Post-analysis:
