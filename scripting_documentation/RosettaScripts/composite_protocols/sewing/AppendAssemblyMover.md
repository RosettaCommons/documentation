#AppendAssemblyMover

AppendAssemblyMover is a derived [[AssemblyMover]] that builds a SEWING assembly from a predetermined starting structure.

[[_TOC_]]

##Description

AppendAssemblyMover is used to incorporate a functional element of a native structure into a larger backbone. It is most commonly used to design binding partners for a protein using a binding peptide as a starting structure. It has also been used to design protein backbones around a native ligand binding site.

##Usage
**NOTE: This is currently out of date but will be automatically updated when the new version of SEWING is merged.**

[[include:mover_AppendAssemblyMover_type]]

###Binding Partners
AppendAssemblyMover allows users to specify an additional PDB as a binding partner for their starting structure using the partner_pdb attribute of the AppendAssemblyMover tag. The structure provided in this PDB file must already have the correct coordinates relative to the starting structure provided to AppendAssemblyMover (no docking or minimization occurs before or during the protocol). The ClashRequirement will automatically check for clashes between the assembly and the binding partner.

In most cases, users will also want to include the PartnerMotifScorer in their set of AssemblyScorers. This scorer evaluates possible packing between the assembly and the binding partner. In addition to the standard recommended scorers and requirements, other potentially useful scorers and requirements for dealing with partner PDBs include:

* SubsetPartnerMotifScorer: Evaluates possible packing between the assembly and a specified region of the partner PDB

The output_partner attribute of AppendAssemblyMover (default true) toggles whether the binding partner will be included in PDB files output from AppendAssemblyMover. Note that the binding partner is not modified or moved during assembly.


###Ligands
The Ligands subtag is a new feature of AppendAssemblyMover which allows users to designate non-protein residues in their starting structure as ligand molecules. AppendAssemblyMover stores and tracks which residues in the starting node are in contact with the ligand and automatically designates them as required residues.

If ligands are included in an assembly, it is highly recommended that users include the LigandClashRequirement as the ClashRequirement does not detect clashes with ligands. Users may also want to include the LigandScorer in their AssemblyScorers section; this scorer evaluates hydrophobic packing between the assembly and the ligand.

The syntax for defining a ligand is as follows:
```xml
<Ligands>
  <Ligand ligand_resnum="(&core::Size;)" ligand_selector="(&string;)" auto_detect_contacts="(true &bool;) pdb_conformers="(&string;) alignment_atoms="(&string;)>
    <Contact contact_resnum="(&core::Size;)" contact_atom_name="(&string;)" ligand_atom_name="(&string;)" />
    . . . (additional Contact subtags)
  </Ligand>
 . . . (additional Ligand subtags)
</Ligands>
```

Each AppendAssemblyMover may have a Ligands subtag which can contain one or more Ligand subtags. Each ligand can be specified either using a residue number or using a residue selector. 

The auto_detect_contacts option (default true) indicates that AppendAssemblyMover should automatically detect contacts between the ligand and the starting structure. Currently, only covalent bonds and protein-metal contacts (including contacts to metal atoms in larger ligands) can be detected automatically. We intend to add support for hydrogen bond detection in the future. **If auto_detect_contacts is false or if no detectable contacts exist, the user MUST manually specify at least one contact between the ligand and the starting structure.**

Ligand contacts may also be manually specified using Contact subtags. Each Contact tag must specify the names of the two atoms involved in the contact as well as the residue number within the starting structure (Rosetta or PDB numbering) of the contact residue. 

AppendAssemblyMover also includes support for ligand conformer sampling. In order to enable conformer sampling, three steps must be followed: 

1) The user must set the conformer_switch_probability attribute of the AppendAssemblyMover tag to a nonzero value (conformer sampling is turned off by default).
2) The user must provide a text file containing a list of PDB conformers using the pdb_conformers attribute of the Ligand tag. Each PDB file should contain one ligand conformation with no additional structure/residues.
3) The user must specify three ligand atom names using the alignment_atoms attribute of the Ligand tag. These atoms will be used to superimpose conformers onto one another during conformer switching. It is highly recommended that the user select atoms that will retain the geometry of any atoms involved in contacts.

If conformer sampling is enabled, it is highly recommended that the user include the KeepLigandContactsRequirement in the set of requirements. This requirement ensures that conformer sampling does not increase the distance between two contact atoms beyond a certain user-defined threshold.

##Example
The following is an example RosettaScript using AppendAssemblyMover:

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
    <AppendAssemblyMover name="assemble" model_file_name="/nas02/home/g/u/guffy/smotifs_H_5_40_L_1_6_H_5_40.segments" add_probability="0.05" hashed="false" minimum_cycles="10000" maximum_cycles="20000" start_temperature="1.5" end_temperature="0.1">
      <Ligands>
        <Ligand ligand_selector="select_zn" auto_detect_contacts="true" />
      </Ligands>
      <AssemblyRequirements>
        <DsspSpecificLengthRequirement dssp_code="L" maximum_length="6" /> Prevents super-long loops, should be unnecessary with this segment file                                                                                                       
        <DsspSpecificLengthRequirement dssp_code="H" maximum_length="25" minimum_length="10" /> Prevents super-short helices                                                                                                                             
        <ClashRequirement />
        <LigandClashRequirement />
        <SizeInSegmentsRequirement maximum_size="9" minimum_size="5" />
      </AssemblyRequirements>
    </AppendAssemblyMover>
  </MOVERS>
  <APPLY_TO_POSE>
  </APPLY_TO_POSE>
  <PROTOCOLS>
        <Add mover_name="assemble" />
  </PROTOCOLS>
</ROSETTASCRIPTS>
```

##See Also
* [[AssemblyMover]]
* [[LigandBindingAssemblyMover]] Used to add new contacts to a specified ligand
* [[SEWING]]
* [[LegacyAppendAssemblyMover]] The legacy SEWING version of this mover