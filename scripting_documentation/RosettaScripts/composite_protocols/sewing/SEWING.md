#SEWING
The SEWING protocol is a method for the rapid generation of denovo backbones that uses large segments of natural protein structure. For definitions of common terms used in SEWING, visit the [[SEWING Dictionary]].

##Basic concepts
SEWING stands for **S**tructure **E**xtension **WI**th **N**ative-fragment **G**raphs. SEWING functions by identifying relatively large sub-structures, called models (2-5 pieces of secondary structure, called segments) from native PDBs, and then assembling these models based on structural similarity.


##SmartSEWING workflow
1. [[Segment File Generation|segment-file-generation]] - Extraction of secondary structure units from native structures

1b. [[Structural Comparison of Substructures|edge-file-generation]]( Hashed SEWING only ) - Structurally compare substructures to one another using a geometric hashing algorithm

2. [[Backbone Generation|AssemblyMover]] - Create new backbones by combining structurally similar segments
3. [[Refinement|Refinement of SEWING assemblies]] - Refine backbones, design side chains, and select structures generated using SEWING

The original SEWING workflow can be found here: [[Old Sewing Documentation]]
