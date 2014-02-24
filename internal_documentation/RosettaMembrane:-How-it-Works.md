The purpose of the RosettaMembrane framework is to model the geometry of membrane proteins: where structures are positioned with respect to the membrane to inform important elements like fold trees, movers, and conformation. The purpose of this page is to describe the components of the membrane framework at a more detailed level: 

## Conformation
The goal of a membrane conformation is to describe elements of a membrane protein, such as topology, embedding and lipids accessibility, not normally described by Rosetta's base conformation class. Below is roughly what the conformation object looks like: 

[[/internal_documentation/conf_overview.png]]

### Membrane Residue Types
To define membrane and chain orientation, the framework uses two new residue types, MEM and EMB, derived from a virtual residue type. Becasue they are virtual, they have no impact on the chemical properties of the structure and cannot be added to a polymer chain by bond (no upper/lower connect points). Instead, these residues are added by jump by the framework and act as local coordinate frames. Below describes the purpose of each residue: 

**Membrane Residue (MEM)** 
Defines the membrane at the center of the pose coordinate frame. In particular, defines three parameters: MPct, MPnm, and MPtk which describe the membrane center, normal vector, and thickness respectively. These parameters always use the following values: 
 * (MPct) Center = (0, 0, 0)
 * (MPnm) Normal = (0, 0, 1) 
 * (MPtk) Thicnkess = 30.0A 

Each atom type is also virtual. 

**Embedding Residues (EMB)**
Defines the position of a particular chain with respect to the membrane. In particular, it defines three parameters using virtual atoms: MPct, MPnm, and MPdp which describe membrane chain embedding center, membrane chain embedding normal vector, and membrane chain depth with respect to membrane. These parameters can be defined from an embedding definition file which is described in detail in the next section.  

Both MEM and EMB residues are of amino acid type MPR (Membrane Protein Residue). 

### Membrane Embedding Definitions
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
Two overall command line options are required for running the membrane framework: 

|**Flag**|**Description**|**Type**|
|---|---|---|
|-in:membrane:membrane_chains|List of chains |Filename|
|-jd2:resource_definition_files|Membrane protein resource definition file|Filename|

### Resource Manager Data
The remainder of inputs to the membrane code are managed by the resource manager. Here I am documenting which resource loaders (and corresponding resource manager classes) correspond to which resources. All of this code is located in `src/core/membrane/io`.

|**Resource**|**Description**|**Resource Manager Classes**|
|---|---|---|
|Spanning Topology File|Membrane spanning topology data derived from OCTOPUS | SpanFileLoader, SpanFileIO, SpanFileOptions, SpanFileFallbackConfiguration|
|Lipid Accessibility Data File |Lipid accessibility data derived from run_lips.pl| LipoFileIO, LipoFileLoader, LipFileOptions, LipoFileFallbackConfiguration|
|Embedding Definition|Reads in .embed files for by-chain embedding definitions | EmbedDefIO, EmbedDefLoader, EmbedDefOptions, EmbedDefFallbackConfiguration|
|EmbedSearchParams|Reads in advanced options for embedding search parameters as a global resource| EmbedSearchParamsLoader, EmbedSearchParamsIO, EmbedSearchParamsOptions, EmbedSearchParamsFallabckConfiguration|

To add a new data resource associated with the membrane framework, _please use the resource manager_

## Components of Membrane Conformation
A membrane conformation extends from Rosetta's conformation object and manages the following data: 
* A spanning topology object per chain
* A lipids accessibility object per chain (if specified)
* Location of one membrane residue for the entire pose
* Location of one embedding residue per membrane chain
* A valid membrane fold tree topology

Conformation is constructed by the membrane protein factory. It is not responsible for correct initialization, but for maintaining invariants. 

## Membrane Scoring Function - Options and Info
The membrane scoring function was developed by Vladmir Yarrov-Yaravoy and Patrick Barth in 2006 as a direct addition with the membrane ab initio protocol. The membrane scoring function accounts for hydrophobic layers in the membrane, as well as differing residue pair interactions and penalizes topological features that would otherwize create significant energetic cost due to positioning in the membrane. 

The following scoring terms are included in the current version of the scoring function. 

|**Score**|**Description**|
|---|---|---|
|Mpair|membrane pairwise residue interaction energy|
|Menv|membrane residue environment energy|
|Mcbeta|membrane residue centroid density energy|
|Mlipo|membrane residue lipophilicity energy|
|Menv_hbond|membrane non-helical secondary structure in the hydrophobic layer penalty|
|Menv_termini|membrane N- and C- termini residue in the hydrophobic layer penalty|
|Menv_tm_proj|transmembrane helix projection penalty|

The following options can be applied to the scoring method. We advise against using fixed_membrane with the framework, as the framework models conformation. 

|**Flag**|**Description**|**Type**|
|---|---|---|
|Menv_penalties|Membrane environment penalties imposed during scoring (see ref [1])|Boolean|
|no_interpolate_Mpair|Turn off interpolation between 2 membrane layers if using Mpair term|Boolean|
|Mhbond_depth|Update for fullatom scoring|Boolean|
|Fa_Membed_update|Update for fullatom scoring|Boolean|

## Membrane Protein Factory
The membrane protein factory is the top level of the membrane code, and is responsible for initializing and maintaining all elements in membrane conformation. It will create a membrane protein starting structure to pass off to a mover in a protocol. 

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