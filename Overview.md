## Metadata

The Rosetta Membrane Framework was developed by Julia Koehler Leman and Rebecca Alford at the Gray Lab at JHU. 

Last updated: 12/12/14. 

For questions please contact: 
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## Description

The original RosettaMembrane was developed by Vladimir Yarov-Yarovoy, Patrick Barth, and Bjoern Wallner before the re-implementation of Rosetta as Rosetta3. Much of the code was implemented as scores in a few classes that also contained functionality for input file handling, computing of membrane embedding, and the protocol themselves, which were Membrane Relax and Membrane AbInitio at the time. Since newer concepts such as the FoldTree were not connected to this code, implementation of new protocols were a major hurdle. We therefore decided to create a completely new implementation of this code to (1) greatly facilitate new protocol development for membrane proteins, (2) connect this code to newer concepts such as FoldTree, Movers, Graph, ScoreFunctionFactory, etc, (3) improve user-friendliness, (4) make protocols available for RosettaScripts, PyRosetta, and commandline. For more detail please see *Alford, Koehler Leman et al.* 

The major aspects of this implementation are the following:
- **MembraneResidue:** In contrast to the original RosettaMembrane, the membrane is now represented as a virtual residue (MEM) added to the pose. It stores the center point of the membrane, the membrane normal vector, and the thickness. The thickness value stored in MEM is half of the "true" membrane thickness, since the membrane is currently regarded as symmetric around z = 0 being at the center of the membrane. In the membrane coordinate system (right handed) the membrane is currently regarded as a flat membrane in the xy-plane with the membrane normal showing in the positive z direction. 

- **MembraneInfo:** The MembraneInfo class is the main hub for storing all membrane-related data in the pose. This includes the membrane center, normal, thickness, SpanningTopology (from spanfile), and Lipophilicity (from lipsfile). It is part of conformation and therefore centrally accessible through the pose in most parts of Rosetta, especially the protocol level (MembraneInfo lives in core2 so it is accessible to everything below in the hierarchy). Since the membrane is represented by a virtual residue that can move during a Rosetta protocol, the membrane center and normal in MembraneInfo are automatically updated after a move. The MembraneInfo object is instantiated, i.e. a pose is converted into a membrane pose, by applying the AddMembraneMover. 

- **FoldTree:** The MembraneResidue is connected to the pose by a jump in the FoldTree. Depending on where the root of the FoldTree is, either the membrane or the protein is flexible or fixed: (1) If the MembraneResidue is at the root of the FoldTree, it remains fixed while the protein moves flexibly in this coordinate system. (2) If one of the protein residues is at the root of the FoldTree, the MembraneResidue (and therefore the membrane) moves flexibly in the coordinate system of the pose. The FoldTree is not handled in MembraneInfo for the sole reason to have more control in the individual protocols, i.e. the developer needs to decide what is required for each protocol: a fixed or a flexible membrane. While a flexible membrane is computationally cheaper and recommended for most protocols, some protocols require a fixed membrane for multiple poses to move in (such as MPDocking). 

- **ScoreFunctions:** During the re-implementation of the Membrane Framework we kept the original low-resolution and high-resolution ScoreFunctions of RosettaMembrane. Updates to the low-resolution scoring functions are currently underway in the Yarov-Yarovoy lab with plans to also update the high-resolution scoring functions in the near future. 

- **Movers:** Several Movers are available with more being implemented as needed. The most important one is the AddMembraneMover that creates a membrane pose from a regular pose - it requires a spanfile to be read in. When using Movers, please pay attention whether they are suited for your particular protocol, as many movers are specific to either (1) a fixed membrane and movable protein, or (2) a movable membrane and a fixed protein. 

- **Visualization:** The Membrane Framework is coupled to the PymolMover which allows real-time visualization of a Rosetta simulation with the membrane present and up-to-date. Pretty cool and useful stuff. 

- **Applications:** Four main applications for membrane proteins (MPrelax, MPddG, MPdocking, symmetric MPdocking) are currently available with more to come. Not all applications are available for all interfaces, please see *Alford, Koehler Leman et al.* for more info, especially Figure 2 in this paper. 

## More details

Four major classes are also of interest: Span, SpanningTopology, EmbeddingDef, and Embedding. A **Span** is an object that stores the start and end residue of a transmembrane span. Multiple Spans are stored in a **SpanningTopology** object that basically stores the information from a spanfile (see inputs). An **EmbeddingDef** (=EmbeddingDefinition) stores the center point and normal vector for an object (this can be an individual transmembrane span, a whole chain, or a whole protein) which is similar to the first and second moment of the membrane portion of this object. For instance, for a single transmembrane helix, the EmbeddingDef center would be the center point between the first and last residue CA atom. The normal vector would be the vector between these two CA's. The EmbeddingDef center of a whole protein would be average of all span centers and the normal would be average of all span normals. Ideal embedding for a whole protein is achieved when the EmbeddingDef of a whole protein (i.e. center and normal) superimpose with the membrane center and normal. Embeddings are handled separately from the membrane to have full flexibility on the protocol level - objects can be moved around by comparing their EmbeddingDef with the membrane center and normal. (An alternative viewpoint would be to regard them as separate membrane residues, even though we didn't choose this representation here.) Multiple EmbeddingDef objects are stored in an **Embedding** object that also stores the average of the EmbeddingDef's - for instance each span can have its own EmbeddingDef while the average would be the EmbeddingDef of the whole protein. 

## Code and documentation

`core2/conformation/membrane` has several classes: MembraneInfo, Span, SpanningTopology, LipidAccInfo (from lips files). The latter three are classes storing information that can be obtained from the protein sequence using prediction servers.

`protocols3/membrane/geometry` contains the EmbeddingDef and Embedding classes and `protocols3/membrane` contains most of the movers. 

## References

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Tilley D, Elazar A, Gray JJ. (2015) An integrated framework enabling computational modeling and design of Membrane Proteins. PlosOne - in preparation 

## References for original RosettaMembrane

* Yarov-Yarovoy V, Schonbrun J, Baker D. (2006 Mar 1) Multipass membrane protein structure prediction using Rosetta. Proteins. 62(4):1010-25.
* Barth P, Schonbrun J, Baker D. (2007 Oct 2) Toward high-resolution prediction and design of transmembrane helical protein structures. Proc Natl Acad Sci U S A. 104(40):15682-7.
* Barth P, Wallner B, Baker D. (2009 Feb 3) Prediction of membrane protein structures with complex topologies using limited constraints. Proc Natl Acad Sci U S A. 106(5):1409-14.
