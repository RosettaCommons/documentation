[[_TOC_]]

## Metadata

Authors: 
 - Author: Rebecca F. Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Updated: December 2014

## Citation
Rosetta Revision #57514

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Elazar A, Tiley D, Gray JJ (2015)
An integrated framework advancing membrane protein modeling and design
PLoS ONE (in preparation) 

## About
Measuring free energy changes upon mutation can inform our understanding of membrane protein stability and variation and is a step toward design. In this application, we measure the difference in Rosetta energy by scoring the native and mutated proteins to compute the ddG upon mutation. This application uses the all atom energy function for membrane proteins in Rosetta with the membrane framework. 

In this protocol capture, we compute the ddG upon mutation for mutations in OmpLA described in Moon & Fleming, 2011. For each mutation, the alanine at position 181, located at the mid-plane of the membrane bilayer, is mutated to all 19 canonical amino acids. The application prints each ddG as output. This PyRosetta can also be easily adapted to compute ddG for other mutations by changing the input protein and list of mutations.

## Code and Demo
The membrane ddG application is implemented as a python script in PyRosetta. An example script lives in the Rosetta/demos/protocol_captures/2014/mpframework-ddG directory called compute_ompLA_ddG.py

## Example Command Lines
To run the membrane ddG script for this example case, run the python script (no arguments)

./compute_ompLA_ddG.py

## References
1. Chaudhury S, Lyskov S, Gray JJ (2010) PyRosetta: a script-based interface for implementing molecular modeling algorithms using Rosetta.

2.  Moon CP, Fleming KG (2011) Side-chain hydrophobicity scale derived from transmembrane protein folding into lipid bilayers. Proc Natl Acad Sci. 