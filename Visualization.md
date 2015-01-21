## TODO

- expand
- cite Evan's papers
- more info about PymolMover
- is the flag -membrane_new:view_in_pymol still relevant and used?
- what about the VisualizeMembraneMover??? Better for Chimera; if you have Pymol, use PymolMover instead
- add an image here?

## Metadata

The Rosetta Membrane Framework was developed by Julia Koehler Leman and Rebecca Alford at the Gray Lab at JHU. 
Last updated: 12/12/14. 

For questions please contact: 
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## Description

The Membrane Framework in Rosetta interacts with Pymol through the PymolPyRosettaServer.py script in `<path to Rosetta>/Rosetta/main/source/src/python/bindings/`. Two membrane planes are visualized and updated in real-time during a Rosetta simulation. To run it

1. open pymol first
2. run the PymolPyRosettaServer.py script inside Pymol
3. run your Rosetta script from the regular terminal
4. then lean back, watch and enjoy some popcorn.

## Code and documentation

## Flags

`-show_simulation_in_pymol 0` invokes the PymolMover. If the protein is a membrane protein, the membrane will be shown automatically. 

## Example

## References

* Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Tilley D, Elazar A, Gray JJ. (2015) An integrated framework enabling computational modeling and design of Membrane Proteins. PlosOne - in preparation 
