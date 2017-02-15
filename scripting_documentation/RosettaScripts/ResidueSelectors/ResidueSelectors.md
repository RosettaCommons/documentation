<!-- --- title: ResidueSelectors -->

*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*

ResidueSelectors
----------------

ResidueSelectors define a subset of residues from a Pose. Their apply() method takes a Pose and returns a ResidueSubset (a utility::vector1\< bool \>). This vector1 will be as large as there are residues in the input Pose, and its ith entry will be "true" if residue i has been selected. Once you have a ResidueSubset, you can use it in a number of ways.  For instance, you can use the OperateOnResidueSubset task operation to combine a ResidueSelector with a [[Residue Level TaskOperation|Residue Level TaskOperations]] to modify the ResidueLevelTasks which have a "true" value in the ResidueSubset. ResidueSelectors should be declared in their own block and named, or declared as subtags of other ResidueSelectors or of TaskOperations that accept ResidueSelectors (such as the OperateOnResidueSubset task operation).

Note that certain other Rosetta modules (e.g. the [[ReadResfile|ReadResfileOperation]] TaskOperation, which is not a Residue Level TaskOperation but can still accept a ResidueSelector as input) may also use ResidueSelectors.  Ultimately, it is hoped that many Rosetta components will be modified to permit this standardized method of selecting residues.

The purpose of separating the residue selection logic from the modifications that TaskOperations perform on a PackerTask is to make available the complicated logic of selecting residues that often lives in TaskOperations. If you have a complicated TaskOperation, consider splitting it into a ResidueSelector and operations on the residues it selects.

ResidueSelectors can be declared in their own block, outside of the TaskOperation block. For example:

    <RESIDUE_SELECTORS>
       <Chain name=chA chains=A/>
       <Index name=res1to10 resnums=1-10/>
    </RESIDUE_SELECTORS>

Some ResidueSelectors can nest other ResidueSelectors in their definition; e.g.

    <RESIDUE_SELECTORS>
        <Neighborhood name="chAB_neighbors">
            <Chain chains="A,B">
        </Neighborhood>
    </RESIDUE_SELECTORS>

In which case, the structure of the Neighborhood ResidueSelector will be stated as

    <Neighborhood name=(%string) ... >
        <(Selector)>
    </Neighborhood>

With the <(Selector)> subtag designating that any ResidueSelector can be nested inside it.

[[_TOC_]]

### Logical ResidueSelectors

#### NotResidueSelector

    <Not name="(&string)" selector="(&string)">

or

    <Not name="(&string)">
        <(Selector) .../>
    </Not>

-   The NotResidueSelector requires exactly one selector.
-   The NotResidueSelector flips the boolean status returned by the apply function of the selector it contains.
-   If the "selector" option is given, then a previously declared ResidueSelector (from the RESIDUE\_SELECTORS block of the XML file) will be retrieved from the DataMap
-   If the "selector" option is not given, then a sub-tag containing an anonymous/unnamed ResidueSelector must be declared. This selector will not end up in the DataMap.  For example, it is possible to nest a Chain selector beneath a Not selector to say "give me everything except chain A:"
    ```
    <Not name="all_but_chA">
       <Chain chains="A"/>
    </Not>
    ```
any ResidueSelector can be defined as a subtag of the Not selector.  You cannot, however, pass the subselector by name except by using the "selector" option.

#### AndResidueSelector

    <And name="(&string)" selectors="(&string)">
       <(Selector1)/>
       <(Selector2)/>
        ...
    </And>

-   The AndResidueSelector can take arbitrarily many selectors.
-   The AndResidueSelector takes a logical *AND* of the ResidueSubset vectors returned by the apply functions of each of the ResidueSelectors it contains.  <b>Practically speaking, this means that it returns the <i>intersection</i> of the selected sets -- the residues that are in set 1 AND in set 2.</b>  (Do not confuse this with the "or" selector, which returns the union of the two sets -- the residues that are in set 1 OR in set 2.)
-   The "selectors" option should be a comma-separated string of previously-declared selector names. These selectors will be retrieved from the DataMap.
-   The "selectors" option is not required, nor are the sub-tags required; but at least one of the two must be given. Both can be given, if desired.
-   Selectors declared in the sub-tags will be appended to the set of selectors for the AndResidueSelector, but will not be added to the DataMap.

