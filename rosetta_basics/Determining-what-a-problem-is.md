Very frequently, new graduate students in non-Rosetta labs are given very vague problem statements.
At least, they are vague with respect to the questions here.
For example: "You should acquire Rosetta and determine which of these mutations would be tolerated."
This is a great project and potentially super valuable, but it is a hard, hard question; machine learning algorithms trained on sequence data and dozens of structural features drawn from Rosetta-derived ensembles frequently get the right answer, but not always, and just looking at the change in Rosetta score won't get you there.

Unfortunately, there is no IsThisMutationTolerated mover.
This is not an error on the part of your PI; this is an important opportunity for you to figure out what sort of sampling is necessary to answer your question.
For example, suppose one of the mutations is alanine-to-proline at the second position of an alpha helix.
This is the third most common position for proline in alpha helices; thus, it is very improbable but not impossible.
So the question is: how fold-breaking is this mutation?

One starting point might be to make the mutation with a fixed backbone, repack in a shell around that residue, and evaluate the energy.
If it is too bad, maybe there needs to be some backbone motion to relieve strain.
Moreover, how good was your original model? Your work may benefit from taking a low quality NMR structure, generating an ensemble from each model, and proceding from the best cluster centroids of that ensemble.

Also, none of these results necessarily relate to the underlying question your PI asked.
Does your PI want to know how well tolerated the mutations are _structurally_?
Well, then you can produce some measurement derived from the RMSD of the whole protein, native and mutant ensembles both, or perhaps a subset of the protein near the mutation in question, or if it has a critical region like an interface with another protein or an active site, the RMSD there.
Naturally, you'd want to incorporate an energetic measurement, too; if in the mutant ensemble the lowest RMSD-to-native models have the worst energy even within your "best centroids" and vice-versa, that is a bad sign for the stablity of that mutation.
Does your PI want, rather, to know how well tolerated the mutations are _functionally_?
You are mostly out of luck.
This is a phenomenally complicated question.
Perhaps the RMSD over "functionally relevant" residues would be helpful, but that's just a possibility; it's impossible to endorse any generally useful metric and identifying "functionally relevant" residues is usually intractable.

In brief: most biological questions you are given are complicated and require extensive thought.
In contrast, this page _only_ tells you the type of sampling you can do, which is very valuable _once you have decided what you want to do_.
