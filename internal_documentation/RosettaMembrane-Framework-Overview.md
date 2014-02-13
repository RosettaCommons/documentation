## Developer Info

### Authors/Developers
- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Advised by Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))

### Metadata
Corresponding PI: Jeffrey Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Modified: 2/12/2013

## About
By default, much of Rosetta is oriented for modeling membrane proteins. In previous, there have been a few applications that use the membrane scoring function (Yarov-Yaravoy et al. 2006); membrane _ab initio_, relax, and comparative modeling. However, many of these protocols do not provide a generalizable approach to modeling membrane protein conformation and kinematics. This creates significant barriers to further developing protocols for modeling membrane proteins in Rosetta. 

The **RosettaMembrane Framework** provides a generalized framework for modeling membrane proteins. The framework is not an application; but provides the necessary components for modeling membrane protein conformation, topology, embedding, and kinematics. The framework also handles the large amounts of required data via the Resource manager and Below is an overall landscape of the membrane protein framework: 

[[/internal_documentation/basic_structure_mpframework.png]]

The framework is a developer tool. Each page below details its components, guidelines on development and use, and how to get the most out of the framework: 

**Framework Development**
- [[internal_documentation/Official RosettaMembrane Framework Project Page]]
- [[RosettaMembrane: Coding Conventions and Testing]]
- [[RosettaMembrane: Configuring Required Inputs]]
- [[Scripts and Tools]]

**Framework Components**
- [[Resource Management and Options]]
- [[Membrane Residue Types]]
- [[Membrane Embedding Definitions]]
- [[Membrane Conformation]]
- [[Top Level Membrane Protein Factory]]

## Code and Demo
The code for implementing membrane proteins lives in `src/core/membrane`. Unit tests live in both `test/core/membrane` and `test/protocols/membrane`. Integration test application `mpframework_integration`

## Legacy Code
Previous implementations of membrane proteins in Rosetta can be accessed by supplying the membrane weights on the command line using -score::weights membrane_highres.wts with membrane ab initio flags (see Rosetta 3.5 manual)

## References
* Barth P, Wallner B, Baker D. (2009 Feb 3) Prediciton of membrane protein structures with complex topologies using limited constraints. Proc Natl Acad Sci U S A. 106(5):1409-14.
* Barth P, Schonbrun J, Baker D. (2007 Oct 2) Toward high-resolution prediction and design of transmembrane helical protein structures. Proc Natl Acad Sci U S A. 104(40):15682-7.
* Yarov-Yarovoy V, Schonbrun J, Baker D. (2006 Mar 1) Multipass membrane protein structure prediction using Rosetta. Proteins. 62(4):1010-25.
