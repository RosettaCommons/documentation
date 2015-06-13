#Centroid and Full-atom modes


TODO: Fill in details on this page

In an ideal world with infinite time and computer power, we could perform all of our simulations with all atoms. In practice, trying to perform extensive backbone sampling while including all side chain atoms is impractical at best. To get around this problem, poses are often converted into [[centroid|Glossary#centroid]] mode for portions of a protocol that require extensive sampling (for example, the initial stages of *[[ab initio|abinitio-relax]]* structure prediction.  In centroid mode, the backbone remains fully atomic, but the representation of each side chain is simplified to a single "atom" of varying size. For protein backbones, this representation preserves five backbone atoms for each amino acid: nitrogen (N), the alpha carbon (CA), the carbonyl carbon (C), the carbonyl oxygen (O), and the polar hydrogen on nitrogen. The side chain is replaced by the "CEN" atom whose radius and properties (polarity, charge, etc.) are determined by the residue's identity.

After large-scale sampling in centroid mode, poses are generally converted back to their all-atom representation for refinement, which generally entails some combination of [[side chain repacking|Rosetta-overview#packer]] and [[minimization|minimization-overview]]. This allows Rosetta to more accurately score interactions between side chains and other finer details of the protein's structure.



##See Also

* [[Rosetta overview]]
* [[Glossary]]
* [[Scoring explained]]
* [[Score types]]


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


