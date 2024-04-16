#Supercharge - redesigning protein surfaces with high net charge

Metadata
========

Author: Bryan Der, contact Brian Kuhlman bkuhlman [at] email.unc.edu

Jan. 2013 by Bryan Der (bder [at] email.unc.edu), Kuhlman lab (bkuhlman [at] email.unc.edu)

Code and Demo
=============

- The code lives in a single file, `src/apps/public/design/supercharge.cc`   
- Integration test: `ain/tests/integration/tests/supercharge`  
- Demo: `demos/public/supercharge`  

Production runs are still quick and light, it just requires packrotamers for surface positions, and we recommend running the protocol several times using a variety of target net charges. Experimentally, it's hard to say what the optimal net charge will be, so a spectrum of net charges should be tested at the bench.

References
==========

* AvNAPSA-mode: Lawrence MS, Phillips KJ, Liu DR. Supercharging proteins can impart unusual resilience. J Am Chem Soc. 2007 Aug 22;129(33):10110-2. 
* Rosetta-mode: Der BS, Kluwe C, Miklos AE, Jacak R, Lyskov S, Gray JJ, Georgiou G, Ellington AD, Kuhlman B. Alternative computational protocols for supercharging protein surfaces for reversible unfolding and retention of stability. PLoS One. 2013 May 31;8(5):e64363.

Purpose
===========================================

Reengineering protein surfaces to have high net charge, called supercharging, can improve reversibility of unfolding by preventing aggregation of partially unfolded states. Aggregation is a common obstacle for use of proteins in biotechnology and medicine. Net charge, rather than number of charged residues, is often an indicator of aggregation propensity. Additionally, highly cationic proteins and peptides are capable of nonviral cell entry, and highly anionic proteins are filtered by kidneys more slowly than neutral or cationic proteins.

Optimal positions for incorporation of charged side chains should be determined, as numerous mutations and accumulation of like-charges can also destabilize the native state. A previously demonstrated approach deterministically mutates flexible polar residues (amino acids DERKNQ) with the fewest average neighboring atoms per side chain atom. Our approach uses Rosetta-based energy calculations to choose the surface mutations. Both automated approaches for supercharging are implemented in this protocol.

Algorithm
=========

Simply put, user options govern the definition of surface residues and the packer task, then PackRotamersMover is used to redesign the surface.

In detail, the supercharge server can run in four different modes:
- AvNAPSA with a target net charge
- AvNAPSA with a surface cutoff
- Rosetta with a target net charge
- Rosetta with a surface cutoff

This is the workflow of each mode: 

**AvNAPSA-mode, target charge**

1.  Define surface. sort NQ and RK/DE residues by AvNAPSA value (low to high)
2.  Next residue in sorted list: Positive: mutate DENQ–\>K, Negative: mutate RKQ–\>E and N–\>D
3.  If net charge = target net charge, output pdb

**AvNAPSA-mode, surface cutoff**

1.  Define surface by AvNAPSA value (\<100 default)
2.  For each NQ and DE/RK residue in the surface: Positive: mutate DENQ--\>K, Negative: mutate RKQ–\>E and N–\>D
3.  Output pdb

**Rosetta-mode, surface cutoff and target charge**

1.  Define surface. Neighbor by distance calculator (CB dist.), \<16 neighbors default or Define surface by AvNAPSA value (\<100 default)
2.  Set design task 
    * read user resfile, if provided 
    * dont\_mutate gly, pro, cys 
    * dont\_mutate h-bonded sidechains 
    * dont\_mutate correct charge residues
3.  Set reference energies for RK/DE, starting at user input values
4.  pack rotamers mover
5.  check net charge, increment/decrement reference energies (back to step 3.)
6.  Once a pack rotamers run results in the correct net charge, output pdb

**Rosetta-mode, surface cutoff and input reference energies for the desired charged residue types (Arg/Lys for positive-supercharging, Asp/Glu for negative-supercharging)**

1.  Define surface. Neighbor by distance calculator (CB dist.), \<16 neighbors default or Define surface by AvNAPSA value (\<100 default)
2.  Set design task 
    * read user resfile, if provided 
    * dont\_mutate gly, pro, cys 
    * dont\_mutate h-bonded sidechains 
    * dont\_mutate correct charge residues
3.  Set reference energies for RK/DE, using the user input values
4.  pack rotamers mover
5.  Output pdb

Limitations
===========

This code does NOT predict the net charge that will be sufficient to prevent aggregation and promote refolding, or to mediate nonviral cell entry of cationic proteins. The protocol should be run numerous times to achieve a spectrum of net charges, and several variants should be tested at the bench.

