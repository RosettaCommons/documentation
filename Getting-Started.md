***
Getting started
===========

This page is written for an audience of scientists new to Rosetta: perhaps a first year graduate student, or young postdoc, who has received/started a project that needs "some computer modeling". 
In other words, an individual coming to Rosetta from a cold start.
Is Rosetta a good tool for the modeling you need to do? If so, how do you go about getting and using Rosetta?

Rosetta is a very large software suite for macromolecular modeling. 
By software suite, we mean that it is a large collection of computer code (mostly in C++, some in Python, a little in other languages), but it is not a single monolithic program.
By macromolecular modeling, we mean the process of evaluating and ranking the physical plausibility of different structures of biological macromolecules (usually protein, but nucleic acids and ligands are significantly supported and support for implicit lipid membranes is growing). 
Generally, a user will choose some specific protocol within Rosetta and provide that protocol with inputs for A) what structure to work on, and B) what options within the protocol are appropriate for the user's needs.


<map name="GraffleExport">
	<area shape=rect coords="330,305,421,376" href="http://localhost:4567/Getting-Started#do-i-have-what-i-need">
	<area shape=rect coords="226,305,317,376" href="http://localhost:4567/Getting-Started#do-i-have-what-i-need">
	<area shape=rect coords="122,305,213,376" href="http://localhost:4567/Getting-Started#do-i-have-what-i-need">
	<area shape=rect coords="377,166,532,253" href="http://localhost:4567/Getting-Started#do-i-have-what-i-need">
	<area shape=rect coords="11,166,166,253" href="http://localhost:4567/Getting-Started#do-i-have-what-i-need">
	<area shape=rect coords="189,11,354,97" href="http://localhost:4567/Getting-Started#do-i-have-what-i-need">
</map>
[[/uploads/cold_start_diagram.graffle | usemap="#GraffleExport"]]



Do I have what I need?
-----------------
Doing macromolecular modeling well—doing good science—requires careful consideration of your inputs, how the modeling is performed, and analysis of your outputs.
Rosetta itself can be operated as a ["black box"](https://en.wikipedia.org/wiki/Black_box), but you are doing yourself and your science a disservice if you use it that way.

1) Inputs to Rosetta

The major input to Rosetta is the input structure.
Generally, if you have a high-resolution structure(s) (better than 2 Å) of your molecule, it can be used with Rosetta with minimal remediation LINKY LINKY.
If you have a poorer-resolution structure, an NMR structure, a homology model, or no structure at all, then LINKY LINKY LINKY you must carefully consider how to prepare your structure for modeling and how this restricts the conclusions you may draw.

2) Choosing the Rosetta protocol

The other input is the choice of [[which Rosetta protocol|Solving-a-Biological-Problem]] to use and what options to choose.

3) Interpreting outputs

Something about data analysis

***

[[/uploads/cold_start_diagram.graffle]]