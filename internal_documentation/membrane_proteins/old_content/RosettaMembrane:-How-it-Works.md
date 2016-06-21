The purpose of the RosettaMembrane framework is to model the geometry of membrane proteins: where structures are positioned with respect to the membrane to inform important elements like fold trees, movers, and conformation. The purpose of this page is to describe the components of the membrane framework at a more detailed level: 

# Membrane Protein Factory
The membrane protein factory is the top level of the membrane code, and is responsible for initializing and maintaining all elements in membrane conformation. It will create a membrane protein starting structure to pass off to a mover in a protocol. The MembraneProteinFactory class is currently called by the CreateMembranePoseMover which will create a membrane protein in your protocol. 

**You should access the membrane framework directly through the mover - do not #include any class that is not MP conformation or in membrane properties - this is incorrect use of the framework. 

# Membrane Conformation
The goal of a membrane conformation is to describe elements of a membrane protein, such as topology, embedding and lipids accessibility, not normally described by Rosetta's base conformation class. It manages the following data: 
* A spanning topology object per chain
* A lipids accessibility object per chain (if specified)
* Location of one membrane residue for the entire pose
* Location of one embedding residue per membrane chain
* A valid membrane fold tree topology

Conformation is constructed by the membrane protein factory. It is not responsible for correct initialization, but for maintaining invariants. 

Below is roughly what the conformation object looks like: 

![Conformation Overview](/internal_documentation/conf_overview.png)

## Membrane Residue Types
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

## Membrane Embedding Definitions
There are several algorithms which can be used to calculate parameters for defining the embedding of a membrane chain. The exact formatting of embedding definition files is described in the framework setup page. The purpose of this description is to discuss the actual algorithms. 

**Methods for Computing Center and Normal Parameters**

There are currently four methods for defining a center, normal or both. 
* **user_defined**: The user provides a set of parameters (x, y, z) for the normal and center. The framework will use these parameters as the final embedding parameters.  
* **from_topology**: Given a spanning topology definition, calculate the following parameters: 
  * Center: average position between inner and outer residues
  * Normal: Normal to the plane formed by average center between inner and outer residues. 
* **from_pdb**: Ignore any specified coordinate and set the following default parameters. Note, this means the chain embedding will directly overlap with the center and normal definition of the membrane prior to applying initial trans mover. 
  * Center: (0, 0, 0)
  * Normal: (0, 0, 1)
* **from_search**: Search for membrane embedding parameters using existing MCM search methods. MCM search can be adjusted through the following options specified in the resource definition file: 

|**Option*|**Description**|**Type**|
|---|---|---|
|center_search|Use discrete search for membrane center|Boolean|
|center_max_delta|Maximum membrane width deviation during center search (Angstroms)|Integer|
|normal_search|Use discrete search for membrane normal|Boolean|
|normal_start_angle|Magnitude of starting angle during normal search (degrees)|Integer|
|normal_max_angle|Magnitude of angle deviation during normal search (degrees)|Integer|
|normal_delta_angle|Maximum angle deviation allowed during search|Integer|

# Input Handling: Resource Management and Flags
There are two main forms of input to the membrane framework: resource manager data and general flags specified on the command-line. Both are required for using the framework. 

## Command Line Options
Two overall command line options are required for running the membrane framework: 

|**Flag**|**Description**|**Type**|
|---|---|---|
|-in:membrane:membrane_chains|List of chains |Filename|
|-jd2:resource_definition_files|Membrane protein resource definition file|Filename|

## Resource Manager Data
The remainder of inputs to the membrane code are managed by the resource manager. Here I am documenting which resource loaders (and corresponding resource manager classes) correspond to which resources. All of this code is located in `src/core/membrane/io`.

|**Resource**|**Description**|**Resource Manager Classes**|
|---|---|---|
|Spanning Topology File|Membrane spanning topology data derived from OCTOPUS | SpanFileLoader, SpanFileIO, SpanFileOptions, SpanFileFallbackConfiguration|
|Lipid Accessibility Data File |Lipid accessibility data derived from run_lips.pl| LipoFileIO, LipoFileLoader, LipFileOptions, LipoFileFallbackConfiguration|
|Embedding Definition|Reads in .embed files for by-chain embedding definitions | EmbedDefIO, EmbedDefLoader, EmbedDefOptions, EmbedDefFallbackConfiguration|
|EmbedSearchParams|Reads in advanced options for embedding search parameters as a global resource| EmbedSearchParamsLoader, EmbedSearchParamsIO, EmbedSearchParamsOptions, EmbedSearchParamsFallabckConfiguration|

To add a new data resource associated with the membrane framework, _please use the resource manager_

# Membrane Scoring Function - Options and Info
The membrane scoring function was developed by Vladmir Yarrov-Yaravoy and Patrick Barth in 2006 as a direct addition with the membrane _ab initio_ protocol. The membrane scoring function accounts for hydrophobic layers in the membrane, as well as differing residue pair interactions and penalizes topological features that would otherwize create significant energetic cost due to positioning in the membrane. 

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