# AddCDRProfilesOperation
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## AddCDRProfilesOperation

###Author
Jared Adolf-Bryfogle; jadolfbr@gmail.com; 
PI: Roland Dunbrack

Part of the RosettaAntibody and RosettaAntibodyDesign (RAbD) Framework
* [[Rosetta Antibody Design (RAbD) Manual | RosettaAntibodyDesign]]

### Brief
Add Cluster-based CDR Profiles as the task operation for the set of CDRs by default.
Uses the ResidueProbDesignOperation to sample the CDR Cluster profile based on the probability distribution for the CDR clusters.  Multiple rounds of packing are recommended to sample on the distributions.
CDR definitions used are North/Dunbrack as the clusters are defined using it.  By default ALL CDRs are set for sampling.

### Profile Sampling Details 

Each time a task is generated, it will choose one amino acid from the set for that position and add it to (or replace)  the set of packable residues chosen for that position. Decreases number of rotamers for packing and the space for design.  Instead of using energy for profiles, we use selection of residues through probabilities at each task generation.  If the picking_rounds option is set at > 1, is higher it can result in more than one additional residue in the task from the native and increase variability of potential designs.

### Details 

If Cluster-based profiles cannot be used, will use the fallback strategy.
This can happen if the the CDR is of an unknown cluster or there is too little data
about the cluster to use profiles.

FALLBACK STRATEGIES:
*   _seq_design_conservative_ adds a conservative mutation set to the possible residue types (blosum62 default),
*   _seq_design_basic_ will do nothing (as the default for design is to allow all residue positions);
*   _seq_design_none_ will disable design for that CDR (essentially your saying that if it doesn't have profiles, don't design it)

**This TaskOperation is not currently recommended for H3 as it does not cluster well.**

**(Not currently RS enabled)** Optionally sample whole CDR sequences (using integrated [[AddCDRProfileSetsOperation]]] via the primary strategy of:
*   _seq_design_profile_sets_ (use sets instead of profile probability)
*   _seq_design_profile_sets_combined_ (use profile sets and profile probability)


```xml
<AddCDRProfilesOperation cdrs="(&string,&string)" numbering_scheme="(&string)" include_native_restype="(&bool, true)" picking_rounds="(&size, 1)"/>
```


###Common Options 

-   cdrs (&string,&string) (default=all cdrs):  Select the set of CDRs you wish to restrict to (ex: H1 or h1)
-   numbering_scheme (&string):  Set the antibody numbering scheme.  This option can also be set through the command line.  See [[General Antibody Tips | General-Antibody-Options-and-Tips]] for more info.
-   include_native_restype (&bool) (default=true):  Include the native residue type when sampling? 
-   picking_rounds (&size) (default=1): Set the number of times a residutype is chosen from the distribution each time the packer is generated.  Increase this number to increase variability of design.
 
### Design Strategies

-   fallback_strategy (&string) (default=seq_design_conservative): Set the fallback strategy as explained above.  Options are: 
 *   _seq_design_conservative_ adds a conservative mutation set to the possible residue types (blosum62 default),
 *   _seq_design_basic_ will do nothing (as the default for design is to allow all residue positions);
 *   _seq_design_none_ will disable design for that CDR (essentially your saying that if it doesn't have profiles, don't design it)

### Uncommon Options
-   use_outliers (&bool) (default=false): Use cluster outliers as defined using DihedralDistance and RMSD.
-   stats_cutoff (&size) (default=10): Will use the fallback strategy for this CDR if the total is less than or equal to this number.
-   sample_zero_probs_at (&size) (default=0): Set the number of times a sequence each chosen.  Increase this number to increase variability of design.
-   cons_design_data_source (&string) (default=blosum62):  Data source used for the ConservativeDesignOperation, which is a fallback strategy.  This guides the set of allowed mutations.  Higher blosum means higher conservation (numbers indicate sequence similarity cutoffs.  The set of mutations allowed are those from the substitution matrix at values >=0.  
 *   legal = ['chothia_1976', 'BLOSUM30', 'blosum30', 'BLOSUM35', 'blosum35', 'BLOSUM40', 'blosum40', 'BLOSUM45', 'blosum45', 'BLOSUM50', 'blosum50', 'BLOSUM55', 'blosum55', 'BLOSUM60', 'blosum60', 'BLOSUM62', 'blosum62', 'BLOSUM65', 'blosum65', 'BLOSUM70', 'blosum70', 'BLOSUM75', 'blosum75', 'BLOSUM80', 'blosum80', 'BLOSUM85', 'blosum85', 'BLOSUM90', 'blosum90', 'BLOSUM100', 'blosum100']

### Benchmarking Options
-   force_north_paper_db (&bool) (default=false): Force the use of the original 2011 North/Dunbrack clustering paper data as the database instead of any up-to-date versions downloaded from PyIgClassify. 

##See Also

* [[General Antibody Tips | General-Antibody-Options-and-Tips]]
* [[Antibody TaskOperations | TaskOperations-RosettaScripts#antibody-and-cdr-specific-operations]]
* [[Antibody Movers | Movers-RosettaScripts#antibody-modeling-and-design-movers]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