#### OrResidueSelector

    <Or name="(&string)" selectors="(&string)">
       <(Selector1)/>
       <(Selector2)/>
        ...
    </Or>

-   The OrResidueSelector can take arbitrarily many selectors.
-   The OrResidueSelector takes a logical *OR* of the ResidueSubset vectors returned by the apply functions of each of the ResidueSelectors it contains.  <b>Practically speaking, this means that it returns the <i>union</i> of the selected sets -- the residues that are in set 1 OR in set 2.</b>  (Do not confuse this with the "and" selector, which returns the intersection of the two sets -- the residues that are in set 1 AND in set 2.)
-   The "selectors" option should be a comma-separated string of previously-declared selector names. These selectors will be retrieved from the DataMap.
-   The "selectors" option is not required, nor are the sub-tags required; but at least one of the two must be given. Both can be given, if desired.
-   Selectors declared in the sub-tags will be appended to the set of selectors for the OrResidueSelector, but will not be added to the DataMap.

### Conformation Independent Residue Selectors

#### ChainSelector

    <Chain chains="(&string)"/>

-   The string given for the "chains" option should be a comma-separated list of chain identifiers
-   Each chain identifier should be either an integer, so that the Pose chain index will be used, or a single character, so that the PDB chain ID can be used.
-   The ChainSelector sets the positions corresponding to all the residues in the given set of chains to true, and all the other positions to false.

#### JumpDownstreamSelector

    <JumpDownstream jump="(&int)"/>

-   The integer given for the "jump" argument should refer to a Jump that is present in the Pose.
-   The JumpDownstreamSelector sets the positions corresponding to all of the residues that are downstream of the indicated jump to true, and all the other positions to false.
-   This selector is logically equivalent to a NotSelector applied to the JumpUpstreamSelector for the same jump.

#### JumpUpstreamSelector

    <JumpUpstream jump="(&int)"/>

-   The integer given for the "jump" argument should refer to a Jump that is present in the Pose.
-   The JumpUpstreamSelector sets the positions corresponding to all of the residues that are upstream of the indicated jump to true, and all the other positions to false.
-   This selector is logically equivalent to a NotSelector applied to the JumpDownstreamSelector for the same jump.

#### RandomResidueSelector

