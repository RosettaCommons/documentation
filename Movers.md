## Metadata

The Rosetta Membrane Framework was developed by Julia Koehler Leman and Rebecca Alford at the Gray Lab at JHU. 
Last updated: 12/12/14. 

For questions please contact: 
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## Description

Several Movers are available in the Membrane Framework. Be aware that:
- The **AddMembraneMover** NEEDS to be run to create a membrane pose from a regular pose. It instantiates the MembraneInfo object and the MembraneResidue.
- **All other Movers are (unless otherwise stated) sensitive to which parts are moving during a protocol**, either the membrane or the protein! Using the wrong Mover will result in incorrect output. 

## Code and documentation

`protocols/membrane` contains most of the simple movers, except maybe some specific ones that rely on other protocols (like the MPDocking mover for instance).

## References

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Tilley D, Elazar A, Gray JJ. (2015) An integrated framework enabling computational modeling and design of Membrane Proteins. PlosOne - in preparation 
