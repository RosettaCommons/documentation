Rosetta's scorefunction has gone though many changes over the years. This page documents some of the landmarks.

Which scorefunction?
====================

Rosetta has never relied exclusively on a single scorefunction (except maybe in its earliest incarnation).  Popular protocols like [[relax]] and [[ab initio]] use different scorefunctions at different points in their execution. Since the advent of [[design|fixbb]] in Rosetta, most applications stick to a single scorefunction.

Publications timeline
=====================

Scorefunctions timeline
=======================
*Rosetta2 / pre-score12 days -- ????

***Score12** was the gold standard from the beginning of the Rosetta3 era up until the release of Talaris13.  This is substantially similar to the scorefunction discussed in the [[Top7 paper]] above.  The 12 has no particular meaning - it was the 12th scorefunction listed in the database.

***Score12_correct** was widely discussed at [[RosettaCON]]s for several years running as a collection of terms to improve Score12's performance.  It was never adopted wholesale.

***Talaris13** was the result of a meeting (held at a hotel named Talaris) where the community used [[OptE]] and many new scorefunction tests to try to improve on Score12.

***Talaris14** is an error-correction of Talaris13 - the weights are (ANDREW FILL THIS IN) (_I think energies were too small/large relative to the Monte Carlo temperatures, so all terms were rescaled to correct temperature.  One energy term was fixed to a new weight as a mistake correction.)_

