## Developers

The membrane framework code was developed by Rebecca Alford and Julia Koehler Leman at the Gray Lab at JHU. This documentation was last updated 9/16/14. 

For questions & Inquiries, contact: 
- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

## About

A bunch of scrambled text below. Main points to cover: 
 - Why add the membrane? What membrane rosetta does that regular rosetta does not
 - Brief history of membrane code (giving all-important credit to Vladimir & Patrick)

"Modeling membrane proteins in Rosetta is guided by the Rosetta Membrane Framework. This framework provides a general representation of the membrane along with scoring functions and adapted sampling techniques to model proteins in the membrane bilayer. 

Much of Rosetta is designed for modeling proteins in solution. However, there is a growing need for computational methods that model proteins in the membrane bilayer. In 2006 and 2007, Yarov et al. and Barth et al. implemented a low- and high-resolution scoring function and method for _de novo_ folding of membrane proteins. "

(include a cool picture of a membrane protein!)

## Representation of the Membrane Bilayer (include images reminiscent of the tile images)
 - Topology
 - Lipophilicity
 - membrane position
 - FoldTree

## Membrane Scoring Functions

Describe 2 scoring functions for membranes, developed by xx and yy. Low res can be turned on using the cen_membrane_2014 weights and highres turned on using the fa_membrane_2014 weights. To learn more about scoring terms for each scoring function, visit the following pages: 
 - [[Low Resolution Membrane Scoring Terms]] (include 'tile' style image descriptions & equations)
 - [[High Resolution Membrane Scoring Terms]] (include 'tile' style image descriptions & equations)

## Membrane Sampling Moves 

Brief introduction to importance of membrane-aware sampling, what that means, why you want to do it 

 - Set membrane position
 - Derive membrane position from structural topology
 - Optimize membrane position based on scoring function
 - Minimizing the membrane jump 

## Useful Scripts & Tools

Describe structure of Rosetta/tools/membrane_tools (what's in there? why would I use it?/what context?)

## Links to Previous Membrane Implementations

From previous membrane framework page: 
"Previous implementations of membrane proteins in Rosetta can be accessed by supplying the membrane weights on the command line using -score::weights membrane_highres.wts with membrane ab initio flags (see Rosetta 3.5 manual)
"
Something more descriptive, preferably with actual links
 - Membrane ab initio protocol

## References

* Barth P, Wallner B, Baker D. (2009 Feb 3) Prediction of membrane protein structures with complex topologies using limited constraints. Proc Natl Acad Sci U S A. 106(5):1409-14.
* Barth P, Schonbrun J, Baker D. (2007 Oct 2) Toward high-resolution prediction and design of transmembrane helical protein structures. Proc Natl Acad Sci U S A. 104(40):15682-7.
* Yarov-Yarovoy V, Schonbrun J, Baker D. (2006 Mar 1) Multipass membrane protein structure prediction using Rosetta. Proteins. 62(4):1010-25.
