#SEWING
The SEWING protocol is a method for the rapid generation of denovo backbones that uses large segments of natural protein structure. For definitions of common terms used in SEWING, visit the [[SEWING Dictionary]].

##Basic concepts
SEWING stands for **S**tructure **E**xtension **WI**th **N**ative-fragment **G**raphs. SEWING functions by identifying relatively large sub-structures (typically 2-5 pieces of secondary structure, called segments) from native PDBs, and then assembling these models based on structural similarity.

The workflow below is for an updated version of SEWING not yet released to users. For documentation on the SEWING protocol published by TM Jacobs in a 2016 issue of Science, please refer to the [[original SEWING workflow|Old Sewing Documentation]].


##SmartSEWING workflow
1. [[Segment File Generation|segment-file-generation]] - Extraction of secondary structure units from native structures
    
    [[Structural Comparison of Substructures|structural-comparison-of-substructures]] ( Hashed SEWING only ) - Structurally compare substructures to one another using a geometric hashing algorithm
2. [[Backbone Generation|AssemblyMover]] - Create new backbones by combining structurally similar substructures
3. [[Refinement|Refinement of SEWING assemblies]] - Refine backbones, design side chains, and select structures generated using SEWING
