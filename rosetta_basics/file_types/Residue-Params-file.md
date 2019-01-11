Author:  Sam DeLuca

Edited 27 November 2017 by Vikram K. Mulligan (vmullig@uw.edu)

An overview of params files
===========================

Params files store a variety of chemical and geometric information used to define the shape and chemical connectivity of an amino acid building block or other small molecule. 

A set of params files for commonly seen residues and metals is included with Rosetta, and can be found in Rosetta/main/database/chemical/residue_type_sets

Params files can be automatically generated given a molfile, sdf file or pdb file of the desired building block/small molecule, using a script distributed with Rosetta, ``main/source/scripts/python/public/molfile_to_params.py``. Note that manual adjustments might be needed, according to the information below. The params file can be read in using the option ``-in:file:extra_res_fa``. 

The following lines are typically found in Ligand params files. This does not represent a complete documentation of the params fileformat. These files are read in core/chemical/residue\_io.cc

-   **NAME** The name of the Residue. Must be unique among all residues loaded into Rosetta

-   **IO\_STRING** The 3 letter and 1 letter codes representing the residue. 3 letter code is _not_ unique; it does not need to be the same as the name. 1 letter code is Z by default.

-   **TYPE** The type of residue being represented, should be 'LIGAND' for ligands, or 'POLYMER' for amino acids, DNA and RNA bases, or other polymer building-blocks.

-   **AA** The amino acid type. Should be "UNK" for ligands, or for most non-canonicals.  (Note that this corresponds to the core::chemical::AA enum, internally.)

-   **ATOM** The PDB atom name, [[Rosetta AtomType|Rosetta AtomTypes]], MM AtomType, and charge. An ATOM line looks like this:

    ```
    ATOM  C17 CH1   X   0.13
    ```

    Where C17 is the PDB atom name, CH1 is the Rosetta AtomType, X is the MM AtomType, and 0.13 is the charge. The PDB atom names must be unique within each params file.

-   **BOND** Defines a bond connection between two named atoms.

-   **CHI** Defines a rotatable chi angle. A chi angle number is specified, followed by the names of the four atoms defining the angle.

-   **CONNECT** Gives an atom a connection to an (unspecified) atom in another residue. This is not to be used for the N and C in the backbone; those are given with LOWER_CONNECT and UPPER_CONNECT respectively. A CONNECT line looks like this:

    ```
    CONNECT SG # replace SG with your atom's name
    ```

    The location of the connected atom must be specified in the ICOOR region as CONN#, where # is the index of the connection. (Connections are numbered from 1, but the backbone connections both count, so your first connecting atom will probably be called CONN3.) The atom must then be specified again as a virtual atom, with coordinates identical to your CONN#'s. Here is an example with virtual atom "V1" standing in for an atom connecting to sulfur atom "SG":

    ```
    ICOOR_INTERNAL    SG     0.000000   65.900000    1.808803   CB    CA    N       
    ICOOR_INTERNAL  CONN3  180.000000   75.000000    1.793000   SG    CB    CA      
    ICOOR_INTERNAL    V1     0.000000   75.000000    1.793000   SG    CB   CONN3 # Same as CONN3
    ```

    When determining the pose, Rosetta will do its best to automatically connect up residues with connections that face each other, but you can also do it manually with the [[DeclareBond]] mover. 

-  **PROPERTIES** A series of properties describing this ligand type or residue type.  Allowed properties include (though this list is not exhaustive): PROTEIN POLYMER LIGAND COARSE METAL METALBINDING DNA RNA CARBOHYDRATE SURFACE POLAR CHARGED AROMATIC TERMINUS LOWER_TERMINUS UPPER_TERMINUS SC_ORBITALS.  For an exhaustive list of allowed properties, see the file source/src/core/chemical/residue_properties/general_properties.list in the main Rosetta repository.

-  **METAL_BINDING_ATOMS**  A list of the names of atoms in this residue/ligand that can form covalent bonds to metal ions.  Only residues with the METALBINDING property can define metal binding atoms.

-   **NBR\_ATOM** The PDB name of the "neighbor atom". In the case of ligands, this defaults to the atom that is closest to the geometric center of the ligand

-   **NBR\_RADIUS** The radius of gyration of the ligand, used to define the overall size of the ligand.

-  **NET\_FORMAL\_CHARGE** The overall charge on this residue type or ligand type.  This must be an integer, though it can be positive or negative.  If not supplied, the net formal charge is assumed to be 0.  (Note: this is used by the [[netcharge score term|NetChargeEnergy]] to determine the net charge of a pose or region.)

-   **ICOOR\_INTERNAL** The [[internal coordinates]] of an atom. The format goes backwards and looks like this:

    ```
    #                 Child  Phi Angle    Theta        Distance   Parent  Angle  Torsion
    ICOOR_INTERNAL    A4     179.932453   59.543328    1.238233   A3      A2     A1
    ```

    And the fields are the following: 
   - Child atom
   - phi angle (torsion angle between A1, A2, A3, A4)
   - theta angle (improper angle = (180 - (angle between A4, A3, A2)))
   - distance (between A4 and A3)
   - parent atom
   - angle atom
   - torsion atom

-   **PDB\_ROTAMERS** The path to a PDB file containing ligand rotamers.

-   **RAMA_PREPRO_FILENAME** The path and name of the Ramachandran map to use when scoring this residue type's conformation, or when sampling.  Two files must be given.  The first is used in the general sampling case, and the second is used when the residue appears before an L- or D-proline, a peptoid, or an N-methylated amino acid (since the group on the amide alters the conformational preferences of the preceding residue).

-  **RAMA_PREPRO_RESNAME** If the Ramachandran file specified with RAMA_PREPRO_FILENAME contains definitions for multiple residue types, this is the string corresponding to the named map in the file that should be associated with _this_ residue type.  If not specified, Rosetta looks for a named map corresponding to the residue type name (e.g. ASP for aspartate).

##See Also

See this page for more information: http://graylab.jhu.edu/pyrosetta/downloads/documentation/PyRosetta_Workshops_Appendix_B.pdf                               
A paper with several examples of params files for different building blocks - http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0067051

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
params files
params files
params files
params files
params files
params files
params files
params files
params files
params files
params files
params files
params files
params files
params files
params files
params files
params files
params files
params files
params files -->
