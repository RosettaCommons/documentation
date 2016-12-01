#OneBody FeaturesReporters

ResidueFeatures
---------------

The ResidueFeatures stores information about each residue in a conformation.

-   **residues** : This connects the sequence position with with the name of the residue and the ResidueType of the residue.
    -   *name3* : The three letter amino acid code. If it is not a canonical amino acid it is *UNK* .
    -   *res\_type* : The unique identifier for the ResidueType of the residue.

<!-- -->

        CREATE TABLE IF NOT EXISTS residues (
            struct_id INTEGER AUTOINCREMENT,
            resNum INTEGER,
            name3 TEXT,
            res_type TEXT,
            FOREIGN KEY (struct_id)
            REFERENCES structures (struct_id)
            DEFERRABLE INITIALLY DEFERRED,
            CONSTRAINT resNum_is_positive CHECK (resNum >= 1),
            PRIMARY KEY(struct_id, resNum));

ResidueConformationFeatures
---------------------------

Store the geometry of residues that have canonical backbones but possibly non-canonical sidechains. The geometry is broken into backbone torsional degrees of freedom, *nonprotein\_residue\_conformation* , sidechain degrees of freedom, *nonprotein\_residue\_angles* , and atomic coordinates *residue\_atom\_coords* .

This differs from ProteinResidueConformationFeatures in that the residue angles are stored as a *chinum* -\> *chiangle* lookup and atomic xzy-coordinates, rather than a table with slots for 4 chi values. If you know you are going to be only working with protein residues, you can conserve space by using the ProteinResidueConformationFeatures.

-   **nonprotein\_residue\_conformation** :
    -   *phi* , *psi* , *omega* : Angles of backbone torsional degrees of freedom

<!-- -->

        CREATE TABLE IF NOT EXISTS nonprotein_residue_conformation (
            struct_id INTEGER AUTOINCREMENT,
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
        struct_id INTEGER AUTOINCREMENT,
        seqpos INTEGER,
        chinum INTEGER,
        chiangle REAL,
        FOREIGN KEY (struct_id, seqpos) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (struct_id, seqpos));

-   **residue\_atom\_coords** :
    -   *x* , *y* , *z* : Spatial coordinates of atom *atomno* in residue *seqpos* in the lab coordinate frame.

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_atom_coords (
        struct_id INTEGER AUTOINCREMENT,
        seqpos INTEGER,
        atomno INTEGER,
        x REAL,
        y REAL,
        z REAL,
        FOREIGN KEY (struct_id, seqpos) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (struct_id, seqpos, atomno));

ProteinResidueConformationFeatures
----------------------------------

The conformation of protein residues is described by the coordinates of each atom. A reduced representation is just specifying the values for each torsional angle degree of freedom, these include the backbone and sidechain torsional angles. Since Proteins have only canonical amino acids, there are at most 4 torsional angles in the sidechains.

-   **protein\_residue\_conformation** : The degrees of freedom in each residue conformation.
    -   *secstruct* : The secondary structure of the residue. NOTE: this is not computed by DSSP but taken from fragments.
	-   *phi* , *psi* , *omega* : Backbone torsional angles
    -   *chi\** : Sidechain torsional angles

<!-- -->

        CREATE TABLE IF NOT EXISTS protein_residue_conformation (
            struct_id INTEGER AUTOINCREMENT,
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
            struct_id INTEGER AUTOINCREMENT,
            seqpos INTEGER,
            atomno INTEGER,
            x REAL,
            y REAL,
            z REAL,
            FOREIGN KEY (struct_id, seqpos) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED);

ProteinBackboneTorsionAngleFeatures
-----------------------------------

The ProteinBackboneTorsionAngleFeatures reporter stores the backbone torsion angle degrees of freedom needed represent proteins made with canonical backbones.

-   **protein\_backbone\_torsion\_angles** :
    -   *phi* : The torsion angle defined by *C\_(i-1)* , *N\_i* , *Ca\_i* , and *C\_i* atoms (-180, 180)
    -   *psi* : The torsion angle defined by *N\_i* , *Ca\_i* , *C\_i* , and *N\_(i+1)* atoms (-180, 180)
    -   *omega* : The torsion angle defined by *Ca\_i* , *C\_i* , *N\_(i+1)* , and *Ca\_(i+1)* (-180, 180)

<!-- -->

        CREATE TABLE IF NOT EXISTS protein_backbone_torsion_angles (
            struct_id INTEGER AUTOINCREMENT,
            resNum INTEGER,
            phi REAL,
            psi REAL,
            omega REAL,
            FOREIGN KEY (struct_id, resNum) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (struct_id, resNum));

ProteinBondGeometryFeatures
---------------------------

