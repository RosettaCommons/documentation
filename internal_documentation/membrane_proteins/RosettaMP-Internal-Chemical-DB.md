<!--- BEGIN_INTERNAL -->
<!--- Membrane Chemical Profiles Project --> 
# RosettaMP Membrane Chemical Profiles Project: Database Organization

[[_TOC_]]

## About
In the Rosetta database, the directory `core/chemical/membrane` is be the home for parameter files describing the membrane bilayer. The documentation below is mostly for my own data management, but will be refined for the future to inform others about how to add different chemical properties. 

## Adding a new Lipid Type
To add a new lipid type to Rosetta's repertoire, five parameter files should be added: 
* Divides describing the relative distribution of chemical groups (i.e. headgroups, hydrocarbon chains, etc)
* Charge distribution profile along the membrane normal
* Mean electrostatic potential along the membrane normal
* Hydrogen bonding potential along the membrane normal
* General lipid chemical type information

The directory currently contains example files for each requirement. An example for DOPC (1,2,-dioleoyl-glycerol-3-phosphate) is currently included: 
* DOPC_div_surf_params
* DOPC_polarity.profile
* DOPC_hbond.profile
* DOPC_pmepot.profile
* DOPC.info

To inform Rosetta you have added a new lipid type, add the four letter code (and appropriate comments, see file for example) to the LipidType.hh enum in core/chemical/membrane. 

## Requirements
Important conventions for potentials: 
 = Must be symmetric about the z-axis
 = Must include boundary conditions where applicable
 = Currently formats think the bilayer is a homogeneous lipid compositions. Heterogeneous compositions are also possible? 

## Contact
This project is currently not released and not ready for use by the general community. For questions, please contact: 
 - Rebecca Alford [rfalford12@gmail.com](rfalford12@gmail.com)
 - Corresponding PI: Jeff Gray [jgray@jhu.edu](jgray@jhu.edu)

<!--- Membrane Chemical Profiles Project --> 
<!--- END_INTERNAL -->