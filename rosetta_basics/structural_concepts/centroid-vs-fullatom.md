#Centroid and Full-atom modes

TODO: Fill in details on this page

In an ideal world with infinite time and computer power, we could perform all of our simulations with all atoms. In practice, trying to perform extensive backbone sampling while including all side chain atoms is impractical at best. 

The first problem is that having all atoms is expensive, because calculating interactions between all atom pairs grows rapidly (n<sup>2</sup>) with the number of atoms. 
The bigger problem is that fully atomic conformational space is **very rugged**, so most moves are either rejected by [[Monte Carlo]].

To get around this problem, poses are often converted into [[centroid|Glossary#centroid]] mode for portions of a protocol that require extensive sampling (for example, the initial stages of *[[ab initio|abinitio-relax]]* structure prediction).  In centroid mode, the backbone remains fully atomic, but the representation of each side chain is simplified to a single "atom" of varying size. For protein backbones, this representation preserves five backbone atoms for each amino acid: nitrogen (N), the alpha carbon (CA), the carbonyl carbon (C), the carbonyl oxygen (O), and the polar hydrogen on nitrogen. The side chain is replaced by the "CEN" atom whose radius and properties (polarity, charge, etc.) are determined by the residue's identity.

Centroid scorefunctions are kind of vague, in the same way that the protein representation is kind of fuzzy. 
This has a disadvantage in terms of interpreting their results, but a huge advantage in that the energy landscape is not nearly as rugged, and sampling very different conformations is easier.

After large-scale sampling in centroid mode, poses are generally converted back to their all-atom representation for refinement, which generally entails some combination of [[side chain repacking|Rosetta-overview#packer]] and [[minimization|minimization-overview]]. This allows Rosetta to more accurately score interactions between side chains and other finer details of the protein's structure.

##See Also

* [[Centroid score terms]]
* [[Rosetta overview]]
* [[Glossary]]
* [[Scoring explained]]
* [[Score types]]
* [[CenRotModel]]

<!--- Gollum search optimization keywords
centroid
centroid
centroid
centroid
centroid
centroid
centroid
centroid
centroid
centroid
centroid
centroid
centroid
centroid
centroid
full atom
full atom
full atom
full atom
full atom
full atom
full atom
full atom
full atom
full atom
full atom
full atom
full atom
full atom
full atom
full atom
fullatom
fullatom
fullatom
fullatom
fullatom
fullatom
fullatom
fullatom
fullatom
fullatom
fullatom
fullatom
fullatom
fullatom
fullatom
fullatom 
--->


