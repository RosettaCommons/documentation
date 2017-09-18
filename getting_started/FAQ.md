# FAQ
## Frequently Asked Questions

This is a list of some of the more frequently asked questions about Rosetta.

See Also:
* [[Infrequently Asked Questions]] - less commonly asked questions. 
* [Introductory Rosetta Tutorial](https://www.rosettacommons.org/demos/latest/Home#tutorials) - a good place to learn Rosetta
* [[Glossary]] - short definitions of Rosetta-related terms.
* [[RosettaEncyclopedia]] - longer form explanations of Rosetta-related concepts. 

[[_TOC_]]

#### How can I get a Rosetta software license?

Rosetta is available to academic and commercial researchers through a license. Academic licenses are free. Please see <https://www.rosettacommons.org/software/license-and-download> for licensing and download Rosetta.

#### Does the Rosetta software come as pre-compiled executables, or source code, in which language?

We distribute source code in C++ and users need to compile it themselves.

#### What's the minimum and recommended hardware settings for Rosetta software?

Rosetta requires a Unix-like operating system like Linux or MacOS - it will not easily run on a Windows machine.

To get the sampling needed for most Rosetta protocols, it's best to run Rosetta on a multiprocessor computing cluster. Most Rosetta protocols are trivially parallelizable, though, and can be run on a single processor, at the cost of much longer runtimes.

Most modern processors should be suitable. The one limitation you may run into is memory. We recommend at least 1G memory per CPU running Rosetta for best performance.

#### How do I compile Rosetta?

Please see the page [[Build Documentation]] or the [Installation tutorial](https://www.rosettacommons.org/demos/latest/tutorials/install_build/install_build) for instructions on how to compile and install Rosetta.

#### Where can I learn how to use Rosetta?

A good starting point will be the series of [introductory tutorials](https://www.rosettacommons.org/demos/latest/Home#tutorials).

#### What is RosettaCommons?

RosettaCommons is a collection of 40+ groups and institutions from around the world which work together to develop and support Rosetta. See <https://www.rosettacommons.org/about> for more information.


#### What is ROSIE? Robetta?

There are a number of publicly accessible servers on the web that allow researchers to run certain Rosetta protocols without installing Rosetta locally.

[Robetta](http://www.robetta.org/) is the original Rosetta web server.

[ROSIE](http://rosie.rosettacommons.org/) (the Rosetta Online Server that Includes Everyone) is a new, centralized site for Rosetta web servers, and includes a number of protocols.

Other web servers also exist.

#### What is PyRosetta?

PyRosetta is a wrapper around the C++ Rosetta libraries, allowing them to be used from user-written Python scripts. See <http://pyrosetta.org> for more details.

#### What is CSRosetta?

CSRosetta is a set of scripts and adjustments to the standard Rosetta platform which makes working with all NMR data (not just chemical shifts) easier. See <http://www.csrosetta.org> for more information.

#### What is _ab inito_ folding?

Ab initio protein folding performs task of predicting 3-D structural models for a protein molecule from its sequence information. visit our full-chain protein structure prediction server: Robetta: <http://robetta.org/>

#### What is the difference between _ab initio_ and _de novo_ modeling?

Ab initio structure prediction classically refers to structure prediction using nothing more than first-principles (i.e. physics). De Novo is a more general term that refers to the greater category of methods that do not use templates from homologous PDB structures. Since Rosetta uses fragments from existing PDB structures in order to guide the search in conjunction with energy functions, there is a semantic argument as to whether it is truly "ab initio" (although the same could be said for any statistically derived energy function). Long story short: call it what you want, but be prepared for a debate!

#### What are fragment libraries?

Fragment libraries are the pieces of experimentally determined structures that Rosetta uses to guide the search of conformational space when predicting structures using the ab initio protocol, as well as longer loop conformations in homology models.

#### How do I interpret the energies output by Rosetta?

See the [[scoring explained]] and [[analyzing results]] for more information.

#### How to cite Rosetta in papers?

There have been a large number of Rosetta papers, so finding the appropriate one to cite can be a challenge.

Generally, you want to cite the paper which presented the protocol which you are using in your paper. Often the relevant publications are listed on the documentation page for the application you used. 

You can also take a look at the [[Rosetta canon]] for major papers, and <https://www.rosettacommons.org/about/pubs> for a somewhat comprehensive list of Rosetta related publications.

#### Where is Rosetta software documentation?

The main Rosetta documentation page is at <http://www.rosettacommons.org/docs/latest/>. The contents of this website are also available in the documentation/ directory in the downloaded version of Rosetta.

We also have runnable demos of Rosetta protocols in the demos/ directory of the Rosetta demos. The text contents of these demos are available online at <http://www.rosettacommons.org/demos/latest/>.

If you're interested in modifying Rosetta to implement new protocols, you can find resources at <https://www.rosettacommons.org/dev>.

#### Why does Rosetta delete some of my residues?

Rosetta will delete residues which are missing too many backbone atoms. 
"Missing" includes those atoms which are marked with zero occupancy in the PDB.
Add the flag "-ignore_zero_occupancy false" to change this behavior.

If the backbone atoms are completely missing, use the [[loopmodel]] protocol to build in the residues.  

#### Is there somewhere I can see the Rosetta options/flags/arguments for the commands?

The documentation for each application should list most of the relevant options for that application.

The [[options overview]] should list options which affect most protocols in Rosetta.


A list of almost all of the options Rosetta recognizes is at the [[full options list]]. (Not every protocol understands every option, though.)


#### Does Rosetta support running with MPI? Or do I have to launch multiple serial jobs?


This is highly protocol dependent. There are a few protocols which take full advantage of MPI communication, and require MPI to run.
Most Rosetta protocols, though, are intrinsically serial for each output structure, but can support running under MPI by having each processor work on a single output structure. See [[MPI]] for more details.

#### How can I create a fragment file?

We highly recommend to use the Robetta server to create fragment file. <http://robetta.bakerlab.org/fragmentsubmit.jsp> It is possible to run fragment picking locally, but requires the installation of a number of dependencies and is non-trivial.

#### What is an "unrecognized residue"?

Rosetta requires a chemical specification of each residue and how they behave. By default it can recognize a fair number of the important residues, but does not understand things like ligands. See [[preparing ligands]] for details on how to get Rosetta to recognize your residue.

#### What is packing? What is design?

Packing is the process of putting sidechains onto a backbone, or optimizing the conformation of sidechains. 
Rosetta uses a set of "rotamers" (discrete sidechain conformation samples derived from experimentally determined structures) and a Metropolis Monte Carlo simulated annealing process to determine which combination of rotamers produces the lowest energy for a given backbone.

Design in Rosetta uses the same packing machinery as sidechain optimization, but instead of optimizing within the rotamers for a single amino acid, it considers rotamers for a number of different amino acid identities. 

#### The run terminates without generating any structures. Why?

See [[fixing errors]] for more information.

#### How is Rosetta reporting RMSD to the native structure when there is no native structure?

Most protocols can use the input structure as a "mock native" structure.

