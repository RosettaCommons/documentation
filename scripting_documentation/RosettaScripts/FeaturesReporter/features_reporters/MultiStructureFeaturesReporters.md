#MultiStructureFeaturesReporters

ProteinRMSDFeatures
-------------------

Compute the atom-wise root mean squared deviation between the conformation being reported and a previously saved conformation. There are several ways of specifying the reference structure, which are considered in the following order

-   Using the **SavePoseMover** :

<!-- -->

        <ROSETTASCRIPTS>
            <MOVERS>
                <SavePoseMover name=spm_init_struct reference_name=init_struct/>
                <ReportToDB name=features_reporter database_name="features_SAMPLE_SOURCE_ID.db3" batch_description="SAMPLE_SOURCE_DESCRIPTION">
                    <ProteinRMSDFeatures reference_name=init_struct/>
                </ReportToDB>
            </MOVERS>
            <PROTOCOLS>
                <Add mover_name=spm_init_struct/>
                <Add mover_name=features_reporter/>
            </PROTOCOLS>
        </ROSETTASCRIPTS>

-   Using `    -in:file:native   `
-   Using the resource manager (TODO)

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
            struct_id INTEGER AUTOINCREMENT,
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

ProteinRMSDNoSuperpositionFeatures
----------------------------------

Same as above, but does not superimpose poses prior to calculating RMSD.

    CREATE TABLE protein_rmsd_no_superposition(
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
            FOREIGN KEY (struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (struct_id, reference_tag));

RotamerRecoveryFeatures
-----------------------

The RotamerRecoverFeatures is a wrapper for the [[rotamer_recovery|RotamerRecoveryScientificBenchmark]] scientific benchmark so it can be included as a feature.

        <RotamerRecoveryFeatures scorefxn="(&string)" protocol="(&string)" comparer="(&string)" mover="(&string)"/>

See the above link for explanations of the parameters. Give the features reporter either a protocol (RRProtocol string) or any other mover.  Specifying the pose to compare works the same way as the ProteinRMSDFeatures (-native flag, SavePoseMover, etc.)

-   **rotamer\_recovery** : The rotamer\_recovery of a feature is how similar Rosetta's optimal conformation is compared to the input conformation when Rosetta's optimal conformation is biased to the input conformation.
    -   **struct\_id** , **resNum** : These are the primary keys for the *residues* table in the ResidueFeatures reporter
    -   **divergence** : This is the *score* that the *RRProtocol* returns.

<!-- -->

        CREATE TABLE IF NOT EXISTS nchi (
            name3 TEXT,  
            nchi INTEGER,
            PRIMARY KEY (name3));

        INSERT OR IGNORE INTO nchi VALUES('ARG', 4);
        INSERT OR IGNORE INTO nchi VALUES('LYS', 4);
        INSERT OR IGNORE INTO nchi VALUES('MET', 3);
        INSERT OR IGNORE INTO nchi VALUES('GLN', 3);
        INSERT OR IGNORE INTO nchi VALUES('GLU', 3);
        INSERT OR IGNORE INTO nchi VALUES('TYR', 2);
        INSERT OR IGNORE INTO nchi VALUES('ILE', 2);
        INSERT OR IGNORE INTO nchi VALUES('ASP', 2);
        INSERT OR IGNORE INTO nchi VALUES('TRP', 2);
        INSERT OR IGNORE INTO nchi VALUES('PHE', 2);
        INSERT OR IGNORE INTO nchi VALUES('HIS', 2);
        INSERT OR IGNORE INTO nchi VALUES('ASN', 2);
        INSERT OR IGNORE INTO nchi VALUES('THR', 1);
        INSERT OR IGNORE INTO nchi VALUES('SER', 1);
        INSERT OR IGNORE INTO nchi VALUES('PRO', 1);
        INSERT OR IGNORE INTO nchi VALUES('CYS', 1);
        INSERT OR IGNORE INTO nchi VALUES('VAL', 1);
        INSERT OR IGNORE INTO nchi VALUES('LEU', 1);
        INSERT OR IGNORE INTO nchi VALUES('ALA', 0);
        INSERT OR IGNORE INTO nchi VALUES('GLY', 0);

        CREATE TABLE IF NOT EXISTS rotamer_recovery (
            struct_id INTEGER AUTOINCREMENT,
            resNum INTEGER,
            divergence REAL,
            recovered INTEGER,
            PRIMARY KEY(struct_id, resNum));