The ProteinBondGeometryFeatures reporter stores bond-angle, bond-length, and bond-torsion for canonical protein amino acids.

let *i* be an atom number of given residue and let bonded\_neighbors( *i* ) be the set of bonded neighbors of atom *i* . Then if *j* , *k* are in bonded\_neighbors( *i* ) such that *j* \< *k* , then ( *j* , *i* , *k* ) is a bond angle. In other words, there is a row in bond\_intrares\_angles such that outAtm1Num = *j* , cenAtmNum = *i* , and outAtm2Num = *k* .

-   **bond\_intrares\_angles** :
    -   *cenAtmNum* : atom number of the center atom defining the bond angle
    -   *outAtm{1,2}Num* : atom numbers of the outer atoms defining the bond angle
    -   *cenAtmName* : the atom name of the center atom
    -   *outAtm{1,2}Name* : the atom names of the outer atoms
    -   *ideal* : ideal angle defined by *-scoring:bonded\_params* or by default in *chemical/mm\_atom\_type\_sets/fa\_standard/par\_all27\_prot\_na.prm*
    -   *observed* : actual angle in structure
    -   *difference* : angle deviation from ideal angle
    -   *energy* : a harmonic potential away from the ideal angle with the spring constant defined by the residue type, and atom identities. - NOTE: THIS CODE IS NOT UP TO DATE WITH CURRENT CART\_BONDED ENERGY CALCULATIONS, RESULTS WILL DIFFER

<!-- -->

            CREATE TABLE IF NOT EXISTS bond_intrares_angles (  
                    struct_id INTEGER AUTOINCREMENT,  
                    resNum INTEGER,  
                    cenAtmNum INTEGER,  
                    outAtm1Num INTEGER,  
                    outAtm2Num INTEGER,  
                    cenAtmName TEXT,  
                    outAtm1Name TEXT,  
                    outAtm2Name TEXT,  
                    ideal REAL,  
                    observed REAL,  
                    difference REAL,  
                    energy REAL,  
                    FOREIGN KEY (struct_id, resNum) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,  
                    PRIMARY KEY (struct_id, resNum, cenAtmNum, outAtm1Num, outAtm2Num));

-   **bond\_interres\_angles** :
    -   *cenResNum* :
    -   *connResNum* :
    -   *cenAtmNum* :
    -   *outAtm{Cen,Conn}Num* :
    -   *cenAtmName* :
    -   *outAtm{Cen,Conn}Name* :
    -   *ideal* : ideal angle defined by *-scoring:bonded\_params* or by default in *chemical/mm\_atom\_type\_sets/fa\_standard/par\_all27\_prot\_na.prm*
    -   *observed* : actual angle in structure
    -   *difference* : angle deviation from ideal angle
    -   *energy* : a harmonic potential away from the ideal angle with the spring constant defined by the residue type, and atom identities. - NOTE: THIS CODE IS NOT UP TO DATE WITH CURRENT CART\_BONDED ENERGY CALCULATIONS, RESULTS WILL DIFFER

<!-- -->

     
            CREATE TABLE IF NOT EXISTS bond_interres_angles (  
                    struct_id INTEGER AUTOINCREMENT,  
                    cenResNum INTEGER,  
                    connResNum INTEGER,  
                    cenAtmNum INTEGER,  
                    outAtmCenNum INTEGER,  
                    outAtmConnNum INTEGER,  
                    cenAtmName TEXT,  
                    outAtmCenName TEXT,  
                    outAtmConnName TEXT,  
                    ideal REAL,  
                    observed REAL,  
                    difference REAL,  
                    energy REAL,  
                    FOREIGN KEY (struct_id, cenResNum) REFERENCES residues (struct_id, cenResNum) DEFERRABLE INITIALLY DEFERRED,  
                    PRIMARY KEY (struct_id, cenResNum, connResNum, cenAtmNum, outAtmCenNum, outAtmConnNum));

-   **bond\_intrares\_lengths** :
    -   *atm{1,2}Num* : atom numbers of atoms that neighbors, usually because they are covalently bound
    -   *atm{1,2}Name* : the names of the atoms
    -   *ideal* : ideal length defined by *-scoring:bonded\_params* or by default in *chemical/mm\_atom\_type\_sets/fa\_standard/par\_all27\_prot\_na.prm*
    -   *observed* : actual length in structure
    -   *difference* : angle deviation from ideal length
    -   *energy* : a harmonic potential away from the ideal length with the spring constant defined by the residue type, and atom identities. - NOTE: THIS CODE IS NOT UP TO DATE WITH CURRENT CART\_BONDED ENERGY CALCULATIONS, RESULTS WILL DIFFER

