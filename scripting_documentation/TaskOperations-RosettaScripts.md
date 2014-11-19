#TaskOperations (RosettaScripts)

[[Return To RosettaScripts|RosettaScripts]]


TaskOperations are used by a TaskFactory to configure the behavior and create a PackerTask when it is generated on-demand for routines that use the "packer" to reorganize/mutate sidechains. The PackerTask controls which residues are packable, designable, or held fixed.  When used by certain Movers (at present, the PackRotamersMover and its subclasses), the set of TaskOperations control what happens during packing, usually by restriction "masks."  

The PackerTask can be thought of as an ice sculpture.  By default, everything is able to pack AND design.  By using TaskOperations, or your set of chisels, one can limit packing/design to only certain residues.  As with ICE, once these residues are restricted, they generally cannot be turned back on.



<code> For Developers </code> 

This section defines instances of the TaskOperation class hierarchy when used in the context of the Parser/RosettaScripts. They become available in the DataMap.


[[_TOC_]]

Example
=======

    ...
    <TASKOPERATIONS>
      <ReadResfile name=rrf/>
      <ReadResfile name=rrf2 filename=resfile2/>
      <PreventRepacking name=NotBeingUsedHereButPresenceOkay/>
      <RestrictResidueToRepacking name=restrict_Y100 resnum=100/>
      <RestrictToRepacking name=rtrp/>
      <OperateOnCertainResidues name=NoPackNonProt>
        <PreventRepackingRLT/>
        <ResidueLacksProperty property=PROTEIN/>
      </OperateOnCertainResidues>
    </TASKOPERATIONS>
    ...
    <MOVERS>
      <PackRotamersMover name=packrot scorefxn=sf task_operations=rrf,NoPackNonProt,rtrp,restrict_Y100/>
    </MOVERS>
    ...

In the rosetta code, the TaskOperation instances are registered with and then later created by a TaskOperationFactory. The factory calls parse\_tag() on the base class virtual function, with no result by default. However, some TaskOperation classes (e.g. OperateOnCertainResidues and ReadResfile above) do implement parse\_tag, and therefore their behavior can be configured using additional options in the "XML"/Tag definition.

ResidueSelection
================

ResidueSelectors
----------------

