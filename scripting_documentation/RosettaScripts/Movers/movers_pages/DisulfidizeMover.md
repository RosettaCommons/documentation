# Disulfidize
*Back to [[Mover|Movers-RosettaScripts]] page.*
## Disulfidize

Scans a protein and builds disulfides that join residues in one set of residues with those in another set. Non-protein and GLY residues are ignored. Residues to be joined must be min_loop residues apart in primary sequence. Potential disulfides are first identified by CB-CB distance, then by mutating the pair to CYS, forming a disulfide, and performing energy minimization.  If the energy is less than the user-specified cutoff, it is compared with a set of rotations and translations for all known disulfides.  If the "distance" resulting from this rotation and translation is less than the user-specified match_rt_limit, the pairing is considered a valid disulfide bond.

Once valid disulfides are found, they are combinatorially added. For example, if disulfides are identified between residues 3 and 16 and also between residues 23 and 50, the following configurations will be found:
1. [3,16]
2. [23,50]
3. [3,16],[23,50]

The mover is now able to place D-cysteine disulfides and mixed D/L disulfides.

NOTE: This is a multiple pose mover. If non-multiple-pose-compatible movers are called AFTER this mover, only the first disulfide configuration will be returned.

```
<Disulfidize name=(&string) scorefxn=(&string) set1=(&selector) set2=(&selector) match_rt_limit=(&float) score_or_matchrt=(&bool true) max_disulf_score=(&float) min_loop=(&int) use_l_cys=(&bool true) keep_current_disulfides=(&bool false) include_current_disulfides=(&bool false) use_d_cys=(&bool false) />
```

- scorefxn:  Name of the scoring function to use for repacking and minimization when rebuilding disulfides.  If not specified, the default scorefunction is used.  Note that a symmetric scorefunction must be provided for symmetric poses.
- set1: Name of a residue selector which identifies a pool of residues which can connect to residues in set2 (default: all residues)
- set2: Name of a residue selector which identifies a pool of residues which can connect to residues in set1 (default: all residues)
- match_rt_limit: "distance" in 6D-space (rotation/translation) which is allowed from native disulfides (default: 1.0)
- score_or_matchrt: If true, disulfides are accepted if they pass the match_rt (rigid-body transform) criterion OR the full-atom disulfide score criterion.  If false, disulfides must pass BOTH criteria.  True by default (one criterion or the other must pass).
- max_disulf_score: Highest allowable per-disulfide dslf_fa13 score (default: -0.25 )
- min_loop: Minimum distance between disulfide residues in primary sequence space
- min_disulfides: Smallest allowable number of disulfides
- max_disulfides: Largest allowable number of disulfides
- keep_current_disulfides:  If true, current disulfides are preserved.  If false, they are mutated to alanine.  False by default.
- include_current_disulfides:  If true, current disulfides are included in the possible disulfide combinations to try.  False by default (only new disulfide combinations tried).
- use_l_cys: Should the mover consider placing L-cysteine?  True by default.
- use_d_cys: Should the mover consider placing D-cysteine?  False by default.  (Note that at least one of use_l_cys and use_d_cys must be set to "true".)

**EXAMPLE**  The following example looks for 1-3 disulfides. All found disulfide configurations are then designed using FastDesign.

```
<Disulfidize name="disulf" min_disulfides="1" max_disulfides="3" max_disulf_score="0.3" min_loop="6" />
<MultiplePoseMover name="multi_fastdes" >
	<ROSETTASCRIPTS>
		<MOVERS>
			<FastDesign name="fastdes" />
		</MOVERS>
		<PROTOCOLS>
			<Add mover="fastdes" />
		</PROTOCOLS>
	</ROSETTASCRIPTS>
</MultiplePoseMover>
```

##Disulfidize with symmetry
As of 29 September 2015, the Disulfidize mover works with symmetric poses, permitting disulfides to be built across symmetric interfaces.  Note that this is, at the current time, an experimental feature that may have bugs associated with it.

##See Also

* [[DisulfideMover]]
* [[ForceDisulfidesMover]]
* [[RemodelMover]]
* [[I want to do x]]: Guide to choosing a mover
