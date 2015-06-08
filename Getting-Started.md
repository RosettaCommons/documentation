This page is written for an audience of scientists new to Rosetta: perhaps a first year graduate student, or young postdoc, who has received/started a project that needs "some computer modeling".  
Is Rosetta a good tool for the modeling you need to do?  If so, how do you go about getting and using Rosetta?

Rosetta is a very large software suite for macromolecular modeling.  
By software suite, we mean that it is a large collection of computer code (mostly in C++, some in Python, a little in other languages), but it is not a single monolithic program.  
By macromolecular modeling, we mean the process of evaluating and ranking the physical plausibility of different structures of biological macromolecules (usually protein, but nucleic acids and ligands are significantly supported and support for implicit lipid membranes is growing).
Generally, a user will choose some specific protocol within Rosetta and provide that protocol with inputs for A) what structure to work on, and B) what options within the protocol are appropriate for the user's needs.
