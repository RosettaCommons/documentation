# About the Project

### Developers
- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Advised by Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))

### Metadata
Corresponding PI: Jeffrey Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Modified: 1/18/2013

### Motivation
Rosetta is by default, oriented for modeling soluble proteins. To date, there are few applications which use membrane scoring (Yarov-Yaravoy et al. 2006); notably membrane _ab initio_, relax, and comparative modeling. However, because Rosetta does not account for conformational aspects specific to membrane-bound proteins, it is challenging to extend and develop new modeling protocols that can account for these differences. 

The goal of the new RosettaMembrane is to provide a generalized framework for modeling the conformational and chemical characteristics of membrane proteins. By providing a more accurate representation of membrane protein conformation, we hope to provide a new platform for improved development of membrane-adapted Rosetta modeling protocols. Furthermore, by adapting the existing protocols to Rosetta 3 and designing an object-oriented framework, we hope that the design promotes evolvability within the Rosetta libraries. 

This documentation describes the current progress in development of the membrane protein framework, coding conventions/guidelines, current tasks, and future tasks. In essence, this should serve as the developer's guide to using and developing RosettaMembrane Framework based protocols. 

### Design Objectives
* Centralized development for membrane proteins
* Fully object-oriented code base (Rosetta3)
* Support for multiple membrane chains
* Support for hybrid systems - some membrane and some non-membrane chains
* User intuitive application development and API
* Effective representation of membrane protein conformation and scoring integration
* Resource manager supported, jD2 supported
* Can easily extend to additional features: symmetry, ligand-docking, protein-protein docking

### Software Tasks (Still TODO)
1. Load membrane proteins as starting structure with JD2
2. Test with PyRosetta

### Code and Demo
The code for implementing membrane proteins lives in src/core/membrane. Integration tests and maybe a demo coming soon. 

### Tools
Tools for setting up larger runs and configuring JD2 jobs with the membrane framework can be found in Rosetta/tools/membrane_tools

### Legacy Code
Previous implementations of membrane proteins in Rosetta can be accessed by supplying the membrane weights on the command line using -score::weights membrane_highres.wts with membrane ab initio flags (see Rosetta 3.5 manual)

# Conventions for Framework Development
To improve the development of protocols using the membrane framework, I am including some development guidelines that should help inform the community about important design choices and ways to maintain them. 

Rosetta also has its own set of coding conventions which can be found here: [RosettaCommons Coding Conventions](https://wiki.rosettacommons.org/index.php/Coding_conventions)

### Stylistic Additions
In addition to the community conventions established, there are few requirements to make documentation and style in the membrane code consistent and readable: 
* **Required** Header Doxygen Tags: @file, @brief, @details, @note MembraneCode, and @author 
* Only #include MembraneProteinFactory, MembraneConformation, and anything in core/membrane/properties. If you are including anything else in the core/membrane namespace, you are probably not using the code correctly
* Class definitions **must** contain custom copy constructor definitions. 
* _all_ classes must be unit tested. This entire code base was rigorously unit tested to ensure that your code could be correctly unit tested so respect the community and write the test :)

### Extending Membrane Proteins
The definition of a membrane protein is defined and maintained by the construction of a membrane pose in the Membrane Protein Factory. With this in mind, to ensure proper use of the code: 
* Only create membrane poses with the Membrane Protein Factory
* If you need to further extend the definition of a membrane protein, **subclass or extend** the MembraneProteinFactory class and override the create_membrane_pose method as such: 

```
core::pose::PoseOP
create_membrane_pose() {
     super::build_pose()

     // your additional code here
```

### Calling the Framework
Currently, the membrane protein framework overrides the prose provided by JD2. Membrane protocols should be called within a generic membrane mover template which generates a membrane protein and treats it as the starting structure. Syntax below: 

```
MembraneProteinFactoryOP mpf = new MembraneProteinFactory( fullatom, membrane_chains, include_lips );
PoseOP pose = mpf->create_membrane_pose();
protocol->apply(pose);
```

