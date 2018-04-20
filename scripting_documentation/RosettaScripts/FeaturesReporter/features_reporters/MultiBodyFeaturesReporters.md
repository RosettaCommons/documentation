#MultiBodyFeaturesReporters

[[_TOC_]]

##Antibody Features




**Overveiw**

These features reporters analyze components of an antibody and interfaces that are a part of it.


###AntibodyFeatures

**Author**

Jared Adolf-Bryfogle; jadolfbr@gmail.com; 
PI: Roland Dunbrack

Part of the RosettaAntibody and RosettaAntibodyDesign (RAbD) Framework
* [[Rosetta Antibody Design (RAbD) Manual | RosettaAntibodyDesign]]

Many of the metric functions were first coded by Brian Weitzner (brian.weitzner@gmail.com) and Jeff Gray ([[http://graylab.jhu.edu]]) at JHU as part of RosettaAntibody 3.0. 

**Overview**

The Antibody Features Reporter is a subclass of the [[InterfaceFeatures |MultiBodyFeaturesReporters#InterfaceFeatures]] Reporter.  It outputs all tables as in the InterfaceFeatures for antibody-specific interfaces (combinations of L, H, and A where L is light, H is heavy, and A is antigen).  By default, it will analyze every antibody interface unless specified in the XML tag.  It will also add information on the antigen to the antibody tables. Use _skip_all_antigen_analysis_ to skip this reporting.  Works on camelid antibodies as well.

In order to use this Reporter, the antibody should be renumbered into a particular numbering scheme.  See [[General Antibody Tips | General-Antibody-Options-and-Tips]] for more information on how to renumber your antibody via different antibody servers.  If your antibody has come from RosettaAntibody 3.0, the antibody is already renumbered in the Chothia scheme, which is the default.  The numbering scheme can be specified through the command-line or via XML tag.

```xml
			<AntibodyFeatures scorefxn="(&string)" interface="(&string)" numbering_scheme="(&string, Chothia_Scheme)" cdr_definition="(&string, Aroop)" pack_separated="(&string, true)" pack_together="(&string, false)" />
```

**XML Options**

-   scorefxn (& scorefxn string): Specify a scorefunction to use
-   interface(s) (&string) (default=All present antibody interfaces):  Specify the interface as ChainsSide1_ChainsSide2 as in LH_A or a list of interfaces as LH_A,L_HA, etc.  Accepted Interface Strings: L_H, L_A, H_A, and LH_A
-   numbering_scheme (&string):  Set the antibody numbering scheme.  Must also set the cdr_definition XML option. Both options can also be set through the command line (recommended).  See [[General Antibody Tips | General-Antibody-Options-and-Tips]] for more info.
-   cdr_definition (&string): Set the cdr definition you want to use.  Must also set the numbering_scheme XML option.  See [[General Antibody Tips | General-Antibody-Options-and-Tips]]


**More XML Options**
-   pack_separated (&bool) (default=false): Repack the detected interface residues during separation.
-   pack_together (&bool) (default=true): Repack the detected interface residues when they are together.
-   dSASA_cutoff (&real) (default=100): Buried Solvent Accessible Surface Area (SASA) cutoff to ignore reporting most values.
-   compute_packstat (&bool) (default=true): Compute the PackStat (RosettaHoles 1.0) value of the interface?  Typically it takes a tiny bit more time.  Sometimes packstat is buggy.  If you are having errors in packstat, try switching this off.  
-   skip_all_antigen_analysis (&bool) (default=false): By default if antigen is present, we will report some data on it.  Pass this option to true to skip antigen reporting.

**Tables**

_ab_metrics_

-   A set of antibody metrics.  Some repeated from the Interface metrics. Paratope is defined as all CDRs present in the antibody.

```sql
CREATE TABLE ab_metrics(
	struct_id INTEGER,
	numbering_scheme TEXT,
	cdr_definition TEXT,
	cdr_residues INTEGER,
	antigen_present INTEGER,
	antigen_chains TEXT,
	net_charge INTEGER,
	paratope_charge INTEGER,
	paratope_SASA REAL,
	paratope_hSASA REAL,
	paratope_pSASA REAL,
	VL_VH_packing_angle REAL,
	VL_VH_distance REAL,
	VL_VH_opening_angle REAL,
	VL_VH_opposite_opening_angle REAL,
	is_camelid INTEGER,
	FOREIGN KEY (struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY (struct_id))
```

_cdr_metrics_

-   Analysis of the CDRS in the antibody pose.

```sql
CREATE TABLE cdr_metrics(
	struct_id INTEGER,
	CDR TEXT,
	length INTEGER,
	start INTEGER,
	end INTEGER,
	ag_ab_contacts_total INTEGER,
	ag_ab_contacts_nres INTEGER,
	ag_ab_dSASA REAL,
	ag_ab_dSASA_sc REAL,
	ag_ab_dhSASA REAL,
	ag_ab_dhSASA_sc REAL,
	ag_ab_dhSASA_rel_by_charge REAL,
	ag_ab_dG REAL,
	SASA REAL,
	charge INTEGER,
	energy REAL,
	anchor_CN_distance REAL,
	aromatic_nres REAL,
	FOREIGN KEY (struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY (struct_id, CDR))

```

_ab_h3_kink_metrics_

-   Antibody H3 Kink Metrics

```sql
CREATE TABLE ab_h3_kink_metrics(
	struct_id INTEGER,
	kink_type TEXT,
	begin INTEGER,
	end INTEGER,
	anion_res INTEGER,
	cation_res INTEGER,
	RD_Hbond_dis REAL,
	bb_Hbond_dis REAL,
	Trp_Hbond_dis REAL,
	qdis REAL,
	qdih REAL,
	FOREIGN KEY (struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY (struct_id))
```


###CDRClusterFeatures

**Author**

Jared Adolf-Bryfogle; jadolfbr@gmail.com; 
PI: Roland Dunbrack

Part of the RosettaAntibody and RosettaAntibodyDesign (RAbD) Framework
* [[Rosetta Antibody Design (RAbD) Manual | RosettaAntibodyDesign]]

**References**

Adolf-Bryfogle J,  Xu Q,  North B, Lehmann A,  Roland L. Dunbrack Jr, [PyIgClassify: a database of antibody CDR structural classifications](http://nar.oxfordjournals.org/cgi/reprint/gku1106?ijkey=mLgOMi7GHwYPx77&keytype=ref) , Nucleic Acids Research 2014

North B, Lehmann A, Dunbrack R, [A new clustering of antibody CDR loop conformations](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3065967/pdf/nihms-249534.pdf) (2011). JMB 406(2): 228-256.


**Overview**

Reports information of the North/Dunbrack CDR Clusters of an antibody. (Uses North/Dunbrack CDR definition)

In order to use this Reporter, the antibody should be renumbered into a particular numbering scheme.  See [[General Antibody Tips | General-Antibody-Options-and-Tips]] for more information on how to renumber your antibody via different antibody servers.  If your antibody has come from RosettaAntibody 3.0, the antibody is already renumbered in the Chothia scheme, which is the default.  The numbering scheme can be specified through the command-line or via XML tag.

```xml
			<CDRClusterFeatures numbering_scheme="AHO_Scheme"/>
```

**XML Options**
-   numbering_scheme (&string):  Set the antibody numbering scheme.  Must also set the cdr_definition XML option. Both options can also be set through the command line (recommended).  See [[General Antibody Tips | General-Antibody-Options-and-Tips]] for more info.
-   cdrs (&string) (default=All CDRs Present):  Set the CDRs you wish to analyze.  Legal = [H1, h1, etc.]

**Tables**

_cdr_clusters_

```sql
CREATE TABLE cdr_clusters(
	struct_id INTEGER,
	resnum_begin INTEGER,
	resnum_end INTEGER,
	chain TEXT,
	CDR TEXT,
	length INTEGER,
	fullcluster TEXT,
	dis REAL,
	normDis REAL,
	normDis_deg REAL,
	sequence TEXT,
	FOREIGN KEY (struct_id) REFERENCES residues(struct_id) DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY (struct_id, resnum_begin, resnum_end))
```

##Beta-Sandwiches

###SandwichFeatures

**Overview**

Function summary: Extract and analyze beta-sandwiches

Extraction: Extract beta-sandwiches conservatively so that it correctly excludes alpha-helix that is identified as beta-sandwich by SCOP and excludes beta-barrel that is identified as beta-sandwiches by CATH. To dump into pdb files, use Matt's format\_converter.

Analysis: Phi/psi angles in core/edge strand each. Electrostatic interactions among residues. Assign one beta-sheet between two beta-sheets that constitute one beta-sandwich as additional chain so that InterfaceAnalyzer can be used. Beta_sheet_capping_info. Amino acids distribution/kind. Topology candidate. Beta-capping. Chirality.


**Tables**

-   **sandwich**

<!-- -->

    CREATE TABLE sandwich(
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


###StrandBundleFeatures

**Overview**

Function summary: Find all strands -\> Leave all pair of strands -\> Leave all pair of sheets

Function detail:

It generates smallest unit of beta-sandwiches that are input files of Tim's SEWING protocol.

After finding all beta strands in pdb files, leave all pair of beta strands (either parallel or anti-parallel) among them. Then leave all pair of beta sheets (which are constituted with 4 beta strands each). As it finds strands/sheets, it find only those that meet criteria specified in option. 'strand\_pairs' table and 'sandwich' table are created in a same schema respectively.


**Tables**

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

##GeometricSolvationFeatures

**Overview**

-   **geometric\_solvation** : The exact geometric solvation score which is computed by integrating the hbond energy not occupied by other atoms.
    -   *hbond\_site\_id* : A hydrogen bonding donor or acceptor
    -   *geometric\_solvation\_exact* : The non-pairwise decomposable version of the geometric solvation score.

**Tables**

<!-- -->

        CREATE TABLE IF NOT EXISTS geometric_solvation (
            struct_id INTEGER AUTOINCREMENT,
            hbond_site_id TEXT,
            geometric_solvation_exact REAL,
            FOREIGN KEY (struct_id, hbond_site_id) REFERENCES hbond_sites(struct_id, site_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, hbond_site_id));

##InterfaceFeatures

**Author**

Jared Adolf-Bryfogle; jadolfbr@gmail.com; 
PI: Roland Dunbrack


InterfaceAnalyzer Authors: Steven Lewis, P. Ben Stranges, Jared Adolf-Bryfogle
The PI is Brian Kuhlman, bkuhlman@email.unc.edu .


**Overview**

This Feature Reporter writes out three tables corresponding to interfaces of a given pose.  Behind the scenes, it uses an updated version of the [[InterfaceAnalyzerMover]], which is also used by the [[InterfaceAnalyzer application | interface-analyzer]].  Without options, it will detect all interfaces of a given pose and report on all of them, even if no residues are in them. 

```xml
			<InterfaceFeatures scorefxn="(& Scorefxn name)" interface="(&string)", pack_separated="(&bool, false)" pack_together="(&bool, false)" dSASA_cutoff="(&real, 100)" compute_packstat="(&bool, true)" pack_together="true"/>
```


**XML Options**

-   scorefxn (& scorefxn string): Specify a scorefunction to use
-   interface(s) (&string) (default=All Interfaces):  Specify the interface as ChainsSide1_ChainsSide2 as in LH_A or a list of interfaces as LH_A,L_HB, etc.  
-   pack_separated (&bool) (default=false): Repack the detected interface residues during separation.
-   pack_together (&bool) (default=true): Repack the detected interface residues when they are together.
-   dSASA_cutoff (&real) (default=100): Buried Solvent Accessible Surface Area (SASA) cutoff to ignore reporting most values.
-   compute_packstat (&bool) (default=true): Compute the PackStat (RosettaHoles 1.0) value of the interface?  Typically it takes a tiny bit more time.  Sometimes packstat is buggy.  If you are having errors in packstat, try switching this off.  

**Tables**

_interface_sides_

-   Output data specific to each side in a given interface

```sql
CREATE TABLE interface_sides(
	struct_id INTEGER,
	interface TEXT,
	side TEXT,
	chains_side1 TEXT,
	chains_side2 TEXT,
	interface_nres INTEGER,
	dSASA REAL,
	dSASA_sc REAL,
	dhSASA REAL,
	dhSASA_sc REAL,
	dhSASA_rel_by_charge REAL,
	dG REAL,
	energy_int REAL,
	energy_sep REAL,
	avg_per_residue_energy_dG REAL,
	avg_per_residue_energy_int REAL,
	avg_per_residue_energy_sep REAL,
	avg_per_residue_dSASA REAL,
	avg_per_residue_SASA_int REAL,
	avg_per_residue_SASA_sep REAL,
	aromatic_fraction REAL,
	aromatic_dSASA_fraction REAL,
	aromatic_dG_fraction REAL,
	interface_to_surface_fraction REAL,
	ss_sheet_fraction REAL,
	ss_helix_fraction REAL,
	ss_loop_fraction REAL,
	FOREIGN KEY (struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY (chains_side1, chains_side2) REFERENCES interfaces(chains_side1, chains_side2) DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY (struct_id, interface, side))
```

_interfaces_

-   Output Overall Interface Data

```sql
CREATE TABLE interfaces(
	struct_id INTEGER,
	interface TEXT,
	chains_side1 TEXT,
	chains_side2 TEXT,
	nchains_side1 INTEGER,
	nchains_side2 INTEGER,
	dSASA REAL,
	dSASA_hphobic REAL,
	dSASA_polar REAL,
	dG REAL,
	dG_cross REAL,
	dG_dev_dSASAx100 REAL,
	dG_cross_dev_dSASAx100 REAL,
	delta_unsatHbonds REAL,
	hbond_E_fraction REAL,
	sc_value REAL,
	packstat REAL,
	nres_int INTEGER,
	nres_all INTEGER,
	complex_normalized REAL,
	FOREIGN KEY (struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY (struct_id, interface))
```

_interface_residues_

-   Output data specific to the residues in a given interface of a given pose.

```sql
CREATE TABLE interface_residues(
	struct_id INTEGER,
	interface TEXT,
	resNum INTEGER,
	chains_side1 TEXT,
	chains_side2 TEXT,
	side TEXT,
	dSASA REAL,
	dSASA_sc REAL,
	dhSASA REAL,
	dhSASA_sc REAL,
	dhSASA_rel_by_charge REAL,
	SASA_int REAL,
	SASA_sep REAL,
	relative_dSASA_fraction REAL,
	dG REAL,
	energy_int REAL,
	energy_sep REAL,
	FOREIGN KEY (struct_id, resNum) REFERENCES residues(struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY (struct_id, interface, resNum))
```



##PoseConformationFeatures

**Overview**

The PoseConformationFeatures reporter measures the conformation level information in a Pose. Together with the ProteinResidueConformationFeatures, the atomic coordinates can be reconstructed. To facilitate creating poses from conformation structure data stored in the features database, PoseConformationFeatures has a *load\_into\_pose* method.

-   **pose\_conformations** : This table stores information about sequence of residues in the conformation.
	-   *annotated\_sequence* : The [annotated sequence](Glossary#annotatedsequence) string of residue types that make up the conformation
    -   *total\_residue* : The number of residues in the conformation
    -   *fullatom* : The ResidueTypeSet is *FA\_STANDARD* if true, and *CENTROID* if false.

**Tables**

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


##RadiusOfGyrationFeatures

**Overview**

Measure the radius of gyration for each structure. The radius of gyration measure of how compact a structure is in O(n). It is the expected displacement of mass from the center of mass. The Wikipedia page is has some [information](http://en.wikipedia.org/wiki/Radius_of_gyration) . Also see, Lobanov MY, Bogatyreva NS, Galzitskaya OV. [Radius of gyration as an indicator of protein structure compactness](http://www.springerlink.com/content/v01q1r143528u261/) . Molecular Biology. 2008;42(4):623-628.

-   **radius\_of\_gyration** :
    -   *radius\_of\_gyration* : Let *C* be the center of mass and *ri* be the position of residue *i'* th of *n* residues, then the radius of gyration is defined to be *Rg = SQRT{SUM\_{ri}(ri-C)\^2/(n-1)}* . Note: the normalizing factor is *n-1* to be consistent with r++. Atoms with variant type "REPLONLY" are ignored.

**Tables**

<!-- -->

        CREATE TABLE IF NOT EXISTS radius_of_gyration (
            struct_id INTEGER AUTOINCREMENT,
            radius_of_gyration REAL,
            FOREIGN KEY(struct_id) REFERENCES structures(struct_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id));


##SecondaryStructureSegmentFeatures

**Overview**
Report continuous segments of secondary structure. DSSP is used to define secondary structure, but simplified to be simply H, E, and L (all DSSP codes other than H and E). Due to this simplification of DSSP codes, the dssp column is NOT a foreign key to the dssp\_codes table.

**Tables**

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

##SmotifFeatures

**Overview**

Record a set of geometric parameters defined by two pieces of adjacent secondary structure. More information can be found here: [http://www.ploscompbiol.org/article/info%3Adoi%2F10.1371%2Fjournal.pcbi.1000750](http://www.ploscompbiol.org/article/info%3Adoi%2F10.1371%2Fjournal.pcbi.1000750)


**Tables**

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


##StructureFeatures

**Overview**

A structure is a group of spatially organized residues. The definition corresponds with a Pose in Rosetta. Unfortunately in Rosetta there is not a well defined way to identify a Pose. For the purposes of the the features database, each structure is assigned a unique struct\_id. To facilitate connecting structures in the database with structures in structures Rosetta, the tag field is unique.

-   **structures** : Identify the structures in the features database
    -   *tag* : The tag identifies the structure in Rosetta. The following locations are searched in order.
        1.  *pose.pdb\_info()-\>name()*
        2.  *pose.data().get(JOBDIST\_OUTPUT\_TAG)*
        3.  *JobDistributor::get\_instance()-\>current\_job()-\>input\_tag()*

**Tables**

<!-- -->

        CREATE TABLE IF NOT EXISTS structures (
            struct_id INTEGER PRIMARY KEY AUTOINCREMENT,
            protocol_id INTEGER,
            tag TEXT,
            UNIQUE (protocol_id, tag),
            FOREIGN KEY (protocol_id) REFERENCES protocols (protocol_id) DEFERRABLE INITIALLY DEFERRED);