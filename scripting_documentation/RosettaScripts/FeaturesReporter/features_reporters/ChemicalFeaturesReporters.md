#Chemical FeaturesReporters -->

AtomTypeFeatures
----------------

        <AtomTypeFeatures/>

The atom-level chemical information stored in the rosetta AtomTypeSet. This includes base parameters for the Lennard Jones Van der Waals term and Lazaridis Karplus solvation model.

-   **atom\_types** : The atom type in the atom type set along with Lennard Jones and Lazaridis Karplus parameters
    -   *atom\_type\_set\_name* : The name of the atom type set. For atom type tests stored in the database the parameters are in the following directory */path/to/rosetta/main/database/chemical/atom\_type\_sets/\<atom\_type\_set\_name\>*
    -   *name* : The name of the atom type
    -   *lennard\_jones\_{radius/well\_depth}* : The base parameters for the Lennard Jones Van der Waals term.
    -   *lazaridis\_karplus\_{lambda, degrees\_of\_freedom, volume}* : The base parameters for the Lazardis Karplus solvation model

<!-- -->

        CREATE TABLE IF NOT EXISTS atom_types (
            atom_type_set_name TEXT,
            name TEXT,
            element TEXT,
            lennard_jones_radius REAL,
            lennard_jones_well_depth REAL,
            lazaridis_karplus_lambda REAL,
            lazaridis_karplus_degrees_of_freedom REAL,
            lazaridis_karplus_volume REAL,
            PRIMARY KEY(atom_type_set_name, name));

-   **atom\_type\_property\_values** : An enumeration of the valid properties that an atom can have. Each property is either true or false except the hybridization properties which is either UNKNOWN (represented as not present) or at most one of hybridization types.
    -   *property* : Valid properties for use in the *atom\_type\_properties* table (see below).

<!-- -->

        CREATE TABLE IF NOT EXISTS atom_type_property_values (
            property TEXT,
            PRIMARY KEY(property));

        INSERT INTO atom_type_property_values VALUES ( 'ACCEPTOR' );
        INSERT INTO atom_type_property_values VALUES ( 'DONOR' );
        INSERT INTO atom_type_property_values VALUES ( 'POLAR_HYDROGEN' );
        INSERT INTO atom_type_property_values VALUES ( 'AROMATIC' );
        INSERT INTO atom_type_property_values VALUES ( 'H2O' );
        INSERT INTO atom_type_property_values VALUES ( 'ORBITALS' );
        INSERT INTO atom_type_property_values VALUES ( 'VIRTUAL' );
        INSERT INTO atom_type_property_values VALUES ( 'SP2_HYBRID' );
        INSERT INTO atom_type_property_values VALUES ( 'SP3_HYBRID' );
        INSERT INTO atom_type_property_values VALUES ( 'RING_HYBRID' );

-   **atom\_type\_properties** : The properties of a atom.
    -   *atom\_type\_set\_name* , *atom\_type* : How the atom type is identified
    -   *property* : A foreign key in to the *atom\_type\_property\_values* table (see above).

<!-- -->

        CREATE TABLE IF NOT EXISTS atom_type_properties (
            atom_type_set_name TEXT,
            name TEXT,
            property TEXT,
            FOREIGN KEY(atom_type_set_name, name) REFERENCES atom_types (atom_type_set_name, name) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY(property) REFERENCES atom_type_property_values (property) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(atom_type_set_name, name));

-   **atom\_type\_extra\_parameters** : Extra numerical parameters that can be associated with an atom type.
    -   *atom\_type\_set\_name* , *atom\_type* : How the atom type is identified
    -   *parameter* : The name of the parameter associated with the atom type.
    -   *value* : The value of the parameter associated with the atom type.

<!-- -->

        CREATE TABLE IF NOT EXISTS atom_type_extra_parameters (
            atom_type_set_name TEXT,
            name TEXT,
            parameter TEXT,
            value REAL,
            FOREIGN KEY(atom_type_set_name, name) REFERENCES atom_types (atom_type_set_name, name) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(atom_type_set_name, name));

ResidueTypesFeatures
--------------------

