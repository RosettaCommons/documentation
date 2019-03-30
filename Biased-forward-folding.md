# Biased forward folding

#MetaData

Author: Daniel-Adriano Silva (dadriano@gmail.com) and Enrique Marcos (emarcos82@gmail.com); PI: David Baker

Purpose
==========

Ab initio structure prediction provides a very stringent test of the compatibility between sequence and structure of de novo protein designs. Funnel-shaped energy landscapes where the designed structure is the global energy minima and has a substantial energy gap with respect to alternative conformations is usually considered as a good indicator of the quality of the design. It is, however, a computationally expensive technique and can only be run for a handful of designs. Instead, Biased forward folding simulations [1,2] allow to quickly identify those designs more likely to achieve near-native conformational sampling in standard ab initio folding simulations.  Folding simulations are biased towards the designed conformation by using a smaller subset (three) of fragments at each residue position and with the lowest RMSD (9- and 3-mers) to the designed structure. If near-native sampling cannot be reached under these favoring conditions it is very unlikely that this will occur in standard ab initio trajectories. Additionally, the use of a smaller number of fragments reduces the amount of conformational space to be explored and therefore the number of simulated trajectories and overall computational cost. Thousands of designs can be quickly screened in this way, and dedicate standard ab initio simulations to the characterization of the most promising designs.

Setting up the simulation
==========
Given a designed sequence-structure pair, fragments are first picked as usually done with Rosetta ab initio structure prediction. A python script then reads the generated 9- and 3-mer fragment files and identifies the desired number of 9-mers and 3-mers closest in C-alpha RMSD to the target structure. The three closest fragments are often used to substantially reduce the number of folding trajectories needed (in the range of 30-50) to assess whether the target structure is reachable by ab initio folding.

Input and output
==========
The quickest way to select the closest fragments in RMSD is to start with a fragment quality check of the designed structure, as usually done in de novo protein design to assess the local compatibility between the designed sequence and structure. This implies calculating, after fragment picking, the RMSD between the generated fragments and those in the designed structure (input.pdb): 

```
r_frag_quality.default.linuxgccrelease -in:file:native input.pdb -f  input.200.3mers -out:qual frag_qual3.dat
r_frag_quality.default.linuxgccrelease -in:file:native input.pdb -f  input.200.9mers -out:qual frag_qual9.dat
```

Then, the python script (lowrms_frag_topN.py, which can be downloaded from https://github.com/emarcos/biased_forward_folding/) reads the previously generated frag_qual.dat files containing the fragments RMSDs and generates new 9- and 3-mer fragment files with the ntop closest RMSD fragments. 

```
python lowrms_frags_topN.py -frag_qual frag_qual3.dat -ntop 3 -fullmer input.200.3mers -out input.3t200.3mers
python lowrms_frags_topN.py -frag_qual frag_qual9.dat -ntop 3 -fullmer input.200.9mers -out input.3t200.9mers
```

With the newly generated fragment files (input.3t200.3mers and input.3t200.9mers), a standard ab initio structure prediction simulation is run using a small number of trajectories (-nstruct between 30 and 50 is a convenient number):

```
minirosetta.default.linuxgccrelease  -ex1 1 -ex2aro 1 -abinitio::fastrelax 1 -relax::default_repeats 15 -abinitio::use_filters false -abinitio::increase_cycles 10  -frag3 input.3t200.3mers -frag9 input.3t200.9mers -abinitio::number_3mer_frags 1 -abinitio::number_9mer_frags 1  -abinitio::rsd_wt_loop 0.5 -abinitio::rsd_wt_helix 0.5 -abinitio::rg_reweight 0.5  -in:file:native input.pdb  -silent_gz 1 -out:file:silent fold_input.out -out:file:scorefile fold_input.sc -nstruct 30
```

References
==========
(1) [Enrique Marcos, Benjamin Basanta, Tamuka M. Chidyausiku, Yuefeng Tang, Gustav Oberdorfer, Gaohua Liu, G.V.T. Swapna, Rongjin Guan, Daniel-Adriano Silva, Jiayi Dou, Jose Henrique Pereira, Rong Xiao, Banumathi Sankaran, Peter H. Zwart, Gaetano T. Montelione, David Baker. "Principles for designing proteins with cavities formed by curved beta-sheets." Science 355, 6321 (2017): 201-206.](https://www.ncbi.nlm.nih.gov/pubmed/28082595)

(2) [Enrique Marcos, Daniel-Adriano Silva. "Essentials of de novo protein design: Methods and applications", Wiley Interdisciplinary Reviews Computational Molecular Sciences, e1374 (2018)](https://onlinelibrary.wiley.com/doi/abs/10.1002/wcms.1374)