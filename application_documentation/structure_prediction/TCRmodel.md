# TCR modeling

# Metadata
This document was last updated April 2, 2019, by Ragul Gowthaman (ragul@umd.edu).
The corresponding principal investigator is Brian Pierce (pierce@umd.edu).
[[_TOC_]]

# TCR modeling

## References

Ragul Gowthaman, Brian G Pierce; TCRmodel: high resolution modeling of T cell receptors from sequence, Nucleic Acids Research, Volume 46, Issue W1, 2 July 2018, Pages W396–W401, https://doi.org/10.1093/nar/gky432

##Introduction

T cell receptors, or TCRs, are immunoglobulin immune receptors found on T cells, and each human is estimated to possess millions of unique TCRs. As with antibodies, TCRs are heterodimers, and diversity is primarily exhibited in loops called complementarity determining region (CDR) loops, which engage foreign antigens. In the case of TCRs, these are typically peptides that are presented by major histocompatibility complex (MHC) proteins. TCRs represent a key element of the cellular immune response, and have major implications in vaccine design, autoimmune disease, and as immunotherapeutics for cancer.

To address the growing need to gain structural insights of TCRs based on their sequences, due in part to advances in immune repertoire sequencing and massive increases in TCR sequence data, we have produced RosettaTCR in the powerful protein modeling program Rosetta. Analogous to the RosettaAntibody program for antibody modeling, RosettaTCR is constructed using all known TCR structures as templates and with optimizations to correctly model TCR architectures. 

##Algorithm

The TCRmodel server has three main stages:

- Template identification: template structures are identified from known TCR CDR loops and framework regions
- Grafting: models are assembled by grafting identified template loops onto framework regions
- Refinement: side chains and backbone of models are minimized using the fast "relax" protocol in Rosetta, and if specified by the user, CDR3 loops subjected to additional cycles of backbone refinement, using kinematic closure loop modeling (Refine: refinement, Remodel: rebuilding + refinement)

The database of template TCR structures is updated from the Protein Data Bank on a monthly basis, and currently includes several hundred crystal structures representing over 100 unique TCRs. If no template is identified among TCR structures, CDR loops are obtained from antibody crystal structures, or are modeled de novo. 

## Instructions For Running TCR modeling Protocol
### Input Files

TCR sequences for modeling can be submitted as amino acid sequences for alpha and beta chains, encompassing at minimum the TCR variable domains. The program will automatically identify germline genes in the input sequences, if there is an exact match in the database.

**Template Database**

The TCR template database, which is required for running the application, is not available by default for weekly Rosetta releases. The TCR template database directory is located at "Rosetta/database/additional_protocol_data/tcr" in the code base. Users can clone or download the template database as part of the "Rosetta/database/additional_protocol_data" directory. 

For example:

git clone git@github.com:RosettaCommons/additional_protocol_data.git

or

git clone https://github.com/RosettaCommons/additional_protocol_data.git

The template database can also be dowloaded from TCRmodel web server from this page: https://tcrmodel.ibbr.umd.edu/links

The default location for the database path is "Rosetta/database/additional_protocol_data/tcr". If placed in a different location, use the flag "-tcr_template_db_path" to provide the path to the template database.


### Output Files

After submission of TCR sequences, the results will provide the parsed CDR loop sequences and identified templates to the user along with the modeled protein as PDB file.

### Basic options
-------------------------

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-alpha|Amino acid sequence of TCR alpha chain.|String|
|-beta|Amino acid sequence of TCR beta chain.|String|
|-minimize_model|Minimize the output model.Default:True|Boolean|
|-relax_model|Minimize the output model.Default:False|Boolean|
|-refine_tcr_cdr3_loops|Refine the CDR3 loops of Alpha and Beta chain.Default:False|Boolean|
|-remodel_tcr_cdr3_loops|Remodel the CDR3 loops of Alpha and Beta chain.Default:False|Boolean|
|-remodel_tcr_cdr3a_loop|Remodel the CDR3 loop of alpha chain. Useful if remodeling is required only for the CDR3 loop of alpha chain. Default:False.|Boolean|
|-remodel_tcr_cdr3b_loop|Remodel the CDR3 loop of beta chain. Useful if remodeling is required only for the CDR3 loop of beta chain.Default:False.|Boolean|
|-refine_all_tcr_cdr_loops|Refine all the CDR loops. Refinement includes CDR1, CDR2, CDR3 & HV4 loops of Alpha and Beta chains. Default:False.|Boolean|


