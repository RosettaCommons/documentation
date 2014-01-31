The **doxygen** MembraneHub page describes the architecture and design. The wiki page describes the implemented of the components and guides/new community standards for adding on to the membrane code.

Wiki page todo: add images

# About the Project

### Developers
- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))

### Metadata
Corresponding PI: Jeffrey Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Modified: 8/4/2013

### Motivation
Rosetta is by default optimized for soluble proteins and most scientific benchmarking efforts excludes membrane-bound proteins. Therefore, default scoring, sampling and mover-methods are not aware of restraints or parameters that would be critical towards modeling membrane proteins in Rosetta. 

In 2006, the first efforts to implement membrane proteins in Rosetta was documented with the addition of a protocol for _ab initio_ modeling of membrane proteins by Vladmir Yarov-Yaravoy et al. Consequently, Rosetta does have methods for scoring membrane proteins (Membrane Layer-Based Scoring function), searching for membrane embedding, and recognizing topology. However, because the code is not object oriented, these can only be accessed internally within membrane scoring and can therefore not be integrated with other scoring functions such as docking.This code is particularly difficult to use as it is old Rosetta++ code meaning not object-oriented. There is also support for a membrane topology broker, however this is also highly intertwined with _ab initio_ methods making it difficult for developers to build protocols with this functionality. 

The current setup of the membrane code also means that users are often creating various new wrapper applications to support membrane proteins, decentralizing development for membrane proteins in Rosetta entirely.

The goal of this project is to develop a new framework for membrane proteins such that any protocol can support these scoring, mover, and sampling methods and users can intuitively specify a membrane protein from the command line. 

### Design Objectives
* Centralized development for membrane proteins
* Membrane code/methods have a home in core (more intuitive for developers)
* Fully object-oriented code (port to Rosetta3)
* User intuitive way to indicate a membrane protein: -in:membrane flag?
* Central implicit membrane for multiple poses (to support protein-protein docking, ligand docking, symmetry, etc)
* Supports new resource manager/jd2 so future developments of Rosetta will not impact this new core code

### Software Tasks (Still TODO)
1. Support the resource manager
2. Support Jd2
3. Add geometry data to pose cache
4. Mode membrane scoring methods to core/membrane with base class EnvPairPotential
5. Improve central membrane hub interface

### Code and Demo
The code for implementing membrane proteins lives in src/core/membrane and is functionality handled by the job distributor. For any given job, membrane protein functionality can be invoked using the -in:membrane flag. Demo coming soon.

### Supported Applications
The membrane code is implemented with jd2 (job distributor) so any application can work with membrane proteins. However, be wary to read a specific protocol’s documentation as to if the protocol specifically supports or is benchmarked with membrane proteins. If this is the case, Rosetta will throw a warning in the output log.

# Developer Guidelines
As Rosetta transitions to an object-oriented model, it was important to redesign the code from its original fortran port to C++ so that it could itnerface well with other Rosetta applications. The membrane code is wrapped with a single main hub that communicates with several other subclasses to initialize membrane-related data, scoring functions, and any mover configurations specific to using a protocol with a membrane protein. The membrane code is supported by jd2 and can be invoked with the -in:membrane command line flag.

The membrane code is designed to be flexible and portable, so when making developments for applications using membrane proteins, keep this new infrastructure in mind as it will significantly help with streamlining many of these developments. Also, be wary to follow the coding conventions for developing membrane code described below.

### Organization and Design
_The Hub_

The membrane hub is the main interface between code for membrane proteins in Rosetta and JD2, acting as a central communicator and organizational hub for membrane developments in Rosetta. The membrane hub is designed central to the concept of a mover - requiring a mover, pose, and protocol-type for initialization. Once called, the membrane hub will create 2 manager classes, an object manager class and protocol manager class which will manage membrane objects and protocol-specific configurations.

_The Object Manager_

The object manager is designed to initialize data that will eventually be added to the pose’s data cache used in scoring, sampling, and moves. This includes data such as membrane protein embedding, topology, and a coordinate system for an implicit membrane. The object manager requires the pose.

_The Protocol Manager_

The protocol manager is designed to manage a library of configuration functions that will make adjustments to the mover class setup and apply function  before apply is called by jd2 that is specific to the membrane and that particular protocol. The protocol manager takes a mover and modifies the setup of the mover as defined by the protocol writer. 

