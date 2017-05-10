#AlignmentFileGeneratorMover

The AlignmentFileGeneratorMover is used to generate Alignment Files for the SEWING design protocol and can be accessed via [[RosettaScripts]]

----------------------
[[_TOC_]]

##Command-Line Flags

The AlignmentFileGeneratorMover uses the MotifHasher utility designed by Will Scheffler. The command-line flags required for this utility can be found on the [[AssemblyMover|AssemblyMover#command-line-flags] page.

This mover also requires an input structure that will be used to generate all possible alignments using a given segment file. This input structure is provided via the ```-s``` flag.

##RosettaScripts Options
* ```model_file_name``` : Path to the segment file used to generate edge file ( See [[Segment File Generation|segment-file-generation]] )
* ```edge_file_name``` : Path to the edge file ( See [[Edge File Generation|structural-comparison-of-substructures#edge-file]] ) 
* ```recursive_depth``` : Determines how many nodes away from the starting segment you want to generate alignments for
* ```match_segments``` : Designates which segments in the input structure are allowed to form alignments
* ```pose_segment_starts``` : A comma separated list of the first residue of each segment in the pose
* ```pose_segment_ends``` : A comma separated list of the last residue of each segment in the pose
* ```set_segments_from_dssp``` : Determine segment boundaries based on pose secondary structure - Can be used in place of the ```pose_segment_starts``` and ```pose_segment_ends``` options
* ```required_resnums``` : The residue numbers of residues in the input structure that must be preserved - Can use a residue selector instead

##Subtags

The AlignmentFileGeneratorMover can be given a [[Ligands]] subtag.

##Example
Here is an example RosettaScripts tag for a HLH input structure that will be added to on both the N- and C-terminal helices.

*Disclaimer: At this time I cannot confirm that this xml script actually works, but it should...*

```xml
<AlignmentFileGeneratorMover 
    name="AFG"
    model_file_name="smotifs_H_1_100_L_1_100_H_1_100.segments"
    edge_file_name="smotifs_H_1_100_L_1_100_H_1_100.edges"
    match_segments="1,3"
    set_segments_from_dssp="true"
/>
```


##See Also
* [[SEWING]] The SEWING home page
* [[Structural Comparison of Substructures|structural-comparison-of-substructures]]