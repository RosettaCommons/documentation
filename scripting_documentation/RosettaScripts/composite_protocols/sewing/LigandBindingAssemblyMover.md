#LigandBindingAssemblyMover#

LigandBindingAssemblyMover is a derived [[AppendAssemblyMover]] that is intended to build new contacts to a partially coordinated ligand while simultaneously building new protein backbone using SEWING.

##Description

LigandBindingAssemblyMover takes a partial ligand binding site and its ligand and, given user-provided information on how the ligand should be coordinated, adds new structural elements that will be able to complete the ligand's coordination with the correct geometry. It also makes any necessary mutations for this coordination and outputs PDBInfoRemarks indicating all coordinating residues.

##Usage
**NOTE: This is currently unavailable but will be automatically updated when the new version of SEWING is merged.**

[[include:mover_LigandBindingAssemblyMover_type]]

###Defining the ligand coordination environment

The Coordination subtag of the Ligand tag (which is documented [[here|AppendAssemblyMover#ligands]]), contains two types of ligand coordination information. First, it contains the "coordination_files" attribute, which provides a comma-separated list of all ligand coordination files (described below) that will be used to identify ligand contacts. Second, it provides information on each atom's preferred geometry in the form of IdealContacts subtags. **Each ligand atom that will form new contacts will have its own IdealContacts subtag.** 

####IdealContacts

Each atom's IdealContacts tag defines the atom name for which it should be applied, its preferred bond lengths ("distance"); bond angles about the atom ("angle"); and the ideal dihedral angles about the atom as defined in the XML schema above. Note that angles and dihedral angles will be accepted if they are any multiple of the entered value; for example, if the user requests a 90 degree angle, then bond angles of 180 degrees will also be accepted. The subtag also indicates the maximum number of contacts/bonds that the ligand should form, **including existing contacts**.

The final attribute of the IdealContacts tag, the geometry score threshold, indicates the tolerance that LigandBindingAssemblyMover should apply when scoring the geometry of newly added ligand contacts. This score is calculated as follows:

```
geometry_score = (delta_distance)^2 + 10*(mod(angle, ideal_angle))^2 + 5*(mod(dihedral_1, ideal_dihedral_1))^2 + 5*(mod(dihedral_2, ideal_dihedral_2))^2
```

Note that all angles are converted to radians for this calculation.

The recommended geometry score threshold will vary depending on the coordination environment of each ligand atom. For example, for a zinc ion with two initial contacts, a threshold of 5 provides the best balance of good geometry and high success rate for the addition of a third contact whereas a threshold of 20 provides the best results for a fourth contact.

####Ligand Coordination Files

Please see the [[zinc_statistic_generator]] application documentation for more information on ligand coordination file generation.

The format for ligand coordination files can be found [[here|SEWING Ligand Coordination Files]].

###Post-Processing

In many cases, users will want to add additional structural elements using [[AppendAssemblyMover]] after their ligands are fully coordinated. This can either be performed using a separate mover to allow for additional filtering/inspection beforehand or can be performed automatically within LigandBindingAssemblyMover by setting the "build_site_only" option to false. In this case, the min_cycles and max_cycles options would indicate the length of the AppendAssemblyMover run (whereas "binding_cycles" is used to determine the length of the LigandBindingAssemblyMover run), and the start_temperature and end_temperature options would control temperature ramping. This option is not recommended in most cases because AppendAssemblyMover will generally perform better with different add/delete probabilities and temperatures than LigandBindingAssemblyMover. For refinement after SEWING, please see the [[refinement of SEWING assemblies]] page.

##Example
The following is an example RosettaScript using LigandBindingAssemblyMover:

```xml
<ROSETTASCRIPTS>
  <SCOREFXNS>
  </SCOREFXNS>
  <RESIDUE_SELECTORS>
    <ResidueName name="select_zn" residue_name3=" ZN" />
  </RESIDUE_SELECTORS>
  <FILTERS>
  </FILTERS>
  <MOVERS>
    <LigandBindingAssemblyMover name="assemble" binding_cycles="20000" model_file_name="/nas02/home/g/u/guffy/netscr/sewing_with_zinc/input_files/smotifs_H_5_40_L_1_6_H_5_40.segment\
s" add_probability="0.05" delete_probability="0.05" hashed="false" segment_distance_cutoff="2" distance_cutoff="8.0" start_temperature="2.0" build_site_only="true" window_width="4" \
>
      <Ligands>
        <Ligand ligand_selector="select_zn" auto_detect_contacts="true" >
          <Coordination coordination_files="/nas02/home/g/u/guffy/netscr/sewing_with_zinc/input_files/H_NEW_stats.txt" geometry_score_threshold="5" >
            <IdealContacts ligand_atom_name="ZN" max_coordinating_atoms="3" angle="109.5" distance="2.2" dihedral_1="30" dihedral_2="120" />
          </Coordination>
        </Ligand>
      </Ligands>
      <AssemblyRequirements>
        <DsspSpecificLengthRequirement dssp_code="L" maximum_length="6" /> Prevents super-long loops                                                                                  
        <DsspSpecificLengthRequirement dssp_code="H" minimum_length="10" /> Prevents super-short helices                                                                              
        <ClashRequirement />
        <SizeInSegmentsRequirement maximum_size="9" minimum_size="5" />
        <LigandClashRequirement />
      </AssemblyRequirements>
    </LigandBindingAssemblyMover>
  </MOVERS>
  <APPLY_TO_POSE>
  </APPLY_TO_POSE>
  <PROTOCOLS>
        <Add mover_name="assemble" />
  </PROTOCOLS>
</ROSETTASCRIPTS>
```
##Guidelines for use

Since the sampling space of LigandBindingAssemblyMover is highly restricted, users are recommended to use relatively high temperature values (between 2.0 and 3.0) to ensure diverse sampling. Note that this mover does not perform temperature ramping; instead, the user-specified max_temperature sets the value for the entire protocol. LigandBindingAssemblyMover also ignores the min_cycles and max_cycles options; instead, the number of cycles is determined by the ligand_binding_cycles option. A value of 20000 cycles is recommended for adding a single ligand contact to ensure a high rate of success.

To prevent wasted sampling, users are recommended to use a segment distance cutoff of no more than two. Note that this cutoff counts the number of additions rather than the number of segments added, so segment files containing larger substructures may have different requirements. A max_distance of 8.0 Å is also recommended to prevent unnecessary calculations in segments that are not close enough to form contacts with the ligand.
Recommended values for the user-specified geometry score threshold can vary significantly depending on the coordination environment of the specified atom. Lower scores generally indicate more ideal geometry (and therefore a stricter cutoff). Since these scores include angles and dihedrals between all pairs of contacts to the atom in question, the score scales nonlinearly with the number of contacts; for example, a value of 5.0 is appropriate for a tetrahedrally coordinated atom forming a third contact whereas a value of 20.0 will give similarly ideal geometries when forming a fourth contact. Deviations from ideal coordination geometry in the starting site can also lead to increased scores. Therefore, users are recommended to perform some benchmarking for their specific use case before performing full-scale simulations.

##See Also
* [[AssemblyMover]]
* [[AppendAssemblyMover]]
* [[SEWING]]