### Coding Conventions
Below are some specific notes on do’s and don’ts of using this new code:

_Organization_

All code added must respect the existing directory structure in core/membrane. For protocol modifications that are membrane-specific and called by the membrane code, make a new directory called protocols/my_protocol/membrane.

_Unit Tests_

Unit testing in Rosetta is always highly encouraged, however it is critical to continue to add good unit tests to the membrane code (specifically code in core) as untested code weakens the strength of the existing rigorous tests. Please, I beg you, write unit tests.

_JD2 Support_

The membrane code gets called from JD2 given a -in::membrane flag. You should never call the membrane hub internally from a protocol as this will lead to double-calculations which without -run:constant_seed could lead to problems and discrepancies in calculations. 

_Resource Manager vs. Options System_

The membrane code uses the resource manager as it provides a more efficient and optimal method for storing memory-intensive resources for a given job. New options must be resource manager supported and have an options system fallback configuration. 

_Membrane Types_

The directory, src/core/membrane/util there is a types.hh which defines generic data structures for scoring membrane data. If you are declaring a new membrane data type, store it there and add the correct initialization, deep copy, and reset utility functions to the types_util file and of course correct unit tests. 

_DataCache_

The only data stored in the pose is the topology and embedding info. All other data is handled by the resource manager. When using this data, be aware that some applications in protocols tend to clear the pose as are still optimized for ab initio. Working on a quick fix for this but it may be easier to modify the existing protocol to make a new pose and store the current one and then copy over relevant data.

_Interface/Implementation_

For full details, see API documentation in Doxygen. 

# Interface and Using the Code
Rosetta supports membrane proteins by adding additional steps to scoring and the conformation of the structure before passing the structure to the protocol. For scoring, Rosetta will add membrane scoring terms and penalties, as well as employing a membrane weights set. if a protocol is not listed under ‘benchmarked applications’ there is not likely an optimal weight set being used.  For conformation, Rosetta will store information about the structure’s topology and membrane embedding which is used in scoring and protocols.

### Running
To run Rosetta with a membrane protein, first generate the two mandatory input files - the spanning file and lipid accessibility file - with the scripts provided in src/apps/public/membrane (see below). Then, add the -in::membrane flag and specify the required inputs below. If you run with -in::membrane without required inputs, Rosetta will exit and return an error message. Below is an example generic command line:

`./my_app.macosgccrelease -database $db -in:file:: 1afo.pdb -in::membrane -in::file::fullatom -in::file::spanfile 1afo.span -in::file::lipofile 1afo.lips`

### Modes
Rosetta will allow loading in a membrane protein with various “mode” options that will control how the structure is loaded and scored during a protocol which are described below. Each of these modes has a corresponding flag that is listed in the option descriptions below.
* **-default**: Rosetta will apply scoring, conformation, and protocol-specific information if available while applying all of the default settings
* **-score_only**: Rosetta will not apply conformation-specific information to the input structure(s)
* **-conf_only**: Rosetta will not use membrane scoring methods, weights, or penalties in scoring structures during a protocol
* **-manage_protocols**: Rosetta will not use protocol specific changes for membrane proteins if availbe and use all of the default settings for the protocol (unless specified otherwise with a different set of flags)
* **-dev_mode**: This mode is for developers only and will allow the user to make internal tweaks to protocols, scoring and conformation info related to membrane proteins. This also allows changing advanced settings or settings that are untested or have not been benchmarked. Use this with caution!

### Generating Required Inputs
To generate a spanfile, go to http://octopus.cbr.su.se/ and generate a topology file from the FASTA sequence. Below is an example format of the resulting topology file:

`#####################################################################
OCTOPUS result file
Generated from http://octopus.cbr.su.se/ at 2008-09-18 21:06:32
Total request time: 6.69 seconds.
#####################################################################

Sequence name: BRD4
Sequence length: 123 aa.
Sequence:
PIYWARYADWLFTTPLLLLDLALLVDADQGTILALVGADGIMIGTGLVGALTKVYSYRFV
WWAISTAAMLYILYVLFFGFTSKAESMRPEVASTFKVLRNVTVVLWSAYPVVWLIGSEGA
GIV

OCTOPUS predicted topology:
oooooMMMMMMMMMMMMMMMMMMMMMiiiiMMMMMMMMMMMMMMMMMMMMMooooooMMM
MMMMMMMMMMMMMMMMMMiiiiiiiiiiiiiiiiiiiiiMMMMMMMMMMMMMMMMMMMMM
ooo`