ResidueTypes store information about the chemical nature of the residue. The information is read in from the from */path/to/rosetta/main/database/chemical/residue\_type\_sets/\<residue\_type\_set\_name\>/residue\_types/* .

-   **residue\_type** :
    -   *residue\_type\_set\_name* : The name of the ResidueTypeSet. e.g. *fa\_standard* or *centroid* .
    -   *name* : The unique string that identifies a residue type in the ResidueTypeSet.
    -   *name3* : Three letter abbreviation for the residue type
    -   *name1* : One letter abbreviation for the residue type
    -   *aa* : Three letter abbreviation for the residue type, where non-canonical residues are *UNK* .
    -   *lower\_connect* , *upper\_connect* : The atoms that are used to connect the residue with the rest of the residues.
    -   *nbr\_atom* : The atom used for neighbor calculations
    -   *nbr\_radius* : A measure of the size of a residue for neighbor calculations (?).

<!-- -->

       CREATE TABLE IF NOT EXISTS residue_type (
            residue_type_set_name TEXT,
            name TEXT,
            version TEXT,
            name3 TEXT,
            name1 TEXT,
            aa TEXT,
            lower_connect INTEGER,
            upper_connect INTEGER,
            nbr_atom INTEGER,
            nbr_radius REAL,
            PRIMARY KEY(residue_type_set_name, name));

-   **residue\_type\_atom** : Each atom in the residue type is identified.
    -   *residue\_type\_set\_name* : The name of the ResidueTypeSet e.g. *fa\_standard* or *centroid* .
    -   *atom\_index* : The index of the atom in the residue.
    -   *atom\_name* : The name of the atom in the residue following the PDB naming convention. e.g. in canonical amino acids, the C-beta atom is *CB1* .
    -   *atom\_type\_name* : The name of the atom type of the atom. e.g. in canonical amino acids, the C-beta atom is ' *CB* '. Note: all atom names are exactly 4 characters.
    -   *mm\_atom\_type\_name* : The molecular mechanics name of the atom in the CHARMM naming scheme. e.g. in canonical amino acids, the C-beta atom is *CT2* .
    -   *charge* : The amount of charge associated with the atom.
    -   *is\_backbone* : Is the atom part of the backbone?

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_type_atom (
            residue_type_set_name TEXT,
            residue_type_name TEXT,
            atom_index INTEGER,
            atom_name TEXT,
            atom_type_name TEXT,
            mm_atom_type_name TEXT,
            charge REAL,
            is_backbone INTEGER,
            FOREIGN KEY(residue_type_set_name, residue_type_name) REFERENCES residue_type(residue_type_set_name, name) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(residue_type_set_name, residue_type_name, atom_index));

-   **residue\_type\_bond** : The covalent bonds in the residue type
    -   *residue\_type\_set\_name* : The name of the ResidueTypeSet e.g. *fa\_standard* or *centroid* .
    -   *atom1* , *atom2* : The atoms participating in the bond where the atom index of *atom1* is less than the atom index of *atom2* .
    -   *bond\_type* : The [type](Glossary#residuetype) of chemical bond.

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_type_bond (
            residue_type_set_name TEXT,
            residue_type_name TEXT,
            atom1 INTEGER,
            atom2 INTEGER,
            bond_type INTEGER,
            FOREIGN KEY(residue_type_set_name, residue_type_name) REFERENCES residue_type(residue_type_set_name, name) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(residue_type_set_name, residue_type_name, atom1, atom2));

-   **residue\_type\_cut\_bond** : Covalent bonds that that form non-tree topologies, e.g. (CD-N) in proline and (CE1-CZ) in tyrosine.
    -   *residue\_type\_set\_name* : The name of the ResidueTypeSet e.g. *fa\_standard* or *centroid* .
    -   *atom1* , *atom2* : The atoms participating in the cut bond where the atom index of *atom1* is less than the atom index of *atom2* .

<!-- -->

       CREATE TABLE IF NOT EXISTS residue_type_cut_bond (
           residue_type_set_name TEXT,
           residue_type_name TEXT,
           atom1 INTEGER,
           atom2 INTEGER,
           FOREIGN KEY(residue_type_set_name, residue_type_name) REFERENCES residue_type(residue_type_set_name, name) DEFERRABLE INITIALLY DEFERRED,
           PRIMARY KEY(residue_type_set_name, residue_type_name, atom1, atom2));

-   **residue\_type\_chi** : The chi torsional degrees of freedom in the ResidueType
    -   *residue\_type\_set\_name* : The name of the ResidueTypeSet e.g. *fa\_standard* or *centroid* .
    -   *chino* : The index of the chi degree of freedom
    -   *atom1* , *atom2* , *atom3* , *atom3* , *atom4* : The atoms that define the torsional degree of freedom

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_type_chi (
            residue_type_set_name TEXT,
            residue_type_name TEXT,
            atom1 TEXT,
            atom2 TEXT,
            atom3 TEXT,
            atom4 TEXT,
            chino INTEGER,
            FOREIGN KEY(residue_type_set_name, residue_type_name) REFERENCES residue_type(residue_type_set_name, name) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(residue_type_set_name, residue_type_name, atom1, atom2));

-   **residue\_type\_chi\_rotamer** : Chi torsional degrees of freedom are binned into discrete rotamer conformations. Each row is a bin for a chi torisional degree of freedom.
    -   *residue\_type\_set\_name* : The name of the ResidueTypeSet e.g. *fa\_standard* or *centroid* .
    -   *chino* : The index of the chi torsional degree of freedom
    -   *mean* : The center of the angle bin
    -   *sdev* : The standard deviation of the bin about the *mean*

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_type_chi_rotamer (
            residue_type_set_name TEXT,
            residue_type_name TEXT,
            chino INTEGER,
            mean REAL,
            sdev REAL,
            FOREIGN KEY(residue_type_set_name, residue_type_name) REFERENCES residue_type(residue_type_set_name, name) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(residue_type_set_name, residue_type_name, chino, mean, sdev));

-   **residue\_type\_proton\_chi** : Chi torsional degrees of freedom controlling the coordinates of hydrogen atoms.
    -   *residue\_type\_set\_name* : The name of the ResidueTypeSet e.g. *fa\_standard* or *centroid* .
    -   *chino* : The index of the chi torsional degree of freedom
    -   *sample* : The sample angle plus or minus each extra sample angle. e.g. The hydroxyl hydrogen in tyrosine is controlled by the third chi torsional degree of freedom with two torsional bins, trans at 180 degrees and cis at 0 degrees, both in the plane of the aromatic ring. To increase conformational sampling 8 extra rotamer bins +/- 1 degree and +/- 20 degrees for each sample bin.
    -   *extra* : Is this sample bin an extra rotamer bin?

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_type_proton_chi (
            residue_type_set_name TEXT,
            residue_type_name TEXT,
            chino INTEGER,
            sample REAL,
            is_extra INTEGER,
            FOREIGN KEY(residue_type_set_name, residue_type_name) REFERENCES residue_type(residue_type_set_name, name) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(residue_type_set_name, residue_type_name, chino, sample));

-   **residue\_type\_property** :
    -   *residue\_type\_set\_name* : The name of the ResidueTypeSet e.g. *fa\_standard* or *centroid* .
    -   *property* : Properties associated with the ResidueType e.g. PROTEIN, POLAR, or SC\_ORBITALS

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_type_property (
            residue_type_set_name TEXT,
            residue_type_name TEXT,
            property TEXT,
            FOREIGN KEY(residue_type_set_name, residue_type_name) REFERENCES residue_type(residue_type_set_name, name) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(residue_type_set_name, residue_type_name, property));

-   **residue\_type\_variant\_type** :
    -   *residue\_type\_set\_name* : The name of the ResidueTypeSet e.g. *fa\_standard* or *centroid* .
    -   *variant\_type* : Variant types associated with the ResidueType, e.g. DEPROTONATED, DISULFIDE, or MODRES

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_type_variant_type (
           residue_type_set_name TEXT,
           residue_type_name TEXT,
           variant_type TEXT,
           FOREIGN KEY(residue_type_set_name, residue_type_name) REFERENCES residue_type(residue_type_set_name, name)DEFERRABLE INITIALLY DEFERRED,
           PRIMARY KEY(residue_type_set_name, residue_type_name, variant_type));

UnrecognizedAtomFeatures
------------------------

           <UnrecognizedAtomFeatures neighbor_distance_cutoff="(&Real 12.0)"/>

UnrecognizedAtom store information about unrecognized atoms. This information is stored in the PDBInfo and is usually populated when there is a residue in a PDB file that does not match any recognized Residue parameter files that is saved with the *-in:remember\_unrecognized\_res* flag.

-   **unrecognized\_residues** : Details about the unrecognized residues
    -   *residue\_number* : The residue number of the unrecognized residue. NOTE: Unrecognized residues are not stored in the residues table.
    -   *name3* : Three letter abbreviation for the residue type.
    -   *max\_temperature* : The highest B-factor for any atom in the unrecognized residue. The occupancy could also be added here as well.

<!-- -->

        CREATE TABLE unrecognized_residues(
                struct_id INTEGER AUTOINCREMENT,
                residue_number INTEGER,
                name3 TEXT,
                max_temperature REAL,
                FOREIGN KEY (struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
                PRIMARY KEY (struct_id, residue_number));

-   **unrecognized\_atoms** : Atomic details about unrecognized residues
    -   *atom\_name* : e.g. the pdb atom name column
    -   *coord\_{x,y,z}* : The atomic coordinates

<!-- -->

        CREATE TABLE unrecognized_atoms(
                struct_id INTEGER AUTOINCREMENT,
                residue_number INTEGER,
                atom_name TEXT,
                coord_x REAL,
                coord_y REAL,
                coord_z REAL,
                temperature REAL,
                FOREIGN KEY (struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
                PRIMARY KEY (struct_id, residue_number, atom_name));

-   **unrecognized\_neighbors** : Close contacts between residues and unrecognized residues, this can be used as a filter for gathering statistics in bulk from the protein databank without representing ligands etc appropriately.
    -   *closest\_contact* : Distance between the ACTCOORD in the residue and the closest atom in each unrecognized residue. Only contacts that are within *neighbor\_distance\_cutoff* , which defaults to 12A.

<!-- -->

        CREATE TABLE unrecognized_neighbors(
                struct_id INTEGER AUTOINCREMENT NOT NULL,
                residue_number INTEGER NOT NULL,
                unrecognized_residue_number REAL NOT NULL,
                closest_contact REAL NOT NULL,
                FOREIGN KEY (struct_id, residue_number) REFERENCES residues(struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
                PRIMARY KEY (struct_id, residue_number));
