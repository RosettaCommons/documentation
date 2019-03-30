#What to do when you can't figure out how to model your problem

You should be here if you weren't able to determine how to address your modeling problem with our pages on [[Solving a Biological Problem]] or [[I want to sample X|I want to do x]].  You might also have been sent here if we weren't able to help you on the Rosetta Forums.  (This may seem circular as this page implicitly directs users from either location to the other).  

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
Perhaps it is just beyond what Rosetta can do, requiring a new [[Mover]] or two. 
This sort of project is reasonable for a Rosetta developer graduate student, but perhaps not as a minor project for a cellular biology grad student in a non-Rosetta lab.
We do see projects of this complexity fairly frequently on the [Rosetta Forums](https://www.rosettacommons.org/forum).

Problems that we can't help with, and how to help us help you
================================
1. Problem #3 above is solvable by Rosetta in the broad sense, but outside of our resources to help you with. The Rosetta community is pretty responsive to specific questions like "I tried to use Mover Foo with these settings but ran into this problem", but not to broad and vague questions like "I need help writing my script".  We understand that learning to write PyRosetta / RosettaScripts, or just use Rosetta in general is hard - but we don't have the resources to train users individually, so we've created this wiki instead.  If this is an issue - be specific in your queries, especially from the programmer's point of view.  (Being highly specific about the protein you are interested in doesn't help us help you.)

2. Like any large institution, we do suffer from "brain drain" and the loss of institutional knowledge.  If you are interested in a specific application used in a paper from 7 years ago that doesn't have much publication history after the initial paper - probably the author left the Rosetta community, moving on to some other job.  If they didn't leave good documentation behind, there's probably nothing we can do to help.  If this is an issue - do let us know exactly which paper you are trying to base your experiment on, so that we know who to attempt to contact.  Sometimes the PI will have a contact for a graduated student, or someone else in their lab will have picked up the project.

3. Sometimes we just don't know!  Rosetta is huge and complex, and complex out of proportion to the number of people who've used it.  You may be the first person to ever ask how to combine Mover Foo with Filter Bar.  Congratulations!  You're at the cutting edge!  Let us know what you find on your adventure!  We haven't been there before, so we don't really know what you'll find.


##See Also
* [[Resources for learning biophysics and computational modeling]]
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[I want to do x]]: Guide on performing different forms of sampling in Rosetta
* [[Rosetta on different scales|Rosetta-on-different-scales]]: A discussion of how much work you need to do to solve a problem
* [[Challenges in Macromolecular Modeling]]: Discusses the problems of sampling and scoring in protein modeling.