Modes
=====

Two modes are implemented, these are refered to AvNAPSA supercharge (Asc) and Rosetta supercharge (Rsc). AvNAPSA supercharge philosophy (Asc): mutate the most exposed polar residues to minimize structural change or destabilization. Only DE-RK-NQ residues can be mutated. Rosetta supercharge philosophy (Rsc): mutate residue positions that preserve and/or add favorable surface interactions. Hydrophobic and small polar surface residues can also be mutated.

AvNAPSA drawbacks: mutating surface polar residues can eliminate hydrogen bonds. Helix capping, edge-strand interaction, and loop stabilization all result from surface hydrogen bonds. Furthermore, this automated protocol mutates N to D and Q to E, but N and Q sometimes act simultaneously as a donor and acceptor for hydrogen bonds.

Rosetta drawbacks: mutating less-exposed positions can lead to better computed energies, but mistakes at these positions can be destabilizing. AvNAPSA favors charge swaps, so Rosetta requires more mutations to accomplish the same net charge.

The AvNAPSA approach varies net charge by adjusting the surface cutoff. The Rosetta approach varies net charge by adjusting reference energies of the positive or negatively charged residues.

Input Files
===========

-   The only required input file is the PDB to be redesigned. If homology models, NMR ensembles, or relaxed crystal structures are the starting structure, -l can be used.
-   Optionally, the user can use a resfile to specify residue positions to NOT mutate (NATAA or NATRO). This would be useful to preserve a known binding surface, for example. The default for the input resfile should be ALLAA and the supercharge protocol restricts the allowed residues at designable positions. For example, Gly, Pro, Cys residues and hbonded sidechains are not allowed to mutate by default.

If there are any special input file types, describe them here.

-   No special input file types.

Options
=======

Options, AvNAPSA and Rosetta modes:
-------------------

target\_net\_charge\_active BOOL def(false); // supercharge will mutate the surface to achieve the target net charge value (below). Boolean control for ROSIE implementation (instead of .user() ) 

target\_net\_charge SIGNED\_INT def(0); //AvNAPSA: Residue positions are mutated one at a time from most exposed to least exposed until the target net charge is achieved. Rosetta: reference energies of Arg/Lys/Asp/Glu are incremented until PackRotamers gives the target net charge.

surface\_atom\_cutoff UNSIGNED\_INT def(100); // this is how AvNAPSA defines surface, can be used in either approach

compare\_residue\_energies\_all BOOL def(false); //prints a full residue-by-residue energy analysis in the log file 

compare\_residue\_energies\_mut BOOL def(true); //only includes mutated residues in the energy analysis

resfile FILE; this is how you can specify which residues to not mutate. Default setting must be ALLAA, and residue-by-residue settings should be NATAA, as shown below:

```
ALLAA
start
  20  A  NATAA
  24  A  NATAA
  26  A  NATAA
```

if the default were NATRO, for example, no design would occur!

Options, AvNAPSA mode:
-------------------

AvNAPSA\_positive BOOL def(false); //run positive-charge AvNAPSA

AvNAPSA\_negative BOOL def(false); //run negative-charge AvNAPSA

surface\_atom\_cutoff UNSIGNED\_INT def(100); // this is how AvNAPSA defines surface, can be used in either AvNAPSA or Rosetta modes. \<100 is good for light supercharging, \<150 is good for heavy supercharging. Rosetta typically defines surface according to number of residue neighbors (\<16 default). The atom-based and residue-based surface definitions correlate with an R-squared of 0.85, so they are moderately similar.

Options, Rosetta mode:
-------------------

surface\_residue\_cutoff UNSIGNED\_INT def(16); //residues with \<16 neighboring residues within 10 Å are considered part of the surface

include\_arg BOOL def(false); //use arginine in Rosetta supercharge 

include\_lys BOOL def(false); //use lysine in Rosetta supercharge 

include\_asp BOOL def(false); //use aspartate in Rosetta supercharge 

include\_glu BOOL def(false); //use glutamate in Rosetta supercharge

the reference energies of the charged residue types will govern the net charge of Rosetta designs. Rosetta can choose between the allowed charged residue types and the native residue. More negative reference energies will result in more charge mutations. The user can increment reference energy values to vary the resulting net charge. For positive-charging, refweight\_asp and refweight\_glu values will be ignored. For negative-charging, refweight\_lys and refweight\_arg values will be ignored. 

refweight\_arg FLOAT def(-0.98); 

refweight\_lys FLOAT def(-0.65); 

