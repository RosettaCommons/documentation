
#Ligand coordination file format

[[_TOC_]]

Overview
========

The SEWING LigandBindingAssemblyMover requires a ligand coordination file that indicates the relative coordinates of a ligand atom relative to possible coordinating residues in different rotamers for each atom forming new contacts. These files can be generated using the [[zinc_statistic_generator]] application or other custom applications.

File Format
============

The first two lines of a ligand coordination file give identifying information for the file: the first line is a single character (H, E, or L) indicating the secondary structure type for which the file should be used, and the second line gives the residue name of the ligand for which the file was generated. 

The third line of a ligand coordination file gives headings indicating the contents of the remainder of the file:
```
Coord_res_name  Coord_atom_number  Ligand_atom_number  Local_x  Local_y  Local_z  Chi1  Chi2  Chi3  Chi4
```
These headings indicate residue name and atom number of the residue that will be coordinating the ligand atom; the number of the ligand atom to be coordinated; the coordinates of the ligand relative to a coordinate frame formed by the backbone atoms (N, Calpha, and C) for this residue type and rotamer; and the chi angles of the coordinating residue. If the residue has fewer than four chi angles, all remaining values will be zero.

Sample Files
============

The following are the first several lines of a ligand coordination file for zinc which allows coordinating HIS or HIS_D residues:

```
H
ZN
Coord_res_name	Coord_atom_number	Ligand_atom_number	Local_x	Local_y	Local_z	Chi1	Chi2	Chi3	Chi4
HIS	7	1	-2.54052	-2.04827	-1.3255	170.3	63.7	0	0
HIS	7	1	-2.54168	-2.08673	-1.30475	170.3	64.5	0	0
HIS	7	1	-2.54274	-2.1249	-1.28347	170.3	65.3	0	0
HIS	7	1	-2.54371	-2.16278	-1.26166	170.3	66.1	0	0
HIS	7	1	-2.54457	-2.20035	-1.23933	170.3	66.9	0	0
HIS	7	1	-2.54533	-2.23762	-1.21649	170.3	67.7	0	0
HIS	7	1	-2.546	-2.27457	-1.19313	170.3	68.5	0	0
```

##See Also

* [[File types list]]: List of file types used in Rosetta
* [[LigandBindingAssemblyMover]]: Mover that uses this file type
* [[zinc_statistic_generator]]: Application to generate ligand coordination files
* [[Rosetta Basics]]: The Rosetta Basics home page
* [[Options overview]]: Overview of Rosetta command line options
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications
