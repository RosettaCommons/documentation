<!-- --- title: Featuresdatabaseschema -->Features Database Schema
========================

Each features database contains information about the features extracted from the input structures.

See the FeaturesReporters [[organization|FeatureReporters]]

You can see a graphical schema based on the following [[here|Features-schema]] .

AtomTypesFeatures
-----------------

        <AtomTypesFeatures/>

The atom-level chemical information stored in the Rosetta AtomTypeSet. This includes base parameters for the Lennard Jones Van der Waals term and Lazaridis Karplus solvation model.

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

AtomAtomPairFeatures
--------------------

        <AtomAtomPairFeatures min_dist="(&real 0)" max_dist="(&real 10)" nbins="(&integer 15)"/>

The distances between pairs of atoms is an indicator of the packing of a structure. Since there are a large number of atom pairs, here, the information is summarized by atom pair distributions for each pair of atom types (Rosetta AtomType -\> element type). See AtomInResidueAtomInResiduePairFeatures for an alternative binning of atom-atom interactions.

-   **atom\_pairs** : Binned distribution of pairs of types of atoms
    -   *atom\_type* : The AtomType of the central atom. This is a subset of the AtomTypes defined in the full-atom AtomTypeSet (rosetta/main/database/chemical/atom_type_sets/fa_standard/atom_properties.txt) : *CAbb* , *CObb* , *OCbb* , *CNH2* , *COO* , *CH1* , *CH2* , *CH3* , *aroC* , *Nbb* , *Ntrp* , *Nhis* , *NH2O* , *Nlys* , *Narg* , *Npro* , *OH* , *ONH2* , *OOC* , *Oaro* , *Hpol* , *Hapo* , *Haro* , *HNbb* , *HOH* , and *S* .
    -   *element* : The element type of the second atom: *C* , *N* , *O* , and *H*
    -   *{lower/upper}\_break* : The boundaries for the distance bin
    -   *count* : The number of atom-atom instances of the correct type that occur in the specific distance range in the structure.

