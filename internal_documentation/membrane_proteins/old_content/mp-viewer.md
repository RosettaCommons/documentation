[[_TOC_]]

## Metadata

Authors: 
 - Author: Rebecca F. Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Updated: December 2014

## Citation
Rosetta Revision #57518

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Elazar A, Tiley D, Gray JJ (2015)
An integrated framework advancing membrane protein modeling and design
PLoS ONE (in preparation) 

## About
Visualizing the geometry of the membrane is an important step in analysis of membrane models. In particular, we can answer questions about interactions at different hydrophobic layers, membrane embedding, and orientation. This application enables visualization of output Rosetta models with the Rosetta PyMOL viewer. This tool uses the position of the bilayer described by the membrane framework to derive the position of two parallel planes separated by the membrane thickness. These planes are modeled as CGO objects in python and are drawn on the fly during simulations. This tool can also be used in real-time during simulations with any JD2-supported Rosetta application using the same set of flags. 

## Code and Demo
The PyMOL viewer with membranes can be used with any Rosetta application that uses the membrane framework with teh same flags. We also provide an application to explicitly view output models in the C++ code: 

Application: view_membrane_protein.<platform-exe> 

## Generating Inputs
The membrane pymol viewer application requires 1 input file: 

  1. Generating a Spanfile
  A spanfile describing transmembrane spanning regions can be generated using the OCTOPUS server (http://octopus.cbr.su.se/). This file must be converted to a Rosetta spanfile format using octopus2span.pl. Example command is given below: 

```
cd mpframework-pymol/scripts/
./octopus2span.pl octopus_pred.out > spanfile.txt
```

## Options

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-membrane_new:setup:spanfiles|Spanfile describing spanning topology of starting structure|String|
|-show_simulation_in_pymol 0|Use the PyMOL viewer to visualize membrane planes for structures|Boolean|
|-packing:prepack_missing_sidechains false|Wait to repack sidechains during pdb initialization until the membrane pose is fully initialized with the membrane framework|Boolean|

## Example Command Lines
To run this application, use the following command line: 

`./view_membrane_protein.<exe> -database /path/to/my/rosettadb @flags`

## References
1. Baugh EH, Lyskov S, Weitzner BD, Gray JJ (2011) Real-Time PyMOL Visualization for Rosetta and PyRosetta. PLoS ONE 6: e21931.

2. DeLano W (n.d.) The PyMOL Manual: Compiled Graphics Objects (CGOs) and Molscript Ribbons. Available: http://pymol.sourceforge.net/newman/user/toc.html.