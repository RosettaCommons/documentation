# RosettaMP Application: Visualization with the PyMOL Mover

## Code and Demo
The PyMOL viewer with visualizing the membrane bilayer can be used with any Rosetta application with just one additional option. We also provide an application to explicitly view output models in the C++ code: 

A standalone application can also be found in `Rosetta/main/source/src/apps/public/membrane/mp_viewer.cc` 

A demo can also be found in `Rosetta/demos/protocol_captures/mp_pymol_viewer`

Rosetta Revision #58096

## Background
Visualizing the membrane bilayer is important for analysis of membrane models and debugging protocols. In particular, we can answer questions about interactions at different hydrophobic layers, membrane embedding, and orientation. This application enables visualization of output Rosetta models with the Rosetta PyMOL viewer. This tool uses the position of the bilayer described by the membrane framework to derive the position of two parallel planes separated by twice the membrane thickness. These planes are modeled as CGO objects in PyMOL and are drawn on-the-fly during simulations. This tool can also be used in real-time during simulations with any JD2-supported Rosetta application using the same set of flags. 

## Options

The membrane pymol viewer application requires the spanfile as an input. 

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-mp:setup:spanfiles|Spanfile describing spanning topology of starting structure|String|
|-mp:setup:position_from_topo|Initialize and determine membrane position from the transmembrane spans of the protein|Boolean |
|-show_simulation_in_pymol 0|Use the PyMOL viewer to visualize membrane planes for structures|Boolean|
|-keep_pymol_simulation_history 1|optional for making movies in Pymol: keep the frame history in Pymol|Boolean|
|-packing:prepack_missing_sidechains false|Wait to repack sidechains during pdb initialization until the membrane pose is fully initialized with the membrane framework|Boolean|

## Example Command Lines
To run the view membrane protein application from generated Rosetta models, use the following command line: 

`./mp_viewer.<exe> -database /path/to/my/rosettadb @flags`


## References
1. Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol. - In Press 

2. Baugh EH, Lyskov S, Weitzner BD, Gray JJ (2011) Real-Time PyMOL Visualization for Rosetta and PyRosetta. PLoS ONE 6: e21931.

3. DeLano W (n.d.) The PyMOL Manual: Compiled Graphics Objects (CGOs) and Molscript Ribbons. Available: http://pymol.sourceforge.net/newman/user/toc.html.

## Contact

Questions and comments to: 
 - Rebecca F. Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))
