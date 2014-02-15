The RosettaMembrane framework is a framework in Rosetta for modeling the kinematics and conformation of membrane proteins. The information provided below aims to serve as a brief overview of how each component works and can be used in a modeling context. 

## Membrane Residue Types
The framework uses two new residue types: MEM and EMB. Both of these residues are virtual, they have no impact on the chemical properties of the structure and cannot be added to a polymer chain by bond (no upper/lower connect points). Instead, these residues can be added by jump and act as internal reference frames for the positioning of the chain with respect to the membrane. 

**Membrane Residues** (MEM) are constructed from three atoms - MPct, MPnm, and MPtk which note the membrane center, normal vector, and thickness respectively. These atom types are not virtual atoms but have virtual properties (so no chemical interactions and no connectivity). 

**Embedding Residues** (EMB) are constructed from three atoms - MPct, MPnm, and MPdp which note the chain embedding center, normal vector, and depth in the membrane respectively. These atom types are not virtual atoms but have virtual properties (so no chemical interactions and no connectivity). 

Both MEM and EMB residues are of amino acid type MPR (Membrane Protein Residue). 

## Membrane Embedding Definitions
There are several algorithms which can be used interchangeably to calculate the embedding of a membrane chain. Each algorithm can be applied to calculating the center, normal or both for a given membrane chain.  These are discussed briefly in the framework setup documentation, and discussed in further detail here: 
* **user_defined**: The user provides a set of parameters (x, y, z) for the normal and center. The framework will use these parameters as the final starting parameters and not use any further computation. 
* **from_topology**: Given a membrane topology definition, the embedding factory will calculate the center 
from the average position between inner and outer residues (defined in SpanningTopology) and the normal vector as the normal to the average plane formed by the mp center residues. The from topoogy method will use the user defined values as starting parameters. 
* **from_pdb**: The embedding factory will ignore user specified coordinates and set (0, 0, 0) and (0, 0, 1) for the center and normal respectively. Note, this means the chain embedding will directly overlap with the center and normal definition of the membrane. 
* **from_search**: The from_search method will provide n cycles of a search and score method to search for the optimal membrane embedding using the membrane scoring function and filters as acceptance criteria. This method will use the user specified values as starting parameters. The "from_search' method can be controlled given the following advanced parameters which can be specified as Resource options in the resource definition file: 

|**Option*|**Description**|**Type**|
|---|---|---|
|center_search|Use discrete search for membrane center|Boolean|
|center_max_delta|Maximum membrane width deviation during center search (Angstroms)|Integer|
|normal_search|Use discrete search for membrane normal|Boolean|
|normal_start_angle|Magnitude of starting angle during normal search (degrees)|Integer|
|normal_max_angle|Magnitude of angle deviation during normal search (degrees)|Integer|
|normal_delta_angle|Maximum angle deviation allowed during search|Integer|

## Resource Management and Options
There are two main forms of input to the membrane framework: resource manager data and general flags specified on the command-line. Both are required for using the framework. 

### Command Line Options
Two overall commandline options are required for running the membrane framework: 

|**Flag**|**Description**|**Type**|
|---|---|---|
|-in:membrane:membrane_chains|List of chains |Filename|
|-jd2:resource_definition_files|Membrane protein resource definition file|Filename|

### Resource Manager Data
The remainder of inputs to the membrane code are managed by the resource manager. Here I am documenting which resource loaders (and corresponding resource manager classes) correspond to which resources 

|**Resource**|**Description**|**Resource Manager Classes**|
|---|---|---|
|Spanning Topology File|Membrane spanning topology data derived from OCTOPUS | SpanFileLoader, SpanFileIO, SpanFileOptions, SpanFileFallbackConfiguration|
||Membrane protein resource definition file|Filename|


## Components of Membrane Conformation

## Membrane Scoring Function - Options and Info

## Membrane Protein Factory






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
