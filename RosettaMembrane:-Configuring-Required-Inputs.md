Running Rosetta with membrane proteins requires additional data from 3rd party apps for describing the topology and embedding of each membrane chain. The following inputs are required for running framework protocols: 
* Membrane Spanning Topology Data
* Membrane lipophobicity data (recommended, but not required)
* Membrane embedding data - initial parameters

All required parsing scripts discussed on this page are located in `tools/membrane_tools`and detailed on the [[RosettaMembrane: Scripts and Tools]] page. 

## Membrane Spanning Topology Data
Spanning topology data describes the position of individual residues in a membrane protein with respect to different membrane regions (intracellular, membrane spanning, and extracellular region). This data is traditionally generated with [OCTOPUS](http://octopus.cbr.su.se/) and then converted to the Rosetta span file format. 

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
After this file is generated, convert the file to a .span file using the script octopus2span.pl in `tools/membrane_tools` Example usage of this script is below:

```
./octopus2span.pl BRD4.oct > BRD4.span
```

## Membrane Lipophobicity Data
Lipophobicity data for membrane proteins describes the lipid accessibility of particular positions with respect to their position in the membrane. This data is used as part of the current membrane scoring function. 

To generate a lipid accessibility data file (.lips or .lips4), you will need to have already generated a .span file above. Running the script requires the following dependencies: 
* blast (not blast+)
* nr blast databases
* alignblast.pl script (also in `tools/membrane_tools`)
* fasta sequence
* .span file

Below is example usage of the script:

```
./run_lips.pl <myseq.fasta> <mytopo.span> /path/to/blastpgp /path/to/nr alignblast.pl
```

## Setting up a job using inputs from commandline (recommended)
Setting up a job using the commandline is the easiest way to run your protocol in the membrane framework. It only requires one file in addition to all the spanfiles, optional lipophilicity files, optional PDB files, and flags or options file.

The **setup file** (for instance membrane_setup.txt) needs to contain one line for each chain in your protein:

```
1afo_A spanfile
1afo_B user center 8 8 0 normal 8 8 8
```
1st column: File prefix that Rosetta will use for finding spanfiles (and optional lips files and PDB files)
2nd column: There are three possibilities:
* **spanfile**: Chain embedding is defined as given in the spanfile
* **search**: Chain embedding is searched for using the RosettaMembrane energy function.
* **user**: Chain embedding is defined by the user and is kept during the protocol. It requires at least either the center point defined by the user (center of the chain, as 8 8 0 in the above example) OR the normal vector defined by the user (normal vector of the chain, as 8 8 8 in the above example). If both are known, both can be given in any order. Also, if only one is given, the other setting will be searched for using the RosettaMembrane energy function. 

The **flag file** only requires two additional lines:

```
-in:membrane
-in:file:membrane_input setup.txt
```

## Setting up a job using the Resource Manager (more complex)
### Embedding Definition
In the membrane protein framework, _each chain_ of a pose also requires a specific membrane protein embedding definition. This definition defines a normal vector and center position of the chain with respect to Rosetta's defined implicit membrane (normal vec <0, 0, 1>, center position (0, 0, 0), thickness = 30A).

For each chain, you will need to generate an embedding definition file. This file will either (a) specify the final embedding parameters used or (b) specify initial parameters for a more detailed calculation of the embedding. How these initial parameters are used is controlled by the following method tags in the normal and center fields.   
* **default** - Uses a default setting of (0,0,0) for center and (0,0,1) for normal as final starting parameters
* **from_topology** - Calculates normal and center from membrane spanning topology using specified xyz as final from whatever coordinates are specified in the .embed file
* **user_defined** - Accepts specified coordinates as final coordinates
* **from_search** - Search for parameter using membrane MCM search method and coordinates specified in the .embed file as starting coordinates for this calculation. Note: In previous, this behavior was controlled by the command line and is _is no longer supported_

Note - you do not have to specify the same tag for both normal and center. The code is flexible enough to use different calculation methods for different parameters. Good examples of this can be found in the unit test for Embedding Factory. 

The depth parameter (depth of chain with respect to membrane) is completely user controlled. 

Below is an example .embed file format. 

```
POSE <Description>
normal        x y z  <tag>
center        x y z  <tag>
depth         <value>
```

### Resource Manager setup file
The RosettaMembrane framework requires that one of these data files be generated for each chain specified. Therefore, the resource definition file (as part of the ResourceManager) is used as a means of organizing these inputs. For more about setting up resource description files, please refer to the ResourceManager documentation (note - still internal dox) 

Below is an example Resource Definition file for a pose with 2 chains. 

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