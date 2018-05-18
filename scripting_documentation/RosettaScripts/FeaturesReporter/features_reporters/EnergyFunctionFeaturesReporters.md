#EnergyFunctionFeaturesReporters

TotalScoreFeatures
------------------
Report the total score for each structure using whatever score function you like.  The difference between this reporter and the many others that deal with scores is simplicity.  This reporter only reports total scores and has a very simple schema.  In most cases, this is exactly what you want.  But if you need to break down your scores by type or by residue, then you will need to use one or more of the other reporters described in this section.

Example:

```xml
<TotalScoreFeatures scorefxn="talaris2013"/>
```

Options:

* scorefxn: Required.  The name of the score function to report.

Schema:

```sql
CREATE TABLE `total_scores` (
  `struct_id` bigint(20) NOT NULL,
  `score` double NOT NULL,
  PRIMARY KEY (`struct_id`)
)
```

ScoreTypeFeatures
-----------------

The ScoreTypeFeatures store the score types for as for all EnergyMethods.

        <ScoreTypeFeatures scorefxn="(default_scorefxn &string)"/>

-   **score\_types** : Store information about the EnergyMethod associated with each score type.
    -   *batch\_id* : The score types are reference the *batches* tabe to allow for score types to change change over time.
    -   *score\_type\_id* : The *core::scoring::ScoreType* enum values.
    -   *score\_type\_name* : The string version of the *core::scoring::ScoreType* enum values.

<!-- -->

        CREATE TABLE IF NOT EXISTS score_types (
            batch_id INTEGER,
            score_type_id INTEGER,
            score_type_name TEXT,
            FOREIGN KEY (batch_id) REFERENCES batches (batch_id) DEFERRABLE INITIALLY DEFERRED),
            PRIMARY KEY (batch_id, score_type_id);

ScoreFunctionFeatures
---------------------

The ScoreFunctionFeatures store the weights and energy method options for the score function.

        <ScoreFunctionFeatures scorefxn="(default_scorefxn &string)"/>

-   **score\_function\_weights** : Store the non-zero score term weights.
    -   *score\_function\_name* : The tag name of the score function specified in the \<SCOREFUNCTIONS/\> block
    -   *score\_type\_id* : The *core::scoring::ScoreType* enum values
    -   *weight* : The score term weight

