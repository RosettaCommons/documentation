# Not Yet Released RosettaMP Movers

[[_TOC_]]

## Movers for Initialization

## Movers for changing the membrane position 

 - [[*FlipMover* | RosettaMP-Movers-Flip ]] Reflect the pose about the xy plane of the membrane
 - [[*TiltMover* | RosettaMP-Movers-Tilt ]] Tilts a single span or partner relative to the jump number
 - [[*SpinAroundPartnerMover* | RosettaMP-Movers-SpinAroundPartner ]] Spin the protein around the second partner in the xy plane

## Movers for docking

- [[ MPDockingMover | RosettaMP-Movers-MPDocking ]] Docks two membrane proteins
- [[MPDockingSetupMover | RosettaMP-Movers-MPDockingSetup]] Reads in 2 poses and 2 spanfiles, concatenates them, and prints them out. Currently only works for 2 poses

## Movers for sampling the protein embedding

- [[OptimizeProteinEmbeddingMover | RosettaMP-Movers-OptimizeProteinEmbedding]] Optimizes the protein embedding in the membrane.

## Movers for Visualization

##Unsure
- [[MPLipidAccessibilityMover | RosettaMP-Movers-MPLipidAccessibility]] Computes which residues are lipid accessible and puts that information into the B-factors.
- [[RangeRelaxMover | RosettaMP-Movers-RangeRelax]] Relaxes a membrane protein by relaxing in ranges.

## Contact

- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## References

The above movers are part of unpublished protocols, but sine they use the RosettaMP framework you should cite the following paper: 

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Tilley D, Elazar A, Gray JJ. (2015) An integrated framework advancing membrane protein modeling and design. PLoS Computational Biology - Accepted
