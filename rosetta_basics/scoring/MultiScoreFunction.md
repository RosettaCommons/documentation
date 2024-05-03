# MultiScoreFunction

## Summary

The score functions in Rosetta don't accept selectors, meaning you can't score part of a protein with one score function, and another part of it with another. `MultiScoreFunction` is what provides this functionality. All kinds of scores can be mixed and matched by `MultiScoreFunction`.

## Usage

### Rosetta scripts

Note: if you are not familiar with XML format, you can read [this page](???).

#### Example

```
<MultiScoreFunction 
    name=(string) 
    dump_pdbs=(bool,"false")>

    <SimpleCombinationRule 
        recompute_residue_subsets=(bool,"true")
        name=(string)>
    </SimpleCombinationRule>

    <SimpleElectricFieldCombinationRule 
        recompute_residue_subsets=(bool,"true") 
        mean_field_method=(string,"atoms") 
        grid_spacing=(real,"1.0") 
        grid_extension=(real,"1.0") 
        dielectric_constant=(real,"1.0")
        name=(string)>
    </SimpleElectricFieldCombinationRule>

    <Region 
        residue_selector=(string)  
        efield_residue_selector=(string) 
        scorefxn=(string)>

        <SimpleBondResolutionRule name=(string)>
        </SimpleBondResolutionRule>

        <CappedBondResolutionRule 
            peptide_nterm_cap=(string,"acetyl") 
            peptide_cterm_cap=(string,"methylamide")   
            thiol_cap=(string,"sulfhydryl") 
            other_cap=(string,"methyl") 
            name=(string)>
        </CappedBondResolutionRule>
    </Region>

</MultiScoreFunction>
```
Line by line code description:

