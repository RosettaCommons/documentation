Rosetta's scorefunction has gone though many changes over the years. This page documents some of the landmarks.

An introductory tutorial on how to score biomolecules using Rosetta can be found [here](https://www.rosettacommons.org/demos/latest/tutorials/scoring/scoring).

Which scorefunction?
====================

Rosetta has never relied exclusively on a single scorefunction (except maybe in its earliest incarnation).  Popular protocols like [[relax]] and [[ab initio|abinitio relax]] use different scorefunctions at different points in their execution. Since the advent of [[design|fixbb]] in Rosetta, most applications stick to a single scorefunction.

Publications timeline
=====================
**See also the [[Rosetta Canon|Rosetta-canon#scoring]]**

* Rohl CA, Strauss CE, Misura KM, Baker D (2004) [Protein structure prediction using Rosetta.](http://www.ncbi.nlm.nih.gov/pubmed/15063647) (pubmed link)  
Methods in Enzymology.  
This paper, often called the **Rohl review**, is a window into Rosetta's early scorefunction, and remains an excellent reference for early forms of the score function terms. It can be a little hard to find online, but paper photocopies float around most Rosetta labs.

* Kuhlman B, Dantas G, Ireton GC, Varani G, Stoddard BL, Baker D (2003)  
[Design of a novel globular protein fold with atomic-level accuracy.] (http://www.ncbi.nlm.nih.gov/pubmed/14631033) (pubmed link)  
Science 302:1364-8  
This paper, often called the **Top7 paper**, is primarily a design paper (see below), but is important for scoring as it introduces sequence-related energy terms (reference energies, p_aa_pp, etc), and is the closest reference for "where **score12** came from".
The supplemental is most relevant for scoring.

* Leaver-Fay A, O'Meara MJ, Tyka M, Jacak R, Song Y, Kellogg EH, Thompson J, Davis IW, Pache RA, Lyskov S, Gray JJ, Kortemme T, Richardson JS, Havranek JJ, Snoeyink J, Baker D, Kuhlman B (2013)  
[Scientific benchmarks for guiding macromolecular energy function improvement.] (http://www.ncbi.nlm.nih.gov/pubmed/23422428) (pubmed link)  
Methods Enzymol 523:109-43  
Leaver-Fay et al. describe OptE, a methodology for using sequence-recovery and rotamer-recovery benchmarks to improve weights sets for scoring functions.  This was used in the next paper...

* O'Meara MJ, Leaver-Fay A, Tyka M, Stein A, Houlihan K, DiMaio F, Bradley P, Kortemme T, Baker D, Snoeyink J, Kuhlman B (2015)  
[A Combined Covalent-Electrostatic Model of Hydrogen Bonding Improves Structure Prediction with Rosetta.](http://www.ncbi.nlm.nih.gov/pubmed/25866491) (pubmed link)  
J Chem Theory Comput. 2015;11(2):609-622. PubMed PMID: 25866491  
...to generate [[Talaris2013/4|score-types]], the current state-of-the-art general purpose Rosetta energy function.

* Park H, Bradley P, Greisen Jr. P, Liu Y, Mulligan VK, Kim DE, Baker D, DiMaio F (2016)
[Simultaneous Optimization of Biomolecular Energy Functions on Features from Small Molecules and Macromolecules.]
(https://www.ncbi.nlm.nih.gov/pubmed/27766851) (pubmed link)
J Chem Theory Comput. 2016;12(12):6201–6212. PubMed PMID 27766851

* Alford RF, Leaver-Fay A, Jeliazko JR, O'Meara MJ, DiMaio FP, Park H, Shapovalov MV, Renfrew PD, Mulligan VM, Kappel K, Labonte JW, Pacella MS, Bonneau R, Bradley P, Dunbrack RL, Das R, Baker D, Kuhlman B, Kortemme T, Gray JJ (2017) [The Rosetta all-atom energy function for macromolecular modeling and design.](http://pubs.acs.org/doi/abs/10.1021/acs.jctc.7b00125)(acs link) J Chem Theory Comput. 2017;13(6):3031-3048

Scorefunctions timeline
=======================
*Rosetta2 / pre-score12 days -- ????

* **Score12** was the gold standard from the beginning of the Rosetta3 era up until the release of Talaris13.  This is substantially similar to the scorefunction discussed in the [[Top7 paper|Glossary#top7-top7-paper]] above.  The 12 has no particular meaning - it was the 12th scorefunction listed in the database.

* **Score12_correct** was widely discussed at [[RosettaCON|Glossary#RosettaCON]]s for several years running as a collection of terms to improve Score12's performance.  It was never adopted wholesale.

* **Talaris13** was the result of a meeting (held at a hotel named Talaris) where the community used [[OptE|opt-e-parallel-doc]] and many new scorefunction tests to try to improve on Score12.  It was denoted 13 both as a successor to score12 and because it was developed in 2013.

* **Talaris14** is an error-correction of Talaris13.  One of the hydrogen bonding weights was incorrect.  All the weights were re-scaled to more closely match the Rosetta Energy Unit size of score12 - ultimately the units are arbitrary but better comparison with score12 was desired.  The YHH_planarity term was added to help control the alcohol hydrogen in tyrosine.  This was developed in 2014, but not put into use until 2016.

* **REF2015** was developed as [[beta_nov15|Overview of Seattle Group energy function optimization project]] and became the default scorefunction in July 2017.  Beta_nov16 is under development behind it.

##See Also

* [Scoring tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scoring/scoring)
* [[Scoring explained]]
* [[Units in Rosetta]]: Gives a description of Rosetta energy units
* [[Hydrogen bond energy term|hbonds]]
* [[Score functions and score terms|score-types]]
* [[Additional score terms|score-types-additional]]
* [[Design-centric guidance terms|design-guidance-terms]]
* [[Scorefunctions for noncanonical residues and molecules|NC-scorefunction-info]]
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Rosetta Canon]]: Landmark Rosetta papers
* [[Rosetta Timeline]]: Rosetta releases and other events

<!-- SEO
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
score function scorefunction
-->
