# About the Project

### Developers
- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))

### Metadata
Corresponding PI: Jeffrey Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Modified: 09/20/2013

### About
The membrane protein framework in Rosetta is designed to be flexible and support various protocols. As a result, there is a generic system for inputs that will enable greatest flexibility, extensibility, and reuse. Below is instructions for setting up a job using membrane proteins. 

# Required Inputs
The membrane protein framework views a membrane protein as either spanning the membrane or embedded at a given depth in the membrane. For each pdb, you will need a (1) OCTOPUS span file (if spanning), (2) Lipophobicity Data file and (3) an Embedding Definition file. All required parsing scripts are located in `src/apps/public/membrane`

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
./run_lips.pl <myfasta.txt> <mytopo.span> /path/to/blastpgp /path/to/nr alignblast.pl
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

# Setting Up a Job
The flexibility of the membrane protein framework is designed to work synchronously with the resource manager. For more about setting up resource description files, please refer to <link to RM wiki page> 

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
           <PoseFromPDB tag="BRD4_A" locator_tag="startstruct_locator" locator_id="BRD4_A.pdb" resource_options="pdb1">
           <EmbedConfig tag="BRD4_embedA" locator_tag="embedding_locator" locator_id="BRD4_A.embed">
           <SpanFile tag="BRD4_spanA" locator_tag="spanning_locator" locator_id="BRD4_A.span">
           <LipoFile tag="BRD4_lipsA" locator_tag="lipsexp_locator"  locator_id="BRD4_A.lips">
      
           <Group 2 - Chain B (from search)>
           <PoseFromPDB tag="BRD4_B" locator_tag="startstruct_locator" locator_id="BRD4_B.pdb"
           <EmbedConfig tag="BRD4_embedB" locator_tag="embedding_locator" locator_id="BRD4_B.embed" resource_options="embedB_options">
           <SpanFile tag="BRD4_spanB" locator_tag="spanning_locator" locator_id="BRD4_B.span">
           <LipoFile tag="BRD4_lipsB" locator_tag="lipsexp_locator"  locator_id="BRD4_B.lips">

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
# Running a Job
To run a protocol, specify your normal executables and flags along with a membrane resource definition file.

```
./my_app.linuxgccrelease @flags -resorce_definition_files membrane.xml
```

# References
* Barth P, Wallner B, Baker D. (2009 Feb 3) Prediciton of membrane protein structures with complex topologies using limited constraints. Proc Natl Acad Sci U S A. 106(5):1409-14.
* Barth P, Schonbrun J, Baker D. (2007 Oct 2) Toward high-resolution prediction and design of transmembrane helical protein structures. Proc Natl Acad Sci U S A. 104(40):15682-7.
* Yarov-Yarovoy V, Schonbrun J, Baker D. (2006 Mar 1) Multipass membrane protein structure prediction using Rosetta. Proteins. 62(4):1010-25.