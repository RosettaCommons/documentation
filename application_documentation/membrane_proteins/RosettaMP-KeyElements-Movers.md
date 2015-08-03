# Movers for Initialization, Sampling, etc (RosettaMP)

[[_TOC_]]

## Overview
The RosettaMP framework supports a set of movers that initialize elemnts of RosettaMP and implement sampling movers that account for the membrane environment. Each mover currently in the code and supported by the RosettaScripts interface is detailed in the pages below: 

## Movers for Initialization

 - **[[AddMembraneMover | RosettaMP-Movers-AddMembrane ]]** Initialize the RosettaMP framework by adding a memrbane representation to the pose
 - **[[SymmetrcAddMembraneMover | RosettaMP-Movers-SymmetricAddMembrane ]]** Initialize the RosettaMP framework with a symmetric pose 
 - **[[AddMPLigandMover | RosettaMP-Movers-AddMPLigand ]]** Add a single ligand to a pose already supported by the RosettaMP framework

## Movers for changing the membrane position 

 - **[[MembranePositionFromTopology | RosettaMP-Movers-MembranePositionFromTopology ]]** Calculate the membrane position from the transmembrane spans
 - **[[SetMembranePositionMover | RosettaMP-Movers-SetMembranePosition ]]** Set the membrane position to a given center and normal
 - **[[OptimizeMembranePositionMover | RosettaMP-Movers-OptimizeMembranePosition ]]** Optimize the position of the membrane by deterministic search (relies on the scoring function)
 - **[[RandomMembranePositionMover | RosettaMP-Movers-RandomMembranePosition ]]** Sample a random membrane position

## Movers for sampling the protein embedding

 - **[[TransformIntoMembraneMover| RosettaMP-Movers-TransformIntoMembrane ]]** Transform the protein based on its embedding into the current membrane position
 - **[[TranslationRotation | RosettaMP-Movers-TranslationRotation ]]** Translate & rotate the protein from and old center/normal into a new center/normal

## Movers for Visualization

 - **[[VisualizeEmbeddingMover | RosettaMP-Movers-VisualizeEmbedding ]]** Add embedding residues to the pose based on data in Embedding for visualization
 - **[[VisualizeMembrane | RosettaMP-Movers-VisualizeMembrane ]]** Add a series of pseudoatoms for visualizing the membrane as planes of pseudoatoms in pymol (very expensive)

## Contact

- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## References

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol. - In Press

