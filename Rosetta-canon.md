#The Rosetta canon

_In the beginning Rosetta was created from the Centroid and the Fragment._  
_And the Fullatom Pose was without Conformation, and Null; and darkness_ was _upon the potential energy surface. And the Students of Baker moved upon the face of protein structure._  
_And Rosetta said, Let there be the Metropolis criterion: and there was convergence._  
_And Rosetta saw the folding funnel, and saw that it was good._ 
_Thus the Students of Baker divided the models from the decoys._  

Rosetta has a relatively long academic history, and there is a substantial set of papers that are foundational to both the content of the code-base and the accomplishments of its users.
We distilled these references to a core canon: the papers we assume each other have read, the papers we wish we had read, the papers we should have read, and, in lucky cases, the papers we have read.

These are organized by field in order of Rosetta entering the field, and chronological order within each group.

[[_TOC_]]

Protein Structure Prediction
-----------------
* Simons KT, Bonneau R, Ruczinski I, Baker D (1999)  
[Ab initio protein structure prediction of CASP III targets using ROSETTA.] (http://www.ncbi.nlm.nih.gov/pubmed/?term=10526365)    
Proteins Suppl 3:171-6  
The first use of the Rosetta algorithm successfully predicted ab initio protein structures to an RMSD within 6.4, 6.0, and 3.8Å.

* Raveh B, London N, Schueler-Furman O (2010)  
[Sub-angstrom modeling of complexes between flexible peptides and globular proteins.] (http://www.ncbi.nlm.nih.gov/pubmed/?term=20455260)  
Proteins 78:2029-40  
Raveh et al. describe algorithms to predict the bound state of flexible peptides in protein pockets.

* DiMaio F, Leaver-Fay A, Bradley P, Baker D, Andre I (2011)  
[Modeling symmetric macromolecular structures in Rosetta3.] (http://www.ncbi.nlm.nih.gov/pubmed/?term=21731614)  
PLoS One 6:e20450  
DiMaio et al. describe a framework for efficiently modeling highly symmetric oligomers using a single monomer, the inter-monomer interface, and mathematical relationships between subunits.

Scoring
--------------
* Rohl CA, Strauss CE, Misura KM, Baker D (2004) [Protein structure prediction using Rosetta.](http://www.ncbi.nlm.nih.gov/pubmed/15063647)
This paper, often called the **Rohl review**, is a window into Rosetta's early scorefunction, and remains an excellent reference for early forms of the score function terms. It can be a little hard to find online, but paper photocopies float around most Rosetta labs.

* Kuhlman B, Dantas G, Ireton GC, Varani G, Stoddard BL, Baker D (2003)  
[Design of a novel globular protein fold with atomic-level accuracy.] (http://www.ncbi.nlm.nih.gov/pubmed/?term=14631033)  
Science 302:1364-8  
This paper, often called the **Top7 paper**, is primarily a design paper (see below), but is important for scoring as it introduces sequence-related energy terms (reference energies, p_aa_pp, etc).
The supplemental is most relevant for scoring.

<!--* Kortemme T, Kim DE, Baker D (2004)  
[Computational alanine scanning of protein-protein interfaces.] (http://www.ncbi.nlm.nih.gov/pubmed/?term=14872095)  
Sci STKE 2004:pl2  
Kortemme et al. exhibit an alanine scanning algorithm for protein-protein interfaces that correctly predicts 79% of hot spot residues.-->

<!--* Kellogg EH, Leaver-Fay A, Baker D (2011)  
[Role of conformational sampling in computing mutation-induced changes in protein structure and stability.] (http://www.ncbi.nlm.nih.gov/pubmed/?term=21287615)  
Proteins 79:830-8  
Kellogg et al. explore methods for computing the stability change corresponding to a point mutation in a protein with variable conformational sampling and scoring function selection.
-->

* Leaver-Fay A, O'Meara MJ, Tyka M, Jacak R, Song Y, Kellogg EH, Thompson J, Davis IW, Pache RA, Lyskov S, Gray JJ, Kortemme T, Richardson JS, Havranek JJ, Snoeyink J, Baker D, Kuhlman B (2013)  
[Scientific benchmarks for guiding macromolecular energy function improvement.] (http://www.ncbi.nlm.nih.gov/pubmed/23422428)  
Methods Enzymol 523:109-43  
Leaver-Fay et al. describe OptE, a methodology for using sequence-recovery and rotamer-recovery benchmarks to improve weights sets for scoring functions and describe [[Talaris2013]], the current state-of-the-art general purpose Rosetta energy function.

Docking
--------------
* Gray JJ, Moughon S, Wang C, Schueler-Furman O, Kuhlman B, Rohl CA, Baker D (2003)  
[Protein-protein docking with simultaneous optimization of rigid-body displacement and side-chain conformations.] (http://www.ncbi.nlm.nih.gov/pubmed/?term=12875852)
J Mol Biol 331:281-99  
Gray et al. produce the first effort in Rosetta to couple rigid-body docking and sidechain optimization; in so doing, they frequently obtain binding funnels that typically recapitulate at least 25% of binding contacts.

* Chaudhury S, Gray JJ (2008)  
[Conformer selection and induced fit in flexible backbone protein-protein docking using computational and NMR ensembles.] (http://www.ncbi.nlm.nih.gov/pubmed/?term=18640688)  
J Mol Biol 381:1068-87  
Chaudhury and Gray demonstrate algorithms that echo traditional lock-in-key complexing (rigid body docking) and more sophisticated models (conformer selection via EnsembleDock; induced fit via backbone minimization on the smaller partner of the complex; a combination of both) and validate the EnsembleDocking protocol by illustrating that docking-competent conformers exist in the unbound ensemble.

* Sircar A, Chaudhury S, Kilambi KP, Berrondo M, Gray JJ (2010)  
[A generalized approach to sampling backbone conformations with RosettaDock for CAPRI rounds 13-19.] (http://www.ncbi.nlm.nih.gov/pubmed/?term=20535822)  
Proteins 78:3115-23  
Sircar et al. describe their use of the EnsembleDock and SnugDock algorithms to generate improved docking models for the CAPRI competition.

Design
--------------
* Kuhlman B, Dantas G, Ireton GC, Varani G, Stoddard BL, Baker D (2003)  
[Design of a novel globular protein fold with atomic-level accuracy.] (http://www.ncbi.nlm.nih.gov/pubmed/?term=14631033)  
Science 302:1364-8  
Kuhlman et al. demonstrate the computational design of a protein with an entirely novel fold.
The significance of this result arises because prior design efforts involved stabilizing or modifying existing, known folds; the ability to _de novo_ create a protein was wholly original.

* Guntas G, Purbeck C, Kuhlman B (2010)  
[Engineering a protein-protein interface using a computationally designed library.] (http://www.ncbi.nlm.nih.gov/pubmed/?term=20974935)  
Proc Natl Acad Sci U S A 107:19296-301  
Computational design at twenty amino acid positions was used to semi-direct two protein libraries, which greatly outperformed the control library where all residues were allowed: the former produced multiple mid-nanomolar binders while the latter could not produce bunders under fifty micromolar after four rounds of selection.

Ligand docking
--------------
* Davis IW, Baker D (2009)  
[RosettaLigand docking with full ligand and receptor flexibility.](http://www.ncbi.nlm.nih.gov/pubmed/?term=19041878)
J Mol Biol 385:381-92  
Davis and Baker incorporate receptor flexibility via backbone minimization and obtain correct cross-docking ligand orientations within 2A RMSD in 64% of cases.

* Meiler J, Baker D (2006)  
[ROSETTALIGAND: protein-small molecule docking with full side-chain flexibility.] (http://www.ncbi.nlm.nih.gov/pubmed/?term=16972285)  
Proteins 65:538-48  
The original incorporation of ligand molecules into Rosetta, due to Meiler and Baker, permitted rotamer optimization on the protein partner and obtains a correlation of 0.63 for interaction energy versus experimental binding energy.

RNA
--------------
* Sripakdeevong P, Kladwang W, Das R (2011)  
[An enumerative stepwise ansatz enables atomic-accuracy RNA loop modeling.] (http://www.ncbi.nlm.nih.gov/pubmed/?term=22143768)  
Proc Natl Acad Sci U S A 108:20573-8  
Sripakdevong et al. discuss an ansatz by which they enumerate and score RNA loop conformations, enabling the solution of heretofore intractable "RNA puzzles"

* Das R, Baker D (2007)  
[Automated de novo prediction of native-like RNA tertiary structures.] (http://www.ncbi.nlm.nih.gov/pubmed/?term=17726102)  
Proc Natl Acad Sci U S A 104:14664-9  
Das and Baker describe successful prediction of RNA structure from sequence data.
They reproduce 90% of Watson-Crick base pairs and more than one third of noncanonical features.

Enzyme Design
--------------
* Siegel JB, Zanghellini A, Lovick HM, Kiss G, Lambert AR, St Clair JL, Gallaher JL, Hilvert D, Gelb MH, Stoddard BL, Houk KN, Michael FE, Baker D (2010)  
[Computational design of an enzyme catalyst for a stereoselective bimolecular Diels-Alder reaction.] (http://www.ncbi.nlm.nih.gov/pubmed/?term=20647463)  
Science 329:309-13  
Siegel et al. design a stereoselective and chemoselective Diels-Alderase, obtain its crystal structure, and illustrate that mutations at the putative binding site can tune its substrate specificity. 

* Jiang L, Althoff EA, Clemente FR, Doyle L, Röthlisberger D, Zanghellini A, Gallaher JL, Betker JL, Tanaka F, Barbas CF 3rd, Hilvert D, Houk KN, Stoddard BL, Baker D (2008)
[De novo computational design of retro-aldol enzymes.] (http://www.ncbi.nlm.nih.gov/pubmed/?term=18323453)
Science 319:1387-91

Loop modeling
--------------
* Mandell DJ, Coutsias EA, Kortemme T (2009)  
[Sub-angstrom accuracy in protein loop reconstruction by robotics-inspired conformational sampling.] ()    
Nat Methods 6:551-2  
Mandell et al. describe the kinematic loop closure algorithm for remodeling protein loop geometry.


Rosetta development
-------------
* Leaver-Fay A, Tyka M, Lewis SM, Lange OF, Thompson J, Jacak R, Kaufman K, Renfrew PD, Smith CA, Sheffler W, Davis IW, Cooper S, Treuille A, Mandell DJ, Richter F, Ban YE, Fleishman SJ, Corn JE, Kim DE, Lyskov S, Berrondo M, Mentzer S, Popović Z, Havranek JJ, Karanicolas J, Das R, Meiler J, Kortemme T, Gray JJ, Kuhlman B, Baker D, Bradley P (2011)  
[ROSETTA3: an object-oriented software suite for the simulation and design of macromolecules.] (http://www.ncbi.nlm.nih.gov/pubmed/?term=21187238)  
Methods Enzymol 487:545-74  

* Cooper S, Khatib F, Treuille A, Barbero J, Lee J, Beenen M, Leaver-Fay A, Baker D, Popović Z, Players F (2010)  
[Predicting protein structures with a multiplayer online game.] (http://www.ncbi.nlm.nih.gov/pubmed/?term=20686574)  
Nature 466:756-60  
Cooper et al.'s development of the FoldIt game showed that highly parallel human intuition is a useful tool for 

* Chaudhury S, Lyskov S, Gray JJ (2010)  
[PyRosetta: a script-based interface for implementing molecular modeling algorithms using Rosetta.](http://www.ncbi.nlm.nih.gov/pubmed/?term=20061306)  
Bioinformatics 26:689-91  
Chaudhury et al. developed a Python based scripting interface to Rosetta functionality, permitting users to easily compose protocols without interacting with the C++ layer.

Peptidomimetics
-------------
* Renfrew PD, Craven TW, Butterfoss GL, Kirshenbaum K, Bonneau R (2014)  
[A rotamer library to enable modeling and design of peptoid foldamers.] (http://www.ncbi.nlm.nih.gov/pubmed/?term=24823488)    
J Am Chem Soc 136:8772-82  
Renfrew et al. demonstrate that peptoid residues (N-alkylated or arylated glycines) have sidechain conformations that fall neatly into rotamer bins much like peptides and demonstrate two methods for constructing rotamer libraries to model them.

* Drew K, Renfrew PD, Craven TW, Butterfoss GL, Chou FC, Lyskov S, Bullock BN, Watkins A, Labonte JW, Pacella M, Kilambi KP, Leaver-Fay A, Kuhlman B, Gray JJ, Bradley P, Kirshenbaum K, Arora PS, Das R, Bonneau R (2013)  
[Adding diverse noncanonical backbones to rosetta: enabling peptidomimetic design.] (http://www.ncbi.nlm.nih.gov/pubmed/?term=23869206)  
PLoS One 8:e67051  
Drew et al. create custom modes for backbone sampling to incorporate peptidomimetic scaffolds into Rosetta, enabling the design of amino acid-derived nonnatural foldamers.