refweight\_asp FLOAT def(-0.67); 

refweight\_glu FLOAT def(-0.81);

dont\_mutate\_glyprocys BOOL def(true); //glycine, proline, and cysteine often serve special structural roles in proteins, these are not mutated by default.

dont\_mutate\_correct\_charge BOOL def(true); //i.e., Don’t mutate arginine to lysine. Don't mutate aspartate to glutamate.

dont\_mutate\_hbonded\_sidechains BOOL def(true); //don’t mutate residues with sidechains forming a hydrogen bond

pre\_packminpack BOOL def(false); //Packrotamers is always done as the first step. This option will go one step further and run packrotamers, sidechain+backbone minimization, packrotamers on the input structure before performing the supercharge design step.

nstruct UNSIGNED\_INT def(1); //Monte Carlo sequence design of a protein surface is often convergent but it is still stochastic, multiple design runs can be performed if desired.

Tips
====

ex1 and ex2 are not very important since this protocol only redesigns the surface. For homology model ensembles or NMR ensembles, we recommend supercharging all the input structures and choosing consensus mutations. For supercharging a single crystal structure, or ensembles, we recommend generating designs with a spectrum of net charges. Since repacking the surface converges on similar sequences, we do not recommend using nstruct \> 10 (actually, nstruct is not used for AvNAPSA-mode because the sequence is deterministic). When positive-supercharging, you can bias the choice of Arg vs. Lys by giving different reference energies for the two residues. Likewise for negative-supercharging. The protocol dumps output PDBs with customized self-documenting names, so I use jd2:no\_output.

Expected Outputs
================

Output 1: PDB

Output 2: resfile. This is an output resfile (rather than input) so the user can see what the design task looked like.

Output 3: log. The output includes net charge, number of mutations, what the mutations are, pymol selection for convenient viewing of mutated residues, and a residue-by-residue energy comparison of the designed vs. starting structures.

Here are some of the lines you'll find in the log file:

