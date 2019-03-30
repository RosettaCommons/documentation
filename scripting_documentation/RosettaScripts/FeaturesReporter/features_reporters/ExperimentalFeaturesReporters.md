#ExperimentalFeaturesReporters

PdbDataFeatures
---------------

The PdbDataFeatures records information that is stored in the protein databank structure format.

        <PdbDataFeatures/>

-   **residue\_pdb\_identification** : Identify residues using the PDB nomenclature. Note, this numbering has biological relevance and therefore may be negative, skip numbers, etc. When using the *DatabaseInputer* or *DatabaseOutputter* with the Rosetta job distributor, this table is mapped to the PDBInfo object.
    -   *struct\_id* , *residue\_number* : References the primary key in the residues table
    -   *chain\_id* : ATOM record columns 21
    -   *insertion\_code* : ATOM record column 26
    -   *pdb\_residue\_number* : PDB identification 22-25

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_pdb_identification (
            struct_id INTEGER AUTOINCREMENT,
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