<!-- -->

        CREATE TABLE IF NOT EXISTS score_function_weights (
            batch_id INTEGER,
            score_function_name INTEGER,
            score_type_id INTEGER,
            weight REAL,
            FOREIGN KEY (batch_id, score_type_id) REFERENCES score_types (batch_id, score_type_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (batch_id, score_type_id));

-   **score\_function\_method\_options** : Store the method options for the score function.
    -   *score\_function\_name* : The tag name of the score function specified in the \<SCOREFUNCTIONS/\> block
    -   *option\_key* : The method option
    -   *option\_value* : The value of the method option

<!-- -->

        CREATE TABLE IF NOT EXISTS score_function_method_options (
            batch_id INTEGER,
            score_function_name INTEGER,
            option_key TEXT,
            option_value TEXT,
            FOREIGN KEY (batch_id) REFERENCES batches (batch_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (batch_id, score_function_name, option_key);

StructureScoresFeatures
-----------------------

        <StructureScoresFeatures scorefxn="(&scorefxn)"/>

The StructureScoresFeatures stores the overall score information for all enabled EnergyMethods.

-   Depends on **ScoreTypesFeatures**

-   **structure\_scores** :
    -   *score\_value* : The weighted score value for the given type.

<!-- -->

        CREATE TABLE IF NOT EXISTS structure_scores (
            batch_id INTEGER
            struct_id INTEGER AUTOINCREMENT,
            score_type_id INTEGER,
            score_value INTEGER,
            FOREIGN KEY (struct_id) REFERENCES structures (struct_id) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY (batch_id, score_type_id) REFERENCES score_types (batch_id, score_type_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY (batch_id, struct_id, score_type_id));

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
            batch_id INTEGER,
            struct_id INTEGER AUTOINCREMENT,
            resNum INTEGER,
            score_type_id INTEGER,
            score_value REAL,
            context_dependent INTEGER,
            FOREIGN KEY (struct_id, resNum) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY (batch_id, score_type_id) REFERENCES score_types (batch_id, score_type_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(batch_id, struct_id, resNum, score_type)); 

-   **residue\_scores\_2b** : The two-body scores for each pair of residues in the structure. Note: Intra-residue two body terms are stored in this table with resNum1 == resNum2.
    -   *resNum1* , *resNum2* : The rosetta residue numbering for the participating residues. Note: *resNum1* \<= *resNum2*
    -   *score\_type* : The score type as a string
    -   *score\_value* : The score value
    -   *context\_dependent* : 0 if the score type is context-independent and 1 if it is context-dependent

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_scores_2b (
            batch_id INTEGER,
            struct_id INTEGER AUTOINCREMENT,
            resNum1 INTEGER,
            resNum2 INTEGER,
            score_type_id INTEGER,
            score_value REAL,
            context_dependent  INTEGER,
            FOREIGN KEY (struct_id, resNum1) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY (struct_id, resNum2) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            FOREIGN KEY (batch_id, score_type_id) REFERENCES score_types (batch_id, score_type_id) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(batch_id, struct_id, resNum1, resNum2, score_type));

ResidueTotalScoresFeatures
--------------------------

        <ResidueTotalScoresFeatures scorefxn="(&scorefxn)"/>

The ResidueTotalScoresFeatures stores for each residue the total score for the one body terms for that residue and half the total score for the two body terms involving that residue. Note that terms that depend on the whole structure are stored via the StructureScoresFeatures. In order to include hydrogen bonding in the totals, the score function must specify the *[[decompose_bb_hb_into_pair_energies|RosettaScripts#scorefunctions]]* flag.

-   **residue\_total\_scores** : The one body scores for each residue in the structure.
    -   *score\_value* : SUM(1b) + SUM(2b)/2 energies

<!-- -->

        CREATE TABLE IF NOT EXISTS residue_total_scores (                                                                                                                      
            struct_id INTEGER AUTOINCREMENT,
            resNum INTEGER,
            score_value REAL,
            FOREIGN KEY (struct_id, resNum) REFERENCES residues (struct_id, resNum) DEFERRABLE INITIALLY DEFERRED,
            PRIMARY KEY(struct_id, resNum)); 

HBondParameterFeatures
----------------------

The parameters for the hydrogen bond potential are specified in the Rosetta database as parameter sets. Each parameter set specifies polynomials, fade functions, and which are applied to which hydrogen bond chemical types. To indicate parameter set, either use *-hbond\_params \<database\_tag\>* set on the command line, or set *score\_function.energy\_method\_options().hbond\_options()-\>params\_database\_tag(\<database\_tag\>)* . 

-   **hbond\_fade\_interval** : Limited interaction between geometric dimensions are controlled by simple fading functions of the form \_\_/----\\\_\_.
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

-   **hbond\_polynomial\_1d** : One dimensional polynomials for each geometric dimension used to compute the hydrogen bond energy. 
    -   *database\_tag* : The hydrogen bond parameter set
    -   *name* : The name of the polynomial referenced in the *hbond\_evaluation\_types* table.
    -   *dimension* : The geometric dimension with which the polynomial should be used.
    -   *xmin* , *xmax* : The polynomial is truncated beyond the *xmin* and *xmax* values.
    -   *root1* , *root2* : The values where the polynomial equals 0.
    -   *degree* : The number of coefficients in the polynomial. For example 10x\^2 - 3x + 1 would have degree 3.
    -   *c\_\** : The coefficients of the polynomial, ordered from highest power to the lowest power.

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
    -   *AHdist\_{short/long}\_fade* : The fading functions to be applied to the AHdist polynomial evaluations. The short/long distinction allows for different angle dependence for hydrogen bonds that have different bond lengths. The distinction follows in spirit the behavior originally described in [Kortemme 2003](http://www.sciencedirect.com/science/article/B6WK7-47WBSCV-T/2/d7c673dd51017848231e7b9e8c05fbca) .
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

ScreeningFeatures
-----------------

ScreeningFeatures is used to consolidate scoring information related to a ligand into a table for later processing. It is most useful when you would otherwise need to join multiple very large tables, and was originally intended for use in a High Throughput Screening Pipeline. This mover must be used in conjunction with the screening\_job\_inputter.

    <ScreeningFeatures chain="(chain &string)">
        <descriptor type="(descriptor_name &string)"/>
        <descriptor type="(descriptor_name &string)"/>
    </ScreeningFeatures>

In the XML definition above, chain is a ligand chain and the descriptor type is the string key in a string\_real or string\_string pair added to the job. This mover currently assumes that ligands consist of one residue.

    CREATE TABLE `screening_features` (
      `struct_id` bigint(20) NOT NULL,
      `residue_number` int(11) NOT NULL,
      `chain_id` varchar(1) NOT NULL,
      `name3` text NOT NULL,
      `group_name` text NOT NULL,
      `descriptor_data` text NOT NULL,
      PRIMARY KEY (`struct_id`,`residue_number`),
      CONSTRAINT `screening_features_ibfk_1` FOREIGN KEY (`struct_id`) REFERENCES `structures` (`struct_id`)
    ) 

-   **screening\_features** :
    -   *struct\_id* - The struct\_id
    -   *residue\_number* - The ligand residue number
    -   *chain\_id* - The ligand chain id
    -   *name3* - The 3 letter name of the ligand
    -   *group\_name* - The group\_name specified by the screening\_job\_inputter
    -   *descriptor\_data* - The data associated with the descriptors defined in the xml script. The data is formatted as a JSON dictionary.