<!-- -->

            CREATE TABLE IF NOT EXISTS bond_intrares_lengths (  
                    struct_id INTEGER AUTOINCREMENT,  
                    resNum INTEGER,  
                    atm1Num INTEGER,  
                    atm2Num INTEGER,  
                    atm1Name TEXT,  
                    atm2Name TEXT,  
                    ideal REAL,  
                    observed REAL,  
                    difference REAL,  
                    energy REAL,  
                    FOREIGN KEY (struct_id, resNum) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,  
                    PRIMARY KEY (struct_id, resNum, atm1Num, atm2Num));

-   **bond\_interres\_lengths** :
    -   *res{1,2}Num* : Two residues that have atoms that are bound together
    -   *atm{1,2}Num* : atom numbers of atoms that neighbors, one from each residue, usually because they are covalently bound
    -   *atm{1,2}Name* : the names of the atoms
    -   *ideal* : ideal length defined by *-scoring:bonded\_params* or by default in *chemical/mm\_atom\_type\_sets/fa\_standard/par\_all27\_prot\_na.prm*
    -   *observed* : actual length in structure
    -   *difference* : angle deviation from ideal length
    -   *energy* : a harmonic potential away from the ideal length with the spring constant defined by the residue type, and atom identities. - NOTE: THIS CODE IS NOT UP TO DATE WITH CURRENT CART\_BONDED ENERGY CALCULATIONS, RESULTS WILL DIFFER

<!-- -->

     
            CREATE TABLE IF NOT EXISTS bond_interres_lengths (  
                    struct_id INTEGER AUTOINCREMENT,  
                    res1Num INTEGER,  
                    res2Num INTEGER,  
                    atm1Num INTEGER,  
                    atm2Num INTEGER,  
                    atm1Name TEXT,  
                    atm2Name TEXT,  
                    ideal REAL,  
                    observed REAL,  
                    difference REAL,  
                    energy REAL,  
                    FOREIGN KEY (struct_id, res1Num) REFERENCES residues (struct_id, res1Num) DEFERRABLE INITIALLY DEFERRED,
                    PRIMARY KEY (struct_id, res1Num, atm1Num, atm2Num));

-   **bond\_intrares\_torsions** :

chemical/mm\_atom\_type\_sets/fa\_standard/mm\_torsion\_params.txt

            CREATE TABLE IF NOT EXISTS bond_intrares_torsions (
                    struct_id INTEGER AUTOINCREMENT,
                    resNum INTEGER,
                    atm1Num INTEGER,
                    atm2Num INTEGER,
                    atm3Num INTEGER,
                    atm4Num INTEGER,
                    atm1Name TEXT,
                    atm2Name TEXT,
                    atm3Name TEXT,
                    atm4Name TEXT,
                    ideal REAL,
                    observed REAL,
                    difference REAL,
                    energy REAL,
                    FOREIGN KEY (struct_id, resNum) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
                    PRIMARY KEY (struct_id, resNum, atm1Num, atm2Num, atm3Num, atm4Num));

RotamerFeatures
---------------

The RotamerFeatures reporter stores the predicted sidechain conformation given the backbone torsion angles and the observed deviation away from the it. Currently this is restricted to canonical amino acids and use with the dunbrack library. The *dun08* and *dun10* libraries define semi-rotameric conformations for *ASP* , *GLU* , *PHE* , *HIS* , *ASN* , *GLN* , *TRP* , and *TYR* where the last torsion angle is treated as a continuous variable.

For the *dun02* library see ﻿

-   Dunbrack RL, Cohen FE. Bayesian statistical analysis of protein side-chain rotamer preferences. Protein science : a publication of the Protein Society. 1997;6(8):1661-81.
-   ﻿Dunbrack RL. Rotamer libraries in the 21st century. Current opinion in structural biology. 2002;12(4):431–440.

For the *dun10* library see

-   ﻿Shapovalov MV, Dunbrack RL. A smoothed backbone-dependent rotamer library for proteins derived from adaptive kernel density estimates and regressions. Structure (London, England : 1993). 2011;19(6):844-58. artid=3118414&tool=pmcentrez&rendertype=abstract [Accessed July 24, 2011].

-   **residue\_rotamers** :
    -   *rotamer\_bin* : The dunbrack library divides sidechain conformation space into discrete rotameric conformations. For fully rotameric conformations this is based on all the sidechain torsion angles. for semi-rotameric conformations this is based on all but the last sidechain torsion angles.
    -   *nchi* : The number of rotameric torsion angles in the residue. For example *nchi* for tyrosine is 1 in the *dun10* library.
    -   *semi\_rotameric* : Boolean value, true if the sidechain is a semi-rotameric amino acid.
    -   *chi{1,2,3,4}\_mean* : The expected value of the rotameric torsion angles given the backbone conformation and semi-rotameric torsion angles (if semi-rotameric). This this is bilinear/trilinear interpolated data recorded on 10 degree bins.
    -   *chi{1,2,3,4}\_standard\_deviation* : The standard deviation of the rotameric torsion angles given the backbone conformatino and semi-rotameric tosion angles (if semi-rotameric).
    -   *chi{1,2,3,4}\_deviation* : The angle deviation away from the mean.
    -   *rotamer\_bin\_probability* : The probability of being in the rotamer bin.

