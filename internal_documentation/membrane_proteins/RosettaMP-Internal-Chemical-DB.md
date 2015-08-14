<!--- BEGIN_INTERNAL -->
<!--- Membrane Chemical Profiles Project --> 
# RosettaMP Membrane Chemical Profiles Project: Database Organization

In the Rosetta database, the directory `core/chemical/membrane` will be the home for parameter files describing the membrane bilayer. The documentation below is mostly for my own data management, but will be refined for the future to inform others about how to add different chemical properties. 

To add a new lipid type to Rosetta's repertoire, five parameter files should be added: 
1. Divides describing the relative distribution of chemical groups (i.e. headgroups, hydrocarbon chains, etc)
2. Charge distribution profile along the membrane normal
3. Mean electrostatic potential along the membrane normal
4. Hydrogen bonding potential along the membrane normal
5. General lipid chemical type information

The directory currently contains example files for each requirement. An example for DOPC (1,2,-dioleoyl-glycerol-3-phosphate) is currently included: 
1. DOPC_div_surf_params
2. DOPC_polarity.profile
3. DOPC_hbond.profile
4. DOPC_pmepot.profile
5. DOPC.info

To inform Rosetta you have added a new lipid type, add the four letter code (and appropriate comments, see file for example) to the LipidType.hh enum in core/chemical/membrane. 
+
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