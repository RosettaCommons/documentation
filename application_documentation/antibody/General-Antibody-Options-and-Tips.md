#Antibody General

## PDB Numbering and CDR Definitions

There are many numbering schemes and CDR definitions for antibodies in the literature.

To begin any current Rosetta Antibody protocol, one must first renumber their input PDB, unless the PDB is created by sequence through the antibody.py script (Which currently only outputs Chothia - renumbered antibodies).

- Chothia + Kabat: [AbNum](http://www.bioinf.org.uk/abs/abnum/)
- AHo (Required for Antibody Design protocols): [PyIgClassify](http://dunbrack2.fccc.edu/PyIgClassify/)

##Relavent Options

```
(antibody group - can be used like: antibody:numbering_scheme)

-numbering_scheme, String,
The numbering scheme of the PDB file. Options are: Chothia_Scheme, Enhanced_Chothia_Scheme, AHO_Scheme, 
IMGT_Scheme. Kabat_Scheme is also accepted, but not fully supported due to H1 numbering conventions.  
Use Kabat_Scheme with caution.,
  default=Chothia_Scheme

-cdr_definition, String,
The CDR definition to use.  Current Options are: Chothia, Aroop, North, Kabat, Martin,
 default=Aroop

-light_chain, String,
Type of light chain if known.  Only used for design for now.,
 legal = [unknown, lambda, kappa],
 default=unknown

-check_cdr_chainbreaks, Boolean,
Check CDRs of input antibody for chainbreaks upon initializing RosettaAntibody and RosettaAntibodyDesign. 
Chainbreaks found will result in the model not proceeding. A peptide bond in the loop is considered 
broken if its C-N bond is > 2.0 A,
 default=true

-check_cdr_pep_bond_geom, Boolean,
Check CDRs of input antibody for bad peptide bond geometry.  This checks Ca-C-N and C-N-Ca bond angles for 
-large- deviations from the min max values found in a recent analysis of protein geometry  - Conformation 
dependence of backbone geometry in proteins. Structure -.  If found, the model will not proceed.  
Use FastRelax with bond angle min to fix issues.  These issues usually arise from poorly resolved crystal loops 
or incorrectly solved structures.  Many older antibody structures have some of these issues.,
 default=false

-allow_omega_mismatches_for_north_clusters, Boolean,
Skip first grouping Cis and Trans for North/Dunbrack clusters 
in which a Cis/Trans designation currently does not exist. 
If you get an NA, or a warning when identifying CDRs, change this option to true.  
Currently only used for the RosettaAntibodyDesign (RAbD) Framework.,
 default=false
```