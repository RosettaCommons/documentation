#prepare\_template\_for\_MR.pl companion script

Metadata
========

Last edited Oct 26, 2010 by Frank DiMaio. Code by Frank DiMaio. P.I.: David Baker.

Code and Demo
=============

The code for this application is in src/apps/public/electron\_density/prepare\_template\_for\_MR.pl. A demo, showing the role of this protocol in a molecular replacement pipeline, are in demo/electron\_density/molecular\_replacement. In particular, step 1 of the pipeline deals with the use of of this application. (The README in this folder explains each step in detail).

Application purpose
===========================================

This is a helper script for setting up a template and alignment file for using Rosetta to solve difficult molecular replacement problems. Given an alignment file produced from HHsearch, it generates the input template files and alignment files which serve as input to Rosetta's model building.

Algorithm
=========

The script takes just one arguments: an HHR format alignment file. The script parses the .hhr file, downloads each template PDB, and trims the PDB to the aligned residues. In addition, the script produces a 'rosetta-style' alignment file; the format is discussed in the expected outputs section.

This script uses the alignment to produce a trimmed template suitable for an initial molecular replacement search. All deleted residues are removed, and aligned nonmatching residues are trimmed to the gamma carbon. Functionally, the template trimming is doing the same thing as the crystallographic software 'Sculptor' but it doesn't remap the residues as sculptor does (and makes it easier to run with different alignments).

Input Files
===========

The only input, an .hhr alignment file, generally comes from HHsearch's web interface ( [http://toolkit.tuebingen.mpg.de/hhpred](http://toolkit.tuebingen.mpg.de/hhpred) ). After submitting the sequence through their website, export the results to a .hhr file. Results may be trimmed so only alignments with a reasonable e-value and sequence coverage are included.

The trimmed HHR-file should look something like this:

```
Query         1XXX 
Match_columns 134
No_of_seqs    101 out of 418
Neff          6.7 
Searched_HMMs 22773
Command       /cluster/toolkit/production/bioprogs/hhpred/hhsearch -cpu 4 -v 1 -i /cluster/toolkit/production/tmp/production/417840/9488624.hhm -d /cluster/toolkit/production/databases/hhpred/new_dbs/pdb70_21Aug10/db/pdb.hhm -o /cluster/toolkit/production/tmp/production/417840/9488624.hhr -p 20 -P 20 -Z 100 -B 100 -seq 1 -aliw 80 -global -ssm 2 -norealign -sc 1 -dbstrlen 10000 -cs /cluster/toolkit/production/bioprogs/csblast/data/clusters.prf 

 No Hit                             Prob E-value P-value  Score    SS Cols Query HMM  Template HMM
  1 2qo4_A Liver-basic fatty acid  100.0       0       0  292.6  21.2  126    2-133     1-126 (126)


No 1  
>2qo4_A Liver-basic fatty acid binding protein; liver bIle acid-binding protein, BABP, FABP, cholic acid, cholate, bIle acid, lipid-binding, transport; HET: CHD; 1.50A {Danio rerio} PDB: 2qo6_A* 2qo5_A* 2ftb_A* 2ft9_A*
Probab=100.00  E-value=0  Score=292.58  Aligned_cols=126  Identities=31%  Similarity=0.488  Sum_probs=0.0

Q ss_pred             CcccEEEEEEeccCHHHHHHHcCCCHHHHhhhhcCCceEEEEEeCCEEEEEEEccceEEEEEEECCCcEEeecccCCCCE
Q 1CRB_ChainA       2 VDFNGYWKMLSNENFEEYLRALDVNVALRKIANLLKPDKEIVQDGDHMIIRTLSTFRNYIMDFQVGKEFEEDLTGIDDRK   81 (134)
Q Consensus         2 ~~f~G~wkl~~sENfde~Lk~lGv~~~~Rk~a~~~~p~~eI~~~Gd~~tikt~t~~kt~~~~F~lGeefee~~~t~dg~~   81 (134)
                      |+|+|+|+|++|||||+||+|||||+++|++|+.++|+++|+||||+|+|++.+++++.+++|+|||||||+  ++||++
T Consensus         1 MaF~G~wkl~~sENfd~flkalGv~~~~rk~a~~~~p~~~I~~~Gd~~~ikt~s~~kt~~~~F~lGeefee~--~~dG~k   78 (126)
T 2qo4_A            1 MAFSGTWQVYAQENYEEFLRAISLPEEVIKLAKDVKPVTEIQQNGSDFTITSKTPGKTVTNSFTIGKEAEIT--TMDGKK   78 (126)
T ss_dssp             -CCCEEEEEEEEESHHHHHHHTTCCHHHHHHTTTCCCEEEEEEETTEEEEEEEETTEEEEEEEETTBEEEEE--CTTSCE
T ss_pred             CCccEEEEEEeccCHHHHHHHcCCCHHHHhhhhcCCceEEEEEeCCEEEEEEEcCCeeEEEEEECCCcEEEE--cCCCCE


Q ss_pred             EEEEEEEECCEEEEEEECCCCCeEEEEEEECCEEEEEEEECCEEEEEEEEEC
Q 1CRB_ChainA      82 CMTTVSWDGDKLQCVQKGEKEGRGWTQWIEGDELHLEMRAEGVTCKQVFKKV  133 (134)
Q Consensus        82 ~k~~~t~eg~kLv~~~~~~~~~~~~~re~~g~~l~~t~~~~~V~~~R~ykrv  133 (134)
                      +|++++||||+|++    ..++...+||++||+|++||+++||+|+|+|+||
T Consensus        79 ~k~~~t~eg~kLv~----~~~~~~~~Re~~g~~l~~t~~~~~v~~~R~ykrv  126 (126)
T 2qo4_A           79 LKCIVKLDGGKLVC----RTDRFSHIQEIKAGEMVETLTVGGTTMIRKSKKI  126 (126)
T ss_dssp             EEEECEEETTEEEE----ECSSCEEEEEEETTEEEEEEEETTEEEEEEEEEC
T ss_pred             EEEEEEEECCEEEE----EECCCcEEEEEECCEEEEEEEECCEEEEEEEEEC
```

