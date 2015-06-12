# RosettaMembrane Framework Overview

## Developer Info

### Authors/Developers
- Rebecca Faye Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))

### Metadata
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Modified: 8/6/2013

## About
Rosetta is largely designed for use with proteins in solution. However, as the number of unique membrane protein structures in the PDB grows, there is a great need for new computational methods for modeling and refining proteins in membranes. The **RosettaMembrane Framework** provides a generalized toolkit for modeling membrane proteins in Rosetta. The framework implements a core representation of a membrane protein in the conformation, kinematic, and energy layers. These representations can be easily accessed at the protocols level through the mover interface. 

The membrane framework is implemented in C++, but is also compatible with the Resource Manager, PyRosetta, and RosettaScripts Interfaces.

This is the homepage for membrane framework documentation (and any derivative applications (for now)). Please feel free to email the authors above with any questions. 

## Main Source Code 
The main membrane framework code lives in `core/conformation/membrane` and `protocols/membrane.` All of the code has corresponding sets of unit and integration tests. 

To use the membrane framework in your protocols, include the `AddmembraneMover` at the top of your code. Syntax/example code is shown below: 

```
#include <protocols/membrane/AddMembraneMover.hh> 

using namespace protocols::membrane;

AddMembraneMoverOP add_memb = new AddMembraneMover(); 
add_memb->apply( pose ); 

```

## Demos
Demos are coming soon! These will live in the RosettaCommons/demos repository under protocol_capture/2014

## Subpages
Below you can find more information on the membrane framework: 

- [[RosettaMembrane: Using the Membrane Framework]]
- [[RosettaMembrane: Configuring Required Inputs]]
- [[RosettaMembrane Low Resolution Energy Function]]
- [[RosettaMembrane High Resolution Energy Function]]
- [[RosettaMembrane: Scripts and Tools]]
- [[RosettaMembrane: How it Works]]

## Legacy Code
Previous implementations of membrane proteins in Rosetta can be accessed by supplying the membrane weights on the command line using -score::weights membrane_highres.wts with membrane ab initio flags (see Rosetta 3.5 manual)

## References
* Barth P, Wallner B, Baker D. (2009 Feb 3) Prediciton of membrane protein structures with complex topologies using limited constraints. Proc Natl Acad Sci U S A. 106(5):1409-14.
* Barth P, Schonbrun J, Baker D. (2007 Oct 2) Toward high-resolution prediction and design of transmembrane helical protein structures. Proc Natl Acad Sci U S A. 104(40):15682-7.
* Yarov-Yarovoy V, Schonbrun J, Baker D. (2006 Mar 1) Multipass membrane protein structure prediction using Rosetta. Proteins. 62(4):1010-25.