#TwoBodyFeaturesReporters

PairFeatures
------------

The PairFeatures reporter measures the distances between residues.

-   **residue\_pairs** : The information stored here follows 'pair' EnergyMethod. The functional form for the pair EnergyMethod is described in [Simons, K.T., et al, Improved Recognition of Native-Like Protein Structures Using a Combination of Sequence-Dependent and Sequence-Independent Features of Proteins, (Proteins 1999).](http://www.ncbi.nlm.nih.gov/pubmed/10336385,)
    -   *resNum{1/2}* : the rosetta Residue indices of residues involved. Note, each pair is only recorded once and resNum1 \< resNum2.
    -   *res{1/2}\_10A\_neighbors* : Number of neighbors for each residue, used as a proxy for burial. (These columns are going to be moved to the **residue\_burial** table soon.)
    -   A *residue center* is represented by the actcoord, which is defined to be the average geometric center of of the ACT\_COORD\_ATOMS specified in the residue type params file for each residue type.
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
            CONSTRAINT res1_10A_neighbors_greater_than CHECK (res1_10A_neighbors >= 1),
            CONSTRAINT res2_10A_neighbors_greater_than CHECK (res2_10A_neighbors >= 1));

AtomAtomPairFeatures
--------------------

        <AtomAtomPairFeatures min_dist="(&real 0)" max_dist="(&real 10)" nbins="(&integer 15)"/>

The distances between pairs of atoms is an indicator of the packing of a structure. Since there are a large number of atom pairs, here, the information is summarized by atom pair distributions for each pair of atom types (Rosetta AtomType -\> element type). See AtomInResidueAtomInResiduePairFeatures for an alternative binning of atom-atom interactions.

