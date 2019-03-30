# VLB
*Back to [[Mover|Movers-RosettaScripts]] page.*
## VLB (aka Variable Length Build)

Under development! All kudos to Andrew Ban of the Schief lab for making the Insert, delete, and rebuild segments of variable length. This mover will ONLY work with non-overlapping segments!

**IMPORTANT NOTE!!!!** : VLB uses its own internal tracking of ntrials! This allows VLB to cache fragments between ntrials, saving a very significant amount of time. But each ntrial trajectory will also get ntrials extra internal VLB apply calls. For example, "-jd2:ntrials 5" will cause a maximum of 25 VLB runs (5 for each ntrial). Success of a VLB move will break out of this internal loop, allowing the trajectory to proceed as normal.

```xml
<VLB name="(&string)" scorefxn="(string)">
    <VLB TYPES GO HERE/>
</VLB>
Default scorefxn is score4L. If you use another scorefxn, make sure the chainbreak weight is > 0. Do not use a full atom scorefxn with VLB!
```

There are several move types available to VLB, each with its own options. The most popular movers will probably be SegmentRebuild and SegmentInsert.

```

<SegmentInsert left=(&integer) right=(&integer) ss=(&string) aa=(&string) pdb=(&string) side=(&string) keep_bb_torsions=(&bool)/> 

Insert a pdb into an existing pose. To perform a pure insertion without replacing any residues within a region, use an interval with a zero as the left endpoint.
e.g. [0, insert_after_this_residue].
If inserting before the first residue the Pose then interval = [0,0].  If inserting after the last residue of the Pose then interval = [0, last_residue]. 

*ss = secondary structure specifying the flanking regions, with a character '^' specifying where the insert is to be placed. Default is L^L.
*aa = amino acids specifying the flanking regions, with a character '^' specifying insert.
*keep_bb_torsions = attempt to keep the a few torsions from around the insert. This should be false for pure insertions. (default false)
*side = specifies insertion on its N-side ("N"), C-side ("C") or decide randomly between the two (default "RANDOM"). Random is only random on parsing, not per ntrial
```

```

<SegmentRebuild left=(&integer) right=(&integer) ss=(&string) aa=(&string)/> 
Instruction to rebuild a segment. Can also be used to insert a segment, by specifying secondary structure longer than the original segment.
```

```
Very touchy. Watch out.
<SegmentSwap left=(&integer) right=(&integer) pdb=(&string)/> instruction to swap a segment with an external pdb
```

```xml
<Bridge left="(&integer)" right="(&integer)" ss="(&string)" aa="(&string)"/> connect two contiguous but disjoint sections of a
                       Pose into one continuous section
```

```xml
<ConnectRight left="(&integer)" right="(&integer)" pdb="(&string)"/> instruction to connect one PDB onto the right side of another
```

```xml
<GrowLeft pos="(&integer)" ss="(&string)" aa="(&string)"/> Use this for n-side insertions, but typically not n-terminal
            extensions unless necessary.  It does not automatically cover the
            additional residue on the right endpoint that needs to move during
            n-terminal extensions due to invalid phi torsion.  For that case,
            use the SegmentRebuild class replacing the n-terminal residue with
            desired length+1.
```

```xml
<GrowRight pos="(&integer)" ss="(&string)" aa="(&string)"/> instruction to create a c-side extension
```

For more information, see the various BuildInstructions in src/protocols/forge/build/

# Computational 'affinity maturation' movers (highly experimental)

These movers are meant to take an existing complex and improve it by subtly changing all relevant degrees of freedom while optimizing the interactions of key sidechains with the target. The basic idea is to carry out iterations of relax and design of the binder, designing a large sphere of residues around the interface (to get second/third shell effects).

We start by generating high affinity residue interactions between the design and the target. The foldtree of the design is cut such that each target residue has a cut N- and C-terminally to it, and jumps are introduced from the target protein to the target residues on the design, and then the system is allowed to relax. This produces deformed designs with high-affinity interactions to the target surface. We then use the coordinates of the target residues to generate harmonic coordinate restraints and send this to a second cycle of relax, this time without deforming the backbone of the design. Example scripts are available in demo/rosetta\_scripts/computational\_affinity\_maturation/


##See Also

* [[I want to do x]]: Guide to choosing a mover