|code|description|Accepted argumetns|
|----|-----------|------------------|
|`MultiScoreFunction`|||
|`name=(string)`|A unique identifier given to this MultiScoreFunction for use in RosettaScripts.|any string. e.g. "a_cup_of_coffee"|
|`dump_pdbs=(bool,"false")`|If true, a timestamped PDB file is dumped for each region whenever this scoring function is used to score. Note: FOR DEBUGGING ONLY. This is very expensive, and produces a great deal of disk output, when used in a production run!  It can also be dangerous when used with MPI or multi-threaded parallel processing, since parallel processes or threads may try to write to disk simultaneously.  False by default.|"false", "true"|
|`SimpleCombinationRule`|This is a subtag that specifies Russian doll behaviour.  The region selected by the first residue selector is scored with the first scoring function. The second scoring function is applied to the union of the regions selected by the first and second residue selectors, and then to the residues selected by the first; the energy of the latter is subtracted from the former.  The Nth scoring function is applied to the union fo the regions selected by the first N residue selectors, and then to the union of the first N-1 residue selectors; the energy of the latter is subtracted from the former.  The final energy is the sum of all of these differences.||
|`recompute_residue_subsets=(bool,"true")`|If true, then every time the multiscorefunction containing this combination rule is applied to a Pose, the residue subset of the region is recomputed. If false, then the first computed residue subset is used throughout. For example, if you are performing a proten-ligand interaction energy calculation using the a multiscorefunction, and if your multiscorefunction uses a residue selector built from a distance-based cutoff from the ligand its neighboring residues, then this flag will have potentially undesired behavior. In an interaction energy calculation, the energy is computed twice: once for the complex and again when the protein and ligandare separated in space. When set to true (default), the residue selector separately is applied to the Pose to determine the residues in the region. This means that the residue subsets composing that region will differ between the complexed and the separated energy calculations. In contrast, if this flag is false, then the initial residue subset created from the complex will be recycled for the energy calculation of the separated protein and ligand. Alternatively, if you use an Index residue selector to partition your scoring regions, then this flag will have no impact on the final result because the regions will be determined the same either way. CRITICAL NOTE regarding thread safety - if this flag is false, then the cached data member corresponding to the residue subsets needs to be updated, which means that if multiple threads are using this same object there will be data racing. Please consider your workflow carefully.|"false","true"|
|`name=(string)`|The name given to this instance.|any string|
|`SimpleElectricFieldCombinationRule`| This is a subtag that specifies Russian doll behaviour (i.e., ONION-style scoring) much like SimpleCombinationRule. In addition, this combination rule will apply an electric field to a region based on that region's 'efield_residue_selector', which specifies a collection residues whose Rosetta partial charges will be used to compute a uniform field toward the center of mass of the region. The electric field only has an effect for QM energy functions. If not specified, then the entire region outside of the QM region being polarizes will be used to create the electric field.  (Note also that due to GAMESS limitations, the computes electric field from outer regions is uniform, not spatially varying.)||
|`recompute_residue_subsets="true"`|If true, then every time the multiscorefunction containing this combination rule is applied to a Pose, the residue subset of the region is recomputed. If false, then the first computed residue subset is used throughout. For example, if you are performing a proten-ligand interaction energy calculation using the a multiscorefunction, and if your multiscorefunction uses a residue selector built from a distance-based cutoff from the ligand its neighboring residues, then this flag will have potentially undesired behavior. In an interaction energy calculation, the energy is computed twice: once for the complex and again when the protein and ligand are separated in space. When set to true (default), the residue selector separately is applied to the Pose to determine the residues in the region. This means that the residue subsets composing that region will differ between the complexed and the separated energy calculations. In contrast, if this flag is false, then the initial residue subset created from the complex will be recycled for the energy calculation of the separated protein and ligand. Alternatively, if you use an Index residue selector to partition your scoring regions, then this flag will have no impact on the final result because the regions will be determined the same either way. CRITICAL NOTE regarding thread safety - if this flag is false, then the cached data member corresponding to the residue subsets needs to be updated, which means that if multiple threads are using this same object there will be data racing. Please consider your workflow carefully.|"false","true"|
|`mean_field_method="atoms"`|The method used to compute the mean field.|"grid" : compute mean field by averaging the field at a grid of points , "atoms" (default): compute the mean field by averaging the field at points in the region|
|`grid_spacing="1.0"`|If the mean field method is 'grid', this is the grid spacing, in Angstroms. Note: the number of points will increase in cubes, as this applies to three dimensions in space.|Any positive real number. Default is 1.0|
|`grid_extension="1.0"`|If the mean field method is 'grid', this is the grid extension (padding beyond the atoms of the target region), in Angstroms.|Any positive real number. Default is 1.0|
|`dielectric_constant="1.0"`|The dielectric constant to use when computing the mean electric field.  Other values to consider are 3.23 for proteins (see [this reference](https://doi.org/10.48550/arXiv.2001.07053), 78.4 for water, or the Rosetta values of 4 for protein and 80 for water.  At some point in the future, support for Rosetta-style distance-dependent dielectric functions may be added.|Any positive real number. Default is 1.0 (vacuum electrostatics)|
|`name (string)`|The name given to this instance.|any string|
|`Region`|This is a subtag which Defines a region of a pose to score with a particular scorefunction in the context of a multiscorefunction.||
|`residue_selector="<selector-name>"`|The residue selector defining this region to be scored.|The name of a previously declared residue selector or a logical expression of AND, NOT (!), OR, parentheses, and the names of previously declared residue selectors. Any capitalization of AND, NOT, and OR is accepted. An exclamation mark can be used instead of NOT. Boolean operators have their traditional priorities: NOT then AND then OR. For example, if selectors s1, s2, and s3 have been declared, you cou
ld write: 's1 or s2 and not s3' which would select a particular residue if that residue were selected by s1 or if it were selected by s2 but not by s3.|
|`efield_residue_selector="<selector-name>"`|The residue selector producing an electric field to be felt by this region.|same as above|
|`scorefxn=<scorefxn-name>`|The scoring function to use to score this region.||
|`SimpleBondResolutionRule`|This is a subtag that essentially says to do nothing.  Severed bonds are left open, with no capping groups or other modifications.  This bond resolution rule has no parameters that can be set.||
|`name="<name>"`|The name given to this instance.|any string|
|`CappedBondResolutionRule`|This is a subtag that allows chemical capping groups to be added to severed bonds in sub-regions of poses when scored with a MultiScoreFunction.||
|`peptide_nterm_cap="acetyl"`|The type of capping group to add to peptide bonds that are open at the N-terminus.|"leave_open", "hydrogen", "acetyl" (default), "methyl"|
|`peptide_cterm_cap="methylamide"`|The type of capping group to add to peptide bonds that are open at the C-terminus.|"leave_open", "hydrogen", "methylamide" (default)|
|`thiol_cap="sulfhydryl"`|The type of capping group to add to disulfide bond forming groups that have an open bond.|"leave_open", "sulfhydryl" (default)|
|`other_cap="leave_open"`|The type of capping group to add to other open bonds.|For now only "leave_open" is allowed|
|`name="<name>"`|The name given to this instance.|any string|

## Detailed control