ResidueSelectors define a subset of residues from a Pose. Their apply() method takes a Pose and a ResidueSubset (a utility::vector1\< bool \>), and modifies the ResidueSubset. Unlike a PackerTask, a ResidueSubset does not have a commutativity requirement, so the on/off status for residue *i* can be changed as many times as necessary. Once a ResidueSubset has been constructed, a ResLevelTaskOperation (see [[below|TaskOperations-RosettaScripts#Residue-Level-TaskOperations]] ) may be applied to the ResidueLevelTasks which have a "true" value in the ResidueSubset. ResidueSelectors should be declared in their own block and named, or declared as subtags of other ResidueSelectors or of TaskOperations that accept ResidueSelectors (such as the OperateOnResidueSubset task operation).

The purpose of separating the residue selection logic from the modifications that TaskOperations perform on a PackerTask is to make available the complicated logic of selecting residues that often lives in TaskOperations. If you have a complicated TaskOperation, consider splitting it into a ResidueSelector and operations on the residues it selects.

ResidueSelectors can be declared in their own block, outside of the TaskOperation block. For example:

    <RESIDUE_SELECTORS>
       <Chain name=chA chains=A/>
       <Index name=res1to10 resnums=1-10/>
    </RESIDUE_SELECTORS>

### Logical ResidueSelectors

#### NotResidueSelector

    <Not name=(&string) selector=(&string)>

or

    <Not name=(&string)>
        <(Selector) .../>
    </Not>

-   The NotResidueSelector requires exactly one selector.
-   The NotResidueSelector flips the boolean status returned by the apply function of the selector it contains.
-   If the "selector" option is given, then a previously declared ResidueSelector (from the RESIDUE\_SELECTORS block of the XML file) will be retrieved from the DataMap
-   If the "selector" option is not given, then a sub-tag containing an anonymous/unnamed ResidueSelector must be declared. This selector will not end up in the DataMap

#### AndResidueSelector

    <And name=(&string) selectors=(&string)>
       <(Selector1)/>
       <(Selector2)/>
        ...
    </And>

-   The AndResidueSelector can take arbitrarily many selectors.
-   The AndResidueSelector takes a logical *AND* of the ResidueSubset vectors returned by the apply functions of each of the ResidueSelectors it contains.
-   The "selectors" option should be a comma-separated string of previously-declared selector names. These selectors will be retrieved from the DataMap.
-   The "selectors" option is not required, nor are the sub-tags required; but at least one of the two must be given. Both can be given, if desired.
-   Selectors declared in the sub-tags will be appended to the set of selectors for the AndResidueSelector, but will not be added to the DataMap.

#### OrResidueSelector

    <Or name=(&string) selectors=(&string)>
       <(Selector1)/>
       <(Selector2)/>
        ...
    </Or>

-   The OrResidueSelector can take arbitrarily many selectors.
-   The OrResidueSelector takes a logical *OR* of the ResidueSubset vectors returned by the apply functions of each of the ResidueSelectors it contains.
-   The "selectors" option should be a comma-separated string of previously-declared selector names. These selectors will be retrieved from the DataMap.
-   The "selectors" option is not required, nor are the sub-tags required; but at least one of the two must be given. Both can be given, if desired.
-   Selectors declared in the sub-tags will be appended to the set of selectors for the OrResidueSelector, but will not be added to the DataMap.

### Conformation Independent Residue Selectors

#### ChainSelector

    <Chain chains=(&string)/>

-   The string given for the "chains" option should be a comma-separated list of chain identifiers
-   Each chain identifier should be either an integer, so that the Pose chain index will be used, or a single character, so that the PDB chain ID can be used.
-   The ChainSelector sets the positions corresponding to all the residues in the given set of chains to true, and all the other positions to false.

#### JumpDownstreamSelector

    <JumpDownstream jump=(&int)/>

-   The integer given for the "jump" argument should refer to a Jump that is present in the Pose.
-   The JumpDownstreamSelector sets the positions corresponding to all of the residues that are downstream of the indicated jump to true, and all the other positions to false.
-   This selector is logically equivalent to a NotSelector applied to the JumpUpstreamSelector for the same jump.

#### JumpUpstreamSelector

    <JumpUpstream jump=(&int)/>

-   The integer given for the "jump" argument should refer to a Jump that is present in the Pose.
-   The JumpUpstreamSelector sets the positions corresponding to all of the residues that are upstream of the indicated jump to true, and all the other positions to false.
-   This selector is logically equivalent to a NotSelector applied to the JumpDownstreamSelector for the same jump.

#### ResidueIndexSelector

    <Index resnums=(&string)/>

-   The string given for the "resnums" option should be a comma-separated list of residue identifiers
-   Each residue identifier should be either *an integer* , so that the Pose numbering can be used, *two integers separated by a dash* , designating a range of Pose-numbered residues, or *an integer followed by a single character* , e.g. 12A, referring to the PDB numbering for residue 12 on chain A. (Note, residues that contain insertion codes cannot be properly identified by this scheme).
-   The ResidueIndexSelector sets the positions corresponding to the residues given in the resnums string to true, and all other positions to false.

### Conformation Dependent Residue Selectors

#### InterGroupInterfaceByVector

    <InterfaceByVector name=(%string) cb_dist_cut=(11.0&float) nearby_atom_cut=(5.5%float) vector_angle_cut=(75.0&float) vector_dist_cut=(9.0&float) grp1_selector=(%string) grp2_selector=(%string)/>

or

    <InterfaceByVector name=(%string) cb_dist_cut=(11.0&float) nearby_atom_cut=(5.5%float) vector_angle_cut=(75.0&float) vector_dist_cut=(9.0&float)>
       <(Selector1)/>
       <(Selector2/>
    </InterfaceByVector>

-   Selects the subset of residues that are at the interface between two groups of residues (e.g. residues on different chains, which might be useful in docking, or residues on the same chain, which might be useful in domain assembly) using the logic for selecting interface residues as originally developed by Stranges & Leaver-Fay. This logic selects residues that are either already in direct contact with residues in the other group (i.e. contain atoms within the nearby\_atom\_cut distance threshold of the other group's atoms) or that are pointing their c-alpha-c-beta vectors towards the other group so that at least one c-beta *i* -c-alpha *i* -c-alpha *j* angle (between residues *i* and *j* ) is less than the vector\_angle\_cut angle threshold (given in degrees) and has its neighbor atom within the vector\_dist\_cut distance threshold (given in Angstroms) of at least one neighbor atom from the other group.
-   Groups 1 and 2 can be given either through the grp1\_selector and grp2\_selector options, (requiring that the indicated selectors had been previously declared and placed in the DataMap) or may be declared anonymously in the given subtags. Anonymously declared selectors are not added to the DataMap.
-   The cb\_dist\_cut is a fudge factor used in this calculation and is used only in constructing an initial graph; neighbor relationships are only considered between pairs of residues that have edges in this initial graph. cb\_dist\_cut should be greater than vector\_dist\_cut.

#### NeighborhoodResidueSelector

    <Neighborhood name=(%string) resnums=(%string) distance=(10.0%float)/>

or

    <Neighborhood name=(%string) selector=(%string) distance=(10.0%float)/>

or

    <Neighborhood name=(%string) distance=(10.0%float)>
       <Selector ... />
    </Neighborhood>

-   The NeighborhoodResidueSelector selects all the residues within a certain distance cutoff of a focused set of residues.
-   It sets each position in the ResidueSubset that corresponds to a residue within a certain distance of the focused set of residues as well as the residues in the focused set to true, and sets all other positions to false.
-   The set of focused residues can be specified in one of three (mutually exclusive) ways: through a resnums string (see the ResidueIndexSelector [[above|TaskOperations-RosettaScripts#ResidueIndexSelector]] for documentation on how this string should be formatted), a previously-declared ResidueSelector using the "selector" option, or by defining a subtag that declares an anonymous ResidueSelector.

#### NumNeighborsSelector

    <NumNeighbors name=(%string) count_water=(false&bool) threshold=(17%integer) distance_cutoff=(10.0&float)/>

-   The NumNeighborsSelector sets to true each position in the ResidueSubset that corresponds to a residue that has at least *threshold* neighbors within *distance\_cutoff,* and sets all other positions to false.
-   The NumNeighborsSelector uses the coordinate of each residue's neighbor atom as a representative and counts two residues as being neighbors if their neighbor atoms are within *distance\_cutoff* of each other.
-   It is possible to include water residues in the neighbor count by setting the "count\_water" boolean to true


Per Residue Specification
=========================

OperateOnResidueSubset
----------------------

    <OperateOnResidueSubset name=(%string) selector=(%string) >
       <(ResLvlTaskOperation)/>
    </OperateOnResidueSubset/>

or

    <OperateOnResidueSubset name=(%string)>
       <(Selector)/>
       <(ResLvlTaskOperation)/>
    </OperateOnResidueSubset/>

-   OperateOnResidueSubset is a TaskOperation that applies a ResLevelTaskOperation to the residues indicated by a ResidueSelector.
-   The ResidueSelector may be provided either through the "selector" option (in which case, the string provided to the option should refer to a previously declared ResidueSelector which can be found in the DataMap), or though an anonymously declared ResidueSelector whose definition is given as a sub-tag. Anonymously declared ResidueSelectors are not added to the DataMap.
-   Existing ResLvlTaskOperations are defined [[below|TaskOperations-RosettaScripts#Residue-Level-TaskOperations]] .


OperateOnCertainResidues Operation
----------------------------------

Allows specification of [Residue Level Task Operations](#Residue_Level_TaskOperations) based on residue properties specified with [ResFilters](#ResFilters) .

Example:

    <OperateOnCertainResidues name=PROTEINnopack>
      <PreventRepackingRLT/> //Only one Residue level task per OperateOnCertainResidues block
      <ResidueHasProperty property=PROTEIN/> //Only one ResFilter per OperateOnCertainResidues block
    </OperateOnCertainResidues>

Residue Level TaskOperations
----------------------------

Use these as a subtag for special OperateOnCertainResidues TaskOperation. Only one may be used per OperateOnCertainResidues

### RestrictToRepackingRLT

Turn off design on the positions selected by the accompanying ResFilter.

    <RestrictToRepackingRLT/>

### PreventRepackingRLT

Turn off design and repacking on the positions selected by the accompanying ResFilter.

    <PreventRepackingRLT/>

### RestrictAbsentCanonicalAASRLT

Do not allow design to amino acid identities that are not listed (i.e. permit only those listed) at the positions selected by the accompanying ResFilter.

    <RestrictAbsentCanonicalAASRLT aas=(&string)/>

-   aas - list of one letter codes of permitted amino acids, with no separator. (e.g. aas=HYFW for only aromatic amino acids.)

### AddBehaviorRLT

Add the given "behavior" to the positions selected by the accompanying ResFilter.

    <AddBehaviorRLT behavior=(&string)/>

-   behavior - Behavior string. These are protocol-specific. Consult the protocol documentation for if it responds to behavior strings.

ResFilters
----------

Use these as a subtag for special OperateOnCertainResidues TaskOperation. Only one may be used per OperateOnCertainResidues, however a compound filter (Any/All/None) may be used to combine multiple filters in a single operation.

### CompoundFilters

AnyResFilter, AllResFilter, NoResFilter combine the results of specified subfilters with the given boolean operation. Any number of subfilters may be declared.

e.g.

      <AnyResFilter>
        <ChainIs chain=A/>
        <ChainIs chain=B/>
      </AnyResFilter>

As task operations produce restriction masks, and therefor only prevent targets from repacking/designing, the most effective way to specify a set of residues for design or repack is the use of a double-negative task operation:

     <OperateOnCertainResidues name=aromatic_apolar>
       <PreventRepackingRLT/>
       <NoResFilter>
         <ResidueType aromatic=1 apolar=1/>
       </NoResFilter>
     </OperateOnCertainResidues>

Restricts repacking to aromatic and apolar residues.

### ResidueType

Convenience filter selects residues by type.

     <ResidueType aromatic=(0 &bool) apolar=(0 &bool) polar=(0 &bool) charged=(0 &bool)/>

### ResidueHasProperty

### ResidueLacksProperty

Selects or excludes residues based on the given residue property.

-   property: Residue property, as specified in the residue resfile. (e.g. DNA, PROTEIN, POLAR, CHARGED) One only.

<!-- -->

     e.g. <ResidueHasProperty property=POLAR/>

### ChainIs

### ChainIsnt

set of residues based on their chain letter in the original PDB.

-   chain: defaults to "A"

<!-- -->

     e.g. <ChainIs chain=A/>

### ResidueName3Is

### ResidueName3Isnt

-   name3: Any number of residue type specifiers, comma separated.

<!-- -->

     e.g. <ResidueName3Is name3=ARG,LYS,GUA/>

### ResidueIndexIs

### ResidueIndexIsnt

-   indices: comma-separated list of rosetta residue indices (1 to nres)

<!-- -->

     e.g. <ResidueIndexIs indices=1,2,3,4,33/>

### ResiduePDBIndexIs

### ResiduePDBIndexIsnt

-   indices: comma-separated list of chain.pos identifiers e.g. indices=

<!-- -->

     e.g. <ResiduePDBIndexIs indices=A.2,C.100,D.-10/>

Specialized TaskOperations
==========================

List of current TaskOperation classes in the core library (\* indicates use-at-own-risk/not sufficiently tested/still under development):

Position/Identity Specification
-------------------------------

### SelectResiduesWithinChain

Selects a list of residues within a chain for design/repacking according to internal chain numbering. If modify\_unselected\_residues is true all other residues are set to norepack.

    <SelectResiduesWithinChain name=(&string) chain=(1&Integer) resid=(&comma-separated integer list) allow_design=(1&bool) allow_repacking=(1&bool) modify_unselected_residues=(1&bool)/>

-   chain: which chain. Use only sequential numbering: 1, 2..
-   resid: which residues within the chain. Again, only numbering (24,35)
-   allow\_design: if true, allows design at selected positions.
-   allow\_repacking: if true, allows repacking at selected positions.
-   modify\_unselected\_residues: if true, set non-selected residues to norepacking.

### SeqprofConsensus

Read PSSM sequence profiles and at each position allow only identities that pass a certain threshold in the PSSM. The code mentions symmetry-support, but I haven't tested this.

    <SeqprofConsensus name=(&string) filename=(""&string) min_aa_probability=(0.0 &Real) probability_larger_than_current=(1 &bool) ignore_pose_profile_length_mismatch=(0 &bool) convert_scores_to_probabilities=(1&bool)  keep_native=(0&bool)/>

SeqprofConsensus can also be operated with ProteinInterfaceDesign and RestrictToAlignedSegments task operations contained within it. In that case, three different threshold can be set, one for the protein interface (where residues are marked for design), one for RestrictToAlignedSegments (again, where residues are marked for design), and one for the remainder of the protein. The reasoning is that you may want to be less 'consensus-like' at the active site than away from it. The three cutoffs would then be set by: conservation\_cutoff\_protein\_interface\_design, conservation\_cutoff\_aligned\_segments, and min\_aa\_probability (for the remainder of the protein). The subtags, ProteinInterfaceDesign and RestrictToAlignedSegments are expected to be subtags of SeqprofConsensus and all of the options open to these task operations can be set the same way (the option name is not expected and if you specify it you would generate failure).

-   filename: of the PSSM. If none is specified, the task operation will attempt to read SequenceProfile constraints directly from the pose, and set up a profile based on those constraints. If those aren't available, expect an exit.
-   min\_aa\_probability: the PSSM style log2 transformed probabilities. For instance set to 0 to allow favorable positions, set to 2 to allow very favorable only, and set to -2 to also allow slightly unfavorable identities. The highest-probability identities are always allowed to design, so set to very high values (\>10) if you want the highest probability identities to be allowed in design.
-   probability\_larger\_than\_current: always allow identities with probabilities at least larger than that of the current residue seen in the PDB.
-   ignore\_pose\_profile\_length\_mismatch: if set to 0 this will cause a utility exit if the pose and profile do not match.
-   convert\_scores\_to\_probabilities: convert the PSSM scores (e.g., -4, +10) to probabilities in the 0-1 range.
-   keep\_native: If set to true adds the native aa identity to allowed identities regardless of min\_aa\_probability cut-off.

### ReadResfile

Read a resfile. If a filename is given, read from that file. Otherwise, read the file specified on the commandline with -packing:resfile.

     <ReadResfile name=(&string) filename=(&string) />

### ReadResfileFromDB

Lookup the resfile in the supplied relational database. This is useful for processing different structures with different resfiles in the same protocol. The database *db* should have a table *table\_name* with the following schema:

        CREATE TABLE <table_name> (
            tag TEXT,
            resfile TEXT,
            PRIMARY KEY(tag));

When this task operation is applied, it tries to look up the *resfile* string associated with the *tag* defined by

        JobDistributor::get_instance()->current_job()->input_tag()

This task operation takes the following parameters:

-   **[[database_connection_options|RosettaScripts-database-connection-options]]** : Options to connect to the relational database
-   table=("resfiles" &string)

### RestrictIdentitiesAtAlignedPositions

Restricts user-specified positions, which are aligned with positions in a source-pdb, to the identities observed in the source pdb. Can be used to revert pre-specified residues to their identities in a wild-type progenitor. Can also be used to modify a task factory to only consider the identities in the source pdb for the target positions (while not changing the packer task for other positions). Note that the pose and the source pose must be aligned for this to work. Residues that have no aligned residue on the target pdb are ignored.

-   source\_pdb: the pdb from which the identities will be derived
-   resnums: the residue numbers in the source\_pdb(!) that need to be derived
-   chain (default 1 &integer): which chain on the target pdb are we looking for aligned residues?
-   design\_only\_target\_residues (default 0 &bool): if true, designs the target residues to the identities in source while repacking a 6A shell around each residue. If false, only restricts the allowed identities at the target residues, not impacting other residues.
-   prevent\_repacking

### RestrictToAlignedSegments

(This is a devel TaskOperation and not available in released versions.)

Restricts design to segments that are aligned to the segments in source pdb files. The pdbs should have been pre-aligned. The start and stop residues must be at most 3A from a residue on the input pose, or else the alignment fails (the segment will not be aligned). The segments that are not aligned will be turned to restrict to repacking.

     <RestrictToAlignedSegments name=(&string) source_pdb=(&string) start_res=(&string) stop_res=(&string) repack_shell=(6.0 &real)>
    <Add source_pdb=(&string) start_res=(&string) stop_res=(&string)/>
    .
    .
    .
    </RestrictToAlignedSegments>

-   source\_pdb: pdb file name to which to align. the start and stop res refer to it. As many lines as needed can be added, including from different pdb files. PDBs will only be loaded if they differ from the previous line's pdb file name, to save on reads from disk.
-   from\_res: start residue. Refers to source pdb. Rosetta/pdb numbering.
-   stop\_res: stop residue. ditto.
-   repack\_outside: residues not specified by the alignment will be allowed to repack if true, will be prevented from repacking if false.

### RestrictChainToRepacking

Do not allow design in a particular chain

      <RestrictChainToRepacking name=(&string) chain=(1 &int)/>

### RestrictToRepacking

Only allow residues to repack. No design.

     <RestrictToRepacking name=(&string) />

### RestrictResidueToRepacking

Restrict a single residue to repacking. No design.

     <RestrictResidueToRepacking name=(&string) resnum=(0 &integer)/>

### RestrictResiduesToRepacking

Restrict a string of comma-delimited residues to repacking. No design.

     <RestrictResiduesToRepacking name=(&string) residues=(0 &integer "," separated)/>

### PreventRepacking

Do not allow repacking at all for the specified residue. Freezes residues.

    <PreventRepacking name=(&string) resnum=(0 &int) />

### PreventResiduesFromRepacking

Do not allow repacking at all for a string of residues to repacking. Use comma-delimited list of residues

     <PreventResiduesFromRepacking name=(&string) residues=(0 &integer,"," separated)/>

### NoRepackDisulfides

Do not allow disulfides to repack.

     <NoRepackDisulfides name=(&string) />

### DatabaseThread

This task operation is designed to deal with situations in which a pose is changed in a way that adds or removes residues. This creates a problem for normal threading that requires a constant start and stop positions. This task operation can use a database of sequences or a single target sequence. It also need a template pdb to find on the pose a user defined start and end residues. A sequence length and threading start position are calculated and then a correct length sequence is randomly chosen from the database and threaded onto the pose.

```
<DatabaseThread name=(&string) database=("" &string) target_sequence=("" &string) template_file=(&string) start_res=(&int) end_res=(&int) allow_design_around=(1 &bool) design_residues=(comma-delimited list) keep_original_identity=(comma-delimited list)/>
```

To actually change the sequence of the pose, you have to call something like PackRotamersMover on the pose using this task operation. Notice that this only packs the threaded sequence, holding everything else constant.

This task operation builds off of ThreadSequence so the same logic applies: 'X' means mark position for design, while ' ' or '\_' means mark pose residue to repacking only.

-   database: The database should be a text file with a list of single letter amino acids (not fasta).
-   target_sequence: The desired sequence if there is only one desired sequence (this can happen if the pose is changed during design such that the start and end positions are not constant. In such cases ThreadSequence is not useful). The task operation expects either a database or a target sequence and will fail if neither are provided. If both are provided the database will be ignored. 
-   template\_file: a pdb that serves as a constant template to map the start and end residues onto the pose in case that the length of the pose is altered during design.
-   start\_res: the residue to start threading from. This is a residue in the template pdb. It is used to find the closest residue on the source pdb.
-   end\_res: the residue to end the threading. This is a residue in the template pdb. It is used to find the closest residue on the source pdb. The delta between the end and start residue is used to find the desired sequence length in the database.
-   allow\_design\_around: if set to false, only design the region that is threaded. The rest is set to repack.
-   design\_residues: the same as placing 'X' in the target sequence. This trumps the sequence in the database so if a residue has a different identity in the database it is changed to 'X'.
-   keep\_original\_identity: the same as placing a ' ' or a '\_' in the sequence. The pose residue is marked for repacking only. This trumps both the database sequence and the list from design\_residues.

### AlignedThread

A task operation that enables threading of aligned residues between a query and a template. receives a FASTA format sequence alignment (file may hold multiple sequences), and allows the threading only of residues that are aligned between query and structure. positions where either the template structure or the query sequence have a gap '-' are skipped. suitable for when you wish to model a sequence over a structure, and they are of different lengths

```
<AlignedThread name=(&string) query_name=(&string) template_name=(&string) alignment_file=(&string) start_res=(&int 1)/>
```

- query_name: the name of the query sequence, as written in the alignment file
- template_name: the name of the template sequence, as written in the alignment file. the same sequence as that of the structure passed with -s.
- alignment_file: the name of the alignment file in FASTA format. should be in the usual ('>name_of_sequence' followed by the amino acid single letter sequence on the next line or lines) for this to work.
- start_res: the residue at which to start threading. useful for threading the non-first chain. 

### DesignAround

Designs in shells around a user-defined list of residues. Restricts all other residues to repacking.

    <DesignAround name=(&string) design_shell=(8.0 &real) resnums=(comma-delimited list) repack_shell=(8.0&Real) allow_design=(1 &bool) resnums_allow_design=(1 &bool)/> 

-   resnums can be a list of pdb numbers, such as 291B,101A.
-   repack\_shell: what sphere to pack around the target residues. Must be at least as large as design\_shell.
-   allow\_design: allow design in the sphere, else restrict to repacking.
-   resnums\_allow\_design: allow design in the resnums list, else restrict to repacking.

### RestrictToTermini

Restrict to repack only one or both termini on the specified chain.

    <RestrictToTermini chain=(1 &size) repack_n_terminus=(1 &bool) repack_c_terminus=(1 &bool) />

### DsspDesign
    
Design residues with selected amino acids depending on the local secondary structure. The secondary structure at each residue is determined by DSSP (or read from a blueprint file).

All functionality here is included in the LayerDesign task operation, which is much more powerful. However, this filter has significantly reduced overhead by avoiding slow SASA calculations.

    <DsspDesign name=(&string) blueprint=(&string)>
        <SecStructType aas=(&string) append(&string) exclude=(&string)/>
    </DsspDesign>
- blueprint: a blueprint file which specifies the secondary structure at each position.

Below are the valid secondary structure types and the default set of allowed residue types.
- Helix: ADEFIKLNQRSTVWY
- Sheet: DEFHIKLNQRSTVWY
- Loop: ACDEFGHIKLMNPQRSTVWY
- HelixStart: ADEFHIKLNPQRSTVWY
- HelixCapping: DNST
- Nterm: ACDEFGHIKLMNPQRSTVWY
- Cterm: ACDEFGHIKLMNPQRSTVWY

The set of allowed residues for each secondary structure type can be customized.
- aas: define the set of residues allowed for the defined secondary structure type; the string is composed of one letter amino acid codes.
- append: append the following residues to the set of allowed residues for the defined secondary structure type.
- exclude: opposite of append.

### LayerDesign

Design residues with selected amino acids depending on the enviroment(accessible surface area). The layer of each residue is assigned to one of the three basic layers(core, boundary or surface) depending on the accessible surface area of mainchain + CB.

Aditional layers can be defined in the xml file by passing another taskoperation to get the residue selection. Only the residues that are marked as designable in the packer task are taken into consideration, any information about the available amino acids/rotamers selected by the taskoperation are not going to be considered. The amino acids to be used in each of this new layers has to be specified in the xml. Several taskoperations can be combined to the intersection between the different sets of designable residues.

If a resfile is read before calling this operation, this operation is not applied for the residues defined by PIKAA, NATAA or NATRO. Note that this task is ligand compatible, the ligand is simply set to be repackable but not designable. Optionally allow all amino acids to select residue subsets by SASA cutoffs.

        <LayerDesign name=(&string layer) layer=(&string core_boundary_surface) pore_radius=(&real 2.0) core=(&real 20.0) surface=(&real 40.0) repack_non_design=(&bool 1) make_rasmol_script=(&bool 0) make_pymol_script=(&bool 0)   >
            <ATaskOperation name=task1 >
                <all copy_layer=(&string layer) append=(&string) exclude=(&string)  specification=(&string "designable")  operation=(&string "design") />
                <SecStructType aas=(&string) append(&string) exclude=(&string) />            
            </ATaskOperation >
        </LayerDesign>

Option list

-   layer ( default "core\_boundary\_surface\_other" ) : layer to be designed, other ex. core\_surface means only design core and surface layer, other refers to the additional layers defined with packertasks
-   use\_original\_non\_designed\_layer ( default, 0 ) : restrict to repacking the non design layers
-   pore\_radius ( default 2.0) : pore radius for calculating accessible surface area
-   core ( default 20.0) : residues of which asa is \< core are defined as core
-   surface ( default 40.0) : residues of which asa is \> surface are defined as surface
-   (layer)\_(ss): set up the asa threshold for a specific secondary structure element in a particular layer. For example surface\_E=30 makes that for strand residues the asa cutoff is 30 instead of the one defined by surface.
-   make\_rasmol\_script: if true write a rasmol script coloring the residues by the three basic layers, core, boundary and surface.
-   make\_pymol\_script: if true write a pymol script coloring the residues by the three basic layer and the aditional taskoperation defined layers..
-   repack\_non\_design: if true side chains will be repacked, left untouched if otherwise.
-   use\_sidechain\_neighbors: if true, assign a residue's layers based on counting the number CA atoms from other residues within a cone in front of the residue's ca-cb vector.  Because this option is no longer SASA based, the layer assignments will always be identical regardless of the protein sequence; i.e. layers could be assigned based on a polyalanine backbone and it would make no difference.  This option changes the defaults for core and surface to neighbors < 2 (surface) and neighbors > 5.2 (core).  HOWEVER, these defaults will be overwritten if core and surface are manually specified in declaring the taskoperation!  So make sure you do not specify new core and surface settings appropriate for SASA when you are actually counting neighboring residues.  Note: this option has not been tested on nonstandard residue types...

TaskOperations can be combined together using the CombinedTasks tag, the nested tasks don't need to be named, just declared with type and parameters.

        <CombinedTasks name=combined_task>
             <ATaskOperation />
             <AnotherTaskOperation />
        </CombinedTasks>

_**Currently Deprecated, new syntax for residue assignment coming soon! **_
After you combined tasks you need to assign residues, you can use the 'all' tag to assign residues for all the different secondary structure elements.

        <combined_task>
            <all copy_layer=(&string) append=(&string) exclude=(&string)  specification=(&string "designable")  operation=(&string "design")/>
        </combine_task>

The options for the "all" tag are the following:

-   copy\_layer: layer from where to copy the residues definition, can be core, boundary, surface or a task defined layer.
-   append: append the following residues to the defined layer, the string is composed of one letter aminoacids code.
-   exclude: opposite as append.
-   specification: What residues from the task operation should be considered as the layer. Options are "designable" (pick designable residues), "repacakble" (pick residues restricted to only repack) or "fixed" (residues marked by the task as not repackable). Default is "designable"
-   operation: What to do with the specified layer. Default is 'design', other options are 'no\_design' (allow repacking) and 'omit' (prevent repacking).

After an all operation other definitions can be performed, for example:

        <combined_task>
            <all copy_layer=surface/>
            <Strand append="F"/>
        </combine_task>

copies the layer definition from surface and adds Phe to the available residue types only to the residues on the strands.

Below are the selected amino acid types for each layer, this can be overwritten in the xml:

core

-   Loop: AFILPVWY
-   Strand: FIL VWY
-   Helix: AFIL VWY ( P only at the beginning of helix )
-   HelixCapping: DNST

boundary

-   Loop: ADEFGIKLNPQRSTVWY
-   Strand: DEF IKLN QRSTVWY
-   Helix: ADE IKLN QRSTVWY ( P only at the beginning of helix )
-   HelixCapping: DNST

surface

-   Loop: DEGHKNPQRST
-   Strand: DE HKN QRST
-   Helix: DE HKN QRST ( P only at the beginning of helix )
-   HelixCapping: DNST

Nterm

-   all: ACDEFGHIKLMNPQRSTVWY

Cterm

-   all: ACDEFGHIKLMNPQRSTVWY

<!-- -->

     This example creates a new layer that combines BuildingBlockInterface(symmetric interface with SelectBySasa picking up the core of the complex
     since applying task operations returns the intersection of the sets this combined task will return the buried residues of the symmetric  interface.

    <LayerDesign name=layer layer=other >

        <CombinedTasks name=symmetric_interface_core>
            <BuildingBlockInterface  />
            <SelectBySASA state=bound core=1 />
        </CombinedTasks>

         assign to the new layer for the interface core the same residues as for the surface and append for all possible secondary structures , append  phe and a leu to all ss types.

        <symmetric_interface_core>
            <all copy_layer=surface append="FL"/>
        </symmetric_interface_core>

    </LayerDesign>


<!-- -->

     This example no.2 creates core_boundary_surface that designs differently by layers
        <TASKOPERATIONS>

          <LayerDesign name=layerdesign make_pymol_script=1 layer=core_boundary_surface>

              <core>
                <all append="AFGILMNPQVWYH" />
                <all exclude="CRKDEST" />
              </core>

             <boundary>
               <all append="AFGILMNPQVWYDEHKRST" />
               <all exclude="C" />
             </boundary>

             <surface>
              <all append="AGMNPQDEHKRST" />
              <all exclude="CILVFWY" />
             </surface>

              </LayerDesign>

        </TASKOPERATIONS>

### SelectBySASA

Select residues by their solvent accessible surface area in either the monomeric, bound, or unbound state of the pose. Accessible surface area cutoffs can be set for positions to be considered core, boundary or surface as follows: residues with accessible surface areas less than core\_asa are considered core, those with areas greater than surface\_asa are considered surface, and those between the core\_asa and surface\_asa cutoffs are considered boundary. These SASAs can be assessed in either the monomeric, bound, our unbound state, and either on all mainchain and CBeta atoms or on all sidechain heavyatoms. All residues that do not match the user-specified criteria are prevented from repacking. Works with asymmetric or asymmetric poses, as well as poses with symmetric-building blocks. Can be used to implement custom "layer design" protocols. For de novo designs, it is likely best to use mode="mc" rather than mode="sc". To set the parameters to be the same as the defaults for the LayerDesign task operation use: mode="mc", state="bound", probe\_radius=2.0, core\_asa=20, surface\_asa=40.

     <SelectBySASA name=(&string) mode=("sc" &string) state=("monomer" &string) probe_radius=(2.2 &Real) core_asa=(0 &Real) surface_asa=(30 &Real) jumps=(1 &Size "," separated) sym_dof_names=("" &string "," separated) core=(0 &bool) boundary=(0 &bool) surface=(0 &bool) verbose=(0 &bool) />

Examples:

Only allow repacking at the core positions in the bound state. Useful in combination with other tasks such as RestrictToInterface in order to select just the core of the interface for design.

     <SelectBySASA name=core mode="sc" state="bound" probe_radius=2.2 core_asa=0 surface_asa=30 core=1 boundary=0 surface=0 verbose=1 />

Only allow repacking at the boundary and surface positions in the bound state.

     <SelectBySASA name=core mode="sc" state="bound" probe_radius=2.2 core_asa=0 surface_asa=30 core=0 boundary=1 surface=1 verbose=1 />

Prevent the core of the monomers (each chain) from repacking. Useful in combination with other tasks to ensure that one does not design core positions.

     <SelectBySASA name=no_core_mono_repack mode="sc" state="monomer" probe_radius=2.2 core_asa=0 surface_asa=30 core=0 boundary=1 surface=1 verbose=1 />

Option list

-   mode ( default "sc" ) : Options: "mc" or "sc". Atoms to be evaluated during the SASA calculation. The default is to consider the total SASA of the sidechain atoms of each residue (mode="sc"), but one can alternatively consider the total SASA of the mainchain + CB atoms of each residue (mode="mc").
-   state ( default, "monomer" ) : Options: "monomer", "bound", or "unbound". Specify the state you would like the SASA to be evaluate in. If state="monomer", then each chain will be extracted from the pose and the SASA evaluated separately on each of these monomeric poses. If state="bound", then the pose is not modified before evaluating SASAs. If state="unbound", then the chains are translated 1000 angstroms along the user specified jumps or sym\_dofs prior to evaluating SASAs.
-   probe\_radius ( default, 2.2 ) : Probe radius for calculating the solvent accessible surface area. Note: the default is larger than the typical used to represent water of 1.4 angstroms, but has been found to work well with the other default parameters for protein redesign purposes.
-   core\_asa ( default, 0 ) : Upper accessible surface area cutoff for a residue to be considered core. Any residue with a value below core\_asa will be selected as core.
-   surface\_asa ( default, 30 ) : Lower accessible surface area cutoff for a residue to be considered surface. Any residue with a value above surface\_asa will be selected as surface. Any residue with a value between core\_asa and surface\_asa will be considered boundary.
-   jumps ( default, 1 ) : Comma-separated list of jumps to be translated along if mode="unbound".
-   sym\_dof\_names ( default, "" ) : Comma-separated list of sym\_dof\_names controlling master symmetric DOFs to be translated along if mode="unbound".
-   core ( default, false ) : Should core positions be designable? If yes, then set core=true.
-   boundary ( default, false ) : Should boundary positions be designable? If yes, then set boundary=true.
-   surface ( default, false ) : Should surface positions be designable? If yes, then set surface=true.
-   verbose ( default, false ) : If set to true, then extra information will be output to the tracer, including PyMOL selections of the residues considered to be core, boundary, and surface. Aids in testing out appropriate parameters for a given system and verifying that the positions are being selected as desired.

### RestrictToInterface

Restricts to interface between two protein chains along a specified jump and with a given radius.

     <RestrictToInterface name=(&string) jump=(&integer, 1) distance=(&Real, 8.0) />

### RestrictToInterfaceVector

Restricts the task to residues defined as interface by core/pack/task/operation/util/interface\_vector\_calculate.cc Calculates the residues at an interface between two protein chains or jump. The calculation is done in the following manner. First the point graph is used to find all residues within some big cutoff(CB\_dist\_cutoff) of residues on the other chain. For these residues near the interface, two metrics are used to decide if they are actually possible interface residues. The first metric is to itterate through all the side chain atoms in the residue of interest and check to see if their distance is less than the nearby atom cutoff (nearby\_atom\_cutoff), if so then they are an interface residue. If a residue does not pass that check, then two vectors are drawn, a CA-CB vector and a vector from CB to a CB atom on the neighboring chain. The dot product between these two vectors is then found and if the angle between them (vector\_angle\_cutoff) is less than some cutoff then they are classified as interface. The vector cannot be longer than some other distance (vector\_dist\_cutoff).

There are two ways of using this task, first way is to use jumps:

```
  <RestrictToInterfaceVector name=(& string) jump=(1 & int,int,int... ) CB_dist_cutoff=(10.0 & Real) nearby_atom_cutoff=(5.5 & Real) vector_angle_cutoff=(75.0 & Real) vector_dist_cutoff=(9.0 & Real)/>
```

-   jump - takes a comma separated list of jumps to find the interface between, will find the interface across all jumps defined

OR you can use chains instead

```
  <RestrictToInterfaceVector name=(& string) chain1_num=(1 & int) chain2_num=(2 & int) CB_dist_cutoff=(10.0 & Real) nearby_atom_cutoff=(5.5 & Real) vector_angle_cutoff=(75.0 & Real) vector_dist_cutoff=(9.0 & Real)/>
```

-   chain1\_num - chain number of the chain on one side of the interface. Optionally accepts a comma separated list of chain numbers.
-   chain2\_num - chain on the other side of the interface from chain1. Optionally accepts a comma separated list of chain numbers.

Common tags, see descriptions above:

-   CB\_dist\_cutoff - distance, should keep between 8.0 and 15.0
-   nearby\_atom\_cutoff - distance, should be between 4.0 and 8.0
-   vector\_angle\_cutoff - angle in degrees, should be between 60 and 90
-   vector\_dist\_cutoff - distance, should be between 7.0 and 12.0

Note that if you specify a list of chain numbers for the chain1\_num and chain2\_num options, the interface will be calculated between the two sets. In other words, if chain1\_num=1,2 and chain2\_num=3,4 the interface will be calculated between chains 1 and 3, 1 and 4, 2 and 3, and 2 and 4. The interface between chains 1 and 2 and between 3 and 4 will not be calculated.

### ProteinInterfaceDesign

Restricts to the task that is the basis for protein-interface design. Default behavior:

    - prevent mutation of native pro/gly/cys
    - prevent design of nonnative pro/gly/cys
    - allow design of chain2 non-pro/gly/cys positions with Cbeta within 8.0Å of chain1
    - allow repack of chain1 non-pro/gly/cys positions with Cbeta within 8.0Å of chain2

Note: When using this taskop on a pose with more than 2 chains, everything before the indicated jump is treated as "chain1", everything after as "chain2".

-   repack\_chain1=(1, &bool)
-   repack\_chain2=(1, &bool)
-   design\_chain1=(0, &bool)
-   design\_chain2=(1, &bool)
-   allow\_all\_aas=(0 &bool)
-   design\_all\_aas=(0 &bool)
-   interface\_distance\_cutoff=(8.0, &Real)
-   jump=(1&integer) chains below, and above the jump are called chain1 and chain2 above.
-   modify\_before\_jump=(1 &bool)
-   modify\_after\_jump=(1 &bool)

modify before/after jump determine whether the taskoperation will change residues before/after the jump. For instance, if you want set repack on chain2 interfacial residues to true, and the rest of chain2 to false, and yet not change the task for chain1, then use this taskoperation with modify\_before\_jump=0

### DetectProteinLigandInterface

Setup packer task based on the detect design interface settings from enzyme design.

    <DetectProteinLigandInterface name=(&string) cut1=(6.0 &Real) cut2=(8.0 &Real) cut3=(10.0 &Real) cut4=(12.0 &Real) 
    design=(1 &bool) resfile=("" &string) design_to_cys=(0 &bool) catres_interface=(0 &bool) catres_only_interface=(0 &bool) 
    arg_sweep_interface =(0 &bool) target_cstids=("" &string)/>

The task will set to design all residues with a Calpha within cut1 of the ligand (specifically the last ligand), or within cut2 of the ligand, where the Calpha-Cbeta vector points toward the ligand. Those residues within cut3 or within cut4 pointing toward the ligand will be set to repack. All others will be set to be fixed. Setting design to false will turn off design at all positions.

If resfile is specified, the listed resfile will be read in the settings therein applied to the task. Any positions set to "AUTO" (and only those set to AUTO) will be subjected the detect design interface procedure as described above. Note that design=0 will turn off design even for positions where it is permitted in the resfile (use "cut1=0.0 cut2=0.0 design=1" to allow design at resfile-permitted positions while disabling design at all AUTO positions).

By default, the DetectProteinLigandInterface will turns off design at disulfide cysteines, and will not permit designing to cysteine. (Positions which start off as cysteine can remain as cysteine if use input sidechains is turned on, or if design is turned off at that position, for example for enzdes catalytic residues). If you wish to allow design to cysteine at designable positions, set design\_to\_cys=1.

catres\_interface: consider catalytic residues (if present) to determine interface (i.e. residues less than cut1 to these residues will be made designable etc.)

catres\_only\_interface: consider only neighbors of catalytic residues (not ligand) for defining interface

arg\_sweep\_interface: use arginine-reachability to interface as the criterion for defining designable positions instead of distance

target\_cstids: comma-separated list of particular constrained residues to be considered as exclusive targets for interface detection (e.g. 1B,2B,3B)

### SetCatalyticResPackBehavior

Ensures that catalytic residues as specified in a match/constraint file do not get designed. If no option is specified the constrained residues will be set to repack only (not design).

If the option fix\_catalytic\_aa=1 is set in the tag (or on the commandline), catalytic residues will be set to non-repacking.

If the option -enzdes::ex\_catalytic\_rot \<number\> is active, the extra\_sd sampling for every chi angle of the catalytic residues will be according to \<number\>, i.e. one can selectively oversample the catalytic residues

### RestrictAbsentCanonicalAAS

Restrict design to user-specified residues. If resnum is left as 0, the restriction will apply throughout the pose.

     <RestrictAbsentCanonicalAAS name=(&string) resnum=(0 &integer) keep_aas=(&string) />

### DisallowIfNonnative

Restrict design to not include a residue as an possibility in the task at a position unless it is the starting residue. If resnum is left as 0, the restriction will apply throughout the pose.

     <DisallowIfNonnative name=(&string) resnum=(0 &integer) disallow_aas=(&string) />

-   disallow\_aas takes a string of one letter amino acid codes, no separation needed. For example disallow\_aas=GCP would prevent Gly, Cys, and Pro from being designed unless they were the native amino acid at a position.

This task is useful when you are designing in a region that has Gly and Pro and you do not want to include them at other positions that aren't already Gly or Pro.

### ThreadSequence

Threads a single letter sequence onto the source pdb.

    <ThreadSequence name=(&string) target_sequence=(&string) start_res=(1&int) allow_design_around=(1&bool)/>

To actually change the sequence of the pose, you have to call something like PackRotamersMover on the pose using this task operation. Notice that with default parameters, this packs the threaded sequence while leaving everything else open for design.

The target sequence can contain two types of 'wildcards'. Placing 'x' in the sequence results in design at this position: target\_sequence="TFYxxxHFS" will thread the two specified tripeptides and allow design in the intervening tripeptide. Placing ' ' (space) or '\_' (underscore), however, restricts this position to repacking: the string "TFY HFS" (three spaces between the two triplets) will thread the two tripeptides and will repack the pose's original intervening tripeptide. The string "TFY\_\_\_HFS" (three underscores between the two triplets) will also only repack the original intervening tripeptide.

allow\_design\_around: if set to false, only design the region that is threaded. The rest is set to repack.

### JointSequence

    <JointSequence use_current=(true &bool)  use_native=(false &bool) filename=(&string) native=(&string) use_natro=(false &bool) 
    use_fasta=(false &bool) chain=( &integer) use_chain=(&integer) />

Prohibit designing to residue identities that aren't found at that position in any of the listed structures:

-   use\_current - Use residue identities from the current structure (input pose to apply() of the taskoperation)
-   use\_native - Use residue identities from the structure listed with -in:file:native
-   filename - Use residue identities from the listed file
-   native - Use residue identities from the listed file
-   use\_fasta - Use residue identities from a native sequence given by a FASTA file (specify the path to the FASTA file with the -in:file:fasta flag at the command line)
-   chain - to which chain to apply, 0 is all chains
-   use\_chain - given an additional input pdb, such as through in:file:native, which chain should the sequence be derived from. 0 is all chains.

If use\_natro is true, the task operation also adds the rotamers from the native structures (use\_native/native) in the rotamer library.

### RestrictDesignToProteinDNAInterface

Restrict Design and repacking to protein residues around the defined DNA bases

    <RestrictDesignToProteinDNAInterface name=(&string) dna_defs=(chain.pdb_num.base) base_only=(1, &bool) z_cutoff=(0.0, &real) />

-   dna\_defs: dna positions to design around, separated by comma (e.g. C.405.THY,C.406.GUA). The definitions should refer only to one DNA chain, the complementary bases are automatically retrieved. Bases are ADE, CYT, GUA, THY. The base (and its complementary) in the starting structure will be mutated according to the definition, if not prevented from another task operation.
-   base\_only: only residues within reach of the DNA bases are considered
-   z\_cutoff: limit the protein interface positions to the ones that have a projection of their distance vector on DNA axis lower than this threshold. It prevents designs that are too far away along the helical axis

<!--- BEGIN_INTERNAL -->

### BuildingBlockInterface

(This is a devel TaskOperation and not available in released versions.)

For use when designing with symmetric building blocks. Prevents repacking at residues that are: 1) distant from the inter-building block interface, or 2) near the inter-building block interface, but also make intra-building block interface contacts that are not clashing.

      <BuildingBlockInterface name=(&string) nsub_bblock=(1 &Size) sym_dof_names="" &string) contact_dist=(10.0 &Real) bblock_dist=(5.0 &Real) fa_rep_cut=(3.0 &Real) />

-   nsub\_bblock - The number of subunits in the symmetric building block (e.g., 3 for a trimer). This option is not needed for multicomponent systems.
-   sym\_dof\_names - Names of the sym\_dofs corresponding to the symmetric building blocks. (Eventually replace the need for this option by having is\_singlecomponent or is\_multicomponent utility functions). If no sym\_dof\_names are specified, then they will be extracted from the pose.
-   contact\_dist - Residues with beta carbons not within this distance of any beta carbon from another building block are prevented from repacking.
-   bblock\_dist - The all-heavy atom cutoff distance used to specify residues that are making inter-subunit contacts within the building block. Because these residues are making presumably important intra-building block interactions, they are prevented from repacking unless they are clashing.
-   fa\_rep\_cut - The cutoff used to determine whether residues making inter-subunit contacts within the building block are clashing.

### RestrictIdentities

Used to specify a set of amino acid identities that are either restricted to repacking, or prevented from repacking altogether. Useful if you don't want to design away, for instance, prolines and glycines.

      <RestrictIdentities name=(&string) identities=(comma-delimited list of strings) prevent_repacking=(0 &bool) />

-   identities - A comma-delimited list of the amino acid types that you'd like to prevent from being designed or repacked (e.g., "PRO,GLY").
-   prevent\_repacking - Whether you want those identities to be prevented from repacking altogether (pass true) or just from being designed (pass false).

<!--- END_INTERNAL --> 

### RestrictNativeResidues

Restrict or prevent repacking of native residues. Accepts a native pose (reference pose) from the command line (via in:file:native) or via the pdbname tag. Loops over all residues and compares the current amino acid at each position to the amino acid in the same position in the reference pose. If the identity is the same, then the residue is either prevented from repacking (if prevent\_repacking option is set to true) or restricted to repacking.

     <RestrictNativeResidues name=(&string) prevent_repacking=(0 &bool) verbose=(0 &bool) pdbname=("" &string) />

Example: Only allow design at non-native positions (prevent repacking of all native residues).

     <RestrictNativeResidues name=non_native prevent_repacking=1 verbose=1 pdbname="input/native.pdb" />

Option list

-   prevent\_repacking ( default = 0 ) : Optional. If set to true, then native residues will be prevented from repacking.
-   verbose ( default = 0 ) : Optional. If set to true, then will output a pymol selection string of all non-native residues to stdout.
-   pdbname ( default = "" ) : Optional. Name of the reference pdb to be used as the "native" structure. May alternatively be specified by the in:file:native flag.

<!--- BEGIN_INTERNAL -->

### RetrieveStoredTask

(This is a devel TaskOperation and not available in released versions.)

Retrieves a stored packer task from the pose's cacheable data; must be used in conjunction with the StoreTask mover. Allows the caching and retrieval of tasks such that a packer task can be defined at an arbitrary point in a RosettaScripts protocol and used again later. This is useful when changes to the pose in the intervening time may result in a different packer task even though the same task operations are applied. Has the ancillary benefit of shortening the lists of task operations that frequently pepper RosettaScripts .xml files.

      <RetrieveStoredTask name=(&string) task_name=(&string) />

-   task\_name - The index where the stored task can be accessed in the pose's cacheable data. This must be identical to the task\_name used to store the task using the StoreTask mover.

<!--- END_INTERNAL --> 

### ProteinCore

(This is a devel TaskOperation and not available in released versions.)

Restricts design of residues that are in the core (e.g. to prevent charges). To determine which residues are core, it counts spatial neighbors (distance between Cb). To avoid confusion in turns on the protein surface, neighbors in sequence are omitted, similar to the way used in *Choi & Deane, Mol Biosyst(2011) 7(12):3327-3334 DOI: 10.1039/c1mb05223c*

     
     <ProteinCore name=(&string) distance_threshold=(8.0 &real) bound=(0 &bool) jump=(1 &Size) neighbor_cutoff=(10 &Size) neighbor_count_cutoff=(6 &Size) /> 

Option list

-   distance\_threshold: maximum distance for a residue to be considered a neighbor
-   bound: removes chain(s) after jump to avoid counting ligand residues as neighbors
-   jump: jump between chain of interest and ligand
-   neighbor\_cutoff: number of sequential neighbors to be excluded from calculation
-   neighbor\_count\_cutoff: number of neighbors required for a core residue

### HighestEnergyRegion

Selects residues that have the highest per-residue energy. This task operation is stochastic to allow for variation in design regions. Residues are selected by this task operation as follows. First, all residues are ranked in order of total score of a region which consists of a sphere around the residue. Next, the first residue is selected based on a random number generator. The first residue in the list (the one with highest (worst) score) has a 50% probability of being selected, the second residue has 25% probability, and so on. If regions\_to\_design is \> 1, additional residues are selected using the same process, except with previously chosen residues removed from consideration.

    <HighestEnergyRegion name=(&string) region_shell=(&real) regions_to_design=(&int) repack_non_selected=(&bool) scorefxn=(&string) />

-   region\_shell: The radius of a sphere that surrounds the residue selected for mutation. All residues within this sphere will be set to design, and all residues outside of it will not be designed.
-   repack\_non\_selected: If set, residues outside of the design sphere will be repacked, otherwise they will be fixed.
-   regions\_to\_design: The number of residues (and regions based on the value of region\_shell) to be selected for design.
-   scorefxn: Scorefunction to be used to determine scores of regions.

**Example** The following example redesigns a sphere of 8 A radius centered in a poorly scoring region of the pose. Residues outside of the sphere are fixed.

    <TASKOPERATIONS>
        <HighestEnergyRegion name="des_high_energy" region_shell="8.0" regions_to_design="1" repack_non_selected="0" />
    </TASKOPERATIONS>
    <MOVERS>
        <PackRotamersMover name="design" task_operations="des_high_energy" />
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="design" />
    </PROTOCOLS>

### DesignByResidueCentrality

Selects residues for design that have the highest value of residue centrality. Centrality is determined by the intra-protein interaction network. Residues are defined as interacting and receive an edge in the network if they have atoms that are \<= 4 angstroms apart. The residue centrality is the average of the average shortest path from each node to all other nodes, and can be used to identify residues that are structurally or functionally important.

This task operation is stochastic to allow for variation in design regions. Residues are selected by this task operation as follows. First, all residues are ranked in order of network centrality. Next, the first residue is selected based on a random number generator. The first residue in the list (the one with highest centrality) has a 50% probability of being selected, the second residue has 25% probability, and so on. If regions\_to\_design is \> 1, additional residues are selected using the same process, except with previously chosen residues removed from consideration.

    <DesignByResidueCentrality name=(&string) region_shell=(8.0 &real) regions_to_design=(1 &int) repack_non_selected=(0 &bool) />

-   region\_shell: The radius of a sphere that surrounds the residue selected for mutation. All residues within this sphere will be set to design, and all residues outside of it will not be designed.
-   repack\_non\_selected: If set, residues outside of the design sphere will be repacked, otherwise they will be fixed.
-   regions\_to\_design: The number of residues (and regions based on the value of region\_shell) to be selected for design.

**Example** The following example redesigns a sphere of 8 A radius centered at a residue of high centrality. Residues outside of the sphere are fixed.

    <TASKOPERATIONS>
        <DesignByResidueCentrality name="des_by_centrality" region_shell="8.0" regions_to_design="1" repack_non_selected="0" />
    </TASKOPERATIONS>
    <MOVERS>
        <PackRotamersMover name="design" task_operations="des_by_centrality" />
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="design" />
    </PROTOCOLS>

### DesignRandomRegion

Simply chooses random residues from the pose. This task operation is stochastic to allow for variation in design regions. Each call to this operation results in a new randomly selected set of residues chosen for design.

    <DesignRandomRegion name=(&string) region_shell=(&real) regions_to_design=(&int) repack_non_selected=(&bool) />

-   region\_shell: The radius of a sphere that surrounds the residue selected for mutation. All residues within this sphere will be set to design, and all residues outside of it will not be designed.
-   repack\_non\_selected: If set, residues outside of the design sphere will be repacked, otherwise they will be fixed.
-   regions\_to\_design: The number of residues (and regions based on the value of region\_shell) to be selected for design.

**Example** The following example redesigns a sphere of 8 A radius centered at a randomly selected residue. Residues outside of the sphere are fixed.

    <TASKOPERATIONS>
        <DesignRandomRegion name="des_random" region_shell="8.0" regions_to_design="1" repack_non_selected="0" />
    </TASKOPERATIONS>
    <MOVERS>
        <PackRotamersMover name="design" task_operations="des_random" />
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="design" />
    </PROTOCOLS>

### DesignCatalyticResidues

Sets catalytic residues to designable. Prior to being called, this task operation REQUIRES that enzdes constraints be added to the pose. This can be accomplished using the \<AddOrRemoveMatchCsts /\> mover as shown in the example. This could be combined with the \<SetCatalyticResPackBehavior /\> task operation to set the catalytic residues to repack and design the spheres around them.

    <DesignCatalyticResidues name=(&string) region_shell=(&real) regions_to_design=(&int) repack_non_selected=(&bool) />

-   region\_shell: The radius of a sphere that surrounds the residue selected for mutation. All residues within this sphere will be set to design, and all residues outside of it will not be designed.
-   repack\_non\_selected: If set, residues outside of the design sphere will be repacked, otherwise they will be fixed.
-   regions\_to\_design: The number of residues (and regions based on the value of region\_shell) to be selected for design.

**Example** The following example redesigns a sphere of 8 A radius centered at catalytic residues. Residues outside of the sphere are fixed.

    <TASKOPERATIONS>
        <SetCatalyticResPackBehavior name="repack_cat" fix_catalytic_aa="0" />
        <DesignCatalyticResidues name="des_catalytic" region_shell="8.0" regions_to_design="1" repack_non_selected="0" />
    </TASKOPERATIONS>
    <MOVERS>
        <AddOrRemoveMatchCsts name="add_csts" cstfile="my_csts.cst" cst_instruction="add_new" />
        <PackRotamersMover name="design" task_operations="des_catalytic,repack_cat" />
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="add_csts" />
        <Add mover_name="design" />
    </PROTOCOLS>

### DesignByCavityProximity

This task operations scans the protein to identify intra-protein voids, and selects residues for design based on their proximity to the voids. Residues are scored by the metric (distance\_to\_cavity\_center)/(volume\_of\_cavity) and the lowest scoring residues are selected for design.

    <DesignByCavityProximity name=(&string) region_shell=(8.0 &real) regions_to_design=(1 &int) repack_non_selected=(0 &bool) />

-   region\_shell: The radius of a sphere that surrounds the residue selected for mutation. All residues within this sphere will be set to design, and all residues outside of it will not be designed.
-   repack\_non\_selected: If set, residues outside of the design sphere will be repacked, otherwise they will be fixed.
-   regions\_to\_design: The number of residues (and regions based on the value of region\_shell) to be selected for design.

**Example** The following example redesigns a sphere of 8 A radius centered at a residue near an intra-protein cavity. Residues outside of the sphere are fixed.

    <TASKOPERATIONS>
        <DesignByCavityProximity name="des_cavity" region_shell="8.0" regions_to_design="1" repack_non_selected="0" />
    </TASKOPERATIONS>
    <MOVERS>
        <PackRotamersMover name="design" task_operations="des_cavity" />
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="design" />
    </PROTOCOLS>

### DesignBySecondaryStructure

Selects residues for design based on agreement with psipred secondary structure prediction. Residues which disagree with the secondary structure prediction are selected for design. This mover is stochastic in that residues which disagree in secondary structure prediction are selected randomly every time the task operation is called.

    <DesignBySecondaryStructure name=(&string) region_shell=(8.0 &real) regions_to_design=(1 &int) repack_non_selected=(0 &bool) blueprint=("" &string) cmd=(&string) />

-   region\_shell: The radius of a sphere that surrounds the residue selected for mutation. All residues within this sphere will be set to design, and all residues outside of it will not be designed.
-   repack\_non\_selected: If set, residues outside of the design sphere will be repacked, otherwise they will be fixed.
-   regions\_to\_design: The number of residues (and regions based on the value of region\_shell) to be selected for design.
-   blueprint: a blueprint file which specifies the secondary structure at each position.
-   cmd: **Required** Path to the runpsipred executable.

**Example** The following example redesigns a sphere of 8 A radius centered at a residue with secondary structure prediction that disagrees with actual secondary structure. Residues outside of the sphere are fixed.

    <TASKOPERATIONS>
        <DesignBySecondaryStructure name="des_by_sspred" region_shell="8.0" regions_to_design="1" repack_non_selected="0" cmd="/path/to/runpsipred_single" />
    </TASKOPERATIONS>
    <MOVERS>
        <PackRotamersMover name="design" task_operations="des_by_sspred" />
    </MOVERS>
    <PROTOCOLS>
        <Add mover_name="design" />
    </PROTOCOLS>

### InteractingRotamerExplosion

Task Operation that oversamples rotamers that score well with a specified target residue (or set thereof). Note that this TaskOP by itself does not select or deselect any residue positions for design. Rather, it builds extra rotamers of the residue types and at positions that were allowed by previously used TaskOPs. This means that this TaskOP should be used in conjunction with other TaskOPs that take care of which regions to design.
This TaskOP can be considered to work like the old rotamer explosion protocols in Rosetta 2.x

If the -debug option is activated, all extra rotamers generated by this task op will be written to disk.

Note: rotamers are selected based on their score against the target res conformation in the pose, i.e. if the target residues are also packable, only their input conformation is considered by this TaskOP. In principle it should be possible to adapt this TaskOP to consider all rotamers of the target res though.

Under the hood, the RotamerSetOperation src/protocols/toolbox/rotamer_set_operations/AddGood2BPairEnergyRotamers is used.

**Example:** the following snippet sets up a PackRotamersMover to oversample rotamers at ex_level 4 (for all chis) that have an interacting (2Body) score of better than -0.5 REU (in whatever score function used) with residue 5 on chain B in the pose. The DesignAroundOperation takes care of what residue types are built at what positions.

    <TASKOPERATIONS>
        <DesignAround name=desaround design_shell=12.0 resnums="5B" repack_shell=15.0 allow_design=1 resnums_allow_design=0 />
        <InteractingRotamerExplosion name=rotexpl ex_level=4 score_cutoff=0.5 target_seqpos="5B" debug=0 />
    </TASKOPERATIONS>
      <MOVERS>
              <PackRotamersMover name=packrot scorefxn=talaris task_operations=desaround,rotexpl />
      </MOVERS>


Rotamer Specification
---------------------

### InitializeFromCommandline

Reads commandline options. For example, -ex1 -ex2 (does not read resfile from command line options) This taskoperation will complain about an unimplemented method, but you can safely ignore the message.

     <InitializeFromCommandline name=(&string) />

### IncludeCurrent

Includes current rotamers (eg - from input pdb) in the rotamer set. These rotamers will be lost after a packing run, so they are only effective upon initial loading of a pdb!

     <IncludeCurrent name=(&string) />

### ExtraRotamersGeneric

During packing, extra rotamers can be used to increase sampling. Use this TaskOperation to specify for all residues at once what extra rotamers should be used. Note: The *extrachi\_cutoff* is used to determine how many neighbors a residue must have before the extra rotamers are applied. For example of you want to apply extra rotamers to all residues, set *extrachi\_cutoff=0* . See the Extra Rotamer Commands section on the [[resfiles|resfiles#Extra-Rotamer-Commands:]] page for additional details.

     <ExtraRotamersGeneric name=(&string)
    ex1=(0 &boolean) ex2=(0 &boolean) ex3=(0 &boolean) ex4=(0 &boolean)
    ex1aro=(0 &boolean) ex2aro=(0 &boolean) ex1aro_exposed=(0 &boolean) ex2aro_exposed=(0 &boolean)
    ex1_sample_level=(7 &Size) ex2_sample_level=(7 &Size) ex3_sample_level=(7 &Size) ex4_sample_level=(7 &Size)
    ex1aro_sample_level=(7 &Size) ex2aro_sample_level=(7 &Size) ex1aro_exposed_sample_level=(7 &Size) ex2aro_exposed_sample_level=(7 &Size) 
    exdna_sample_level=(7 &Size)
    extrachi_cutoff=(18 &Size)/> 

### RotamerExplosion

Sample residue chi angles much more finely during packing. Currently hardcoded to use three 1/3 step standard deviation.

*Note: This might actually need to be called as RotamerExplosionCreator in the xml*

     <RotamerExplosionCreator name=(&string) resnum=(&Integer) chi=(&Integer) />

### LimitAromaChi2

Prevent to use the rotamers of PHE, TYR and HIS that have chi2 far from 90.

-   chi2max ( default 110.0 ) : max value of chi2 to be used
-   chi2min ( default 70.0 ): min value of chi2 to be used

### AddLigandMotifRotamers

Using a library of protein-ligand interactions, identify possible native-like interactions to the ligand and add those rotamers to the packer, possibly with a bonus.

    <AddLigandMotifRotamers name=(&string)/>

Since it only makes sense to run AddLigandMotifRotamers once (it takes a very long time), I have not made the options parseable. You can however read in multiple weight files in order to do motif weight ramping.

### ImportUnboundRotamers

Import unbound rotamers from a given PDB file. Specify the unbound/native PDB file using the flag: -packing::unboundrot

Note: This task operation was developed to favor unbound rotamers (in particular, native rotamers) from an imported PDB file. If this is what you want, make sure that you use the load\_unbound\_rot mover (no parameters, and currently undocumented), which changes the rotamer Dunbrack scoring term (fa\_dun), such that the scores for your imported unbound rotamers are equal to the best scoring rotamers in your currently used library. This will favor the imported unbound rotamers at the time you design/repack sidechains. This task operation should be used with your favorite sidechain designing/packing mover (for example: GreedyOptMutationMover, RepackMinimize, or PackRotamersMover).

    <ImportUnboundRotamers name=(&string)/>

Packer Behavior Modification
----------------------------

### ModifyAnnealer

Allows modification of the temperatures and quench used by the annealer during packing.

```
<ModifyAnnealer name=(&string) high_temp=(100.0 &Real) low_temp=(0.3 &Real) disallow_quench=(0 &bool)/>
```

-   high\_temp - the starting high temperature for the annealer
-   low\_temp - the temperature that the annealer cools to
-   disallow\_quench - quench accepts every change that lowers the energy. If you want more diversity it could be prudent to disallow the quench step. Quench is on by default.

### ProteinLigandInterfaceUpweighter

Specifically upweight the strength of the protein-ligand interaction energies by a given factor.

    <ProteinLigandInterfaceUpweighter name=(&string) interface_weight=(1.0 &Real) catres_interface_weight=(1.0 &Real)/>

interface\_weight: upweight ligand interactions by this weight

catres\_interface\_weight: upweight catatlytic residue interactions by this weight

Development/Testing
-------------------

### InitializeExtraRotsFromCommandline

Under development and untested. Use at your own risk.

### SetRotamerCouplings

Under development and untested. Use at your own risk.

### AppendRotamer

Under development and untested. Use at your own risk.

### AppendRotamerSet

Under development and untested. Use at your own risk.

### PreserveCBeta

Under development and untested. Use at your own risk.

### RestrictYSDesign

Restrict amino acid choices during design to Tyr and Ser. This is similar to the restricted YS alphabet used by Sidhu's group during in vitro evolution experiments. Under development and untested. Use at your own risk.

Currently Undocumented
======================

The following TaskOperations are available through RosettaScripts, but are not currently documented. See the code (particularly the respective parse\_tag() and apply() functions) for details. (Some may be undocumented as they are experimental/not fully functional.)

AddRigidBodyLigandConfs, DisableZnCoordinationResiduesTaskOp, ExtraChiCutoff, ExtraRotamers, OptCysHG, OptH, PreventChainFromRepacking, ReadResfileAndObeyLengthEvents, RemodelRotamerLinks, ReplicateTask, RestrictByCalculators, RestrictConservedLowDdg, RestrictInterGroupVectorOperation, RestrictNonSurfaceToRepacking, RestrictToCDRH3Loop, RestrictToInterfaceOperation, RestrictToLoopsAndNeighbors, RestrictToNeighborhood, SeqprofConsensus, SetIGType, SetRotamerLinks, WatsonCrickRotamerCouplings

Residue Level TaskOperations:

-   DisallowIfNonnativeRLT