<!-- -->

        CREATE TABLE IF NOT EXISTS atom_pairs (
            struct_id INTEGER,
            atom_type TEXT,
            element TEXT,
            lower_break REAL,
            upper_break REAL,
            count INTEGER,
            FOREIGN KEY (struct_id) REFERENCES structures (struct_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (struct_id, atom_type, element, lower_break));

AtomInResidueAtomInResiduePairFeatures
--------------------------------------

The distances between pairs of atoms is an indicator of the packing of a structure. Since there are a large number of atom pairs, here, the information is summarized by atom pair distributions for each pair of atom types (residue type + atom number). This is very similar in spirit to [Lu H, Skolnick J. A distance-dependent atomic knowledge-based potential for improved protein structure selection. Proteins. 2001;44(3):223-32](http://www.ncbi.nlm.nih.gov/pubmed/11455595) , however, they use different distance bins. Here, (0,1], ..., (9,10] are used because they are easy. It may make sense to come up with a better binning upon further analysis. The molar fraction of atom types can be computed by joining with the Residues table since the types are unique within each residue type. If this is turns out to be too cumbersome, it may need to be pre-computed. **WARNING** : Currently, this generates an inordinate amount of data!!! \~250M per structure. **WARNING**

-   **atom\_in\_residue\_pairs** : Binned distribution of pairs of types of atoms
    -   *residue\_type1* , *atom\_type1* : The ResidueType and atom number for the first atom type
    -   *residue\_type2* , *atom\_type2* : The ResidueType and atom number for the second atom type
    -   *distance\_bin* : Group all atom pairs in the range (distance\_bin-1, distance\_bin]
    -   *count* : Number of atom pairs in the distance bin

<!-- -->

        CREATE TABLE IF NOT EXISTS atom_pairs (
            struct_id INTEGER,
            residue_type1 TEXT,
            atom_type1 TEXT,
            residue_type2 TEXT,
            atom_type2 TEXT,
            distance_bin TEXT,
            count INTEGER,
            FOREIGN KEY (struct_id) REFERENCES structures (struct_id) DEFERRABLE INITIALLY DEFERRED,
            CONSTRAINT dist_is_nonnegative CHECK (count >= 0),
            PRIMARY KEY (struct_id, residue_type1, atom_type1, residue_type2, atom_type2, distance_bin));

BetaTurnDetectionFeatures
-------------------------

        <BetaTurnDetectionFeatures/>

This reporter scans all available windows of four residues and determines if a β-turn is present, determines the type of β-turn and then writes the starting residue number and turn type to a database.

        CREATE TABLE IF NOT EXISTS beta_turns (
            struct_id INTEGER,
            residue_begin INTEGER,
            turn_type TEXT,
            FOREIGN KEY (struct_id, residue_begin) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, residue_begin));

GeometricSolvationFeatures
--------------------------

-   **geometric\_solvation** : The exact geometric solvation score which is computed by integrating the hbond energy not occupied by other atoms.
    -   *hbond\_site\_id* : A hydrogen bonding donor or acceptor
    -   *geometric\_solvation\_exact* : The non-pairwise decomposable version of the geometric solvation score.

<!-- -->

        CREATE TABLE IF NOT EXISTS geometric_solvation (
            struct_id INTEGER,
            hbond_site_id TEXT,
            geometric_solvation_exact REAL,
            FOREIGN KEY (struct_id, hbond_site_id) REFERENCES hbond_sites(struct_id, site_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, hbond_site_id));

HBondFeatures
-------------

The HBondFeatures (rosetta/main/source/src/protocols/features/HBondFeatures.hh) measures the geometry of hydrogen bonds. The most current reference is [Tanja Kortemme, Alexandre V. Morozov, David Baker, An Orientation-dependent Hydrogen Bonding Potential Improves Prediction of Specificity and Structure for Proteins and Protein-Protein Complexes, (JMB 2003)](http://www.sciencedirect.com/science/article/B6WK7-47WBSCV-T/2/d7c673dd51017848231e7b9e8c05fbca) .

The features associated with hydrogen bonding include

-   **hbond\_sites** : Conceptually these are positively and negatively charged functional groups that can form hydrogen bonds.
    -   *atmNum* :For donor functional groups, atmNum is the atom number of the polar hydrogen. For acceptor functional groups, atmNum is the atom number of an acceptor atom.
    -   *HBChemType* : The HBChemType string corresponding to an HBAccChemType or HBDonChemType (see rosetta/main/source/src/core/scoring/hbonds/types.hh) depending on if the site is a donor or acceptor.

<!-- -->

        CREATE TABLE hbond_sites (
            struct_id INTEGER,
            site_id INTEGER,
            resNum INTEGER,
            atmNum INTEGER,
            is_donor BOOLEAN,
            chain INTEGER,
            resType TEXT,
            atmType TEXT,
            HBChemType TEXT,
            FOREIGN KEY(struct_id, resNum) REFERENCES residues(struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, site_id));

-   **hbond\_site\_atoms** : Each hydrogen bond site defines a portion of a frame by bonded atoms.
    -   Donor atoms:
        -   *atm* : The polar *hydrogen* atom
        -   *base* : The parent atom of the hydrogen atom. This is the *donor* .

    -   Acceptor atoms:
        -   *atm* : The *acceptor* atom
        -   *base* : The parent of the acceptor atom. This is the *base* .
        -   *bbase* : The parent of the base atom.
        -   *base2* : The alternate second base atom of the acceptor.
            -   Note: The parent atom is defined by column 6 of the ICOOR\_SECTION in each residue type params files (see rosetta/main/database/chemical/residue_type_sets/fa_standard/residue_types) .

        -   The base to acceptor unit vector is defined by the [hybridization type (see rosetta/main/database/chemical/atom_type_sets/fa_standard/atom_properties.txt) of the acceptor atom and the above atoms.

<!-- -->

        CREATE TABLE IF NOT EXISTS hbond_site_atoms (
            struct_id INTEGER,
            site_id INTEGER,
            atm_x REAL,
            atm_y REAL,
            atm_z REAL,
            base_x REAL,
            base_y REAL,
            base_z REAL,
            bbase_x REAL,
            bbase_y REAL,
            bbase_z REAL,
            base2_x REAL,
            base2_y REAL,
            base2_z REAL,
            FOREIGN KEY(site_id, struct_id) REFERENCES hbond_sites(site_id, struct_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, site_id));

-   **hbond\_site\_environment** The energy and geometry of hydrogen bonds depends upon its structural context. The hbond\_site\_environment table collects measures of burial, secondary structure, and total hydrogen bonding.
    -   *sasa\_r100* , *sasa\_r140* , *sasa\_r200* : The solvent accessible surface area of the heavy atom of the polar site with water probes of 1.0A, 1.4A and 2.0A.
    -   *hbond\_energy* : Half of the the total energy of all hbonds at the polar site.
    -   *num\_hbonds* : The number of hbonds at the polar site.

<!-- -->

        CREATE TABLE IF NOT EXISTS hbond_site_environment (
            struct_id INTEGER,
            site_id INTEGER,
            sasa_r100 REAL,
            sasa_r140 REAL,
            sasa_r200 REAL,
            hbond_energy REAL,
            num_hbonds INTEGER,
            FOREIGN KEY(struct_id, site_id) REFERENCES hbond_sites(struct_id, site_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, site_id));

-   **hbond\_sites\_pdb** The PDB file format stores identification, geometric and experimental information about each atom. Here, the information stored for the heavy atom of the polar site is stored.
    -   *chain* , *resNum* , *icode* : The PDB identifier of the for the heavy atom. NOTE, the *icode* is necessary to uniquely identify an atom. NOTE: The rosetta numbering and the PDB numbering may be different.
    -   *heavy\_atom\_temperature* : The temperature factor which measures the disorder of the heavy atom.
    -   *heavy\_atom\_occupancy* : The occupancy for the heavy atom.

<!-- -->

       CREATE TABLE IF NOT EXISTS hbond_sites_pdb (
            struct_id INTEGER,
            site_id INTEGER,
            chain TEXT,
            resNum INTEGER,
            iCode TEXT,
            heavy_atom_temperature REAL,
            heavy_atom_occupancy REAL,
            FOREIGN KEY(struct_id, site_id) REFERENCES hbond_sites(struct_id, site_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, site_id));

-   **hbond\_chem\_types** : Text labels for the chemical type classifications
    -   *chem\_type* : The *HBChemType* column in the *hbond\_sites* table reference this.
    -   *label* : A label for the chemical type in the form \<a|d\>\<three-letter-chem-type-code\>: \<one-letter-amino-acid-types-where-this-type-is-found\>. For example *hbdon\_HXL* has *dHXL: s,t* as it's label.

<!-- -->

        CREATE TABLE IF NOT EXISTS hbond_chem_types (
            chem_type TEXT,
            label TEXT,
            PRIMARY KEY(chem_type));

-   **hbonds** : A *hydrogen bond* is defined to be a donor *hbond\_site* and acceptor *hbond\_site* where bonding energy is negative.
    -   *HBEvalType* : The hbond evaluation type (rosetta/main/source/src/core/scoring/hbonds/hbonds_geom.cc) encodes the chemical context of the hydrogen bond.
    -   *energy* : The hbond energy is computed by evaluating the geometric parameters of the hydrogen bond.
    -   *envWeight* : If specified in the HBondOptions (rosetta/main/source/src/core/scoring/hbonds/HBondOptions.hh), the energy of a hydrogen bond can depend upon the solvent environment computed by the number of neighbors in the 10A neighbor graph.
    -   *score\_weight* : The weight of this hydrogen bond in the provided score function. Each HBEvalType is associated with a HBondWeighType (rosetta/main/source/src/core/scoring/hbonds/types.hh) as a column in the HBEval.csv (rosetta/main/database/scoring/score_functions/hbonds/standard_params/HBEval.csv) file in a hbond parameter set. The HBondWeighType is then associated with a ScoreType via hb\_eval\_type\_weight (rosetta/main/source/src/core/scoring/hbonds/hbonds.cc). To get the total energy multiply *energy* \* *envWeight* \* *score\_weight* .
    -   *donRank* : 0 if this is the only hbond at donor site. Otherwise *i* , where this hbond is the *i* th strongest hbond at the donor.
    -   *accRank* : 0 if this is the only hbond at acceptor site. Otherwise *i* , where this hbond is the *i* th strongest hbond at the acceptor.

<!-- -->

        CREATE TABLE IF NOT EXISTS hbonds (
            struct_id INTEGER,
            hbond_id INTEGER,
            don_id INTEGER,
            acc_id INTEGER,
            HBEvalType INTEGER,
            energy REAL,
            envWeight REAL,
            score_weight REAL,
            donRank INTEGER,
            accRank INTEGER,
            FOREIGN KEY (struct_id, don_id) REFERENCES hbond_sites (struct_id, site_id) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY (struct_id, acc_id) REFERENCES hbond_sites (struct_id, site_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, hbond_id));

-   **hbond\_geom\_coords** : The geometric parameters of a hydrogen bond are used to evaluate the energy of the of interaction.
    -   *AHdist* : The distance between the *acceptor* and *hydrogen* atoms.
    -   *cosBAH* : The cosine of the angle defined by the *base* , *acceptor* and *hydrogen* atoms.
    -   *cosAHD* : The cosine of the angle defined by the *acceptor* , *hydrogen* and *donor* atoms.
    -   *chi* : The torsional angle defined by the *abase2* , *base* , *acceptor* and *hydrogen* atoms.

<!-- -->

        CREATE TABLE IF NOT EXISTS hbond_geom_coords (
            struct_id INTEGER,
            hbond_id INTEGER,
            AHdist REAL,
            cosBAH REAL,
            cosAHD REAL,
            chi REAL,
            FOREIGN KEY(struct_id, hbond_id) REFERENCES hbonds(struct_id, hbond_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, hbond_id));

-   **hbond\_lennard\_jones** : The Lennard-Jones attraction energy ( *atrE* ), repulsion energy ( *repE* ), and solvation energy ( *solv* ) are computed over pairs of atoms. Because of the large number of such atom pairs, reporting the geometry and energy for each instance is too costly. However, since the LJ terms may double count the interaction energy between hydrogen bonding atoms, the LJ interactions between just hydrogen bonding atoms are explicitly reported here.
    -   *don\_acc* : LJ energy between the *donor* and the *acceptor* atoms
    -   *don\_acc\_base* : JL energy between the *donor* and the *acceptor base* atoms
    -   *h\_acc* : LJ energy between the *hydrogen* and *acceptor* atoms
    -   *h\_acc\_base* : JL energy between the *hydrogen* and *acceptor base* atoms
        -   Note: To compare these energies against hydrogen energies, they must be weighted by the ScoreFunction weight set.

<!-- -->

        CREATE TABLE IF NOT EXISTS hbond_lennard_jones (
            struct_id INTEGER,
            hbond_id INTEGER,
            don_acc_atrE REAL,
            don_acc_repE REAL,
            don_acc_solv REAL,
            don_acc_base_atrE REAL,
            don_acc_base_repE REAL,
            don_acc_base_solv REAL,
            h_acc_atrE REAL,
            h_acc_repE REAL,
            h_acc_solv REAL,
            h_acc_base_atrE REAL,
            h_acc_base_repE REAL,
            h_acc_base_solv REAL,
            FOREIGN KEY (struct_id, hbond_id) REFERENCES hbonds (struct_id, hbond_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, hbond_id));

HBondParameterFeatures
----------------------

The parameters for the hydrogen bond potential are specified in the Rosetta database as  parameter sets (rosetta/main/database/scoring/score_functions/hbonds). Each parameter set specifies polynomials, fade functions, and which are applied to which hydrogen bond chemical types. To indicate parameter set, either use *-hbond\_params \<database\_tag\>* set on the command line, or set *score\_function.energy\_method\_options().hbond\_options()-\>params\_database\_tag(\<database\_tag\>)* . See the HBondDatabase class (rosetta/main/source/src/core/scoring/hbonds/HBondDatabase.hh) for more information.

-   **hbond\_fade\_interval** : Limited interaction between geometric dimensions are controlled by simple fading functions of the form \_\_/----\\\_\_. See the FadeInterval (rosetta/main/source/src/core/scoring/hbonds/FadeInterval.hh) class for more information.
    -   *database\_tag* : The hydrogen bond parameter set
    -   *name* : The name of the fade interval referenced in the *hbond\_evaluation\_types* table
    -   *junction\_type* : The junction type indicates how the function between the knots should be interpolated. Currently the options are *piecewise\_linear* , and *smooth* which uses a cubic spline with zero derivative at at the knots.
    -   *min0* , *fmin* , *fmax* , *max0* : The x-coordinates of the knots

<!-- -->

        CREATE TABLE IF NOT EXISTS hbond_fade_interval(
            database_tag TEXT,
            name TEXT,
            junction_type TEXT,
            min0 REAL,
            fmin REAL,
            fmax REAL,
            max0 REAL,
            PRIMARY KEY(database_tag, name));

-   **hbond\_polynomial\_1d** : One dimensional polynomials for each geometric dimension used to compute the hydrogen bond energy. See the Polynomial\_1d (rosetta/main/source/src/core/scoring/hbonds/polynomials.hh) class for more information.
    -   *database\_tag* : The hydrogen bond parameter set
    -   *name* : The name of the polynomial referenced in the *hbond\_evaluation\_types* table.
    -   *dimension* : The geometric dimension with which the polynomial should be used.
    -   *xmin* , *xmax* : The polynomial is truncated beyond the *xmin* and *xmax* values.
    -   *root1* , *root2* : The values where the polynomial equals 0.
    -   *degree* : The number of coefficients in the polynomial. For example 10x\^2 - 3x + 1 would have degree 3.
    -   *a\_\** : The coefficients of the polynomial, ordered from highest power to the lowest power.

<!-- -->

        CREATE TABLE IF NOT EXISTS hbond_polynomial_1d (
            database_tag TEXT,
            name TEXT,
            dimension TEXT,
            xmin REAL,
            xmax REAL,
            root1 REAL,
            root2 REAL,
            degree INTEGER,
            c_a REAL,
            c_b REAL,
            c_c REAL,
            c_d REAL,
            c_e REAL,
            c_f REAL,
            c_g REAL,
            c_h REAL,
            c_i REAL,
            c_j REAL,
            c_k REAL,
            PRIMARY KEY(database_tag, name));

-   **hbond\_evaluation\_types** : Associate to (donor chemical type, acceptor chemical type, sequence separation) hydrogen bond types, the which fade intervals, polynomials and weight types to be used in evaluating and assigning hydrogen bond energy.
    -   *database\_tag* : The hydrogen bond parameter set
    -   *don\_chem\_type* : The donor chemical type component of the hydrogen bond type. This is the value used in the hbond\_site.HBChemType column when the site is a hydrogen bond donor.
    -   *acc\_chem\_type* : The acceptor chemical type component of the hydrogen bond type. This is the value used in the hbond\_site.HBChemType column when the site is a hydrogen bond acceptor.
    -   *separation* : The sequence separation type component of the hydrogen bond type. This is used as a proxy for participation in local sequence motifs like intra-helix hydrogen bonding. NOTE: Separation is defined as *acc\_resNum* - *don\_resNum* when both residues are polymers and on the same chain and infinity otherwise.
    -   *AHdist\_{short/long}\_fade* : The fading functions to be applied to the AHdist polynomial evaluations. The short/long distinction allows for different angle dependence for hydrogen bonds that have different bond lengths. The distinction follows in spirit the behavior originally described in Kortemme 2003.
    -   *{cosBAH/cosAHD}\_fade* : The fading functions to be applied to the cosBAH/cosAHD polynomial evaluations.
    -   *AHdist* : Polynomial to be used for the evaluation of the Acceptor -- Hydrogen distance geometric degree of freedom.
    -   *cosBAH\_{short/long}* : Polynomials to be used for the evaluation of the cosine of the Acceptor Base -- Acceptor -- Hydrogen geometric degree of freedom.
    -   *cosAHD\_{short/long}* : Polynomials to be used for the evaluation of the cosine of the Acceptor -- Hydrogen -- Donor geometric degree of freedom.
    -   *weight\_type* : Which slot in the score vector the energy of the hydrogen bond should be accumulated into. See the WeightType for allowable types.

<!-- -->

       CREATE TABLE IF NOT EXISTS hbond_evaluation_types (
            database_tag TEXT,
            don_chem_type TEXT,
            acc_chem_type TEXT,
            separation TEXT,
            AHdist_short_fade TEXT,
            AHdist_long_fade TEXT,
            cosBAH_fade TEXT,
            cosAHD_fade TEXT,
            AHdist TEXT,
            cosBAH_short TEXT,
            cosBAH_long TEXT,
            cosAHD_short TEXT,
            cosAHD_long TEXT,
            weight_type TEXT,
            FOREIGN KEY(database_tag, AHdist_short_fade) REFERENCES hbond_fade_interval(database_tag, name) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY(database_tag, AHdist_long_fade)  REFERENCES hbond_fade_interval(database_tag, name) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY(database_tag, cosBAH_fade)       REFERENCES hbond_fade_interval(database_tag, name) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY(database_tag, cosAHD_fade)       REFERENCES hbond_fade_interval(database_tag, name) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY(database_tag, AHdist)            REFERENCES hbond_polynomial_1d(database_tag, name) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY(database_tag, cosBAH_short)      REFERENCES hbond_polynomial_1d(database_tag, name) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY(database_tag, cosBAH_long)       REFERENCES hbond_polynomial_1d(database_tag, name) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY(database_tag, cosAHD_short)      REFERENCES hbond_polynomial_1d(database_tag, name) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY(database_tag, cosAHD_long)       REFERENCES hbond_polynomial_1d(database_tag, name) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (database_tag, don_chem_type, acc_chem_type, separation));

JobDataFeatures
---------------

Store *string* , *string* - *string* , and *string* - *real* data associated with a job. As an example, the ligand docking code this way when it uses the DatabaseJobOutputter.

-   **job\_string\_data**
    -   *data\_key* : Associate labeled keys with a structure

<!-- -->

        CREATE TABLE IF NOT EXISTS string_data (
             struct_id INTEGER,
             data_key TEXT,
             FOREIGN KEY (struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
             PRIMARY KEY (struct_id, data_key));

-   **job\_string\_string\_data** :
    -   *data\_key* , *data\_value* : Associate labeled text strings with a structure

<!-- -->

        CREATE TABLE IF NOT EXISTS string_string_data (
             struct_id INTEGER,
             data_key TEXT,
             data_value TEXT,
             FOREIGN KEY (struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
             PRIMARY KEY (struct_id, data_key));

-   **job\_string\_real\_data** :
    -   *data\_key* , *data\_value* : Associate labeled, real numbers with a structure

<!-- -->

        CREATE TABLE IF NOT EXISTS string_real_data (
             struct_id INTEGER,
             data_key TEXT,
             data_value REAL,
             FOREIGN KEY (struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
             PRIMARY KEY (struct_id, data_key));

LoopAnchorFeatures
------------------

        <LoopAnchorFeatures min_loop_length=5 max_loop_length=7/>

This reporter scans all available windows of a specified number of residues and calculates the translation and rotation to optimally superimpose the landing onto the takeoff of the loop. The translation and rotation data can then be used to compare different "classes" of loop anchors.

-   **min\_loop\_length** : The minimum span of residues to compute the translation and rotation on.
-   **max\_loop\_length** : The maximum span of residues to compute the translation and rotation on.

<!-- -->

        CREATE TABLE IF NOT EXISTS loop_anchors (
            struct_id INTEGER,
            residue_begin INTEGER,
            residue_end INTEGER,
            FOREIGN KEY (struct_id, residue_begin)
            REFERENCES residues (struct_id, resNum)
            DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY (struct_id, residue_end)
            REFERENCES residues (struct_id, resNum)
            DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, residue_begin, residue_end));

        CREATE TABLE IF NOT EXISTS loop_anchor_transforms (
            struct_id INTEGER,
            residue_begin INTEGER,
            residue_end INTEGER,
            x REAL,
            y REAL,
            z REAL,
            phi REAL,
            psi REAL,
            theta REAL,
            FOREIGN KEY (struct_id, residue_begin, residue_end)
            REFERENCES loop_anchors (struct_id, residue_begin, residue_end)
            DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, residue_begin, residue_end));

OrbitalFeatures
---------------

The OrbitalFeatures stores information about chemical interactions involving orbitals. Orbitals are atomically localized electrons that can form weak, orientation dependent interactions with polar and aromatic functional groups and other orbitals. Orbital geometry are defined in the residue type sets in the database. Following the orbitals score term, orbitals are defines between residues where the action center is at most 11A apart.

-   **orbital\_polar\_hydrogen\_interactions** : Interactions between orbitals and polar hydrogens. Intra-residue interactions are excluded.
    -   *polar hydrogens* : Polar hydrogens are identified by *res2.Hpos\_polar\_sc()*
    -   *orbName1* : This is like *LP10* and is the second column of the ORBITALS tag in the residue parameter files.
    -   *dist* : This is the distance between the orbital and the polar hydrogen
    -   *angle* : This is the cosine of the angle defined by the atom the orbital is attached to, the orbital and the polar hydrogen.

<!-- -->

        CREATE TABLE IF NOT EXISTS orbital_polar_hydrogen_interactions (
            struct_id TEXT,
            resNum1 INTEGER,
            orbNum1 INTEGER,
            orbName1 TEXT,
            resNum2 INTEGER,
            hpolNum2 INTEGER,
            dist REAL,
            angle REAL,
            FOREIGN KEY (struct_id, resNum1) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY (struct_id, resNum2) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, resNum1, orbNum1, resNum2, hpolNum2));

-   **orbital\_aromatic\_hydrogen\_interactions** : Interactions between orbitals and aromatic hydrogens. Intra-residue interactions are excluded.
    -   *aromatic hydrogens* : Aromatic hydrogens are identified by *res2.Haro\_index()*
    -   *orbName1* : This is like *LP10* and is the second column of the ORBITALS tag in the residue parameter files.
    -   *dist* : This is the distance between the orbital and the aromatic hydrogen
    -   *angle* : This is the cosine of the angle defined by the atom the orbital is attached to, the orbital and the aromatic hydrogen.

<!-- -->

        CREATE TABLE IF NOT EXISTS orbital_aromatic_hydrogen_interactions (
            struct_id TEXT,
            resNum1 INTEGER,
            orbNum1 INTEGER,
            orbName1 TEXT,
            resNum2 INTEGER,
            haroNum2 INTEGER,
            dist REAL,
            angle REAL,
            FOREIGN KEY (struct_id, resNum1) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY (struct_id, resNum2) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, resNum1, orbNum1, resNum2, haroNum2));

-   **orbital\_polar\_hydrogen\_interactions** : Interactions between orbitals and polar hydrogens. Intra-residue interactions are excluded. To avoid double counting, *resNum1 \< resNum2* .
    -   *polar hydrogens* : Polar hydrogens are indexed from *1' to* res2.n\_orbitals()
    -   *orbName1* : This is like *LP10* and is the second column of the ORBITALS tag in the residue parameter files.
    -   *dist* : This is the distance between the orbital and the second orbital
    -   *angle* : This is the cosine of the angle defined by the atom the orbital is attached to, the orbital and the second orbital.

<!-- -->

        CREATE TABLE IF NOT EXISTS orbital_orbital_interactions (
            struct_id TEXT,
            resNum1 INTEGER,
            orbNum1 INTEGER,
            orbName1 TEXT,
            resNum2 INTEGER,
            orbNum2 INTEGER,
            dist REAL,
            angle REAL,
            FOREIGN KEY (struct_id, resNum1) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY (struct_id, resNum2) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, resNum1, orbNum1, resNum2, orbNum2));

PairFeatures
------------

PairFeatures measures the distances between residues.

-   **residue\_pairs** : The information stored here follows 'pair' EnergyMethod. The functional form for the pair EnergyMethod is described in [Simons, K.T., et al, Improved Recognition of Native-Like Protein Structures Using a Combination of Sequence-Dependent and Sequence-Independent Features of Proteins, (Proteins 1999).](http://www.ncbi.nlm.nih.gov/pubmed/10336385,)
    -   *resNum{1/2}* : the rosetta Residue indices of residues involved. Note, each pair is only recorded once and resNum1 \< resNum2.
    -   *res{1/2}\_10A\_neighbors* : Number of neighbors for each residue, used as a proxy for burial. (These columns are going to be moved to the **residue\_burial** table soon.)
	-   A *residue center* is represented by the actcoord which is defined to be the average geometric center of of the ACT\_COORD\_ATOMS specified in the [[residue type|Glossary#residuetype]] params file for each residue type.
    -   *actcoord\_dist* : The cartesian distance between residue centers.
    -   *polymeric\_sequence\_dist* : The sequence distance between the residues. If either residue is not a *polymer* residue or if they are on different chains, this is -1.

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_pairs (
            struct_id INTEGER,
            resNum1 INTEGER,
            resNum2 INTEGER,
            res1_10A_neighbors INTEGER,
            res2_10A_neighbors INTEGER,
            actcoord_dist REAL,
            polymeric_sequence_dist INTEGER,
            FOREIGN KEY (struct_id, resNum1) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY (struct_id, resNum2) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            CONSTRAINT res1_10A_neighbors_is_positive CHECK (res1_10A_neighbors >= 1),
            CONSTRAINT res2_10A_neighbors_is_positive CHECK (res2_10A_neighbors >= 1),
            CONSTRAINT actcoord_dist_is_nonnegative CHECK (actcoord_dist >= 0));

PdbDataFeatures
---------------

PdbDataFeatures records information that is stored in the protein databank structure format.

        <PdbDataFeatures/>

-   **residue\_pdb\_identification** : Identify residues using the PDB nomenclature. Note, this numbering has biological relevance and therefore may be negative, skip numbers, etc. When using the *DatabaseInputer* or *DatabaseOutputter* with the Rosetta job distributor, this table is mapped to the PDBInfo object.
    -   *struct\_id* , *residue\_number* : References the primary key in the residues table
    -   *chain\_id* : ATOM record columns 21
    -   *insertion\_code* : ATOM record column 26
    -   *pdb\_residue\_number* : PDB identification 22-25

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_pdb_identification (
            struct_id INTEGER,
            residue_number INTEGER,
            chain_id TEXT,
            insertion_code TEXT,
            pdb_residue_number INTEGER,
            FOREIGN KEY (struct_id, residue_number)
                REFERENCES residues (struct_id, resNum)
                DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (struct_id, residue_number));

-   **residue\_pdb\_confidence** : Summarize atom level confidence measures (B-factors and occupancy) to the residue level with the intention that they will be used to filter out residues.
    -   *max\_\*\_temperature* : The maximum temperature (ATOM record columns 60-65) over different atom subsets: all, backbone, sidechain.
    -   *min\_\*\_occupancy* : The minimum occupancy (ATOM record columns 54-59) over different atom subsets: all, backbone, sidechain.

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_pdb_confidence (
            struct_id INTEGER,
            residue_number INTEGER,
            max_temperature REAL,
            max_bb_temperature REAL,
            max_sc_temperature REAL,
            min_occupancy REAL,
            min_bb_occupancy REAL,
            min_sc_occupancy REAL,
            FOREIGN KEY (struct_id, residue_number)
                REFERENCES residues (struct_id, resNum)
                DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (struct_id, residue_number));

PoseCommentFeatures
-------------------

Arbitrary textual information may be associated with a pose in the form of *(key, val)* comments. The PoseCommentsFeatures stores this information as a feature.

-   **pose\_comments** : All pose comments are extracted using.

<!-- -->

        CREATE TABLE IF NOT EXISTS pose_comments (
            struct_id INTEGER,
            key TEXT,
            value TEXT,
            FOREIGN KEY (struct_id) REFERENCES structures (struct_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, key));

PoseConformationFeatures
------------------------

PoseConformationFeatures measures the conformation level information in a Pose. Together with the ProteinResidueConformationFeatures, the atomic coordinates can be reconstructed. To facilitate creating poses from conformation structure data stored in the features database, PoseConformationFeatures has a *load\_into\_pose* method.

-   **pose\_conformations** : This table stores information about sequence of residues in the conformation.
	-   *annotated\_sequence* : The [[annotated sequence|Glossary#annotated-sequence]] string of residue types that make up the conformation
    -   *total\_residue* : The number of residues in the conformation
    -   *fullatom* : The ResidueTypeSet is *FA\_STANDARD* if true, and *CENTROID* if false.

<!-- -->

        CREATE TABLE IF NOT EXISTS pose_conformations (
            struct_id INTEGER PRIMARY KEY,
            annotated_sequence TEXT,
            total_residue INTEGER,
            fullatom BOOLEAN,
            FOREIGN KEY (struct_id) REFERENCES structures (struct_id) DEFERRABLE INITIALLY DEFERRED);

-   **fold\_trees** : The fold tree specifies a graph of how the residues are attached together. If the residues are thought of as vertices, each row in the *fold\_trees* table specifies a directed edge.
    -   *(start\_res, start\_atom)* : The initial residue and the attachment atom within the residue
    -   *(end\_res, end\_atom)* : The terminal residue and the attachment atom with the residue
    -   *label* : -2 if it is a *CHEMICAL* edge, -1 if is a *PEPTIDE* edge, and 1, 2, ... is a *JUMP* attachment. The geometry of the *JUMP* attachments is stored in the *jumps* table.
    -   *keep\_stub\_in\_residue* : For completeness, the option to keep stub in residue is stored.

<!-- -->

        CREATE TABLE IF NOT EXISTS fold_trees (
            struct_id INTEGER,
            start_res INTEGER,
            start_atom TEXT,
            stop_res INTEGER,
            stop_atom TEXT,
            label INTEGER,
            keep_stub_in_residue BOOLEAN,
            FOREIGN KEY (struct_id) REFERENCES structures (struct_id) DEFERRABLE INITIALLY DEFERRED);

-   **jumps** : Each *JUMP* edge in the fold tree is specified by a coordinate transformation, which is encoded in the *jumps* table.
    -   *jump\_id* : The canonical ordering of jumps in a conformation.
    -   {x,y,z}{x,y,z}: coordinates of the rotation matrix
    -   {x,y,z}: coordinates of the translation vector

<!-- -->

        CREATE TABLE IF NOT EXISTS jumps (
            struct_id INTEGER,
            jump_id INTEGER,
            xx REAL,
            xy REAL,
            xz REAL,
            yx REAL,
            yy REAL,
            yz REAL,
            zx REAL,
            zy REAL,
            zz REAL,
            x REAL,
            y REAL,
            z REAL,
            FOREIGN KEY (struct_id) REFERENCES structures (struct_id) DEFERRABLE INITIALLY DEFERRED);

-   **chain\_endings** : The conformation is broken into chemically bonded chains, which are identified by the chain endings. Note: If there are *n* chains, then there are *n-1* chain\_endings.
    -   *end\_pos* : The last sequence position in the conformation of a chain.

<!-- -->

        CREATE TABLE IF NOT EXISTS chain_endings (
            struct_id INTEGER,
            end_pos INTEGER,
            FOREIGN KEY (struct_id) REFERENCES structures (struct_id) DEFERRABLE INITIALLY DEFERRED);

ProteinBackboneAtomAtomPairFeatures
-----------------------------------

The ProteinBackboneAtomAtomPairFeatures reporter measures all the atom pair distances between backbone atoms in pairs residues where the action coordinate is within 10A. This follows the analysis done in *Song Y, Tyka M, Leaver-Fay A, Thompson J, Baker D. Structure guided forcefield optimization. Proteins: Structure, Function, and Bioinformatics. 2011* . There, they looked at these distances for pairs of residues that form secondary structure.

-   **protein\_backbone\_atom\_atom\_pairs** :
    -   *resNum{1,2}* : The indices of the protein residues. Note: resNum1 \< resNum2.
    -   *{N,Ca,C,O,Ha}\_{N,Ca,C,O,Ha}\_dist* : The distance between the the *N* , *Ca* , *C* , *O* or *Ha* atom on the first residue to the *N* , *Ca* , *C* , *O* or *Ha* atom on the second residue.

<!-- -->

        CREATE TABLE IF NOT EXISTS protein_backbone_atom_atom_pairs (
            struct_id TEXT,
            resNum1 INTEGER,
            resNum2 INTEGER,
             N_N_dist REAL,  N_Ca_dist REAL,  N_C_dist REAL,  N_O_dist REAL,  N_Ha_dist REAL,
            Ca_N_dist REAL, Ca_Ca_dist REAL, Ca_C_dist REAL, Ca_O_dist REAL, Ca_Ha_dist REAL,
             C_N_dist REAL,  C_Ca_dist REAL,  C_C_dist REAL,  C_O_dist REAL,  C_Ha_dist REAL,
             O_N_dist REAL,  O_Ca_dist REAL,  O_C_dist REAL,  O_O_dist REAL,  O_Ha_dist REAL,
            Ha_N_dist REAL, Ha_Ca_dist REAL, Ha_C_dist REAL, Ha_O_dist REAL, Ha_Ha_dist REAL,
            FOREIGN KEY (struct_id, resNum1) REFERENCES residues (struct_id, resNum1) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY (struct_id, resNum2) REFERENCES residues (struct_id, resNum2) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (struct_id, resNum1, resNum2));

ProteinBackboneTorsionAngleFeatures
-----------------------------------

The ProteinBackboneTorsionAngleFeatures reporter stores the backbone torsion angle degrees of freedom needed represent proteins made with canonical backbones.

-   **protein\_backbone\_torsion\_angles** :
    -   *phi* : The torsion angle defined by *C\_(i-1)* , *N\_i* , *Ca\_i* , and *C\_i* atoms (-180, 180)
    -   *psi* : The torsion angle defined by *N\_i* , *Ca\_i* , *C\_i* , and *N\_(i+1)* atoms (-180, 180)
    -   *omega* : The torsion angle defined by *Ca\_i* , *C\_i* , *N\_(i+1)* , and *Ca\_(i+1)* (-180, 180)

<!-- -->

        CREATE TABLE IF NOT EXISTS protein_backbone_torsion_angles (
            struct_id TEXT,
            resNum INTEGER,
            phi REAL,
            psi REAL,
            omega REAL,
            FOREIGN KEY (struct_id, resNum) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (struct_id, resNum));

ProteinResidueConformationFeatures
----------------------------------

The conformation of protein residues is described by the coordinates of each atom. A reduced representation is just specifying the values for each torsional angle degree of freedom, these include the backbone and sidechain torsional angles. Since Proteins have only canonical amino acids, there are at most 4 torsional angles in the sidechains.

-   **protein\_residue\_conformation** : The degrees of freedom in each residue conformation.
    -   *secstruct* : The secondary structure of the residue. NOTE: this is not computed by DSSP but taken from fragments.
    -   *phi* , *psi* , *omega* : Backbone torsional angles
    -   *chi\** : Sidechain torsional angles

<!-- -->

        CREATE TABLE IF NOT EXISTS protein_residue_conformation (
            struct_id INTEGER,
            seqpos INTEGER,
            secstruct STRING,
            phi REAL,
            psi REAL,
            omega REAL,
            chi1 REAL,
            chi2 REAL,
            chi3 REAL,
            chi4 REAL,
            FOREIGN KEY (struct_id, seqpos) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED);"

-   **residue\_atom\_coords** : The atomic coordinates for each residue. Note if all of the residues are ideal, then this table is not populated.
    -   *x* , *y* , *z* : Atomic coordinates in lab coordinate frame.

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_atom_coords (
            struct_id INTEGER,
            seqpos INTEGER,
            atomno INTEGER,
            x REAL,
            y REAL,
            z REAL,
            FOREIGN KEY (struct_id, seqpos) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED);

ProteinRMSDFeatures
-------------------

Compute the atom-wise root mean squared deviation between the conformation being reported and a previously saved conformation. The usage of this mover is more involved than other feature movers:

        <ROSETTASCRIPTS>
            <MOVERS>
                <SavePoseMover name=spm_init_struct reference_name=init_struct/>
                <ReportToDB name=features_reporter db="features_SAMPLE_SOURCE_ID.db3" sample_source="SAMPLE_SOURCE_DESCRIPTION">
                    <ProteinRMSDFeatures reference_name=init_struct/>
                </ReportToDB>
            </MOVERS>
            <PROTOCOLS>
                <Add mover_name=spm_init_struct/>
                <Add mover_name=features_reporter/>
            </PROTOCOLS>
        </ROSETTASCRIPTS>

-   **protein\_rmsd** :
    -   *reference\_tag* : The tag of the structure this structure is compared against
    -   *protein\_CA* : the C-alpha atoms of protein residues are considered
    -   *protein\_CA\_or\_CB* : the C-alpha and C-beta atoms of protein residues are considered
    -   *protein\_backbone* : the backbone atoms (N, C-alpha, C) of protein residues are considered
    -   *protein\_backbone\_including\_O* : the backbone atoms and the carbonyl oxygen atoms of protein residues are considered
    -   *protein\_backbone\_sidechain\_heavy\_atom* : the non-hydrogen atoms of protein residues are considered
    -   *heavyatom* : all non-hydrogen atoms are considered
    -   *nbr\_atom* : the neighbor atoms are considered (the C-beta atom for canonical proteins) see the NBR\_ATOM tag in the residue topology files
    -   *all\_atom* : all atoms are considered

<!-- -->

        CREATE TABLE IF NOT EXISTS protein_rmsd (
            struct_id INTEGER,
            reference_tag TEXT,
            protein_CA REAL,
            protein_CA_or_CB REAL,
            protein_backbone REAL,
            protein_backbone_including_O REAL,
            protein_backbone_sidechain_heavyatom REAL,
            heavyatom REAL,
            nbr_atom REAL,
            all_atom REAL,
            FOREIGN KEY (struct_id) REFERENCES structures (struct_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (struct_id, reference_tag));

ProtocolFeatures
----------------

A protocol is represented as all the information necessary to reproduce the results of the Rosetta application execution. The features associated of each application execution are ultimately linked with a single row in the protocols table. Note, that since the *struct\_id* is an autoincremented primary key of the structures table, often the results from different application executions are attached attached but not merged.

-   **protocols** :
    -   *command\_line* : The complete command line used to execute Rosetta
    -   *specified\_options* : The non-default options specified in the option system.
    -   *svn\_url* : The url for the SVN repository used for the Rosetta source code.
    -   *svn\_version* : The SVN revision number of the svn repository.
    -   *script* : The contents of the rosetta\_scripts XML script if run via the rosetta\_scripts system.

<!-- -->

        CREATE TABLE IF NOT EXISTS protocols (
            protocol_id INTEGER PRIMARY KEY AUTOINCREMENT,
            command_line TEXT,
            specified_options TEXT,
            svn_url TEXT,
            svn_version TEXT,
            script TEXT);

RadiusOfGyrationFeatures
------------------------

Measure the radius of gyration for each structure. The radius of gyration measure of how compact a structure is in O(n). It is the expected displacement of mass from the center of mass. The Wikipedia page is has some [information](http://en.wikipedia.org/wiki/Radius_of_gyration) . Also see, Lobanov MY, Bogatyreva NS, Galzitskaya OV. [Radius of gyration as an indicator of protein structure compactness](http://www.springerlink.com/content/v01q1r143528u261/) . Molecular Biology. 2008;42(4):623-628.

-   **radius\_of\_gyration** :
    -   *radius\_of\_gyration* : Let *C* be the center of mass and *ri* be the position of residue *i'* th of *n* residues, then the radius of gyration is defined to be *Rg = SQRT{SUM\_{ri}(ri-C)\^2/(n-1)}* . Note: the normalizing factor is *n-1* to be consistent with r++. Atoms with variant type "REPLONLY" are ignored.

<!-- -->

        CREATE TABLE IF NOT EXISTS radius_of_gyration (
            struct_id INTEGER,
            radius_of_gyration REAL,
            FOREIGN KEY(struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id));

ResidueBurialFeatures
---------------------

Measures of burial are important for determining solvation and desolvation effects.

-   **residue\_burial** :
    -   *ten\_a\_neighbors* : The number of residues within 10 Angstroms (not counting the residue itself. The distance is measured from the NBR\_ATOM in the residue type parameter file which is usually the C-beta atom.
    -   *twelve\_a\_neighbors* : The number of residues within 12 Angstroms.
    -   *neigh\_vect\_raw* : The length of the average displacement of neighboring residues. The region of inclusion is set by the options *score:NV\_lbound* and *score:NV\_ubound* , defaulting to 3.3 and 11.1 Angstroms. This follows the [Durham E, et al. Solvent Accessible Surface Area Approximations for Protein Structure Prediction](http://www.ncbi.nlm.nih.gov/pubmed/19234730) .
    -   *sasa\_r100* , *sasa\_r140* , *sasa\_200* : The solvent accessible surface area with different sizes of probes (1.0A, 1.4A, 2.0A).

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_burial (
            struct_id TEXT,
            resNum INTEGER,
            ten_a_neighbors INTEGER,
            twelve_a_neighbors INTEGER,
            neigh_vect_raw REAL,
            sasa_r100 REAL,
            sasa_r140 REAL,
            sasa_r200 REAL,
            FOREIGN KEY (struct_id, resNum) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (struct_id, resNum));

ResidueConformationFeatures
---------------------------

Store the geometry of residues that have canonical backbones but possibly non-canonical sidechains. The geometry is broken into backbone torsional degrees of freedom, *nonprotein\_residue\_conformation* , sidechain degrees of freedom, *nonprotein\_residue\_angles* , and atomic coordinates *residue\_atom\_coords* .

This differs from ProteinResidueConformationFeatures in that the residue angles are stored as a *chinum* -\> *chiangle* lookup and atomic xzy-coordinates, rather than a table with slots for 4 chi values. If you know you are going to be only working with protein residues, you can conserve space by using the ProteinResidueConformationFeatures.

-   **nonprotein\_residue\_conformation** :
    -   *phi* , *psi* , *omega* : Angles of backbone torsional degrees of freedom

<!-- -->

        CREATE TABLE IF NOT EXISTS nonprotein_residue_conformation (
            struct_id INTEGER,
            seqpos INTEGER,
            phi REAL,
            psi REAL,
            omega REAL,
            FOREIGN KEY (struct_id, seqpos) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (struct_id, seqpos));

-   **nonprotein\_residue\_angles** :
    -   *chinum* : The index of the chi torsional degree of freedom in the sidechain of the residue
    -   *chiangle* : The angle of the chi torsional degree of freedom in the sidechain of the residue

<!-- -->

        CREATE TABLE IF NOT EXISTS nonprotein_residue_angles (
        struct_id INTEGER,
        seqpos INTEGER,
        chinum INTEGER,
        chiangle REAL,
        FOREIGN KEY (struct_id, seqpos) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (struct_id, seqpos));

-   **residue\_atom\_coords** :
    -   *x* , *y* , *z* : Spatial coordinates of atom *atomno* in residue *seqpos* in the lab coordinate frame.

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_atom_coords (
        struct_id INTEGER,
        seqpos INTEGER,
        atomno INTEGER,
        x REAL,
        y REAL,
        z REAL,
        FOREIGN KEY (struct_id, seqpos) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (struct_id, seqpos, atomno));

ResidueFeatures
---------------

The ResidueFeatures stores information about each residue in a conformation.

-   **residues** : This connects the sequence position with with the name of the residue and the ResidueType of the residue.
    -   *name3* : The three letter amino acid code. If it is not a canonical amino acid it is *UNK* .
    -   *res\_type* : The unique identifier for the ResidueType of the residue.

<!-- -->

        CREATE TABLE IF NOT EXISTS residues (
            struct_id INTEGER,
            resNum INTEGER,
            name3 TEXT,
            res_type TEXT,
            FOREIGN KEY (struct_id)
            REFERENCES structures (struct_id)
            DEFERRABLE INITIALLY DEFERRED,
            CONSTRAINT resNum_is_positive CHECK (resNum >= 1),
            PRIMARY KEY(struct_id, resNum));

ResidueScoresFeatures
---------------------

        <ResidueScoresFeatures scorefxn="(&scorefxn)"/>

The ResidueScoresFeatures stores the score of a structure at the residue level. Terms that evaluate a single residue are stored in *residue\_scores\_1b* . Terms that evaluate pairs of residues are stored in *residue\_scores\_2b* . Terms that depend on the whole structure are stored via the StructureScoresFeatures.

-   **residue\_scores\_1b** : The one body scores for each residue in the structure.
    -   *score\_type* : The score type as a string
    -   *score\_value* : The score value
    -   *context\_dependent* : 0 if the score type is context-independent and 1 if it is context-dependent

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_scores_1b (                                                                                                                      
            struct_id INTEGER,                                                                                                                                              
            resNum INTEGER,                                                                                                                                                 
            score_type TEXT,                                                                                                                                                
            score_value REAL,                                                                                                                                               
            context_dependent INTEGER,                                                                                                                                     
            FOREIGN KEY (struct_id, resNum) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,                                                          
            PRIMARY KEY(struct_id, resNum, score_type)); 

-   **residue\_scores\_2b** : The two-body scores for each pair of residues in the structure. Note: Intra-residue two body terms are stored in this table with resNum1 == resNum2.
    -   *resNum1* , *resNum2* : The rosetta residue numbering for the participating residues. Note: *resNum1* \<= *resNum2*
    -   *score\_type* : The score type as a string
    -   *score\_value* : The score value
    -   *context\_dependent* : 0 if the score type is context-independent and 1 if it is context-dependent

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_scores_2b (
            struct_id INTEGER,
            resNum1 INTEGER,
            resNum2 INTEGER,
            score_type TEXT,
            score_value REAL,
            context_dependent  INTEGER,
            FOREIGN KEY (struct_id, resNum1) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY (struct_id, resNum2) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, resNum1, resNum2, score_type));

ResidueSecondaryStructureFeatures
---------------------------------

Secondary structure is a classification scheme for residues that participate in regular, multi-residue interactions.

-   **residue\_secondary\_structure** :
    -   *dssp* : The Dictionary of Secondary Structure classification scheme following [Kabsch and Sander, Dictionary of protein secondary structure: pattern recognition of hydrogen-bonded and geometrical features](http://onlinelibrary.wiley.com/doi/10.1002/bip.360221211/abstract) . The [coding](http://swift.cmbi.ru.nl/gv/dssp/) is described on their website.

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_secondary_structure(
            struct_id INTEGER,
            resNum INTEGER,
            dssp TEXT,
            FOREIGN KEY(struct_id, resNum) REFERENCES residues(struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, resNum));

ResidueTypesFeatures
--------------------

ResidueTypes store information about the chemical nature of the residue. The information is read in from the from */path/to/rosetta/main/database/chemical/residue\_type\_sets/\<residue\_type\_set\_name\>/residue\_types/* .

-   **residue\_type** :
    -   *residue\_type\_set\_name* : The name of the ResidueTypeSet. e.g. *FA\_STANDARD* or *CENTROID* .
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
            version TEXT,
            name TEXT,
            name3 TEXT,
            name1 TEXT,
            aa TEXT,
            lower_connect INTEGER,
            upper_connect INTEGER,
            nbr_atom INTEGER,
            nbr_radius REAL,
            PRIMARY KEY(residue_type_set_name, name));

-   **residue\_type\_atom** : Each atom in the residue type is identified.
    -   *residue\_type\_set\_name* : The name of the ResidueTypeSet e.g. *FA\_STANDARD* or *CENTROID* .
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
    -   *residue\_type\_set\_name* : The name of the ResidueTypeSet e.g. *FA\_STANDARD* or *CENTROID* .
    -   *atom1* , *atom2* : The atoms participating in the bond where the atom index of *atom1* is less than the atom index of *atom2* .
	-   *bond\_type* : The type of chemical bond.

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
    -   *residue\_type\_set\_name* : The name of the ResidueTypeSet e.g. *FA\_STANDARD* or *CENTROID* .
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
    -   *residue\_type\_set\_name* : The name of the ResidueTypeSet e.g. *FA\_STANDARD* or *CENTROID* .
    -   *chino* : The index of the chi degree of freedom
    -   *atom1* , *atom2* , *atom3* , *atom3* , *atom4* : The atoms that define the torsional degree of freedom

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_type_chi (
            residue_type_set_name TEXT,
            residue_type_name TEXT,
            chino INTEGER,
            atom1 TEXT,
            atom2 TEXT,
            atom3 TEXT,
            atom4 TEXT,
            FOREIGN KEY(residue_type_set_name, residue_type_name) REFERENCES residue_type(residue_type_set_name, name) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(residue_type_set_name, residue_type_name, atom1, atom2));

-   **residue\_type\_chi\_rotamer** : Chi torsional degrees of freedom are binned into discrete rotamer conformations. Each row is a bin for a chi torisional degree of freedom.
    -   *residue\_type\_set\_name* : The name of the ResidueTypeSet e.g. *FA\_STANDARD* or *CENTROID* .
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
    -   *residue\_type\_set\_name* : The name of the ResidueTypeSet e.g. *FA\_STANDARD* or *CENTROID* .
    -   *chino* : The index of the chi torsional degree of freedom
    -   *sample* : The sample angle plus or minus each extra sample angle. e.g. The hydroxyl hydrogen in tyrosine is controlled by the third chi torsional degree of freedom with two torsional bins, trans at 180 degrees and cis at 0 degrees, both in the plane of the aromatic ring. To increase conformational sampling 8 extra rotamer bins +/- 1 degree and +/- 20 degrees for each sample bin.
    -   *extra* : Is this sample bin an extra rotamer bin?

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_type_proton_chi (
            residue_type_set_name TEXT,
            residue_type_name TEXT,
            chino INTEGER,
            sample REAL,
            is_extra BOOL,
            FOREIGN KEY(residue_type_set_name, residue_type_name) REFERENCES residue_type(residue_type_set_name, name) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(residue_type_set_name, residue_type_name, chino, sample));

-   **residue\_type\_property** :
    -   *residue\_type\_set\_name* : The name of the ResidueTypeSet e.g. *FA\_STANDARD* or *CENTROID* .
    -   *property* : Properties associated with the ResidueType e.g. PROTEIN, POLAR, or SC\_ORBITALS

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_type_property (
            residue_type_set_name TEXT,
            residue_type_name TEXT,
            property TEXT,
            FOREIGN KEY(residue_type_set_name, residue_type_name) REFERENCES residue_type(residue_type_set_name, name) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(residue_type_set_name, residue_type_name, property));

-   **residue\_type\_variant\_type** :
    -   *residue\_type\_set\_name* : The name of the ResidueTypeSet e.g. *FA\_STANDARD* or *CENTROID* .
    -   *variant\_type* : Variant types associated with the ResidueType, e.g. DEPROTONATED, DISULFIDE, or MODRES

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_type_variant_type (
           residue_type_set_name TEXT,
           residue_type_name TEXT,
           variant_type TEXT,
           FOREIGN KEY(residue_type_set_name, residue_type_name) REFERENCES residue_type(residue_type_set_name, name)DEFERRABLE INITIALLY DEFERRED,
           PRIMARY KEY(residue_type_set_name, residue_type_name, variant_type));

RotamerBoltzmannWeightFeatures
------------------------------

Measure how constrained each residue is, following [Fleishman, Khare, Koga, & Baker, Restricted sidechain plasticity in the structures of native proteins and complexes](http://onlinelibrary.wiley.com/doi/10.1002/pro.604/full) .

-   **rotamer\_boltzmann\_weight** :
    -   *boltzmann\_weight* : Compute the energy *e\_i* for each rotamer minimized in a fixed environment. If *E* is the energy of the whole structure and *temperature=.8* , then *boltzmann\_weight* = 1 / (sum\_{i} exp((E-e\_i)/temperature))

<!-- -->

        CREATE TABLE IF NOT EXISTS rotamer_boltzmann_weight (
            struct_id INTEGER,
            resNum INTEGER,
            boltzmann_weight REAL,
            FOREIGN KEY (struct_id, resNum) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (struct_id, resNum));

RotamerRecoveryFeatures
-----------------------

The RotamerRecoverFeatures is a wrapper for the [[rotamer_recovery|RotamerRecoveryScientificBenchmark]] scientific benchmark so it can be included as a feature.

        <RotamerRecovery scfxn="(&string)" protocol="(&string)" comparer="(&string)" mover="(&strong)"/>

See the above link for explanations of the parameters.

-   **rotamer\_recovery** : The rotamer\_recovery of a feature is how similar Rosetta's optimal conformation is compared to the input conformation when Rosetta's optimal conformation is biased to the input conformation.

<!-- -->

          CREATE TABLE IF NOT EXISTS rotamer_recovery (
              struct_id INTEGER,
              resNum INTEGER,
              divergence REAL,
              PRIMARY KEY(struct_id, resNum));

SaltBridgeFeatures
------------------

The SaltBridgeFeatures represent salt bridges and related interactions following the definition in:

﻿Donald JE, Kulp DW, DeGrado WF. Salt bridges: Geometrically specific, designable interactions. Proteins: Structure, Function, and Bioinformatics. 2010:n/a-n/a. Available at: [http://doi.wiley.com/10.1002/prot.22927](http://doi.wiley.com/10.1002/prot.22927) [Accessed November 14, 2010].

-   **salt\_bridges** : A row representes the center of an oxygen of the acceptor group ( *ASN* , *ASN* , *GLN* , *GLU* ) being within 6A of the center of the donor group ( *HIS* , *LYS* , *ARG* ). Note: the center of *HIS* is the midpoint between the ring nitrogens.
    -   *psi* : The angle of the oxygen around the donor group [-180, 180)
    -   *theta* : Angle out of the oxygen of donor group plane
    -   *rho* : Distance between the center of the donor group to the oxygen.
    -   *orbital* : *syn* or *anti* , the orbital of acceptor oxygen (based on the torsional angle about the acceptor-acceptor base bond).

<!-- -->

        CREATE TABLE IF NOT EXISTS salt_bridges (
            struct_id INTEGER,
            don_resNum INTEGER,
            acc_id INTEGER,
            psi REAL,
            theta REAL,
            rho REAL,
            orbital TEXT,
            FOREIGN KEY (struct_id, don_resNum) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY (struct_id, acc_id) REFERENCES hbond_sites (struct_id, site_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, don_resNum, acc_id));

StructureFeatures
-----------------

A structure is a group of spatially organized residues. The definition corresponds with a Pose in Rosetta. Unfortunately in Rosetta there is not a well defined way to identify a Pose. For the purposes of the the features database, each structure is assigned a unique struct\_id. To facilitate connecting structures in the database with structures in structures Rosetta, the tag field is unique.

-   **structures** : Identify the structures in the features database
    -   *tag* : The tag identifies the structure in Rosetta. The following locations are searched in order.
        1.  *pose.pdb\_info()-\>name()*
        2.  *pose.data().get(JOBDIST\_OUTPUT\_TAG)*
        3.  *JobDistributor::get\_instance()-\>current\_job()-\>input\_tag()*

<!-- -->

        CREATE TABLE IF NOT EXISTS structures (
            struct_id INTEGER PRIMARY KEY AUTOINCREMENT,
            protocol_id INTEGER,
            tag TEXT,
            UNIQUE (protocol_id, tag),
            FOREIGN KEY (protocol_id) REFERENCES protocols (protocol_id) DEFERRABLE INITIALLY DEFERRED);

StructureScoresFeatures
-----------------------

The StructureScoresFeatures stores the overall score information for all enabled EnergyMethods.

-   **structure\_scores** :
    -   *score\_value* : The score value for the given type.

<!-- -->

        CREATE TABLE IF NOT EXISTS structure_scores (
            struct_id INTEGER,
            score_type_id INTEGER,
            score_value INTEGER,
            FOREIGN KEY (struct_id)
            REFERENCES structures (struct_id)
            DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY (score_type_id)
            REFERENCES score_types (score_type_id)
            DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (struct_id, score_type_id));

ScoreTypeFeatures
-----------------

The ScoreTypeFeatures store the score types for as for all EnergyMethods.

        <ScoreTypeFeatures scorefxn="(default_scorefxn &string)"/>

-   **score\_types** : Store information about the EnergyMethod associated with each score type.
    -   *score\_type\_id* : The *core::scoring::ScoreType* enum values.
    -   *score\_type\_name* : The string version of the *core::scoring::ScoreType* enum values.

<!-- -->

        CREATE TABLE IF NOT EXISTS score_types (
            protocol_id INTEGER,
            score_type_id INTEGER PRIMARY KEY,
            score_type_name TEXT,
            FOREIGN KEY (protocol_id)
            REFERENCES protocols (protocol_id)
            DEFERRABLE INITIALLY DEFERRED);
