# TCR modeling

# Metadata
Author: Ragul Gowthaman (ragul@umd.edu).
This document was last updated Aug 21, 2018, by Ragul Gowthaman.
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

### Output Files

After submission of TCR sequences, the results will provide the parsed CDR loop sequences and identified templates to the user along with the modeled protein as PDB file.

### Basic options
-------------------------

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-alpha|Amino acid squence of the Sequence of TCR alpha chain.|String|
|-beta|Amino acid squence of the Sequence of TCR beta chain.|Boolean|
|-refine_tcr_cdr3_loops|Refine the CDR3 loops of Alpha and Beta chain.|Boolean|
|-remodel_tcr_cdr3_loops|Remodel the CDR3 loops of Alpha and Beta chain.|Boolean|

### Advanced options
-------------------------

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-use_anarci|Use ANARCI for TCR CDR classification and parsing TCR segments. Default false.|Boolean|
|-anarci_path|Path of the ANARCI executable program. |String|
|-include_ab_templates|Include antibody templates for modelling.  Default false.|Boolean|
|-ab_template_db_path|Antibody template database path.|String|
|-search_germline_templates|Search germline templates for modelling. Default:True|Boolean|
|-template_similarity_cutoff|Similarity cutoff to ignore similar template sequences from template database. Default:100|Real|
|-template_identity_cutoff|Identity cutoff to ignore similar template sequences from template database.Default:100|Real|
|-blastp_identity_cutoff|Identity cutoff to ignore similar template sequences from template database.Default:100|Real|
|-ignore_list|List of PDB id's to ignore as templates.Default:None|Boolean|
|-num_cter_overhang_res|Number of C-terminal overhang residues to use for grafting alignment. Default:3|Integer|
|-num_nter_overhang_res|Number of N-terminal overhang residues to use for grafting alignment. Default:3|Integer|
|-relax_model|Minimize the output model.|Boolean|
|-minimize_model|Minimize the output model. (Only works with 2 partner docking). (Global).|Boolean|
|-max_cycles|Max number of cycles to use in the loop remodel protocol. Default 20.|Integer|
|-remodel_tcr_cdr3a_loop|Remodel the CDR3 loop of alpha chain. Useful if remodeling is required only for the CDR3 loop of alpha chain. Default:False.|Boolean|
|-remodel_tcr_cdr3b_loop|Remodel the CDR3 loop of beta chain. Useful if remodeling is required only for the CDR3 loop of beta chain.Default:False.|Boolean|
|-refine_all_tcr_cdr_loops|Refine all the CDR loops. Refinement includes CDR1, CDR2, CDR3 & HV4 loops of Alpha and Beta chains. Default:False.|Boolean|


## Example: Commands for sample TCR modeling run for a human T cell receptor PDB:1AO7

###Basic modeling
$ Rosetta/main/source/bin/tcr.macosclangrelease -database Rosetta/main/database -alpha VEQNSGPLSVPEGAIASLNCTYSDRGSQSFFWYRQYSGKSPELIMSIYSNGDKEDGRFTAQLNKASQYVSLLIRDSQPSDSATYLCAVTTDSWGKLQFGAGTQVVVT -beta VTQTPKFQVLKTGQSMTLQCAQDMNHEYMSWYRQDPGMGLRLIHYSVGAGITDQGEVPNGYNVSRSTTEDFPLRLLSAAPSQTSVYFCASRPGLAGGRPEQYFGPGTRLTVT

###Advanced modeling with loop remodel
$ Rosetta/main/source/bin/tcr.macosclangrelease -database Rosetta/main/database -alpha VEQNSGPLSVPEGAIASLNCTYSDRGSQSFFWYRQYSGKSPELIMSIYSNGDKEDGRFTAQLNKASQYVSLLIRDSQPSDSATYLCAVTTDSWGKLQFGAGTQVVVT -beta VTQTPKFQVLKTGQSMTLQCAQDMNHEYMSWYRQDPGMGLRLIHYSVGAGITDQGEVPNGYNVSRSTTEDFPLRLLSAAPSQTSVYFCASRPGLAGGRPEQYFGPGTRLTVT