-   **atom\_pairs** : Binned distribution of pairs of types of atoms
    -   *atom\_type* : The AtomType of the central atom. This is a subset of the AtomTypes defined in the full-atom AtomTypeSet atom\_properties.txt: *CAbb* , *CObb* , *OCbb* , *CNH2* , *COO* , *CH1* , *CH2* , *CH3* , *aroC* , *Nbb* , *Ntrp* , *Nhis* , *NH2O* , *Nlys* , *Narg* , *Npro* , *OH* , *ONH2* , *OOC* , *Oaro* , *Hpol* , *Hapo* , *Haro* , *HNbb* , *HOH* , and *S* .
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

        CREATE TABLE IF NOT EXISTS atom_in_residue_pairs (
            struct_id INTEGER,
            residue_type1 TEXT,
            atom_type1 TEXT,
            residue_type2 TEXT,
            atom_type2 TEXT,
            distance_bin TEXT,
            count INTEGER,
            FOREIGN KEY (struct_id) REFERENCES structures (struct_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (struct_id, residue_type1, atom_type1, residue_type2, atom_type2, distance_bin),
            CONSTRAINT count_greater_than CHECK (count >= 0));

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

HBondFeatures
-------------

The HBondFeatures reporter measures the geometry of hydrogen bonds. The most current reference is [Tanja Kortemme, Alexandre V. Morozov, David Baker, An Orientation-dependent Hydrogen Bonding Potential Improves Prediction of Specificity and Structure for Proteins and Protein-Protein Complexes, (JMB 2003)](http://www.sciencedirect.com/science/article/B6WK7-47WBSCV-T/2/d7c673dd51017848231e7b9e8c05fbca) .

The HBondFeatures feature reporter takes the following options:

        <HBondFeatures scorefxn="(&scorefxn)" definition_type="(['energy', 'AHdist'])" definition_threshold="(&real)"/>

-   *scorefxn* : Use a the parameters in a defined score function to evaluate the hydrogen bonds
-   *definition\_type* , *definition\_threshold* : How should a hydrogen bond be defined? The default is a hydrogen bond is an interaction where the hbond energy is \< 0, ie `    energy   ` with a `    definition_threshold=0   `

The features associated with hydrogen bonding include

-   **hbond\_sites** : Conceptually these are positively and negatively charged functional groups that can form hydrogen bonds.
    -   *atmNum* :For donor functional groups, atmNum is the atom number of the polar hydrogen. For acceptor functional groups, atmNum is the atom number of an acceptor atom.
    -   *HBChemType* : The HBChemType string corresponding to an HBAccChemType or HBDonChemType depending on if the site is a donor or acceptor.

<!-- -->

        CREATE TABLE hbond_sites (
            struct_id INTEGER,
            site_id INTEGER,
            resNum INTEGER,
            HBChemType TEXT,
            atmNum INTEGER,
            is_donor INTEGER,
            chain INTEGER,
            resType TEXT,
            atmType TEXT,
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
            -   Note: The parent atom is defined by column 6 of the ICOOR\_SECTION in each residue type params files.

        -   The base to acceptor unit vector is defined by the hybridization type of the acceptor atom and the above atoms.

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
    -   *HBEvalType* : The hbond evaluation type encodes the chemical context of the hydrogen bond.
    -   *energy* : The hbond energy is computed by evaluating the geometric parameters of the hydrogen bond.
    -   *envWeight* : If specified in the HBondOptions, the energy of a hydrogen bond can depend upon the solvent environment computed by the number of neighbors in the 10A neighbor graph.
    -   *score\_weight* : The weight of this hydrogen bond in the provided score function. Each HBEvalType is associated with a HBondWeighType as a column in the HBEval.csv file in a hbond parameter set. The HBondWeighType is then associated with a ScoreType via hb\_eval\_type\_weight. To get the total energy multiply *energy* \* *envWeight* \* *score\_weight* .
    -   *donRank* : The donRank is the rank of the HBond at the donor site. It is 0 if this is the only hbond at donor site. Otherwise donRank is *i* , where this hbond is the *i* th strongest hbond at its donor, beginning with *i* =1.
    -   *accRank* : The accRank is the rank of the HBond at the acceptor site. It is 0 if this is the only hbond at acceptor site. Otherwise accRank *i* , where this hbond is the *i* th strongest hbond at its acceptor, beginning with *i* =1.

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
        -   NOTE: The angle is the exterior angle: cosBAH=1 when linear and cosAHD=0 when perpendicular.
        -   NOTE: If the `        -corrections:score:hbond_measure_sp3acc_BAH_from_hvy       ` flag is set, then the base atom for Sp3 acceptors is the heavy atom, otherwise it is the hydrogen atom. (Historical aside, in Score12, the hydrogen atom was used as the base to enforce separation between the covalently bound hydrogen and the hydrogen bonding hydrogen.)

    -   *cosAHD* : The cosine of the angle defined by the *acceptor* , *hydrogen* and *donor* atoms.
        -   NOTE: The angle is the exterior angle: cosAHD=1 when linear and cosAHD=0 when perpendicular

    -   *chi* : The torsional angle defined by the *abase2* , *base* , *acceptor* and *hydrogen* atoms. NOTE: The value is in radians, [-pi, pi].

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

OrbitalFeatures
---------------

The OrbitalFeatures stores information about chemical interactions involving orbitals. Orbitals are atomically localized electrons that can form weak, orientation dependent interactions with polar and aromatic functional groups and other orbitals. Orbital geometry are defined in the residue type sets in the database. Following the orbitals score term, orbitals are defines between residues where the action center is at most 11A apart.

-   **HPOL\_orbital** : Interactions between orbitals and polar hydrogens. Intra-residue interactions are excluded.
    -   *polar hydrogens* : Polar hydrogens are identified by *res2.Hpos\_polar\_sc()*
    -   *orbName1* : This is like *LP10* and is the second column of the ORBITALS tag in the residue parameter files.
    -   *dist* : This is the distance between the orbital and the polar hydrogen
    -   *angle* : This is the cosine of the angle defined by the atom the orbital is attached to, the orbital and the polar hydrogen.

<!-- -->

        CREATE TABLE IF NOT EXISTS HPOL_orbital (
            struct_id TEXT,
            resNum1 INTEGER,
            orbName1 TEXT,
            resNum2 INTEGER,
            hpolNum2 INTEGER,
            resNum1 INTEGER,
            resName2 TEXT,
            htype2 TEXT,
            OrbHdist REAL,
            cosAOH REAL,                                                                                                                                                   
            cosDHO REAL,                                                                                                                                                   
            chiBAOH REAL,                                                                                                                                                  
            chiBDHO REAL,                                                                                                                                                  
            AOH_angle REAL,                                                                                                                                                
            DHO_angle REAL,                                                                                                                                                
            chiBAHD REAL,                                                                                                                                                  
            cosAHD REAL,
            FOREIGN KEY (struct_id, resNum1) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY (struct_id, resNum2) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, resNum1, orbName1, resNum2, hpolNum2));

-   **HARO\_orbital** : Interactions between orbitals and aromatic hydrogens. Intra-residue interactions are excluded.
    -   *aromatic hydrogens* : Aromatic hydrogens are identified by *res2.Haro\_index()*
    -   *orbName1* : This is like *LP10* and is the second column of the ORBITALS tag in the residue parameter files.
    -   *dist* : This is the distance between the orbital and the aromatic hydrogen
    -   *angle* : This is the cosine of the angle defined by the atom the orbital is attached to, the orbital and the aromatic hydrogen.

<!-- -->

        CREATE TABLE IF NOT EXISTS orbital_orbital_interactions (
            struct_id TEXT,
            resNum1 INTEGER,
            orbName1 TEXT,
            resNum2 INTEGER,
            haroNum2 INTEGER,
            resName1 TEXT,
            orbNum1 INTEGER,
            resName2 TEXT,
            htype2 TEXT,
            orbHdist REAL,
            cosAOH REAL,
            cosDHO REAL,
            chiBAOH REAL,
            chiBDHO REAL,
            AOH_angle REAL,
            DHO_angle REAL,
            chiBAHD REAL,
            cosAHD REAL,
            FOREIGN KEY (struct_id, resNum1) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY (struct_id, resNum2) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, resNum1, orbName1, resNum2, haroNum2));

-   **orbital\_orbital** : Interactions between orbitals and polar hydrogens. Intra-residue interactions are excluded. To avoid double counting, *resNum1 \< resNum2* .
    -   *polar hydrogens* : Polar hydrogens are indexed from *1' to* res2.n\_orbitals()
    -   *orbName1* : This is like *LP10* and is the second column of the ORBITALS tag in the residue parameter files.
    -   *dist* : This is the distance between the orbital and the second orbital
    -   *angle* : This is the cosine of the angle defined by the atom the orbital is attached to, the orbital and the second orbital.

<!-- -->

        CREATE TABLE IF NOT EXISTS orbital_orbital (
            struct_id TEXT,
            resNum1 INTEGER,
            orbName1 TEXT,
            resNum2 INTEGER,
            orbNum2 INTEGER,
            resName1 TEXT,
            orbNum1 INTEGER,
            resName2 TEXT,
            orbName2 TEXT,
            orbOrbdist REAL,
            cosAOO REAL,
            cosDOO REAL,
            chiBAOO REAL,
            chiBDOO REAL,
            AOO_angle REAL,
            DOO_angle REAL,
            chiBAHD REAL,
            cosAHD REAL,
            FOREIGN KEY (struct_id, resNum1) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY (struct_id, resNum2) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, resNum1, orbName1, resNum2, orbNum2));

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

