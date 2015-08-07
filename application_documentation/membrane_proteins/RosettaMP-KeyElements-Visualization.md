# Membrane visualization with the PyMOL Viewer (RosettaMP)

## Description

The Membrane Framework in Rosetta interacts with Pymol through the PyMOL Mover. For more information, please see the general visualization page. When the membrane framework is in use,  two membrane planes are visualized and updated in real-time during a Rosetta simulation. To run it

1. open pymol first
2. run the PymolPyRosettaServer.py (located in your PyRosetta folder) script inside Pymol
3. run your Rosetta script from the regular terminal
4. then lean back, watch and enjoy some popcorn.

## Command line

`-show_simulation_in_pymol 0` invokes the PymolMover, updating the protein in Pymol every frame. If the protein is a membrane protein, the membrane will be shown automatically. 


## References
* Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol. - In Press - Rosetta Revision #57518

* Baugh EH, Lyskov S, Weitzner BD, Gray JJ (2011) Real-Time PyMOL Visualization for Rosetta and PyRosetta. PLoS ONE 6(8): e21931.

## Contact

- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))
