# LoopCreationMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## LoopCreationMover

(This is a devel Mover and not available in released versions.)

For a more common and public way of creating loops, use Remodel.  Here is a link to the tutorial:
https://www.rosettacommons.org/demos/latest/tutorials/loop_modeling/loop_modeling#modeling-missing-loops

There is also a `LoopBuilderMover`, documentation of which can be found here: [[LoopBuilderMover]]

**!!!!WARNING!!!!!** This code is under very active development and is subject to change

Build loops to connect elements of protein structure. Protocol is broken into two independent steps - addition of loop residues to the pose, followed by closing the loop. These tasks are performed by LoopInserter and LoopCloser respectively (both are mover subclasses).

 **LOOP INSERTERS**

LoopInserters are responsible for building loops between residues loop\_anchor and loop\_anchor+1

-   LoophashLoopInserter

    ```xml
    <LoophashLoopInserter name=(&string) loop_anchor=(&integer) loop_sizes=(&integer) modify_flanking_regions=(1/0) />
    ```

    -   loop\_anchor: Starting residue number for loop inserter, for example with 'loop\_anchor=18', it will insert loops between loop\_anchor (=18) and loop\_anchor+1 (=19). Multiple loop\_anchors are possible like 'loop\_anchor=18, 35, 67', when there are 3 gaps. Residue numbers will be automatically renumbered as the mover runs.
    -   loop\_sizes: Size of newly added loop, for example with 'loop\_sizes=2,3,4,5', it will add loops of size 2\~5
    -   max\_torsion\_rms: Maximum torsion rmsd for the pre and post-loop segments comparison between old and new (use generous amount to allow the non-anchor side to be left open wide. ex. 100)
    -   min\_torsion\_rms: Minimum torsion rmsd for the pre and post-loop segments comparison between old and new
    -   modify\_flanking\_regions: If "modify\_flanking\_regions=1", apply the torsions of the loophash fragment to residue lh\_fragment\_begin in the pose (default is 0 which applies the torsions of the loophash fragment to residue loop\_anchor()+1 in the pose).
    -   num\_flanking\_residues\_to\_match: Number of residues before and after the loop to be built to calculate geometric compatibility (default=3).
    -   max\_lh\_radius: Maximum radius whithin which loophash segments are looked for

-   FragmentLoopInserter: Attempt to find single fragments that have ends with low-rmsd to the flanking residues of the loop to build.

    ```xml
    <FragmentLoopInserter name=(&string) loop_anchor=(&int)/>
    ```

 **LOOP CLOSERS**

LoopClosers are responsible for closing the recently build loops. These are just wrappers of common loop closure algorithms (i.e. KIC and CCD) built into the LoopCloser interface (as of 04/18/2013, CCD is recommended for this application).

-   CCDLoopCloser - Use CCD to close recently built loop

    ```xml
    <CCDLoopCloser name=(&string) />
    ```

    -   max\_ccd\_moves\_per\_closure\_attempt: Maximum ccd moves per closure attempt (usually max\_ccd\_moves\_per\_closure\_attempt=10000 is enough).
    -   max\_closure\_attempts: Maximum number of attempts to close. Obviously high number like 100 would increase successful closing probability.

 **LOOP CREATION MOVER**

-   LoopCreationMover

    ```xml
    <LoopCreationMover name=(&string) loop_closer=(&LoopCloser name) loop_inserter=(&LoopInserter name) />
    ```

    -   attempts\_per\_anchor: If 'attempts\_per\_anchor=10', it attempts to close per anchor 10 times. (recommended to use but attempts\_per\_anchor=0 by default)
    -   dump\_pdbs: If "dump\_pdbs=1", dump pdbs during after each addition residues, refinement, and closing of the loop
    -   filter\_by\_lam (filter by loop analyzer mover): If "filter\_by\_lam=1", filter out undesirable loops by [total\_loop\_score=rama+omega+peptide\_bond+chainbreak (by this loop) \<= lam\_score\_cutoff\_ (= 0 by default)]. (recommended to use but filter\_by\_lam=0 by default)
    -   include\_neighbors: If "include\_neighbors=1", include loop neighbors in packing/redesign, then calculate them
    -   loop\_closer: A name of loop\_closer, for example with 'loop\_closer=ccd', it uses \<CCDLoopCloser name=ccd/\>
    -   loop\_inserter: A name of loop\_inserter, for example with 'loop\_inserter =lh', it uses \<LoophashLoopInserter name=lh/\>

 *ResourceManager*

With loop\_sizes=2,3,4,5, in loop inserter, loop\_sizes in ResourceOptions should be 8,9,10,11 (since LOOP CREATION MOVER uses 3 (default) residue forward and 3 residues backward additionally to calculate geometric compatibility).

```xml
<JD2ResourceManagerJobInputter>
        <ResourceOptions>
                <LoopHashLibraryOptions tag="lh_lib_options" loop_sizes="8,9,10,11"/>
        </ResourceOptions>
...
</JD2ResourceManagerJobInputter>
```


##See Also

* [[RosettaScriptsLoopModeling]]
* [[Loopmodel application|loopmodel]]
* [[Loop file format|loops-file]]
* [[Fragments file format|fragment-file]]
* [[Resource Manager documentation|ResourceManager]]
* [[LoopBuilderMover]]
* [[LoopCreationMover]]
* [[LoopFinderMover]]
* [[LoopLengthChangeMover]]
* [[LoopModelerMover]]
* [[LoopMoverFromCommandLineMover]]
* [[LoopProtocolMover]]
* [[LoopRemodelMover]]
