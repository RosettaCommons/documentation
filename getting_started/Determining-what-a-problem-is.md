#What to do when you can't figure out how to model your problem

You should be here if you weren't able to determine how to address your modeling problem with our pages on [[Solving a Biological Problem]] or [[I want to sample X|I want to do x]].

Sometimes, new graduate students in non-Rosetta labs are given vague problem statements.
At least, they are vague with respect to the Rosetta worldview and documentation.
For example: "We need to check if these mutations are OK at this site. Find some computational protein design software to check them out before you order oligos." 
This is a great project and potentially super valuable, but it is a [[hard, hard question|http://xkcd.com/1430]]; machine learning algorithms trained on sequence data and dozens of structural features drawn from Rosetta-derived ensembles frequently get the right answer, but not always, and just looking at the change in Rosetta score won't get you there.
Unfortunately, there is no simple IsThisMutationTolerated module to answer questions like this.

This is not an error on your part or the part of your PI: this is an important opportunity for you to figure out what sort of sampling is necessary to answer your question.
For example, suppose one of the mutations is alanine-to-proline at the second position of an alpha helix.
This is the third most common position for proline in alpha helices; thus, it is very improbable but not impossible.
So the question is: how fold-breaking is this mutation?

One starting point might be to make the mutation with a fixed backbone, repack in a shell around that residue, and evaluate the energy.
If it is too bad, maybe there needs to be some backbone motion to relieve strain.
Moreover, how good was your original model? Your work may benefit from taking a low quality NMR structure, generating an ensemble from each model, and proceeding from the best cluster centroids of that ensemble.

Also, none of these results necessarily relate to the underlying question your PI asked.
Does your PI want to know how well tolerated the mutations are _structurally_?
Well, then you can produce some measurement derived from the RMSD of the whole protein, native and mutant ensembles both, or perhaps a subset of the protein near the mutation in question, or if it has a critical region like an interface with another protein or an active site, the RMSD there.
Naturally, you'd want to incorporate an energetic measurement, too; if in the mutant ensemble the lowest RMSD-to-native models have the worst energy even within your "best centroids" and vice-versa, that is a bad sign for the stability of that mutation.
Does your PI want, rather, to know how well tolerated the mutations are _functionally_?
You are mostly out of luck.
This is a phenomenally complicated question.
Perhaps the RMSD over "functionally relevant" residues would be helpful, but that's just a possibility; it's impossible to endorse any generally useful metric and identifying "functionally relevant" residues is usually intractable.

In brief: most biological questions you are given are complicated and require extensive thought. 
Talk with your PI to ensure that you are translating their requests into the right sort of modeling.
[[This page|Solving-a-Biological-Problem]] considers what to do with Rosetta from a biological problem standpoint, and [[this page|I-want-to-do-x]] does the same from a sampling degrees of freedom standpoint.  
Be sure that you understand the problem before you devote lots of computer time to it.
(Of course, lots of computer time is sometimes the problem itself: hard problems require lots of computer time, maybe more than you have available.)

If you can describe your problem well, but are not sure what to do with it, the [Rosetta Forums](http://www.rosettacommons.org/forum) (external link) are often a good resource. Unfortunately this documentation has distilled a lot of the expertise available there, so sometimes the answer is, we just can't do it.

Problems Rosetta cannot solve
=============================
There are three major classes of problems Rosetta cannot solve. 
Generally, if you've put a lot of effort into it, you may be in one of these categories.

1. The problem is well formed and addressed with the correct methods, but fails due to broad [[challenges in macromolecular modeling|Challenges-in-Macromolecular-Modeling]], like the scoring problem and search problem. 
This is 100% Rosetta's fault.

2. The problem can be addressed, but [[not enough computer time|Rosetta-on-different-scales]] was spent: the problem is undersampled. 

3. The problem is well-formed, but very complex.
It may be within Rosetta's capability, but not using a preexisting protocol - perhaps it requires a long [[RosettaScript|RosettaScripts]].
Perhaps it is just beyond what Rosetta can do, requiring only a [[Mover|Glossary#mover]] or two. 
This sort of project is reasonable for a Rosetta developer graduate student, but perhaps not as a minor project for a cellular biology grad student in a non-Rosetta lab.
We do see projects of this type fairly frequently on the Rosetta Forums.


##See Also
* [[Resources for learning biophysics and computational modeling]]
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[I want to do x]]: Guide on performing different forms of sampling in Rosetta
* [[Rosetta on different scales|Rosetta-on-different-scales]]: A discussion of how much work you need to do to solve a problem
* [[Challenges in Macromolecular Modeling]]: Discusses the problems of sampling and scoring in protein modeling.