#SegmentedAtomPairConstraintGenerator
[[include:constraint_generator_SegmentedAtomPairConstraintGenerator_complex_type]]

Provided a **ResidueSelector** with multiple non-contiguous regions, it will create _AtomPairConstraints_ with different parameters for those residues inside a given _ResidueRange_ and those form different _ResidueRange_.

# Example

```xml
<RESIDUE_SELECTORS>
    <SecondaryStructureSelector name="sheet" ss="H" use_dssp="1" />
</RESIDUE_SELECTORS>
<MOVERS>
    <AddConstraints name="add_csts" >
        <SegmentedAtomPairConstraintGenerator name="gen_my_csts" residue_selector="sheet">
           <Inner min_seq_sep="2" />
           <Outer use_harmonic="true" unweighted="true" />
        </SegmentedAtomPairConstraintGenerator>
    </AddConstraints>
    <RemoveConstraints name="rm_csts" constraint_generators="gen_my_csts" />
</MOVERS>
<PROTOCOLS>
    <Add mover="add_csts" />
    <!-- do things with constraints -->
    <Add mover="rm_csts" />
</PROTOCOLS>
```

This example will create SCALARWEIGHTEDFUNC SOG AtomPairConstraints between all the non-contiguous residues belong of each alpha helix and HARMONIC AtomPairConstraints between the residues of different alpha helices.
