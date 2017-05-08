#SEWING
The SEWING protocol is a method for the rapid generation of denovo backbones that uses large segments of natural protein structure. For definitions of common terms used in SEWING, visit the [[SEWING Dictionary]].

##Basic concepts
SEWING stands for **S**tructure **E**xtension **WI**th **N**ative-fragment **G**raphs. SEWING functions by identifying relatively large sub-structures, called models (2-5 pieces of secondary structure, called segments) from native PDBs, and then assembling these models based on structural similarity.

##The Four Steps of SEWING
1. [[Model Generation|model-generation]] - Extraction of 'models' from native structures
2. [[Model Comparison|model-comparison-with-geometric-hashing]] - Structurally compare models to one another using a geometric hashing algorithm
3. [[Assembly|assembly-of-models]] - Stitch models together based on structural superimposition to form novel backbones
4. [[Refinement|Refinement of SEWING assemblies]] - Refine backbones, design side chains, and select structures generated using SEWING

##SmartSEWING workflow
1. [[Segment File Generation|segment-file-generation]] - Extraction of secondary structure units from native structures
2. [[Backbone Generation]] - Create new backbones by combining structurally similar segments