<!-- -->

        CREATE TABLE residue_rotamers IF NOT EXISTS (
            struct_id INTEGER AUTOINCREMENT,
            residue_number INTEGER,
            rotamer_bin INTEGER,
            nchi INTEGER,
            semi_rotameric INTEGER,
            chi1_mean REAL,
            chi2_mean REAL,
            chi3_mean REAL,
            chi4_mean REAL,
            chi1_standard_deviation REAL,
            chi2_standard_deviation REAL,
            chi3_standard_deviation REAL,
            chi4_standard_deviation REAL,
            chi1_deviation REAL,
            chi2_deviation REAL,
            chi3_deviation REAL,
            chi4_deviation REAL,
            rotamer_bin_probability REAL,
            FOREIGN KEY (struct_id, resNum) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (struct_id, residue_number));

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
            struct_id INTEGER AUTOINCREMENT,
            resNum INTEGER,
            ten_a_neighbors INTEGER,
            twelve_a_neighbors INTEGER,
            neigh_vect_raw REAL,
            sasa_r100 REAL,
            sasa_r140 REAL,
            sasa_r200 REAL,
            FOREIGN KEY (struct_id, resNum) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (struct_id, resNum));

ResidueSecondaryStructureFeatures
---------------------------------

Secondary structure is a classification scheme for residues that participate in regular, multi-residue interactions.

-   **residue\_secondary\_structure** :
    -   *dssp* : The Dictionary of Secondary Structure classification scheme following [Kabsch and Sander, Dictionary of protein secondary structure: pattern recognition of hydrogen-bonded and geometrical features](http://onlinelibrary.wiley.com/doi/10.1002/bip.360221211/abstract) . The [coding](http://swift.cmbi.ru.nl/gv/dssp/) is described on their website.

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_secondary_structure(
            struct_id INTEGER AUTOINCREMENT,
            resNum INTEGER,
            dssp TEXT,
            FOREIGN KEY(struct_id, resNum) REFERENCES residues(struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, resNum));

        CREATE TABLE dssp_codes(
            code TEXT NOT NULL,
            label TEXT NOT NULL,
            PRIMARY KEY (code));
        INSERT INTO "dssp_codes" VALUES('H','H: a-Helix');
        INSERT INTO "dssp_codes" VALUES('E','E: b-Sheet');
        INSERT INTO "dssp_codes" VALUES('T','T: HB Turn');
        INSERT INTO "dssp_codes" VALUES('G','G: 3/10 Helix');
        INSERT INTO "dssp_codes" VALUES('B','B: b-Bridge');
        INSERT INTO "dssp_codes" VALUES('S','S: Bend');
        INSERT INTO "dssp_codes" VALUES('I','I: pi-Helix');
        INSERT INTO "dssp_codes" VALUES(' ','Irregular');

BetaTurnDetectionFeatures
-------------------------

        <BetaTurnDetectionFeatures/>

This reporter scans all available windows of four residues and determines if a β-turn is present, determines the type of β-turn and then writes the starting residue number and turn type to a database.

        CREATE TABLE IF NOT EXISTS beta_turns (
            struct_id INTEGER AUTOINCREMENT,
            residue_begin INTEGER,
            turn_type TEXT,
            FOREIGN KEY (struct_id, residue_begin) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, residue_begin));

RotamerBoltzmannWeightFeatures
------------------------------

Measure how constrained each residue is, following [Fleishman, Khare, Koga, & Baker, Restricted sidechain plasticity in the structures of native proteins and complexes](http://onlinelibrary.wiley.com/doi/10.1002/pro.604/full) .

-   **rotamer\_boltzmann\_weight** :
    -   *boltzmann\_weight* : Compute the energy *e\_i* for each rotamer minimized in a fixed environment. If *E* is the energy of the whole structure and *temperature=.8* , then *boltzmann\_weight* = 1 / (sum\_{i} exp((E-e\_i)/temperature))

<!-- -->

        CREATE TABLE IF NOT EXISTS rotamer_boltzmann_weight (
            struct_id INTEGER AUTOINCREMENT,
            resNum INTEGER,
            boltzmann_weight REAL,
            FOREIGN KEY (struct_id, resNum) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (struct_id, resNum));
