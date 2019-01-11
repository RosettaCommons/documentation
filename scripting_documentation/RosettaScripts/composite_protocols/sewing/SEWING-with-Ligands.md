#Sewing with Ligands
Ligand compatibility with SEWING is in its early stages, but is currently supported via the [[RosettaScripts]] interface via a ```Ligands``` subtag to any SEWING mover. **If the Ligands tag is not provided, any ligand in the input structure will be stripped from the structure and ignored during the alignment/design process.** Using this tag ensures that the SEWING Assembly will be aware of the ligand atoms and that any residue contacts with the ligand will be preserved throughout the SEWING protocol. However, to verify that there won't be any clashes with the ligand during the assembly process, you need to provide a [[LigandClashRequirement|AssemblyRequirements#ligandclashrequirement]].

##Ligand Subtag

The Ligands tag takes a list of Ligand subtags. The Ligand tag has several options:
* which will be listed here