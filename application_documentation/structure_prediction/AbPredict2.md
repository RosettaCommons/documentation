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

3. The next step is to create a list of all segments from the precomputed conformation database with the correct length with respect to the input sequence. The Different segment lengthד correspond to rules listed above.
4. To get all the relevant segments from the conformation database you can use this bash script:
`\<Rosetta_Directory\>/demos/tutorials/AbPredict/create_run.sh`

**To run:**
```
./create_run.sh <VL length> <L3 length> <HL length> <L3 length>
```
You should run in the script within the folder `\<Rosetta_Directory\>/demos/tutorials/AbPredict/`

5. The output file "segment_lengths_script_vars" should have 500 lines, with each line looking like this:
```
-parser:script_vars entry_H1_H2="1AHWH" entry_L1_L2="1AHWL" entry_H3="1AHWH" entry_L3="1AHWL"
```
6. Each line in the file corresponds to one modeling process. 500 models is usually sufficient. You can increase the number of output models by running more "ntrials" in each job or creating more jobs by changing the number of lines from 500 to N in the `create_run.sh` file.

7. An example Rosetta modeling job would look like this:
```
<Rosetta_Directory>/main/source/bin/rosetta_scripts.default.linuxgccrelease @flags -parser:script_vars entry_H1_H2=2IBZX entry_L1_L2=3DSFL entry_H3=3V4UH entry_L3=1LO2L  sequence=IKMTQSPSSMYASLGERVTITCKASQDIRKYLNWYQQKPWKSPKTLIYYATSLADGVPSRFSGSGSGQDYSLTISSLESDDTATYYCLQHGESPYTFGGGTKLEIQLQQSGAELVRPGALVKLSCKASGFNIKDYYMHWVKQRPEQGLEWIGLIDPENGNTIYDPKFQGKASITADTSSNTAYLQLSSLTSEDTAVYYCARDNSYYFDYWGQGTTLTVS 
```
8. The output models should be ranked by total Rosetta energy and clustered. Plotting the models' energies vs. RMSD to the lowest energy model can give a good indication if the models are converting to a single solution. 

**Flags file:**
```
-nodelay
-use_input_sc
-ignore_unrecognized_res
-overwrite
-out:file:fullatom
-s 2BRR.ppk_ideal.pdb
-parser:protocol AbPredict_xsd.xml
-parser:script_vars template_pdb=2BRR.ppk_ideal.pdb 
-pdb_comments true

-parser:script_vars H1_H2.db=AB_db_files/H1_H2.db H3.db=AB_db_files/H3.db L3.db=AB_db_files/L3.db L1_L2.db=AB_db_files/L1_L2.db
-out:path:pdb pdb/
```



