# KeepSequenceSymmetry

This feature behaves like traditional symmetry in terms of mutations, but does not force any special geometric symmetry.
In short, it will allow any mutations that the packer task allows but will make sure that all of the chains in a single symmetric system keep the same sequence.

By default, this feature assumes that all chains are part of the same symmetric system, just like traditional symmetric.
If this is not the case for you, check out the [[SetupForSequenceSymmetry]] mover.

### Example:

This script designs a protein according to the a particular resfile, while ensuring that residues 1 and 2 (in rosetta numbering) mutate together.

```xml
<ROSETTASCRIPTS>
  <TASKOPERATIONS>
    <ReadResfile name="resfile" filename="resfile_for_my_special_dimer.res"/>
    <KeepSequenceSymmetry name="kss"/>
  </TASKOPERATIONS>
  <MOVERS>
      <PackRotamersMover name="packer" task_operations="resfile,kss"/>
  </MOVERS>
  <PROTOCOLS>
    <Add mover_name="packer"/>
  </PROTOCOLS>
</ROSETTASCRIPTS>
```