After this file is generated, convert the file to a .span file using the script octopus2span.pl in src/apps/public/membrane Example usage of this script is below:

`./octopus2span.pl mytopo.oct > mytopo.span`

To generate a lipid accessibility, use the run_lips.pl script provided in src/apps/public/membrane. This script requires the NCBI blast toolkit which includes the blastpgp executable, the nr database, and a spanfile generated as described above, as well as the alignblast.pl script which is also located in src/apps/public/membrane.
Below is example usage of the script:

`./run_lips.pl <myfasta.txt> <mytopo.span> /path/to/blastpgp /path/to/nr alignblast.pl`

# Options
### General Options
|**Flag**|**Description**|**Type**|
|---|---|---|
|-in:membrane|Turns on support for a membrane protocol|Boolean|
|--in:file:spanfile|Reads in a membrane topology spanning file|File Path|
|-in:file:lipofile|Reads in a membrane lipid accessibility file|File Path|
|-default_only|Uses a pre-defined set of defaults – ignores adjustment flags|Boolean|
|-score_only|Applies scoring only (mutes conformation info)|Boolean|
|-conf_only|Applies conformation info only (mutes scoring)|Boolean|
|-dev_mode|This mode is for benchmarking – allows parameter tuning and under the hood development|Boolean|
|-manage_protocols|Apply protocol specific changes in Rosetta. Default true, if false uses conf and scoring but otherwise regular protocol settings|Boolean|

### Membrane Embedding Definition Options
|**Flag**|**Description**|**Type**|
|---|---|---|
|-embed_def:center|Set membrane Center|Real Vector|
|-embed_def:normal|Set membrane normal|Real Vector|
|-embed_def:depth|Set membrane depth|Real|

### Membrane Embedding Search Options
|**Flag**|**Description**|**Type**|
|---|---|---|
|-embed_search:center_search|Use discrete search for membrane center|Boolean|
|-embed_search:center_max_delta|Maximum membrane width deviation during center search (Angstroms)|Integer|
|-embed_search:normal_search|Use discrete search for membrane normal|Boolean|
|-embed_search:normal_start_angle|Magnitude of starting angle during normal search (degrees)|Integer|
|-embed_search:normal_max_angle|Magnitude of angle deviation during normal search (degrees)|Integer|
|-embed_search:normal_delta_angle|Maximum angle deviation allowed during search|Integer|

### Scoring Options
|**Flag**|**Description**|**Type**|
|---|---|---|
|Menv_penalties|Membrane environment penalties imposed during scoring (see ref [1])|Boolean|
|no_interpolate_Mpair|Turn off interpolation between 2 membrane layers if using Mpair term|Boolean|
|Mhbond_depth|Update for fullatom scoring|Boolean|
|Fa_Membed_update|Update for fullatom scoring|Boolean|

# Membrane Scoring Terms
The descriptions below come directly from Vladmir Yarov-Yaravoy’s documentation for the membrane ab initio application:

|**Score**|**Description**|
|---|---|---|
|Mpair|membrane pairwise residue interaction energy|
|Menv|membrane residue environment energy|
|Mcbeta|membrane residue centroid density energy|
|Mlipo|membrane residue lipophilicity energy|
|Menv_hbond|membrane non-helical secondary structure in the hydrophobic layer penalty|
|Menv_termini|membrane N- and C- termini residue in the hydrophobic layer penalty|
|Menv_tm_proj|transmembrane helix projection penalty|

# Legacy Code
Previous implementations of membrane proteins in Rosetta can be accessed by supplying the membrane weights on the command line using -score::weights membrane_highres.wts with membrane ab initio flags (see Rosetta 3.5 manual)

# References
* Barth P, Wallner B, Baker D. (2009 Feb 3) Prediciton of membrane protein structures with complex topologies using limited constraints. Proc Natl Acad Sci U S A. 106(5):1409-14.
* Barth P, Schonbrun J, Baker D. (2007 Oct 2) Toward high-resolution prediction and design of transmembrane helical protein structures. Proc Natl Acad Sci U S A. 104(40):15682-7.
* Yarov-Yarovoy V, Schonbrun J, Baker D. (2006 Mar 1) Multipass membrane protein structure prediction using Rosetta. Proteins. 62(4):1010-25.
