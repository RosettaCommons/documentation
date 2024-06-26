<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Mover to generate backbones for de novo design

```xml
<FoldArchitect name="(&string;)" build_overlap="(&non_negative_integer;)"
        start_segments="(&string;)" stop_segments="(&string;)"
        iterations_per_phase="(&non_negative_integer;)" dump_pdbs="(&bool;)"
        debug="(&bool;)" >
    <DenovoArchitect pairings Tags ... />
    <RemodelLoopMoverPoseFolder scorefxn="(&string;)" />
    <RandomTorsionPoseFolder />
    <NullPoseFolder />
    <Perturber Tag ... />
    <PreFoldMovers name="(&string;)" >
        <Add mover="(&string;)" />
    </PreFoldMovers>
    <PostFoldMovers name="(&string;)" >
        <Add mover="(&string;)" />
    </PostFoldMovers>
    <Filters name="(&string;)" >
        <Add filter="(&string;)" />
    </Filters>
</FoldArchitect>
```

-   **build_overlap**: Overlap to use when building loops
-   **start_segments**: Set names of segments to include in the first build phase
-   **stop_segments**: Set names of segments to be included in the final build phase
-   **iterations_per_phase**: Number of iterations per build phase
-   **dump_pdbs**: Dump output to PDB files?
-   **debug**: Dump debugging PDBs?


"DenovoArchitect pairings Tags": Any of the [[DenovoArchitects|BuildDeNovoBackboneMover]]

Subtag **RemodelLoopMoverPoseFolder**:   Folds residues in a pose using RemodelLoopMover

-   **scorefxn**: Name of score function to use

"Perturber Tag": Any of the [[CompoundPerturbers|BuildDeNovoBackboneMover]]

Subtag **PreFoldMovers**:   Prefold protocol



Subtag **Add**:   

-   **mover**: (REQUIRED) Mover to add to this step step

Subtag **PostFoldMovers**:   Postfold protocol



Subtag **Add**:   

-   **mover**: (REQUIRED) Mover to add to this step step

Subtag **Filters**:   Filters to apply to generated backbones



Subtag **Add**:   

-   **filter**: (REQUIRED) Filter to add

---
