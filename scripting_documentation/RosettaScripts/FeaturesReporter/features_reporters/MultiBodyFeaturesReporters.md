#MultiBodyFeaturesReporters

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

PoseConformationFeatures
------------------------

The PoseConformationFeatures reporter measures the conformation level information in a Pose. Together with the ProteinResidueConformationFeatures, the atomic coordinates can be reconstructed. To facilitate creating poses from conformation structure data stored in the features database, PoseConformationFeatures has a *load\_into\_pose* method.

-   **pose\_conformations** : This table stores information about sequence of residues in the conformation.
	-   *annotated\_sequence* : The [annotated sequence](Glossary#annotatedsequence) string of residue types that make up the conformation
    -   *total\_residue* : The number of residues in the conformation
    -   *fullatom* : The ResidueTypeSet is *FA\_STANDARD* if true, and *CENTROID* if false.

<!-- -->

        CREATE TABLE IF NOT EXISTS pose_conformations (
            struct_id INTEGER AUTOINCREMENT PRIMARY KEY,
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
            struct_id INTEGER AUTOINCREMENT,
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
            struct_id INTEGER AUTOINCREMENT,
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
            struct_id INTEGER AUTOINCREMENT,
            end_pos INTEGER,
            FOREIGN KEY (struct_id) REFERENCES structures (struct_id) DEFERRABLE INITIALLY DEFERRED);

GeometricSolvationFeatures
--------------------------

-   **geometric\_solvation** : The exact geometric solvation score which is computed by integrating the hbond energy not occupied by other atoms.
    -   *hbond\_site\_id* : A hydrogen bonding donor or acceptor
    -   *geometric\_solvation\_exact* : The non-pairwise decomposable version of the geometric solvation score.

<!-- -->

        CREATE TABLE IF NOT EXISTS geometric_solvation (
            struct_id INTEGER AUTOINCREMENT,
            hbond_site_id TEXT,
            geometric_solvation_exact REAL,
            FOREIGN KEY (struct_id, hbond_site_id) REFERENCES hbond_sites(struct_id, site_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, hbond_site_id));

RadiusOfGyrationFeatures
------------------------

Measure the radius of gyration for each structure. The radius of gyration measure of how compact a structure is in O(n). It is the expected displacement of mass from the center of mass. The Wikipedia page is has some [information](http://en.wikipedia.org/wiki/Radius_of_gyration) . Also see, Lobanov MY, Bogatyreva NS, Galzitskaya OV. [Radius of gyration as an indicator of protein structure compactness](http://www.springerlink.com/content/v01q1r143528u261/) . Molecular Biology. 2008;42(4):623-628.

-   **radius\_of\_gyration** :
    -   *radius\_of\_gyration* : Let *C* be the center of mass and *ri* be the position of residue *i'* th of *n* residues, then the radius of gyration is defined to be *Rg = SQRT{SUM\_{ri}(ri-C)\^2/(n-1)}* . Note: the normalizing factor is *n-1* to be consistent with r++. Atoms with variant type "REPLONLY" are ignored.

<!-- -->

        CREATE TABLE IF NOT EXISTS radius_of_gyration (
            struct_id INTEGER AUTOINCREMENT,
            radius_of_gyration REAL,
            FOREIGN KEY(struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id));

SandwichFeatures
----------------

Function summary: Extract and analyze beta-sandwiches

Function detail: Extract beta-sandwiches conservatively so that it correctly excludes alpha-helix that is identified as beta-sandwiche by SCOP and excludes beta-barrel that is identified as beta-sandwiches by CATH. To dump into pdb files, use Matt's format\_converter.

Analyze beta-sandwiches such as phi, psi angles in core/edge strand each, assign one beta-sheet between two beta-sheets that constitute one beta-sandwich as additional chain so that InterfaceAnalyzer can be used.

-   **sw\_can\_by\_components**

<!-- -->

    CREATE TABLE sw_can_by_components(
        struct_id INTEGER AUTOINCREMENT NOT NULL,
        sw_can_by_components_PK_id INTEGER NOT NULL,
        tag TEXT NOT NULL,
        sw_can_by_sh_id INTEGER NOT NULL,
        sheet_id INTEGER,
        sheet_antiparallel INTEGER,
        sw_can_by_components_bs_id INTEGER,
        sw_can_by_components_bs_edge INTEGER,
        intra_sheet_con_id INTEGER,
        inter_sheet_con_id INTEGER,
        residue_begin INTEGER NOT NULL,
        residue_end INTEGER NOT NULL,
        FOREIGN KEY (struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
        FOREIGN KEY (struct_id, residue_begin) REFERENCES residues(struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
        FOREIGN KEY (struct_id, residue_end) REFERENCES residues(struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
        PRIMARY KEY (struct_id, sw_can_by_components_PK_id));

SecondaryStructureSegmentFeatures
---------------------------------

Report continuous segments of secondary structure. DSSP is used to define secondary structure, but simplified to be simply H, E, and L (all DSSP codes other than H and E). Due to this simplification of DSSP codes, the dssp column is NOT a foreign key to the dssp\_codes table.

        CREATE TABLE IF NOT EXISTS secondary_structure_segments (
            struct_id INTEGER AUTOINCREMENT NOT NULL,
            segement_id INTEGER NOT NULL,
            residue_begin INTEGER,
            residue_end INTEGER,
            dssp TEXT NOT NULL,
        FOREIGN KEY (struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
        FOREIGN KEY (struct_id, residue_begin) REFERENCES residues(struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
        FOREIGN KEY (struct_id, residue_end) REFERENCES residues(struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
        PRIMARY KEY (struct_id, segment_id))

SmotifFeatures
--------------

Record a set of geometric parameters defined by two pieces of adjacent secondary structure. More information can be found here: [http://www.ploscompbiol.org/article/info%3Adoi%2F10.1371%2Fjournal.pcbi.1000750](http://www.ploscompbiol.org/article/info%3Adoi%2F10.1371%2Fjournal.pcbi.1000750)

    CREATE TABLE smotifs(
        struct_id INTEGER AUTOINCREMENT NOT NULL,
        smotif_id INTEGER NOT NULL,
        secondary_struct_segment_id_1 INTEGER NOT NULL,
        secondary_struct_segment_id_2 INTEGER NOT NULL,
        loop_segment_id INTEGER NOT NULL,
        distance REAL NOT NULL,
        hoist REAL NOT NULL,
        packing REAL NOT NULL,
        meridian REAL NOT NULL,
        FOREIGN KEY (struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
        FOREIGN KEY (struct_id, secondary_struct_segment_id_1) REFERENCES secondary_structure_segments(struct_id, segment_id) DEFERRABLE INITIALLY DEFERRED,
        FOREIGN KEY (struct_id, secondary_struct_segment_id_2) REFERENCES secondary_structure_segments(struct_id, segment_id) DEFERRABLE INITIALLY DEFERRED,
        FOREIGN KEY (struct_id, loop_segment_id) REFERENCES secondary_structure_segments(struct_id, segment_id) DEFERRABLE INITIALLY DEFERRED,
        PRIMARY KEY (struct_id, smotif_id))

StrandBundleFeatures
--------------------

Function summary: Find all strands -\> Leave all pair of strands -\> Leave all pair of sheets

Function detail:

It generates smallest unit of beta-sandwiches that are input files of Tim's SEWING protocol.

After finding all beta strands in pdb files, leave all pair of beta strands (either parallel or anti-parallel) among them. Then leave all pair of beta sheets (which are constituted with 4 beta strands each). As it finds strands/sheets, it find only those that meet criteria specified in option. 'strand\_pairs' table and 'sandwich' table are created in a same schema respectively.

-   **strand\_pairs**

<!-- -->

    CREATE TABLE strand_pairs(
        struct_id INTEGER AUTOINCREMENT NOT NULL,
        strand_pairs_id INTEGER NOT NULL,
        bool_parallel INTEGER NOT NULL,
        beta_select_id_i INTEGER NOT NULL,
        beta_select_id_j INTEGER NOT NULL,
        FOREIGN KEY (struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
        FOREIGN KEY (struct_id, beta_select_id_i) REFERENCES beta_selected_segments(struct_id, beta_selected_segments_id) DEFERRABLE INITIALLY DEFERRED,
        FOREIGN KEY (struct_id, beta_select_id_j) REFERENCES beta_selected_segments(struct_id, beta_selected_segments_id) DEFERRABLE INITIALLY DEFERRED,
        PRIMARY KEY (struct_id, strand_pairs_id));

-   **sandwich**

<!-- -->

    CREATE TABLE sandwich(
        struct_id INTEGER AUTOINCREMENT NOT NULL,
        sandwich_id INTEGER NOT NULL,
        sp_id_1 INTEGER NOT NULL,
        sp_id_2 INTEGER NOT NULL,
        shortest_sc_dis REAL NOT NULL,
        FOREIGN KEY (struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
        FOREIGN KEY (struct_id, sp_id_1) REFERENCES strand_pairs(struct_id, strand_pairs_id) DEFERRABLE INITIALLY DEFERRED,
        FOREIGN KEY (struct_id, sp_id_2) REFERENCES strand_pairs(struct_id, strand_pairs_id) DEFERRABLE INITIALLY DEFERRED,
        PRIMARY KEY (struct_id, sandwich_id));