### Advanced options
---------------------

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-include_ab_templates|Include antibody templates for modelling.  Default false.|Boolean|
|-ab_template_db_path|Antibody template database path.|String|
|-dump_templates|Dump all template pdb files, Default:False|Boolean|
|-tcr_template_db_path|tcr template database path, Default:Use the tcr template databasse located in '$Rosetta/database/additional_protocol_data/tcr'|String|
|-template_similarity_cutoff|Similarity cutoff to ignore similar template sequences from template database. Default:100|Real|
|-template_identity_cutoff|Identity cutoff to ignore similar template sequences from template database.Default:100|Real|
|-blastp_identity_cutoff|Identity cutoff to ignore similar template sequences from template database.Default:100|Real|
|-ignore_list|List of PDB id's to ignore as templates.Default:None|File|
|-use_alpha_germline_templates|use germline templates for alpha chain, by default germline or framework templates choosen by sequence match. Default=False|Boolean|
|-use_beta_germline_templates|use germline templates for beta chain, by default germline or framework templates choosen by sequence match. Default:False|Boolean|
|-use_user_templates|use user provided templates for TCR segments, useful for testing and integrations tests. Default:false|Boolean|
|-alpha_framework_template_id|template PDB id with chain for alpha chain framework segment, eg. 1kgc_D. Default:None|String|
|-beta_framework_template_id|template PDB id with chain for alpha chain framework segment, eg. 1kgc_E. Default:None|String|
|-alpha_germline_template_id|template PDB id with chain for alpha chain germline segment, eg. 1kgc_D. Default:None|String
|-beta_germline_template_id|template PDB id with chain for alpha chain germline segment, eg. 1kgc_E. Default:None|String|
|-alpha_cdr1_template_id|template PDB id with chain for alpha chain CDR1 segment, eg. 1kgc_D. Default:None|String|
|-beta_cdr1_template_id|template PDB id with chain for alpha chain CDR1 segment, eg. 1kgc_E. Default:None|String|
|-alpha_cdr2_template_id|template PDB id with chain for alpha chain CDR2 segment, eg. 1kgc_D. Default:None|String|
|-beta_cdr2_template_id|template PDB id with chain for alpha chain CDR2 segment, eg. 1kgc_E. Default:None|String|
|-alpha_cdr3_template_id|template PDB id with chain for alpha chain CDR3 segment, eg. 1kgc_D. Default:None|String|
|-beta_cdr3_template_id|template PDB id with chain for alpha chain CDR3 segment, eg. 1kgc_E. Default:None|String|
|-alpha_orientation_template_id|template PDB id with chain for orientation of alpha chain, use along with beta_orientation_template_id, eg. 1kgc_D. Default:None|String|
|-beta_orientation_template_id|template PDB id with chain for orientation of beta chain, use along with -alpha_orientation_template_id, eg. 1kgc_E. Default:None|String|
|-alpha_framework_template_pdb|template PDB file for alpha chain framework segment. Default:None|String|
|-beta_framework_template_pdb|template PDB file for alpha chain framework segment. Default:None|String|
|-alpha_germline_template_pdb|template PDB file for alpha chain germline segment. Default:None|String|
|-beta_germline_template_pdb|template PDB file alpha chain germline segment. Default:None|String|
|-alpha_cdr1_template_pdb|template PDB file alpha chain CDR1 segment. Default:None|String|
|-beta_cdr1_template_pdb|template PDB file for alpha chain CDR1 segment. Default:None|String|
|-alpha_cdr2_template_pdb|template PDB file for alpha chain CDR2 segment. Default:None|String|
|-beta_cdr2_template_pdb|template PDB file for alpha chain CDR2 segment. Default:None|String|
|-alpha_cdr3_template_pdb|template PDB file for alpha chain CDR3 segment. Default:None|String|
|-beta_cdr3_template_pdb|template PDB file for alpha chain CDR3 segment. Default:None|String|
|-alpha_orientation_template_pdb|template PDB file for orientation of alpha chain. Default:None|String|
|-beta_orientation_template_pdb|template PDB file for orientation of beta chain. Default:None|String|
|-num_cter_overhang_res|Number of C-terminal overhang residues to use for grafting alignment. Default:3|Integer|
|-num_nter_overhang_res|Number of N-terminal overhang residues to use for grafting alignment. Default:3|Integer|