```
apps.public.supercharge: residue: 194  heavy: 8  sidechain: 5  AvNAPSA_value: 109
apps.public.supercharge: residue: 200  heavy: 9  sidechain: 5  AvNAPSA_value: 96
apps.public.supercharge: residue: 205  heavy: 9  sidechain: 5  AvNAPSA_value: 101
apps.public.supercharge: residue 206 is already negative
apps.public.supercharge: residue: 208  heavy: 8  sidechain: 5  AvNAPSA_value: 50
apps.public.supercharge: residue 209 is already negative
apps.public.supercharge: residue: 210  heavy: 9  sidechain: 5  AvNAPSA_value: 46
apps.public.supercharge: residue: 211  heavy: 11  sidechain: 5  AvNAPSA_value: 97

apps.public.supercharge: Starting net charge is -5 and AvNAPSA_target_net_charge is -25
apps.public.supercharge: Mutate 210
apps.public.supercharge: Mutate 208
apps.public.supercharge: Mutate 152
apps.public.supercharge: Mutate 153
apps.public.supercharge: Mutate 25
apps.public.supercharge: Mutate 51
apps.public.supercharge: Mutate 38
apps.public.supercharge: Mutate 97
apps.public.supercharge: Mutate 127
apps.public.supercharge: Mutate 164
apps.public.supercharge: Mutate 200
apps.public.supercharge: Mutate 103
apps.public.supercharge: PYMOL_SELECT AVNAPSA residues: 210+208+152+153+25+51+38+97+127+164+200+103+

apps.public.supercharge: NEW NAME FOR SUPERCHARGED OUTPUT: 2B3P_A_min_AvNAPSA_neg_96_-25.pdb
apps.public.supercharge: 2B3P_A_min_AvNAPSA_neg_96_-25.pdb  R=7, K=12, D=19, E=25
apps.public.supercharge: 2B3P_A_min_AvNAPSA_neg_96_-25.pdb  Net Charge = -25
apps.public.supercharge: 2B3P_A_min_AvNAPSA_neg_96_-25.pdb  Mutations: K26E, N39D, K52E, K101E, K107E, K131E, K156E, Q157E, R168E, Q204E, N212D, K214E,
apps.public.supercharge: 2B3P_A_min_AvNAPSA_neg_96_-25.pdb  # of mutations: 12
apps.public.supercharge: 2B3P_A_min_AvNAPSA_neg_96_-25.pdb  select 26+39+52+101+107+131+156+157+168+204+212+214+

apps.public.supercharge: pdbname residue total fa_atr fa_rep fa_sol fa_intra_rep pro_close fa_pair hbond_sr_bb hbond_lr_bb hbond_bb_sc hbond_sc dslf_ss_dst dslf_cs_ang dslf_ss_dih dslf_ca_dih rama omega fa_dun p_aa_pp ref
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 10 0.3644 0.2911 -0.3058 0.3239 -1.4283 0.0000 -1.0593 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.7930 0.0000 2.3999 1.0869 -1.2700
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 20 0.8852 0.6912 0.0107 -1.7965 0.7626 0.0000 0.4028 0.0000 0.0000 0.0300 0.0000 0.0000 0.0000 0.0000 0.0000 0.6864 0.0000 2.5038 0.0948 -0.3100
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 24 -0.1093 0.0870 0.0103 0.5427 1.0906 0.0000 -0.0248 0.0000 0.0000 -0.0654 0.0000 0.0000 0.0000 0.0000 0.0000 0.4718 0.0000 1.3747 0.6997 -1.5400
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 37 -0.0362 0.0129 0.0006 -0.2910 -1.0171 0.0000 0.2086 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 -0.8536 0.0000 1.3987 -0.5885 -0.3800
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 42 0.2719 -0.2894 0.0031 0.0901 1.0044 0.0000 -0.4531 0.0000 0.0000 0.0000 -0.1038 0.0000 0.0000 0.0000 0.0000 -0.6141 0.0000 2.9814 -0.1912 -0.7100
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 72 0.3975 0.2649 -0.0007 -0.5445 0.0098 0.0000 0.3601 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 -0.4753 0.0000 0.9331 -0.2628 0.0200
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 91 0.0917 -0.2226 0.1196 -0.0862 -0.5008 0.0000 0.4634 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 -0.2621 0.0000 -0.1621 0.0978 0.1600
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 93 0.5335 -0.0054 -0.0032 0.0969 -0.4706 0.0000 -0.3847 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.1144 0.0000 1.4960 0.5811 -0.3800
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 98 0.0845 0.1706 0.1538 -0.7029 0.2191 0.0000 0.4510 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.1411 0.0000 -0.0224 0.2489 0.0200
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 101 0.6787 0.1133 0.0206 -0.1614 -0.1529 0.0000 -0.3488 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 -0.2019 0.0000 2.6725 0.3413 -0.7100
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 113 0.1539 0.5641 -0.0004 -0.9042 -1.4567 0.0000 0.1523 0.0000 0.0000 0.0000 0.0339 0.0000 0.0000 0.0000 0.0000 0.2621 0.0000 -0.0121 0.3713 0.0200
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 120 0.0583 -0.0026 0.0007 -0.0908 -0.4659 0.0000 0.1072 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 -0.0543 0.0000 -0.1800 0.0626 0.1600
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 124 -0.0384 1.2197 0.0144 -1.0732 -3.5904 0.0000 -0.1986 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0013 0.0000 1.0539 0.2759 -0.8900
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 125 0.0951 0.5035 0.0444 -0.7311 0.0725 0.0000 0.0653 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.1499 0.0000 -0.0306 0.2590 0.0200
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 128 0.0433 -0.0009 0.0004 0.0062 -0.3876 0.0000 0.0020 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 -0.0305 0.0000 -0.0963 -0.1860 0.1600
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 138 0.1440 0.4522 -0.0416 -0.9915 0.6102 0.0000 0.1466 0.0000 0.0000 0.0000 0.0668 0.0000 0.0000 0.0000 0.0000 -0.0257 0.0000 0.8851 -0.0726 -0.1700
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 145 -0.3478 0.0592 -0.0288 -0.9271 0.0888 0.0000 0.1110 0.0000 0.0000 0.0000 0.0067 0.0000 0.0000 0.0000 0.0000 -0.6491 0.0000 0.4166 -0.5798 0.2400
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 149 0.1701 -0.2459 -0.0052 -0.0518 -1.1845 0.0000 -0.1135 0.0000 0.0000 0.0633 0.0000 0.0000 0.0000 0.0000 0.0000 0.5776 0.0000 0.7759 0.6844 -0.3800
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 153 -0.2247 -0.2613 0.0002 -0.1377 0.0400 0.0000 0.1629 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 -0.4850 0.0000 -0.3687 -0.0711 0.3200
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 155 0.5406 0.3019 0.1436 -0.6233 0.0553 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 1.0035 0.0000 -0.4034 1.3313 0.2400
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 160 -0.0473 0.3212 0.0081 -0.6022 0.0747 0.0000 -0.0138 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 -0.7511 0.0000 0.3574 -0.6246 0.2400
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 168 -0.3021 0.0274 0.0131 -0.6476 -0.5254 0.0000 0.1083 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.2500 0.0000 -0.4034 0.1755 0.1600
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 176 0.8351 1.8314 -0.3253 -2.2487 -1.4861 0.0000 0.2085 0.0000 0.0000 0.0000 0.0336 0.0000 0.0000 0.0000 0.0000 0.7663 0.0000 0.6481 0.9543 0.0200
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 178 -0.3683 2.0373 -0.3322 -1.8179 -4.8053 0.0000 -0.6891 0.0000 0.0000 0.0000 0.0336 0.0000 0.0000 0.0000 0.0000 0.4646 0.0000 0.9837 0.5180 -1.1600
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 186 0.5944 0.0793 0.0447 -0.1092 -0.1395 0.0000 0.1015 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 -0.1487 0.0000 0.9292 0.0703 0.0200
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 189 -0.1863 0.3694 -0.0074 -0.0359 -2.3352 0.0000 -0.2577 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 -0.7215 0.0000 1.3672 -0.0030 -0.9400
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 190 0.3781 0.3658 -0.0074 -0.0401 -1.1546 0.0000 -0.0018 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 -0.0511 0.0000 0.9868 0.3996 -0.5500
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 194 -0.5029 0.6575 -0.0044 -1.3504 -0.5447 0.0000 0.0584 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 -0.5862 0.0000 -0.3094 -0.3911 0.2400
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 200 0.2742 -0.2598 0.0424 0.3984 -0.3720 0.0000 0.1195 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 -0.1132 0.0000 -0.3244 0.0992 0.3200
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 202 0.8387 -0.4221 -0.0539 0.8043 -0.2201 0.0000 -0.0416 0.0000 0.0000 -0.2348 0.0000 0.0000 0.0000 0.0000 0.0000 1.0256 0.0000 2.8571 1.3696 -1.2700
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 204 0.7566 -0.4132 0.1792 -0.2779 2.0877 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.7133 0.0000 2.1510 1.3854 -0.6100
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 208 0.5157 0.3552 0.0041 -0.6123 -0.0296 0.0000 0.1402 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.6437 0.0000 -0.1138 0.7940 0.2400
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 226 0.7089 0.1036 0.0097 -0.2365 0.6538 0.0000 0.0037 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.9292 0.0000 1.5962 1.2544 -0.7100
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb 227 -0.7347 0.9993 -0.0509 -0.7053 -0.0501 0.0000 0.0871 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 0.0000 -0.0760 0.0000 0.2680 -0.0646 -1.2100
apps.public.supercharge: rosetta_inputs/2B3P_A_min.pdb SUM-DIFFS 6.5164 9.7559 -0.3433 -15.5347 -15.5481 0.0000 -0.1265 0.0000 0.0000 -0.2070 0.0709 0.0000 0.0000 0.0000 0.0000 2.8946 0.0000 28.6096 10.1198 -10.5900
apps.public.supercharge: pdbname residue total fa_atr fa_rep fa_sol fa_intra_rep pro_close fa_pair hbond_sr_bb hbond_lr_bb hbond_bb_sc hbond_sc dslf_ss_dst dslf_cs_ang dslf_ss_dih dslf_ca_dih rama omega fa_dun p_aa_pp ref
```


Post Processing
===============

Post-processing typically involves checking the change in energy of each mutated residue (in the log file), and viewing the mutated residue positions in pymol (pymol selection of mutated residues in the log file). Also, if designing an ensemble of NMR structures, post-processing should include determining which mutations were made in all or most of the input structures, in other words, determine a consensus sequence.

New things since last release
=============================

If you've made improvements, note them here.

Alternative approaches
======================

The net charge of a protein surface can also be controlled during the design process using the [[netcharge|NetChargeEnergy]] score term, which penalizes deviations from a desired net charge and guides the sequence design algorithms towards solutinos with the desired net charge.  Net charge constraints can be applied with the [[AddNetChargeConstraintMover]] to impose a desired net charge in a selected sub-region such as the surface of a protein.  This is a newer approach that has the advantage of efficiency: rather than producing many designs and only writing out those with the desired charge (the approach taken by the supercharge application), the ```netcharge``` score term guides all designs toward the desired net charge.

##See Also

* [[Design applications | design-applications]]: other design applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta
* [[NetChargeEnergy]]: Guide a traditional design run towards a desired net charge.
* [[AddNetChargeConstraintMover]]: Specify a desired net charge in a sub-region of a pose.
