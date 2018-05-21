# Movers for Initialization, Sampling, etc (RosettaMP)

[[_TOC_]]

## Overview
The RosettaMP framework supports a set of movers that initialize elements of RosettaMP and implement sampling movers that account for the membrane environment. Each mover currently in the code and supported by the RosettaScripts interface is detailed in the pages below: 

## Movers for Initialization

 - **[[AddMembraneMover | RosettaMP-Movers-AddMembrane ]]** Initialize the RosettaMP framework by adding a membrane representation to the pose
 - **[[SymmetricAddMembraneMover | RosettaMP-Movers-SymmetricAddMembrane ]]** Initialize the RosettaMP framework with a symmetric pose 
 - **[[AddMPLigandMover | RosettaMP-Movers-AddMPLigand ]]** Add a single ligand to a pose already supported by the RosettaMP framework

## Movers for changing the membrane position 

- **[[MembranePositionFromTopology | RosettaMP-Movers-MembranePositionFromTopology ]]** Calculate the membrane position from the transmembrane spans
- **[[SetMembranePositionMover | RosettaMP-Movers-SetMembranePosition ]]** Set the membrane position to a given center and normal
- **[[RandomMembranePositionMover | RosettaMP-Movers-RandomMembranePosition ]]** Sample a random membrane position
- **[[FlipMover | RosettaMP-Movers-Flip ]]** Reflect the pose about the xy plane of the membrane
- **[[TiltMover | RosettaMP-Movers-Tilt ]]** Tilts a single span or partner relative to the jump number
- **[[SpinAroundPartnerMover | RosettaMP-Movers-SpinAroundPartner ]]** Spin the protein around the second partner in the xy plane
- **[[OptimizeMembranePositionMover | RosettaMP-Movers-OptimizeMembranePosition ]]** Optimize the position of the membrane by deterministic search (relies on the scoring function)

## Movers for docking

- **[[ MPDockingMover | RosettaMP-Movers-MPDocking ]]** Docks two membrane proteins
- **[[MPDockingSetupMover | RosettaMP-Movers-MPDockingSetup]]** Reads in 2 poses and 2 spanfiles, concatenates them, and prints them out. Currently only works for 2 poses

## Movers for sampling the protein embedding

- **[[TransformIntoMembraneMover| RosettaMP-Movers-TransformIntoMembrane ]]** Transform the protein into membrane coordinates
- **[[TranslationRotation | RosettaMP-Movers-TranslationRotation ]]** Translate & rotate the protein from an old center/normal into a new center/normal
- **[[OptimizeProteinEmbeddingMover | RosettaMP-Movers-OptimizeProteinEmbedding]]** Optimizes the protein embedding in the membrane.

## Movers for Visualization

- **[[VisualizeEmbeddingMover | RosettaMP-Movers-VisualizeEmbedding ]]** Add embedding residues to the pose to visualize embedding of spans, chains or the entire protein
- **[[VisualizeMembrane | RosettaMP-Movers-VisualizeMembrane ]]** Add a series of pseudoatoms for visualizing the membrane as planes of pseudoatoms in visualization programs (very expensive)

## Other Movers

- **[[MPLipidAccessibilityMover | RosettaMP-Movers-MPLipidAccessibility]]** Computes which residues are lipid accessible and puts that information into the B-factors.
- **[[RangeRelaxMover | RosettaMP-Movers-RangeRelax]]** Relaxes a membrane protein by relaxing iteratively in ranges.

## References

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol; 11(9).


## Contact

- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))
