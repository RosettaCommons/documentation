# Options (Flags) for RosettaMP and Previous RosettaMembrane

[[_TOC_]]

## Flags for RosettaMP from 2014

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

## Flags for RosettaMembrane from 2006 (will be deprecated soon)

|**Flag**|**Description**|
|:-------|:--------------|
|-membrane <boolean>|Initialize a pose as a membrane pose|
|-in:file:spanfile <string>|Spanfile containing transmembrane span information, converted from OCTOPUS output|
|-in:file:lipofile <string>|Lipophilicity file containing lipid accessibilities, converted from LIPS output|
|-center_search <bool>|Perform membrane center search, default false|
|-normal search <bool>|Perform membrane normal search, default false|
|-center_mag <real>|Magnitude of membrane normal center search (Angstroms), default 1|
|-center_max_delta <int>|Magnitude of maximum membrane width deviation during membrane center search (Angstroms), default 5|
|-normal_start_angle <int>|magnitude of starting angle during membrane normal search (degrees), default 10|
|-normal_delta_angle <int>|magnitude of angle deviation during membrane normal search (degrees), default 10|
|-normal_cycles <int>|Cycles for finding good embedding normal, default 100|
|-normal_max_angle <int>|magnitude of maximum angle deviation during membrane normal search (degrees), default 40|
|-normal_mag <real>|Magnitude of membrane normal angle search (degrees), default 5|
|-smooth_move_frac <real>|???, default 0.5|
|-no_interpolate_Mpair <boolean>|Don't interpolate between layers for pair interactions, default false|
|-Menv_penalties <bool>|Turn on penalties, default false|
|-Mhbond_depth <bool>|Membrane depth dependent correction to the hbond potential, default false|
|-Membed_init <bool>|??? default false|
|-Fa_Membed_update <bool>|??? default false|
|-fixed_membrane <bool>|Fix membrane position, by default the center is at [0,0,0] and membrane normal is the z-axis, default false|
|-membrane_center <vector of reals>|Membrane center x,y,z|
|-membrane_normal <vector of reals>|Membrane normal x,y,z|
|-thickness <real>|One leaflet hydrocarbon thickness for solvation calculations (Angstroms), default 15|
|-view <bool>|View membrane during protocol, default false|
|-debug <bool>|Print debug output, default false|


## References

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol. - In Press


## Contact

- Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
- Rebecca Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
- Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))
