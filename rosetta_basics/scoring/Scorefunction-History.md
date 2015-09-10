Rosetta's scorefunction has gone though many changes over the years. This page documents some of the landmarks.

Which scorefunction?
====================

Rosetta has never relied exclusively on a single scorefunction (except maybe in its earliest incarnation).  Popular protocols like [[relax]] and [[ab initio]] use different scorefunctions at different points in their execution. Since the advent of [[design|fixbb]] in Rosetta, most applications stick to a single scorefunction.

Publications timeline
=====================
_Note: this is all sketchily from memory, if someone reads this, then reads the papers, edit this to confirm its correctness / remove this hatnote_

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
[A Combined Covalent-Electrostatic Model of Hydrogen Bonding Improves Structure Prediction with Rosetta.](http://www.ncbi.nlm.nih.gov/pubmed/25866491)
J Chem Theory Comput. 2015;11(2):609-622. PubMed PMID: 25866491

...to generate [[Talaris2013/4|score-types]], the current state-of-the-art general purpose Rosetta energy function.

Scorefunctions timeline
=======================
*Rosetta2 / pre-score12 days -- ????

***Score12** was the gold standard from the beginning of the Rosetta3 era up until the release of Talaris13.  This is substantially similar to the scorefunction discussed in the [[Top7 paper]] above.  The 12 has no particular meaning - it was the 12th scorefunction listed in the database.

***Score12_correct** was widely discussed at [[RosettaCON]]s for several years running as a collection of terms to improve Score12's performance.  It was never adopted wholesale.

***Talaris13** was the result of a meeting (held at a hotel named Talaris) where the community used [[OptE]] and many new scorefunction tests to try to improve on Score12.

***Talaris14** is an error-correction of Talaris13 - the weights are (ANDREW FILL THIS IN) (_I think energies were too small/large relative to the Monte Carlo temperatures, so all terms were rescaled to correct temperature.  One energy term was fixed to a new weight as a mistake correction.)_

##See Also

* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Score functions and score terms|score-types]]
* [[Additional score terms|score-types-additional]]
* [[Scoring explained]]
* [[Units in Rosetta]]: Gives a description of Rosetta energy units
* [[Hydrogen bond energy term|hbonds]]
* [[Scorefunctions for noncanonical residues and molecules|NC-scorefunction-info]]
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Glossary]]: Defines key Rosetta terms