### Example: Commands for sample TCR modeling run for a human T cell receptor PDB:1AO7

###Basic modeling
$ Rosetta/main/source/bin/tcrmodel.macosclangrelease -database Rosetta/main/database -alpha VEQNSGPLSVPEGAIASLNCTYSDRGSQSFFWYRQYSGKSPELIMSIYSNGDKEDGRFTAQLNKASQYVSLLIRDSQPSDSATYLCAVTTDSWGKLQFGAGTQVVVT -beta VTQTPKFQVLKTGQSMTLQCAQDMNHEYMSWYRQDPGMGLRLIHYSVGAGITDQGEVPNGYNVSRSTTEDFPLRLLSAAPSQTSVYFCASRPGLAGGRPEQYFGPGTRLTVT

###Advanced modeling with loop remodel
$ Rosetta/main/source/bin/tcrmodel.macosclangrelease -database Rosetta/main/database -alpha VEQNSGPLSVPEGAIASLNCTYSDRGSQSFFWYRQYSGKSPELIMSIYSNGDKEDGRFTAQLNKASQYVSLLIRDSQPSDSATYLCAVTTDSWGKLQFGAGTQVVVT -beta VTQTPKFQVLKTGQSMTLQCAQDMNHEYMSWYRQDPGMGLRLIHYSVGAGITDQGEVPNGYNVSRSTTEDFPLRLLSAAPSQTSVYFCASRPGLAGGRPEQYFGPGTRLTVT -remodel_tcr_cdr3_loops -refine_tcr_cdr3_loops

###Modeling with user provided templates
$ Rosetta/main/source/bin/tcr.macosclangrelease -database Rosetta/main/database -alpha VEQNSGPLSVPEGAIASLNCTYSDRGSQSFFWYRQYSGKSPELIMSIYSNGDKEDGRFTAQLNKASQYVSLLIRDSQPSDSATYLCAVTTDSWGKLQFGAGTQVVVT -beta VTQTPKFQVLKTGQSMTLQCAQDMNHEYMSWYRQDPGMGLRLIHYSVGAGITDQGEVPNGYNVSRSTTEDFPLRLLSAAPSQTSVYFCASRPGLAGGRPEQYFGPGTRLTVT -alpha_germline_template_pdb gma_tmplt_piece.pdb -beta_germline_template_pdb gmb_tmplt_piece.pdb -alpha_cdr3_template_pdb cdr3a_tmplt_piece.pdb -beta_cdr3_template_pdb cdr3b_tmplt_piece.pdb -alpha_orientation_template_pdb ora_tmplt_piece.pdb -beta_orientation_template_pdb orb_tmplt_piece.pdb -use_alpha_germline_templates -use_beta_germline_templates 


###Output
- Output files:
Running TCR modeling application will result in the following PDB format output files. The -out::prefix flag can be used to add prefix to the output file names.
    * tcrmodel.pdb The final refined final model.
    * tcr_graftmodel.pdb The crude grafted model without refinement.
    * tcr_loopmodel.pdb The model after application of optional loop modeling or refinement.