### Resources and Options
Because the membrane framework is resource intensive - meaning the code must carry around several objects to construct and use membrane proteins, our code uses the [Resource Manager](https://wiki.rosettacommons.org/index.php/Projects:ResourceManager). If your membrane framework code requires an additional object, use the resource manager - **do not load statically using the options system**.

To add framework options, you can either add the option to the MembraneProteinOptions class in core/membrane or add to the membrane namespace in the current options system.  

# Using Membrane Framework Protocols
While framework supported protocols are still in development, below is a set of instructions for interfacing with the code to help out development. 

The input system is designed to allow for a few important features: 
* processing both membrane and non membrane chains


### Required Inputs
The membrane protein framework views a membrane protein as either spanning the membrane or embedded at a given depth in the membrane. For each pdb, you will need a (1) OCTOPUS span file (if spanning), (2) Lipophobicity Data file and (3) an Embedding Definition file. All required parsing scripts are located in `Rosetta/tools/membrane_tools`
### OCTOPUS File
To generate a spanfile, go to [OCTOPUS](http://octopus.cbr.su.se/) and generate a topology file from the FASTA sequence. Below is an example format of the resulting file:

```
#####################################################################
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
ooo
```
After this file is generated, convert the file to a .span file using the script octopus2span.pl in src/apps/public/membrane Example usage of this script is below:

```
./octopus2span.pl BRD4.oct > BRD4.span
```

### Lipophobicity Data
To generate a lipid accessibility, use the run_lips.pl script provided in src/apps/public/membrane. This script requires the NCBI blast toolkit which includes the blastpgp executable, the nr database, and a spanfile generated as described above, as well as the alignblast.pl script which is also located in src/apps/public/membrane.
Below is example usage of the script:

```
./make_lips.pl <myfasta.txt> <mytopo.span> /path/to/blastpgp /path/to/nr alignblast.pl
```

### Embedding Definition
In the membrane protein framework, _each chain_ of a pose gets a specific membrane protein embedding definition with respect to the implicitly defined membrane. You will need to specify a membrane protein embedding definition file (embeddef) for each chain input. Below are instructions for setting up this file. 

An embedding definition file specifies three components: **normal** coordinates, **center** coordinates, and **depth** of chain for non-spanning. There are four tags that you can use to specify what happens to these coordinates: 
* **topology** - Calculates normal and center from membrane spanning topology using specified xyz as final
* **define** - Accepts specified coordinates as final coordinates
* **override_pdb** - Uses a default setting of (0,0,0) for center and (0,0,1) for normal which overrides whatever coordinates were specified
* **search** - Search for parameter using membrane MCM search method. You can specify a nice string of options for this in your job file however these options will be IGNORED if you do not use the search tag for the correct parameters in the embedding definition.

Depth is a parameter that specifies a chain's depth in the membrane if it is not spanning. If spanning, depth should be specified at 0 otherwise depth can be greater than 0. If a depth is non-zero, Rosetta will **not** treat the chain as a spanning pose.  

```
POSE <Description>
normal        x y z  <tag>
center        x y z  <tag>
depth         <value>
```

### Setting Up a Job
The flexibility of the membrane protein framework is designed to work synchronously with the resource manager. For more about setting up resource description files, please refer to [Resource Manager Documentation](https://wiki.rosettacommons.org/index.php/Projects:ResourceManager). The job script can be setup using the script `write_mp_xml.py` in Rosetta/tools/membrane_tools.

Below is an example Resource Definition file for a pose with 3 chains and a membrane chain. The first chain (A) accepts the topology-based protein embedding and the second (B) searches for normal and center.  

```
<JD2ResourceManagerJobInputter>
       <! Locators for Membrane Resources >
       <ResourceLocators>
               <FileSystemResourceLocator tag="spanning_locator" base_path="/path/to/input/spanning_locator"/>
               <FileSystemResourceLocator tag="embedding_locator" base_path="/path/to/input/embedding_defs"/>
               <FileSystemResourceLocator tag="startstruct_locator base_path="/path/to/input/pdbs"/>
               <FileSystemResourceLocator tag="lipsexp_locator" base_path="/path/to/input/lips_exp"/>
       </ResourceLocators>

       <! Options for Resources >
       <ResourceOptions>
              <EmbedSearchParamOptions tag="embedB_options"
                  normal_search="true"
                  normal_start_angle="10"
                  normal_max_angle="10"
                  normal_delta_angle="10"
                  center_search="true"
                  center_max_delta="10"
               />

              <PoseFromPDBOptions 
                  tag="pdb1"
                  ignore_unrecognized_res=1
               />
       </ResourceOptions>
       
       <! Specifying the Actual Resources with their Options >
       <Resources>
            
           <Group 1 - Chain A (from topology)>
           <PoseFromPDB tag="BRD4_A" locator_tag="startstruct_locator" locatorID="BRD4_A.pdb" resource_options="pdb1">
           <EmbedConfig tag="BRD4_embedA" locator_tag="embedding_locator" locatorID="BRD4_A.embed">
           <SpanFile tag="BRD4_spanA" locator_tag="spanning_locator" locatorID="BRD4_A.span">
           <LipoFile tag="BRD4_lipsA" locator_tag="lipsexp_locator"  locatorID="BRD4_A.lips">
      
           <Group 2 - Chain B (from search)>
           <PoseFromPDB tag="BRD4_B" locator_tag="startstruct_locator" locatorID="BRD4_B.pdb"
           <EmbedConfig tag="BRD4_embedB" locator_tag="embedding_locator" locatorID="BRD4_B.embed" resource_options="embedB_options">
           <SpanFile tag="BRD4_spanB" locator_tag="spanning_locator" locatorID="BRD4_B.span">
           <LipoFile tag="BRD4_lipsB" locator_tag="lipsexp_locator"  locatorID="BRD4_B.lips">

       </Resources>

       <! Map resource tags to resource descriptions > 
       <Jobs> 
           <Job name="BRD4">
                  <Data desc="BRD4_A" resource_tag="BRD4_A"/>
                  <Data desc="BRD4_embedA" resource_tag="BRD4_embedA" />
                  <Data desc="BRD4_spanA"  resource_tag="BRD4_spanA" />
                  <Data desc="BRD4_lipsA"  resource_tag="BRD4_lipsA" />

                  <Data desc="BRD4_B" resource_tag="BRD4_B"/>
                  <Data desc="BRD4_embedB" resource_tag="BRD4_embedB" />
                  <Data desc="BRD4_spanB"  resource_tag="BRD4_spanB" />
                  <Data desc="BRD4_lipsB"  resource_tag="BRD4_lipsB" />

            </Job>
       </Jobs>
</JD2ResourceManagerJobInputter>
```


# Options for Membrane Scoring Function
### Scoring Options
|**Flag**|**Description**|**Type**|
|---|---|---|
|Menv_penalties|Membrane environment penalties imposed during scoring (see ref [1])|Boolean|
|no_interpolate_Mpair|Turn off interpolation between 2 membrane layers if using Mpair term|Boolean|
|Mhbond_depth|Update for fullatom scoring|Boolean|
|Fa_Membed_update|Update for fullatom scoring|Boolean|

### Membrane Scoring Terms
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

# Running a Job
To run a protocol, specify your normal executables and flags along with a membrane resource definition file.
```
./my_app.macosclangrelease @flags -database /path/to/rosetta/database -resorce_definition_files membrane.xml -in:file:membrane_chains chains.txt
```

# References
* Barth P, Wallner B, Baker D. (2009 Feb 3) Prediciton of membrane protein structures with complex topologies using limited constraints. Proc Natl Acad Sci U S A. 106(5):1409-14.
* Barth P, Schonbrun J, Baker D. (2007 Oct 2) Toward high-resolution prediction and design of transmembrane helical protein structures. Proc Natl Acad Sci U S A. 104(40):15682-7.
* Yarov-Yarovoy V, Schonbrun J, Baker D. (2006 Mar 1) Multipass membrane protein structure prediction using Rosetta. Proteins. 62(4):1010-25.