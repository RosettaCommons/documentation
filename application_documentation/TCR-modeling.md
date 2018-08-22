# TCR modeling

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

## Input Files


Basic options
-------------------------

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-alpha|Defines docking partners by chain ID for multichain docking. For example, "-partners LH\_A" moves chain A around the dimer of chains L and H.|String|
|-beta|Randomize the orientation of the first docking partner. (Only works with 2 partner docking). (Global).|Boolean|
|-refine_tcr_cdr3_loops|Randomize the orientation of the second docking partner. (Only works with 2 partner docking). (Global).|Boolean|
|-remodel_tcr_cdr3_loops|Spin a second docking partner around axes from center of mass of the first partner to the second partner. (Global).|Boolean|

Advanced options
-------------------------

|**Flag**|**Description**|**Type**|
|:-------|:--------------|:-------|
|-use_anarci|Defines docking partners by chain ID for multichain docking. For example, "-partners LH\_A" moves chain A around the dimer of chains L and H.|String|
|-anarci_path|Randomize the orientation of the first docking partner. (Only works with 2 partner docking). (Global).|Boolean|
|-include_ab_templates|Randomize the orientation of the second docking partner. (Only works with 2 partner docking). (Global).|Boolean|
|-ab_template_db_path|Randomize the orientation of the second docking partner. (Only works with 2 partner docking). (Global).|Boolean|
|-search_germline_templates|Spin a second docking partner around axes from center of mass of the first partner to the second partner. (Global).|Boolean|
|-template_similarity_cutoff|Defines docking partners by chain ID for multichain docking. For example, "-partners LH\_A" moves chain A around the dimer of chains L and H.|String|
|-template_identity_cutoff|Randomize the orientation of the first docking partner. (Only works with 2 partner docking). (Global).|Boolean|
|-blastp_identity_cutoff|Randomize the orientation of the second docking partner. (Only works with 2 partner docking). (Global).|Boolean|
|-ignore_list|Spin a second docking partner around axes from center of mass of the first partner to the second partner. (Global).|Boolean|

|-num_cter_overhang_res|Randomize the orientation of the second docking partner. (Only works with 2 partner docking). (Global).|Boolean|
|-num_nter_overhang_res|Spin a second docking partner around axes from center of mass of the first partner to the second partner. (Global).|Boolean|
|-relax_model|Defines docking partners by chain ID for multichain docking. For example, "-partners LH\_A" moves chain A around the dimer of chains L and H.|String|
|-minimize_model|Randomize the orientation of the first docking partner. (Only works with 2 partner docking). (Global).|Boolean|

|-max_cycles|Spin a second docking partner around axes from center of mass of the first partner to the second partner. (Global).|Boolean|