# Protein Embeddings (RosettaMP)

[[_TOC_]]

## What is a protein embedding? 
While the membrane residue describes the position and orientation of the membrane bilayer, we need a more fine-grained representation that describes the specific position of pose elements in the membrane. An **embedding** is the position and orientation (center & normal) of that pose element (see image below). This is especially applicable when moving parts of the protein, such as docking partners, trans-membrane spans, etc. 

[[rosettamp_embedding.png]]

## Representing an Embedding in RosettaMP
We created an EmbeddingDef object that stores the center point and normal vector of a Pose element. We also created an Embedding object that stores multiple EmbeddingDefs (in the same manner as the SpanningTopology contains Spans) and the overall EmbeddingDef over all Pose elements. 

An EmbeddingDef for an individual transmembrane span is calculated from the Cα atoms of the start and end residues of the span with the center being the center point between the Cα coordinates and the normal being the vector from the starting Cα to the end Cα atom. An EmbeddingDef object for a Pose element is described by the average of the centers and normals over all spans contained in that Pose element. The EmbeddingDef is therefore not directly connected to the membrane bilayer but describes measures similar to the first and second moment of the transmembrane spanning region that can be used to identify an initial estimate for a membrane position and orientation that can subsequently be refined. A major advantage of the EmbeddingDef representation is the ability to directly compare the center and normal in the EmbeddingDef object of individual Pose elements with the membrane center and normal stored in the membrane residue. 

This representation enables the implementation of an efficient sampling strategy through specialized Movers solely from the knowledge of the EmbeddingDef and the membrane residue. Further, the flexibility of maintaining EmbeddingDef objects according to transmembrane spans, chains, partners, or complete proteins allows adaptation according to the need of the protocol, e.g. with individual spans for *ab initio* structure prediction, select chains for docking, or complete proteins for high-resolution refinement or positioning in the membrane environment.


## References

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol. - In Press


## Contact

- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

