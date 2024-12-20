#SID_ERMS_Rescore

Name: SID_ERMS_Rescore

Metadata
========

Method, code, and documentation by Robert Bolz (bolz.13@osu.edu). The PI was Steffen Lindert (lindert.1@osu.edu). Last updated Jan 2025 by Robert Bolz. 

Code and Demo
=============

Application resides at Rosetta/main/source/src/apps/public/analysis/SID_ERMS_Rescore.cc. A tutorial for using the application can be found below.

First subunits must be generated either from Alphafold2 or from the PDB subunit structure. The subunits should then be docked using RosettaDock (detailed in the methods section) to generate 10,000 models. From there, SID_ERMS_Rescore can be run on those 10,000 docked models. 
This application relies on the ERMS prediction application, SID_ERMS_prediction, to simulate the ERMS data. As such, all file constraints from that application still apply to this one to correctly simulate the ERMS data. See the tutorial located in the supplemental section of that publication1 and the Rosetta documentation page for more information on the SID_ERMS_prediction application, https://www.rosettacommons.org/docs/latest/application_documentation/Application-Documentation/SID_ERMS_prediction.

Flags for input for the SID_ERMS_Rescore application:
-in:file:l: To input your models for rescoring. Must be a list of file paths to your pdb files. 
-ERMS: The experimental ERMS data for use in rescoring. Must be a tab separated file (.tsv).
-RMSE: Boolean flag to calculate RMSE. (Used in the SID_ERMS_prediction1 portion of the application, see https://www.rosettacommons.org/docs/latest/application_documentation/Application-Documentation/SID_ERMS_prediction).
-complex_type: File to describe the interfaces of the complex (Used in the SID_ERMS_prediction portion of the application, for example files and formatting instructions see  https://www.rosettacommons.org/docs/latest/application_documentation/Application-Documentation/SID_ERMS_prediction).
-out:file:o: Flag to specify output file name and location. File will contain the name of the file, original score of the structure (using the ref152 score function), and the rescored value of the complex. 

Example command: 
*Rosetta path*/main/source/bin/SID_ERMS_Rescore.default.linuxgccrelease 
	-in:file:l *file containing list of paths to pdb files* 
        -complex_type *path to complex type file*
	-ERMS *path to tsv file*
	-RMSE
	-out:file:o *name of output file*

Output: The output file will contain four pieces of information. The name of the file inputs to the application, the RMSE of the ERMS prediction, the score of the input structures (from the ref15 score function), and the rescore values using the ERMS data. 


References
==========

1.	Seffernick, J. T. et al. Simulation of energy-resolved mass spectrometry distributions from surface-induced dissociation. Anal. Chem. 94, 10506–10514 (2022).
2.	Alford, R. F. et al. The Rosetta all-atom energy function for macromolecular modeling and design. J. Chem. Theory Comput. 13, 3031–3048 (2017).

For the SID_ERMS_prediction portion of the application, example files and formatting instructions see  https://www.rosettacommons.org/docs/latest/application_documentation/Application-Documentation/SID_ERMS_prediction).

Purpose
=======

This application rescores and ranks input PDB structures using input SID-ERMS data

Input Files
===========

-in:file:l: To input your models for rescoring. Must be a list of file paths to your pdb files. 
-ERMS: The experimental ERMS data for use in rescoring. Must be a tab separated file (.tsv).
-complex_type: File to describe the interfaces of the complex (Used in the SID_ERMS_prediction portion of the application, for example files and formatting instructions see  https://www.rosettacommons.org/docs/latest/application_documentation/Application-Documentation/SID_ERMS_prediction).

Options
=======

-RMSE: Boolean flag to calculate RMSE. (Used in the SID_ERMS_prediction1 portion of the application, see https://www.rosettacommons.org/docs/latest/application_documentation/Application-Documentation/SID_ERMS_prediction).
-out:file:o: Flag to specify output file name and location. File will contain the name of the file, original score of the structure (using the ref15 score function), and the rescored value of the complex. 


Expected Outputs
================

The output file will contain four pieces of information. The name of the file inputs to the application, the RMSE of the ERMS prediction, the score of the input structures (from the ref15 score function), and the rescore values using the ERMS data. 


New things since last release
=============================
This is the first release.