Limitations
===========

-   The script does not handle any other input format.

-   If hhsearch returns obsoleted PDBs, the script tries to find the replacement but this is not guaranteed. You may need to hand-edit the .hhr file file to point to the correct updated PDBID.

Tips
====

-   Before running the script, look at the .hhr alignment file. Try to trim any alignments which only cover a small portion of the target sequence; it's probably not worth the time it takes to run these.

-   Visually inspect the trimmed templates before running. Were any gaps inseted in the middle of helices/strands? If so, the tempate or the alignment may not be good.

Expected Outputs
================

The script will output 2 files:

(1) The trimmed PDB file. This file shoud be used as input to a molecular replacement program (like PHASER) to find an initial set of potential solutions for refinement.

(2) An alignment file for use in Rosetta. The alignment file looks like the following:

```
## 1CRB_ 2qo4.PHASER.1.pdb
# hhsearch
scores_from_program: 0 1.00
2 DFNGYWKMLSNENFEEYLRALDVNVALRKIANLLKPDKEIVQDGDHMIIRTLSTFRNYIMDFQVGKEFEEDLTGIDDRKCMTTVSWDGDKLQCVQKGEKEGRGWTQWIEGDELHLEMRAEGVTCKQVFKKV
0 AFSGTWQVYAQENYEEFLRAISLPEEVIKLAKDVKPVTEIQQNGSDFTITSKTPGKTVTNSFTIGKEAEIT--TMDGKKLKCIVKLDGGKLVCRTD----RFSHIQEIKAGEMVETLTVGGTTMIRKSKKI
--
```

The first line is '\#\#' followed by: (1) a code for the output file (2) the name of the template PDB If the template is later renamed (by the MR program for example) then this would have to be changed.

The second line identifies the source of the alignment; the third just keep as it is.

The fourth line is the target sequence and the fifth is the template ... the number is an 'offset', identifying where the sequence starts. However, the number doesn't use the PDB resid but just counts residues *starting at 0* . The sixth line is '–'.

Post Processing
===============

The models are generally used for a molecular replacement search; the resulting models and the .ali files are then used as inputs to the rosetta MR rebuilding-and-refinement protocol (see [[this page|mr-protocols]] ).

For more information on the steps following this script, see steps 2-5 of the tutorial in /demo/electron\_density/molecular\_replacement.
