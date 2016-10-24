Author:  Sam DeLuca

An overview of params files
===========================

Params files store a variety of chemical and geometric information. 

A set of params files for commonly seen residues and metals is included with rosetta, and can be found in Rosetta/main/database/chemical/residue_type_sets

The following lines are typically found in Ligand params files. This does not represent a complete documentation of the params fileformat. These files are read in core/chemical/residue\_io.cc

-   **NAME** The name of the Residue. Must be unique among all residues loaded into Rosetta

-   **IO\_STRING** The 3 letter and 1 letter codes representing the residue. 3 letter code is _not_ unique; it does not need to be the same as the name. 1 letter code is Z by default.

-   **TYPE** The type of residue being represented, should be 'LIGAND' for ligands, or 'POLYMER' for protein or DNA residues

-   **AA** The amino acid type. Should be "UNK" for ligands

-   **ATOM** The PDB atom name, [[Rosetta AtomType|Rosetta AtomTypes]], MM AtomType, and charge. an atom line looks like this:

    ```
    ATOM  C17 CH1   X   0.13
    ```

    Where C17 is the PDB atom name, CH1 is the Rosetta AtomType, X is the MM AtomType, and 0.13 is the charge. The PDB atom names must be unique within each params file.

-   **BOND** Defines a bond connection, two PDB atom names are specified

-   **CHI** Defines a rotatable chi angle. A chi angle number is specified, followed by the names of the four atoms defining the angle

-  **PROPERTIES** A series of properties describing this ligand type or residue type.  Allowed properties include (though this list is not exhaustive): PROTEIN POLYMER LIGAND COARSE METAL METALBINDING DNA RNA CARBOHYDRATE SURFACE POLAR CHARGED AROMATIC TERMINUS LOWER_TERMINUS UPPER_TERMINUS SC_ORBITALS.

-  **METAL_BINDING_ATOMS**  A list of the names of atoms in this residue/ligand that can form covalent bonds to metal ions.

-   **NBR\_ATOM** The PDB name of the "neighbor atom". In the case of ligands, this defaults to the atom that is closest to the geometric center of the ligand

-   **NBR\_RADIUS** The radius of gyration of the ligand, used to define the overall size of the ligand.

-   **ICOOR\_INTERNAL** The [[internal coordinates]] of an atom. The format goes backwards and looks like this:

    ```
    ICOOR_INTERNAL    A4  179.932453   59.543328    1.238233   A3   A2   A1
    ```

    And the fields are the following: 
   - Child atom
   - phi angle (torsion angle between A1, A2, A3, A4)
   - theta angle (improper angle = (180 - (angle between A4, A3, A2)))
   - distance (between A4 and A3)
   - parent atom
   - angle atom
   - torsion atom

-   **PDB\_ROTAMERS** The path to a PDB file containing ligand rotamers

See this page for more information: http://graylab.jhu.edu/pyrosetta/downloads/documentation/PyRosetta_Workshops_Appendix_B.pdf

##See Also

* [[File types list]]: File types used in Rosetta
* [[Non-protein residues]]: Guide to using non-protein molecules with Rosetta
* [[How to turn on residue types that are off by default]]
* [[Making Rosetta robust against malformed PDBs|robust]]
* [[Preparing ligand files for use with Rosetta|preparing ligands]]
* [[Preparing PDB files for non-peptide polymers]]
* [[Preparing PDB files containing protein and RNA|RNA-protein-changes]]
* [[Running Rosetta with options]]: Instructions for running Rosetta applications on the command line

<!--
params files
params files
params files
params files
params files -->