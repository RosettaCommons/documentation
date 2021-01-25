# SetupForSequenceSymmetryMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
Page last updated 25 January 2021.

This mover does not affect packing on its own. To enforce sequence symmetry in any packing steps you must enable the **KeepSequenceSymmetry** task operation.
For more information regarding the protocol see the [[KeepSequenceSymmetry]] page.

This mover is used to define a symmetric system where you do not want/cannot define geometric symmetry.
It uses arbitrary residue selectors to define sets of residues for which sequence symmetry is to be enforced.
Linked selectors are defined in **SequenceSymmetry** subtags which take the names of previously defined residue selectors.
It is possible to use different types of residue selectors but all linked selectors must define the same number of residues.

Each **SequenceSymmetry** subtag defines a separate set of regions to maintain sequence symmetry for.
When parsed by the packer, the union of any overlapping subtags is used for specifying linked residues.
For example, linking chain A to B and then A to C in separate subtags is functionally equivalent to linking A, B, and C.

Additionally, each **SetupForSequenceSymmetryMover** must be associated with a specific **KeepSequenceSymmetry** task operation using the *sequence_symmetry_behaviour* option.

Please note, the mover uses a caching system to store linked regions once the mover has been applied. Therefore, if residues are added or removed before packing it may result in unintended behaviour.
It is recommended that users apply the **SetupForSequenceSymmetryMover** immediately before a packing step.

### Syntax
```xml
<SetupForSequenceSymmetryMover name="(&string;)" sequence_symmetry_behaviour="(&string;)" >
  <SequenceSymmetry residue_selectors="(&string)" />
  ...
</SetupForSequenceSymmetryMover>
```
* **sequence_symmetry_behaviour**: name of a previously defined KeepSequenceSymmetry task operation

Subtag **SequenceSymmetry**: a set of ResidueSelectors defining a sequence symmetric region of the protein
* **residue_selectors**: comma seperated list of previously defined ResidueSelectors.

### Example
Say you have a 7 chain protein: 2 dimers and a trimer, where you want to enforce sequence symmetry on each dimer and the trimer simultaneously:
```xml
<RESIDUE_SELECTORS>
   Dimer 1 (each monomer is comprised of a single 40 amino acid chain)
  <Index name="dimer1_a" resnums="1-40" />
  <Chain name="dimer1_b" chain="2" />

   Dimer 2
  <Chain name="dimer2_a" chain="3" />
  <Chain name="dimer2_b" chain="4" />
  
   Trimer
  <Chain name="trimer_a" chain="5" />
  <Chain name="trimer_b" chain="6" />
  <Chain name="trimer_c" chain="7" />
</RESIDUE_SELECTORS>
<TASKOPERATIONS>

  <KeepSequenceSymmetry name="keep_seq_sym" setting="true" />

</TASKOPERATIONS>
<MOVERS>

   Will link the chains for each dimer and trimer seperately
  <SetupForSequenceSymmetryMover name="setup_seq_sym" sequence_symmetry_behaviour="keep_seq_sym" >
    <SequenceSymmetry residue_selectors="dimer1_a,dimer1_b" />
    <SequenceSymmetry residue_selectors="dimer2_a,dimer2_b" />
    <SequenceSymmetry residue_selectors="trimer_a,trimer_b,trimer_c" />
  </SetupForSequenceSymmetryMover>

  <PackRotamersMover name="pack" task_operations="keep_seq_sym" />

</MOVERS>
<PROTOCOLS>
  <Add mover_name="setup_seq_sym" />
  <Add mover_name="pack" />
</PROTOCOLS>

```

### Developer Info

Introduced in PR 4260, updated in PR 5168.

## See Also

* [[SymDofMover]]
* [[SymMinMover]]
* [[SymPackRotamersMover]]
* [[MakeBundleMover]]