ChargeChargeFeatures
--------------------

The ChargeChargeFeatures represent interactions between charged groups in molecular conformations. The primary interaction is through the Coulomb potential, which is proportional to q1\*q2/R\^2. However, because the charge is not always centered at the atom, and the groups can shield the interaction, it is important to measure the angles as well. For each charged site, there are three atoms defined based on the hbond\_site\_atoms table: q1 = atm, B1 = base, C1 = bbase, and similarly for q2.

-   **charge\_charge\_pair** : A row represents two charged polar group: ( *ASP* , *GLU* , *LYS* , *ARG* , *HIS* ) within 8A.
    -   *q{1,2}\_charge* : If it is a donor, then 1, if it is an acceptor then -1
    -   *B1q1q2\_angle* : The bond angle at q1 formed by B1 and q2
    -   *B2q2q1\_angle* : The bond angle at q2 formed by B2 and q1
    -   *q1q2\_distance* : The distance between the q1 and q2 atoms
    -   *B1q1\_torsion* : The torsion angle defined by C1-B1-q1-q2
    -   *B2q2\_torsion* : The torsion angle defined by C2-B2-q2-q1

<!-- -->

        CREATE TABLE IF NOT EXISTS charge_charge_pairs (
            struct_id INTEGER,
            q1_site_id INTEGER,
            q2_site_id INTEGER,
            B1q1q2_angle REAL,
            B2q2q1_angle REAL,
            q1q2_distance REAL,
            B1q1_torsion REAL,
            B2q2_torsion REAL,
            FOREIGN KEY (struct_id, q1_site_id) REFERENCES hbond_sites (struct_id, site_id) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY (struct_id, q2_site_id) REFERENCES hbond_sites (struct_id, site_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, q1_site_id, q2_site_id));

LoopAnchorFeatures
------------------

        <LoopAnchorFeatures min_loop_length="5" max_loop_length="7"/>

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
