#What are "internal coordinates" and why does Rosetta use them?

_This is an essay, but feel free to fill it with links as necessary._

In Cartesian terms, each atom of each residue represents three degrees of freedom.
Each atomic position varies independently and could be separately optimized.
In fact, in [[Cartesian minimization]], particular Rosetta protocols do precisely that.

The issue is that, broadly speaking, 3N degrees of freedom is just too many!
So we obtain an approximation to these degrees of freedom that make our lives much easier and require us to search much less space.
You may wish to recall here the idea, from linear algebra, of _changing basis_.
If you have a vector space, there are typically multiple ways to represent every point in that space, each one being a basis.
For example, in R<sup>3</sup>, you can use (1,0,0) and (0,1,0) and (0,0,1) as a basis, but any other set of three linearly independent vectors qualify as well.
But, importantly, it will always take _three_ linearly independent vectors to span R<sup>3</sup>.

Similarly, there will be, by default, exactly as many internal coordinates as Cartesian coordinates: bond lengths, angles, and dihedrals correspond to each of the x, y, and z coordinates for each atom.
But on the scale of the forces that typically influence protein folding, the spring constants associated with bond angles and bond lengths are not accessible to distortion.
So every bond length and angle that we approximately hold as fixed removes one dof from the set.

Relying on internal coordinates provides a tiny subset of all Cartesian space and allows us to approximate solutions to intractable problems.

Particular protocols rely on Cartesian coordinate and minimization, and that is fine. But unless there is a strong reason to do so, or unless you have reason to believe that you have in your initial sampling gotten sufficiently close to the desired answer already that the majority of the degrees of freedom are well constrained and the rest can be optimized.
This echoes a common motif in Rosetta specifically and in Monte Carlo simulation in general (in any circumstance where you have to sample a big space and have to settle for not doing so exhaustively):
You are much better off sampling degrees of freedom asynchronously.
This is why there exist two phases to many protocols ([[low- and high-resolution|centroid-vs-fullatom]]), for example.
Exploiting the reduced set of variables provided by relying on internal coordinates is essential to Rosetta sampling algorithms.


##See Also

* [[Atomtree overview]]
* [[Rosetta overview]]