The SEWING protocol is a method for the rapid generation of denovo backbones that uses large segments of natural protein structure.

The entire article is mainly about 'backbone generation by SEWING' so
* for 'Sidechain Design aided by Sewing', go to
[[Sidechain Design aided by Sewing|sidechain-design-aided-by-sewing]]
* for jargons of 'SEWING' field, go to
[[SEWING Dictionary|SEWING-Dictionary]]

##Basic concepts
SEWING stands for **S**tructure **E**xtension **WI**th **N**ative-fragment **G**raphs. SEWING functions by identifying relatively large sub-structures, called models (2-5 pieces of secondary structure, called segments) from native PDBs, and then assembling these models based on structural similarity. SEWING can be broken down into three basic steps:

1. [[Model Generation|model-generation]] - Extraction of 'models' from native structures
2. [[Model Comparison|model-comparison-with-geometric-hashing]] - Structurally compare models to one another using a geometric hashing algorithm
3. [[Assembly|assembly-of-models]] - Stitch models together based on structural superimposition to form novel backbones