### Flags for RosettaMP from 2014

|**Flag**|**Description**|
|:-------|:--------------|
|-mp:setup:spanfiles \<vector of strings\>| Spanning topology file converted from OCTOPUS output; unless otherwise specified for certain applications, only one should be provided| |
|-mp:setup:spans_from_structure \<bool\>| Uses spanning topology computed from the PDB; requires the protein to be transformed into the membrane coordinate frame!||
|-mp:setup:lipsfile \<string\>| Lipid accessibility file converted from LIPS output, default=mypdb.lips4| |
|-mp:setup:center \<vector of reals\>| Membrane center x,y,z||
|-mp:setup:normal \<vector of reals\>| Membrane normal x,y,z| |
|-mp:setup:membrane_rsd \<real\>| Membrane residue number for reading in a PDB file with MEM coordinates|
|-mp:thickness \<real\>| User-defined membrane thickness. Overwrites default thickness of 60A.|
|-mp:scoring:hbond \<bool\>| Hydrogen bonding energy correction for membrane proteins|
|-mp:no_interpolate_Mpair \<bool\>| Advanced scoring parameter from RosettaMembrane; don't interpolate between layers for membrane pair potential|
|-mp:Hbond_depth_correction \<bool\>| Advanced scoring parameter from RosettaMembrane; correct hydrogen bonds for membrane depth|
|-mp:TMprojection \<bool\>| Advanced scoring: Penalty for hydrophobic mismatch on/off.|
|-mp:wt_TMprojection \<real\>| Advanced scoring: Weight for hydrophobic mismatch penalty.|
|-mp:non_helix \<bool\>| Advanced scoring: Penalty for non-helix residues in the membrane on/off.|
|-mp:wt_non_helix \<real\>| Advanced scoring: Weight for non-helix penalty. |
|-mp:termini \<bool\>| Advanced scoring: Penalty for termini in the membrane on/off.|
|-mp:wt_termini \<real\>| Advanced scoring: Weight for termini penalty.|
|-mp:secstruct \<bool\>| Advanced scoring: Penalty if structure-based secondary structure doesn\t match predicted one - on/off|
|-mp:wt_secstruct \<real\>| Advanced scoring: Weight for secondary structure penalty.|
|-mp:spanning \<bool\>| Advanced scoring: Penalty if structure-based spanning doesn\t match spanfile - on/off.|
|-mp:wt_spanning \<real\>| Advanced scoring: Weight for spanning penalty.|
|-mp:viewer:thickness \<real\>| PyMOL plugin: Thickness of membrane to visualize, default=15 |
|-mp:viewer:num_points \<int\>| PyMOL plugin: Number of points to define the membrane planes. x \>= 3 |
|-mp:visualize:embedding \<bool\>| VisualizeEmbedddingMover: Visualize embedding centers and normals for each TMspan |
|-mp:visualize:spacing \<real\>| VisualizeMembraneMover: Spacing of virtual membrane residues representing the membrane planes, default=5 |
|-mp:visualize:width \<real\>| VisualizeMembraneMover: Width of membrane planes for n by n plane, default=100 |
|-mp:visualize:thickness \<real\>| VisualizeMembraneMover: Thickness of membrane to visualize, default=15 |
|-mp:visualize:plane_radius \<real\>| VisualizeMembraneMover: Radius of membrane planes to draw in PyMol - part of the PyMol viewer plugin |
