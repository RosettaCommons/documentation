#HybridizeMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## HybridizeMover

Performs comparative modeling as described in detail in:  
[High-resolution comparative modeling with RosettaCM](http://www.sciencedirect.com/science/article/pii/S0969212613002979).  
Song Y, DiMaio F, Wang RY, Kim D, Miles C, Brunette T, Thompson J, Baker D.,
Structure. 2013 Oct 8;21(10):1735-42. doi:10.1016/j.str.2013.08.005. Epub 2013 Sep 12.

## Overview

The Hybridize mover samples structural combinations of multiple input models.  It is used as part of the RosettaCM comparative modelling pipeline.  For a more detailed description of its use for comparative modeling, see [[RosettaCM]].

However, the mover may also be used more generally for structural modelling; several advanced options for that purpose are shown here.

The general input format is shown here:

```xml
     <Hybridize name="&string" stage1_scorefxn="&sring" stage2_scorefxn="&string" fa_scorefxn="&string" batch="(1 &bool)">
            <Template pdb="&string" cst_file="AUTO" weight="1.000" />
            <Template pdb="&string" cst_file="AUTO" weight="1.000" />
            ...
     </Hybridize>
```

## Per-template options
* **pdb=1xxx.pdb**: (required) A PDB file corresponding to a template.  Models may be incomplete, with the _numbering_ specifying the index for each residue.  See [[RosettaCM]] for how the partial_thread app may be used to generate these inputs.
* **cst_file=AUTO**: (default AUTO) One of NONE, AUTO, or a [[Rosetta-format constraint file|constraint-file]]
* **weight=1.0**: (default 1.0) The relative sampling frequency of the given template
* **symmdef=C2.symm**: (optional) A [[symmetry]] definition file

Notice that the protocol proceeds by first selecting an initial template model, then sampling substructures from other templates.  The **weight** variable only controls that first step.  Thus, if you have very incomplete models, it is recommended to set them to weight 0: they will never be used as the starting models, but fragments from them will be recombined with other models.

## Fragment file options

Input [[fragment files|fragment-file]] may be given by adding the following tag withing the `<Hybridize ...>...</Hybridize>` block:

```xml
<Hybridize ...>
    <Fragments three_mers="t000_.200.3mers.gz" nine_mers="t000_.200.9mers.gz"/>
</Hybridize>
```

If not provided, fragments will be built automatically.

## Hybridize mover: Basic options

The following options control scoring:

* **stage1_scorefxn=score3**: (default _score3_) Scorefunction in (centroid) stage 1
* **stage2_scorefxn=score4_smooth_cart**: (default _score4_smooth_cart_) Scorefunction in (centroid) stage 2
* **fa_scorefxn=talaris2013_cart**: (default _talaris2013_cart_) Scorefunction in fullatom stage
* **fa_cst_file=fullatom.cst** (optional) If specified, use the provided constraints in fullatom rather than the centroid constraints
* **keep_pose_constraint=0** (default=0) If set to 1, keep constraints on the incoming pose (useful if constraints are generated in a mover prior to hybridize)
* **disulf_file=dslf** (optional) If specified, force the attached disulfide patterning ([[see the fix_disulf option for the format|full-options-list#run]])

The following options control the protocol flow:

* **stage1_increase_cycles=1.0**: (default 1.0) Increase/decrease sampling in stage 1
* **stage2_increase_cycles=1.0**: (default 1.0) Increase/decrease sampling in stage 2
* **stage25_increase_cycles=1.0**: (default 1.0) Increase/decrease number of minimization steps following stage 2
* **batch=1**: (default 1) The number of centroid structures to generate per fullatom model.  Setting this to 0 will only run centroid modeling.
* **stage2_temperature=2**: (default 2) _kT_ for the Monte Carlo simulation
* **realign_domains=0**: (default 1) If unset, this will not align the input domains to each other before running the protocol.  Unsetting this option requires that input domains be previously aligned to a common reference frame.  This option may be useful to unset for building models into density (if all inputs are docking into density).

The following options handle ligands:

* **add_hetatm=1**: (default 0) If set to 1, use ligands from input template files (see [[RosettaCM]] for more details)
* **hetatm_cst_weight=1** (default 1) If add_hetatm is enabled, this will set the weight on automatically generated intra-ligand restraints.
* **hetatm_to_protein_cst_weight=1** (default 0) If add_hetatm is enabled, this will set the weight on automatically generated ligand-protein restraints.

## Hybridize mover: Advanced options

More advanced options are highlighted in this section.  Note that these may be experimental, so use at your own caution!

The following options may be useful for applying hybridize iteratively:

First, to start from an extended chain, use the following template tag:

```xml
<Hybridize ...>
           <Template pdb="extended" weight="1.0" cst_file="x.cst" />
</Hybridize>
```

If all other templates have zero weight, then the protocol will always start from a single extended chain (unless the add_non_init_chunks is also specified, in which case random rigid body transformations will be taken from other templates).

For fine control of protocol behavior, control the relative weights of individual moves:
* **frag_1mer_insertion_weight=1.0** (default AUTO)
* **small_frag_insertion_weight=1.0** (default AUTO)
* **big_frag_insertion_weight=1.0** (default AUTO)
* **chunk_insertion_weight=1.0** (default AUTO)

The "AUTO" option for all of these scales the relative weights depending on input structure coverage/completeness.  So adjust these with care!

Other fine-grained protocol control options:

* **max_registry_shift=4**: (default 0) Add a random move that shifts the sequence during model-building
* **realign_domains_stage2=1**: (default 0) If set, realign domains in between the two centroid stages; default only aligns the initial models.
* **frag_weight_aligned=0.2**: (default 0) Allow fragment insertions in template regions.  The default is 0; increasing this will lead to increased model diversity.
* **max_contig_insertion=25**: (default infinite) Limits the length of "template recombination" moves.  Useful when inputs are full-length (no gaps).
* **fragprob_stage2=0.8**: (default 0.3) controls the ratio of fragment insertions versus template recombination moves
* **randfragprob_stage2=0.8**: (default 0.5) controls the number of random fragfile insertions versus 'cutpoint' insertions
* **csts_from_frags=1**: (default 0) when set, derives dihedral constraints from input fragments; you need to set 'dihedral_constraint' weight in the stages you want to use this
* **add_non_init_chunks=4**: (default 0) Normally, secondary structure chunks are used from the starting model to set the foldtree.  This option will steal chunks from other templates as well (as long as they do not overlap with current chunks); the number is the expected number of chunks (poisson distribution).  _This option is recommended when starting from an extended chain._

The **detailed controls** block allows fixing certain substructures.  It may be specified by adding the following tag withing the <Hybridize ...></Hybridize> block:

```xml
<Hybridize ...>
    <DetailedControls start_res="273" stop_res="296" sample_template="0" sample_abinitio="0" task_operations="&string"/>
</Hybridize>
```

This says that for residues 273-296, do not allow template hybridization moves (sample_template=0), and do not allow fragment insertion moves (sample_abinitio=0).  If both are set to false for a region, that region will also not minimize in centroid (note that fullatom refinement ignores these flags, however).

##See Also

* [[RosettaCM]]: Full protocol of Rosetta Comparative Modeling
* [[SimpleThreadingMover]]: Simple threading in RosettaScripts
* [[FastRelaxMover]]: The relax application
* [[Preparing structures]]: Page on preparing structures for use in Rosetta using relax.
* [[I want to do x]]: Guide to chosing a mover