Selects residues in the pose at random. Note that this residue selector is stochastic. This is, it will return a different set of residues every time it is called. However, the randomly selected residues can be saved using the [[StoreResidueSubsetMover]] and retrieved using the [[StoredResidueSubset|ResidueSelectors#other_storedresiduesubset]] selector.

    <RandomResidue name="(&string)"
        selector="(TrueSelector &string)"
        num\_residues="(1 &int)" />

- num\_residues -- The number of residues to be randomly selected
- residue\_selector -- Defines the subset from which random residues are chosen.



#### ResidueIndexSelector

    <Index name="(&string)" resnums="(&string)"/>

-   The string given for the "resnums" option should be a comma-separated list of residue identifiers
-   Each residue identifier should be either:
    * *an integer* , so that the Pose numbering can be used, 
    * *two integers separated by a dash* , designating a range of Pose-numbered residues, 
    * *an integer followed by a single character* , e.g. 12A, referring to the PDB numbering for residue 12 on chain A,  
    * *an integer followed by a single character, followed by a dash, followed by an integer followed by a single character*, e.g. 12A-47A, referring to residues 12 through 47 on chain A in PDB numbering.
(Note, residues that contain insertion codes cannot be properly identified by these PDB numbered schemes).
-   The ResidueIndexSelector sets the positions corresponding to the residues given in the resnums string to true, and all other positions to false.

#### ResidueNameSelector
Selects residues by their full Rosetta residue type name. At least one of residue_names and residue_name3 must be specified.

    <ResidueName residue_names="(&string)" residue_name3="(&string)" />

residue_names - A comma-separated list of Rosetta residue names (including patches). For example, "CYD" will select all disulfides, and "CYD,SER:NTermProteinFull,ALA" will select all disulfides, alanines, and N-terminal serines -- all other residues will not be selected (i.e. be false in the ResidueSubset object).

residue_name3 - A comma-separated list of 3-letter Rosetta residue names.  These will be selected regardless of variant type. For example, "SER" will select residues named "SER", "SER:NtermProteinFull", and "SER:Phosphorylated".

**Example**
This example will select all variants of ALA, C-terminal ASN residues, and disulfides:

    <ResidueName residue_names="ASN:CtermProteinFull,CYD" residue_name3="ALA" />



#### Antibody Residue Selectors

These Residue selectors use the underlying Antibody Modeling and Design Framework, and require a renumbered antibody structure.  Please see [[General Antibody Options and Tips]] for more.  If your antibody was output by RosettaAntibody, it is already renumbered into the Chothia Scheme, which is the default.

##### AntibodyRegionSelector 
Selects CDR residues in an antibody or camelid antibody. 

- Author: Dr. Jared Adolf-Bryfogle (jadolfbr@gmail.com) 
- PIs: Dr. Roland Dunbrack and Dr. William Schief

```
    <AntibodyRegion name="(&string)" region="(&string)" numbering_scheme="(&string)" cdr_definition="(&string)" />
```

-   _region (&string) (default=cdr_region)_:  Select the region you wish to disable. Accepted strings: cdr_region, framework_region, antigen_region. 
-   _numbering_scheme (&string)_:  Set the antibody numbering scheme.  Must also set the cdr_definition XML option. Both options can also be set through the command line (recommended).  See [[General Antibody Tips | General-Antibody-Options-and-Tips]] for more info.
-   _cdr_definition (&string)_: Set the cdr definition you want to use.  Must also set the numbering_scheme XML option.  

-  See Also:
 - [[Antibody Movers | Movers-RosettaScripts#antibody-modeling-and-design-movers]]
 - [[Antibody TaskOperations | TaskOperations-RosettaScripts#antibody-and-cdr-specific-operations]]
 - [[General Antibody Tips | General-Antibody-Options-and-Tips]]
 
##### CDRResidueSelector 
Selects CDR residues in an antibody or camelid antibody. 

- Author: Dr. Jared Adolf-Bryfogle (jadolfbr@gmail.com) 
- PIs: Dr. Roland Dunbrack and Dr. William Schief

```
    <CDR name="(&string)" cdrs="(&string,&string)" numbering_scheme="(&string)" cdr_definition="(&string)" />
```

-   _cdrs (&string,&string)_ (default=all cdrs):  Select the set of CDRs you wish to restrict to (ex: H1 or h1) 
-   _numbering_scheme (&string)_:  Set the antibody numbering scheme.  Must also set the cdr_definition XML option. Both options can also be set through the command line (recommended).  See [[General Antibody Tips | General-Antibody-Options-and-Tips]] for more info.
-   _cdr_definition (&string)_: Set the cdr definition you want to use.  Must also set the numbering_scheme XML option. 

-  See Also:
 - [[Antibody Movers | Movers-RosettaScripts#antibody-modeling-and-design-movers]]
 - [[Antibody TaskOperations | TaskOperations-RosettaScripts#antibody-and-cdr-specific-operations]]
 - [[General Antibody Tips | General-Antibody-Options-and-Tips]]






#### Carbohydrate Residue Selectors

These Residue selectors use the underlying RosettaCarbohydrate Framework.

##### [[GlycanTreeSelector]]

##### [[GlycanResidueSelector]]


### Conformation Dependent Residue Selectors

#### BinSelector

The BinSelector selects residues that fall in a named mainchain torsion bin (e.g. the "A" bin, corresponding to alpha-helical residues by the "ABEGO" nomenclature).  Non-polymeric residues are ignored.  By default, only alpha-amino acids are selected, though this can be disabled.

```
     <Bin name="(&string)" bin="(&string)" bin_params_file="('ABEGO' &string)" select_only_alpha_aas="(true &bool)" />
```
- bin: The name of the mainchain torsion bin.
- bin_params_file: The filename of a bin_params file that defines a set of torsion bins.  Current options include "ABEGO", "ABBA" (a symmetric version of the ABEGO nomenclature useful for mixed D/L design), and "PRO_DPRO" (which defines bins "LPRO" and "DPRO" corresponding to the regions of Ramachandran space accessible to L- and D-proline, respectively).  Predefined bin_params files are in database/protocol_data/generalizedKIC/bin_params/.  A custom-written bin_params file may also be provided with its relative path from the execution directory.
- select_only_alpha_aas: If true, only alpha-amino acids are selected.  If false, any polymeric type allowed by the bin definitions file is selected.

This example selects all residues that are in the region of Ramachandran space accessible to D-proline (which can be useful in the context of a script that attempts to design such positions to D-proline):

```
     <Bin name="select_d_pro_positions" bin="DPRO" bin_params_file="PRO_DPRO" />
```

The BinSelector can be combined with AND, OR, or NOT selectors to select multiple regions.  For example, the following would select residues that are in the right- or left-handed helical regions of Ramachandran space:

```
     <Bin name="right_handed_helices" bin="A" bin_params_file="ABBA" />
     <Bin name="left_handed_helices" bin="Aprime" bin_params_file="ABBA" />
     <Or name="right_or_left_handed_helices" selectors="right_handed_helices,left_handed_helices" />
```

#### InterGroupInterfaceByVector

    <InterfaceByVector name="(%string)" cb_dist_cut="(11.0&float)" nearby_atom_cut="(5.5%float)" vector_angle_cut="(75.0&float)" vector_dist_cut="(9.0&float)" grp1_selector="(%string)" grp2_selector="(%string)"/>

or

    <InterfaceByVector name="(%string)" cb_dist_cut="(11.0&float)" nearby_atom_cut="(5.5%float)" vector_angle_cut="(75.0&float)" vector_dist_cut="(9.0&float)">
       <(Selector1)/>
       <(Selector2/>
    </InterfaceByVector>

-   Selects the subset of residues that are at the interface between two groups of residues (e.g. residues on different chains, which might be useful in docking, or residues on the same chain, which might be useful in domain assembly) using the logic for selecting interface residues as originally developed by Stranges & Leaver-Fay. This logic selects residues that are either already in direct contact with residues in the other group (i.e. contain atoms within the nearby\_atom\_cut distance threshold of the other group's atoms) or that are pointing their c-alpha-c-beta vectors towards the other group so that at least one c-beta *i* -c-alpha *i* -c-alpha *j* angle (between residues *i* and *j* ) is less than the vector\_angle\_cut angle threshold (given in degrees) and has its neighbor atom within the vector\_dist\_cut distance threshold (given in Angstroms) of at least one neighbor atom from the other group.
-   Groups 1 and 2 can be given either through the grp1\_selector and grp2\_selector options, (requiring that the indicated selectors had been previously declared and placed in the DataMap) or may be declared anonymously in the given subtags. Anonymously declared selectors are not added to the DataMap.
-   The cb\_dist\_cut is a fudge factor used in this calculation and is used only in constructing an initial graph; neighbor relationships are only considered between pairs of residues that have edges in this initial graph. cb\_dist\_cut should be greater than vector\_dist\_cut.
-   Because of how the logic is set in the interface detection function by Stranges et al., the vector angle criterion will not be checked for residues satisfying the nearby\_atom\_cut distance criterion. If you want all residues to satisfy the vector criterion set cb\_dist\_cut to 0.

#### LayerSelector

The LayerSelector lets a user select residues by burial.  Burial can be assessed by number of sidechain neighbors within a cone along the CA-CB vector (the default method), or by SASA.

```
     <Layer name="(&string)" select_core="(false &bool)" select_boundary="(false &bool)" select_surface="(false &bool)"
          ball_radius="(2.0 &Real)" use_sidechain_neighbors="(true &bool)"
          sc_neighbor_dist_exponent="(1.0 &Real)" sc_neighbor_dist_midpoint="(9.0 &Real)"
          sc_neighbor_denominator="(1.0 &Real)" sc_neighbor_angle_shift_factor="(0.5 &Real)"
          sc_neighbor_angle_exponent="(2.0 &Real)"
          core_cutoff="(5.2 &Real)" surface_cutoff="(2.0 &Real)"
     />
```

Options:
- select\_core=(false &bool), select\_boundary=(false &bool), select\_surface=(false &bool): Boolean flags that let the user choose which layer(s) should be selected.  Multiple layers are permitted, but at least one must be specified or no residues will be selected.
- use_sidechain_neighbors=(true &bool): Should the sidechain neighbor algorithm be used to determine which layer a residue lies in (the default) or should the older SASA-based method be used instead?

SASA-specific options:
- ball_radius=(2.0 &Real): The radius for the rolling ball algorithm used to pick residues by SASA.
- core_cutoff=(20.0 &Real), surface_cutoff=(40.0 &Real):  The SASA values (as a percentage of total surface area) below which a residue is sorted into the core group, or above which a residue is sorted into the surface group.  Note that setting use_sidechain_neighbors=false alters the default values of core_cutoff and surface_cutoff.

Sidechain neighbor-specific options:
- core_cutoff=(5.2 &Real), surface_cutoff=(2.0 &Real):  The number of sidechain neighbors (weighted counts -- see below) above which a residue is sorted into the core group, or below which a residue is sorted into the surface group.

Neighbor residues are counted, weighted by a factor that is a distance factor multiplied by an angle factor.  The two factors are calculated as follows:

**distance factor = 1 / (1 + exp( n*(d - m) ) )**, where **d** is the distance of the neighbor from the residue CA, **m** is the midpoint of the distance falloff, and **n** is a falloff exponent factor that determines the sharpness of the distance falloff (with higher values giving sharper falloff near the midpoint distance).

**angle factor = ( (cos(theta)+a)/(1+a) )^b**, where **theta** is the angle between the CA-CB vector and the CA-neighbor vector, **a** is an offset factor that widens the cone somewhat, and **b** is an exponent that determines the sharpness of the angular falloff (with lower values resulting in a broader cone with a sharper edge falloff).

The parameters above generally need not be changed from their default values.  If the user wishes to change them, though, he or she can do so by altering the following:

- sc_neighbor_dist_exponent=(1.0 &Real): Alters the value of **n**, the distance exponent.
- sc_neighbor_dist_midpoint=(9.0 &Real): Alters the value of **m**, the distance falloff midpoint.
- sc_neighbor_angle_shift_factor=(0.5 &Real): Alters the value of **a**, the angular shift factor.
- sc_neighbor_angle_exponent=(2.0 &Real): Alters the value of **b**, the angular sharpness value.
- sc_neighbor_denominator=(1.0 &Real): Alters the value by which the overall expression is divided.

#### NeighborhoodResidueSelector

    <Neighborhood name=(%string) resnums=(%string) distance=(10.0%float)/>

or

    <Neighborhood name=(%string) selector=(%string) distance=(10.0%float)/>

or

    <Neighborhood name=(%string) distance=(10.0%float)>
       <Selector ... />
    </Neighborhood>

-   The NeighborhoodResidueSelector selects all the residues within a certain distance cutoff of a focused set of residues.
-   It sets each position in the ResidueSubset that corresponds to a residue within a certain distance of the focused set of residues __as well as the residues in the focused set__ to true, and sets all other positions to false.
-   The set of focused residues can be specified in one of three (mutually exclusive) ways: through a resnums string (see the ResidueIndexSelector [[above|TaskOperations-RosettaScripts#ResidueIndexSelector]] for documentation on how this string should be formatted), a previously-declared ResidueSelector using the "selector" option, or by defining a subtag that declares an anonymous ResidueSelector.  
-   Now uses the 10A neighbor graph embedded in the pose after scoring to increase speed of calculation.  Useful for many calls, or when this selector is used as a TaskOperation using the OperateOnResidueSubset operation (Jared Adolf-Bryfogle, June '16).
-  __include_focus_in_subset__ (&bool) (default = True)  Set this option to false to only include neighbor residues.    
-   atom_names_for_distance_measure (&string)  Comma separated list of names of atoms to be used instead of the default neighbor atom per focus residue. This should come in handy to select around a particular ligand atom or a polar atom of a residue. __The number of atom names should be equal to the number of focus residues__, otherwise an error will be thrown during the apply time.

#### NumNeighborsSelector

```
    <NumNeighbors name="(%string)" count_water="(false&bool)" threshold="(17%integer)" distance_cutoff="(10.0&float)"/>
```

-   The NumNeighborsSelector sets to true each position in the ResidueSubset that corresponds to a residue that has at least *threshold* neighbors within *distance\_cutoff,* and sets all other positions to false.
-   The NumNeighborsSelector uses the coordinate of each residue's neighbor atom as a representative and counts two residues as being neighbors if their neighbor atoms are within *distance\_cutoff* of each other.
-   It is possible to include water residues in the neighbor count by setting the "count\_water" boolean to true


#### PhiSelector


```
     <Phi name="(&string)" select_positive_phi="(true &bool)" ignore_unconnected_upper="(true &bool)" />
```
- select_positive_phi: If true (the default), alpha-amino acids with phi values greater than or equal to zero are selected.  If false, alpha-amino acids with phi values less than zero are selected.
- ignore_unconnected_upper: If true (the default) then C-terminal residues and other residues with nothing connected at the upper connection are not selected.  If false, then these residues can be selected, depending on their phi values.  Note that anything lacking a lower connection is <i>never</i> selected.


     The PhiSelector selects alpha-amino acids that are in either the positive phi or negative phi region of Ramachandran space.  Ligands and polymeric residues that are not alpha-amion acids are never selected.  Alpha-amino acids with no lower connection (or nothing connected at the lower connection) are also never selected.  By default, alpha-amino acids with no upper connection are not selected, though this can be disabled.

     The PhiSelector is convenient for:

- Counting and limiting the number of positive-phi positions when sampling loop conformations.
- Restricting positive-phi positions to be glycine, and negative-phi positions to be L-amino acids, when doing canonical design of conventional proteins.
- Limiting the number of L-amino acids in the positive-phi region of Ramachandran space, in conjunction with the aa_composition score term.
- Restricting residues in the positive-phi region to be D-amino acids and residues in the negative-phi region to be L-amino acids when doing mixed D/L design of synthetic peptides.

#### PairedSheetResidueSelector

    <PairedSheetResidueSelector name=(%string)
        secstruct=(%string, "")
        sheet_topology=(%string)
        use_dssp=(%bool, True) />

The PairedSheetResidueSelector selects all residues involved in strand-strand pairings. The set of paired residues is computed by a combination of the secondary structure and user-specified sheet topology. For example, consider an antiparallel beta sheet with secondary structure "LEEEELLEEEEEELLEEEEEEL".  In this case strand 1 is four residues (2-5), and strands 2 (residues 8-13) and 3 (residues 16-21) each have 6 residues. If the given sheet topology is '1-2.A.-1' (i.e. strand 1-2 are paired in an antiparallel direction with register shift 1), the paired residues in those strands are 2-11, 3-10, 4-9, and 5-8. Thus, residues 2, 3, 4, 5, 8, 9, 10, and 11 will be selected. Although residues 12 and 13 are in strand 2, they are not paired with anything in the given topology and will not be selected. Similarly, a given topology of '1-2.A.-1;2-3.A.0' will select all residues marked 'E' by DSSP (2, 3, 5, 8, 9, 10, and 11 from the '1-2.A.-1' pairing, plus 8, 9, 10, 11, 12, 13, 16, 17, 18, 19, 20, and 21 from the '2-3.A.0' pairing).

#####Options
**secstruct** - Secondary structure to be used to determine strand residues. If not specified, secondary structure will be chosen based on the value of the 'use_dssp' option

**use_dssp** - If true, and secstruct is not given, the input secondary structure will be computed by DSSP.  If false, the secondary structure saved in the pose will be used. Note this secondary structure saved in the pose may not always reflect the pose contents unless it is explicitly set via DsspMover.

**sheet_topology** - String describing sheet topology, of the format A-B.P.R, where A is the strand number of the first strand in primary space, B is the strand number of the second strand in primary space, P is 'P' for parallel and 'A' for antiparallel, and R is the register shift.

#####Example
The following example will select all paired residues among strands 1 and 2, using a secondary structure computed by DSSP:

```
<PairedSheetResidueSelector name="E1-E2_pairs"
    sheet_topology="1-2.A.-1" use_dssp="1" />
```


#### PrimarySequenceNeighborhoodSelector

    <PrimarySequenceNeighborhood name=(%string) selector=(%string) lower=(1%int) upper=(1%int) />

or

    <PrimarySequenceNeighborhood name=(%string) lower=(1%int) upper=(1%int) >
       <Selector ... />
    </PrimarySequenceNeighborhood>

-   The PrimarySequenceNeighborhoodResidueSelector selects all the residues within a certain number of residues of a given selection in primary sequence. For example, given a selection of residue 5, PrimarySequenceNeighborhood would select residues 4, 5 and 6 by default.  If upper was set to 2, it would select residues 4, 5, 6 and 7. This ResidueSelector is chain-aware, meaning it will not select residues on a different chain than the original selection. In the example above, if residue 5 were on chain 1 and residue 6 were on a chain 2, the PrimarySequenceNeighborhoodResidueSelector would select residues 4 and 5 only.

**lower** - Number of residues to select lower (i.e. N-terminal) to the input selection. Default=1

**upper** - Number of residues to select upper (i.e. C-terminal) to the input selection. Default=1


#### SecondaryStructureSelector

```
<SecondaryStructure name="(&string)"
    ss="(&string)"
    include_terminal_loops="(&bool, false)"
    use_dssp="(&bool, false)"
    pose_secstruct="(&string, '')" />
```

SecondaryStructureSelector selects all residues with given secondary structure. For example, you might use it to select all loop residues in a pose.  SecondaryStructureSelector uses the following rules to determine the pose secondary structure:
1. If pose_secstruct is specified, it is used.
2. If use_dssp is true, DSSP is used on the input pose to determine its secondary structure.
3. If use_dssp is false, the secondary structure stored in the pose is used.

**ss** - The secondary structure types to be selected. This parameter is required. Valid secondary structure characters are 'E', 'H' and 'L'. To select loops, for example, use ss="L", and to select both helices and sheets, use ss="HE"

**include_terminal_loops** - (default: false) If false, one-residue "loop" regions at the termini of chains will be ignored. If true, all residues will be considered for selection.

**use_dssp** - (default: true). If true, dssp will be used to determine the pose secondary structure every time the SecondaryStructure residue selector is applied. If false, and a secondary structure is set in the pose, the secondary structure in the pose will be used without re-computing DSSP. This option has no effect if pose_secstruct is set.

**pose_secstruct** - (default: ""). If set, the given secondary structure string will be used instead of the pose secondary structure or DSSP. The given secondary structure must match the length of the pose.

**overlap** - (default: 0).  If specified, the ranges of residues with matching secondary structure are expanded by this many residues. Each selected range of residues will not be expanded past chain endings.  For example, a pose with secondary structure LHHHHHHHLLLEEEEELLEEEEEL, ss='E', and overlap 0 would select the two strand residue ranges EEEEE and EEEEE.  With overlap 2, the selected residues would also include up to two residues before and after the strands (LLEEEEELLEEEEEL).

**Example**
The example below selects all residues in the pose with secondary structure 'H' or 'E'.

    <SecondaryStructure name="all_non_loop" ss="HE" />

####SymmetricalResidueSelector
    <SymmetricalResidue name=(%string) selector=(%string) />

The SymmetricalResidueSelector, when given a selector, will return all symmetrical copies (including the original selection) of those residues. While the packer is symmetry aware, not all filters are. This selector is useful when you need to explicitly give residue numbers but you are not sure which symmetry subunit you need.

####TaskSelector
    <Task name=(%string) fixed=(%bool, False) packable=(%bool, True) designable=(%bool, True) task_operations=(%string) />

The TaskSelector uses user-provided task operations to define a selection. Task operations are run on the pose, and residues are selected based on their status in the resulting PackerTask (designable, packable, or fixed). Note that if all of these options are false, no residue will be selected. This is useful for legacy protocols which still use task operations to select residues (which were written before ResidueSelectors existed). New protocols should use ResidueSelectors to select residues.

**task_operations** - Required. The task operations used to define the selection.

**fixed** - If true, residues in the PackerTask marked as fixed (i.e. not packable or designable) will included in the selection. Default = False

**packable** - If true, residues in the PackerTask marked as packable will be included in the selection. Default = True

**designable** - If true, residues in the PackerTask marked as designable will be included in the selection. Default = True

####ResiduePDBInfoHasLabel

    <ResiduePDBInfoHasLabel name=(%string) property=(%string) />

The ResiduePDBInfoHasLabel residue selector selects all residues with the given PDB residue label. Some protocols (e.g. MotifGraft, Disulfidize) use these labels to mark residues, and this selector allows those residues to be selected without the user's knowledge of which residues were marked.

**label** - Required. The PDB residue info label to be selected. (e.g. "DISULFIDIZE")

**Example**
The example below selects all residues that were converted to disulfides by the Disulfidize mover.

    <ResiduePDBInfoHasLabel name="all_disulf" property="DISULFIDIZE" />

#### UnsatSelector

The UnsatSelector selects all the backbone amines or carbonyls (*but not both*) that are not satisfied by a hydrogen bond. The general format of the selector is:

```
     <Unsat name="(&string)" consider_mainchain_only="(true &bool)" check_acceptors="(true &bool)" hbond_cutoff="(-0.5 &real)" scorefxn="(&string)/>
```
- consider_mainchain_only: should we only count the hydrogen bonds from backbone (default) or also include sidechains
- check_acceptors: Should the selector selects based on unsatisfied carbonyls (default) or amines.
- hbond_cutoff: the cutoff you are interested in. the default, -0.5, is a very loose threshold.
- scorefxn: name of scorefxn to be used. right now this has to be included.

This example selects all *residues* in the structure that has a carbonyl that is not satisfied by a hydrogen bond from backbone:

```
     <Unsat name="select_unsat_carbonyl" scorefxn="score"/>
```

This example selects all *residues* in the structure that has a backbone amine that is not satisfied by a hydrogen bond from backbone or side chain:

```
     <Unsat name="select_unsat_carbonyl" scorefxn="score" check_acceptors="false" consider_mainchain_only="false"/>
```

## Other
### StoredResidueSubset

Creates a residue subset by retrieving a residur subset that has been cached into the current pose by the [[StoreResidueSubsetMover]]. The pose length must be the same as when the subset was store.

    <StoredResidueSubset name="(&string)" subset_name="(&string)" />

-   subset\_name - The name the residue subset will be saved as in the pose's cacheable data. Must be identical to the subset\_name used to retrieve the task using the StoredResidueSubset task operation.

####Example

    <RESIDUE_SELECTORS>
      <!-- Creates a subset consisting of whatever is currently chain B -->
      <Chain name="chainb" chains="B" />

      <!-- Retrieves the residue subset created by the "StoreResidueSubset" mover -->
      <StoredResidueSubset name="get_original_chain_b" subset_name="original_chain_b" />
    </RESIDUE_SELECTORS>
    <MOVERS>
      <!-- stores a subset consisting of whatever is in chain B when this mover is called -->
      <StoreResidueSubset name="store_subset" residue_selector="chainb" subset_name="original_chain_b" />
    </MOVERS>

###ScoreTermValueBased
Scores a copy of the pose and selects residues that score within the specified limits for a chosen score type. This could be used to select residues positions that score poorly and design or replace such that the score improves. The tags, _score_type_, _lower_threshold_ and _upper_threshold_ are required.

    <ScoreTermValueBased name=(%string) 
                     score_type=(%string) 
                     lower_threshold=(%real) 
                     upper_thershold=(%real)
                     score_fxn=(%string, default from command line)
                     selector=(%string) />

or

    <ScoreTermValueBased name=(%string) 
                     score_type=(%string) 
                     lower_threshold=(%real) 
                     upper_thershold=(%real) 
                     score_fxn=(%string, default from command line)
                     resnums=(%string, ALL)/>

or

    <ScoreTermValueBased name=(%string) 
                     score_type=(%string) 
                     lower_threshold=(%real) 
                     upper_thershold=(%real)
                     score_fxn=(%string, default from command line)>
       <Selector ... />
    </ScoreTermValueBased>

-   score_type - the name of the [[score type|score-types]] to be used for selection. If this is set to _total_, the weighted sum of all score terms will be used for the operation.
-   lower_threshold - residues scoring above or equal to this value will be selected.
-   upper_threshold - residues scoring below or equal to this value will be selected.
-   score_fxn - the score function to be used to evaluate the scores. If not specified or undefined, the default score function from the command line will be used.
-   resnums - comma separated list of pose or PDB numbers that make a subset of residues to restrict selection. The default is _ALL_.
-   selector - the name of a predefined selector that defines a subset to restrict selection.


####See Also

* [[StoreTaskMover]]
* [[StoreCompoundTaskMover]]

##See Also

* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta