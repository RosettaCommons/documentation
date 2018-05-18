# BackboneGridSampler
*Back to [[Mover|Movers-RosettaScripts]] page.*
## BackboneGridSampler

Generates a chain of identical residues and samples sets of mainchain torsion values, setting all residues to have the same set of mainchain torsion values.  This is useful for identifying secondary structures (particularly internally hydrogen-bonded, helical secondary structures) of novel heteropolymers.  Note that this mover discards any input geometry.
<br/><b>Update (15 May 2015):</b>  The BackboneGridSampler can now sample repeating backbone conformations in which the repeat unit consists of more than one residue.  This can be useful for sampling conformations of mixtures of different building block types -- <i>e.g.</i>D-L-L-D-L-L chains, or alpha-beta-alpha-beta, or whatnot.

```xml
<BackboneGridSampler name="(&string)" residues_per_repeat="(1 &int)" (residue_name="('ALA' &string)" OR residue_name_1="('ALA' &string)" residue_name_2="('ALA', &string)", etc.) scorefxn="(&string)" max_samples="(10000 &int)" selection_type="('low' &string)" pre_scoring_mover="(&string)" pre_scoring_filter="(&string)" dump_pdbs="(false &bool)" pdb_prefix="('bgs_out' &string)" nstruct_mode="(false &bool)" nstruct_repeats="(1 &int)" (residue_count="(12 &int)" OR repeat_count="(12 &int)") cap_ends="(false &bool)">
     <MainchainTorsion res_index="(1 &int)" index="(&int)" (value="(&Real)" | start="(&Real)" end="(&Real)" samples="(&int)" />
     <MainchainTorsion ... />
     <MainchainTorsion ... />
</BackboneGridSampler>
```

Options for this mover include:
-  **residues_per_repeat**:  The number of residues making up the repeating unit in the helix.  Default 1.
-  **residue_name**:  The residue type that the polymer will be built from.  Default alanine.  Note that if **residues_per_repeat** is set to a number greater than 1, the user must specify **residue_name_1**, **residue_name_2**, <i>etc.</i> for each residue in the repeating unit.
-  **scorefxn**:  The scoring function used to pick the lowest-energy conformation (or highest-energy, if selection_type="high").  Required option.
-  **max_samples**:  The maximum number of grid-points sampled.  If the total number of grid-points exceeds this number, an error will be thrown and Rosetta will terminate.  This is to prevent unrealistically vast grids from being attempted inadvertently, though the user can always raise this number to allow larger grids to be sampled.
-  **selection_type**:  This is "low" by default, meaning that the lowest-energy conformation sampled (that passes pre-scoring movers and filters) will be the output pose.  Setting this to "high" results in the highest-energy conformation being selected.
-  **pre_scoring_mover**:  An optional mover that can be applied to the sampled poses before they are scored.  Sidechain-packing movers can be useful, here.  Mover exit status is respected, and failed movers result in discarded samples.
-  **pre_scoring_filter**:  An optional filter that can be applied to the sampled poses before they are scored.  Failed poses are discarded, and will not be selected even if they are the lowest in energy.
-  **dump_pdbs**:  If true, a PDB file is written for every conformation sampled that passes pre-scoring movers and filters.  False by default.
-  **pdb_prefix**:  If dump_pdbs is true, this is the prefix for the PDB files that are written.  A number is appended.  The default is for the prefix to be "bgs_out" (i.e. so that the PDB files are "bgs_out_0001.pdb", "bgs_out_0002.pdb", etc.).
-  **nstruct_mode**:  If true, then each job samples a different set of mainchain torsion values (with just one set of mainchain torsion values sampled per job).  This is useful for automatically splitting the sampling over many processors (assuming the MPI compilation of rosetta_scripts, which automatically splits jobs over processors, is used).  False by default, which means that every job samples every set of mainchain torsion values.
-  **nstruct_repeats**:  If set to a value N greater than 1, N consecutive jobs will sample the same set of mainchain torsion values.  This is useful for repeat sampling -- if, for example, you want to apply a stochastic mover to each grid-point sampled.
-  **residue_count** or **repeat_count**:  The number of repeating units in the generated chain.  If **residues_per_repeat** is set to 1, then either **residue_count** or **repeat_count** may be used synonymously.  If **residues_per_repeat** is greater than 1, then **repeat_count** must be used.  Twelve (12) by default.
-  **cap_ends**:  If true, the lower terminus is acetylated and the upper terminus is aminomethylated.  This can be a good idea for backbones linked by peptide bonds, to avoid charges at the ends of the helix.  False by default.

**MainchainTorsion** blocks are used to define mainchain torsions to sample, or to hold fixed.  If a mainchain torsion is not specified, it is held fixed at its default value (based on the residue params file).  Each **MainchainTorsion** tag has the following options:

-  **res_index**:  The index of the residue in the repeating unit (1, 2, 3, etc.).  This defaults to 1, and need not be specified if there is only 1 residue per repeating unit.
-  **index**:  The index of the mainchain torsion in the specified residue.  (e.g.  For alpha-amino acids, **index=1** is phi, **index=2** is psi, **index=3** is omega).
-  **value**:  A fixed value to which this mainchain torsion should be set.  This prevents sampling, and cannot be used in conjunction with the **start**, **end**, or **samples** options.
-  **start**:  The start value of a range to be sampled.  Cannot be used in conjunction with the **value** option.
-  **end**:  The end value of a range to be sampled.  Cannot be used in conjunction with the **value** option.
-  **samples**:  The number of samples within a range to be sampled.  Cannot be used in conjunction with the **value** option.  The total number of samples will be the product of all of the **samples** options.


##See Also

* [[I want to do x]]: Guide to choosing a mover
* [[BundleGridSamplerMover]]
* [[SmallMover]]
* [[ShearMover]]
