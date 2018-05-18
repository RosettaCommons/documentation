# Disulfidize
*Back to [[Mover|Movers-RosettaScripts]] page.*
## Disulfidize

Scans a protein and builds disulfides that join residues in one set of residues with those in another set. By default, non-protein, GLY, and PRO (or DPRO) residues are ignored. Residues to be joined must be min_loop residues apart in primary sequence. Potential disulfides are first identified by CB-CB distance, then by mutating the pair to CYS, forming a disulfide, and performing energy minimization.  If the energy is less than the user-specified cutoff, it is compared with a set of rotations and translations for all known disulfides.  If the "distance" resulting from this rotation and translation is less than the user-specified match_rt_limit, the pairing is considered a valid disulfide bond.

Once valid disulfides are found, they are combinatorially added. For example, if disulfides are identified between residues 3 and 16 and also between residues 23 and 50, the following configurations will be found:
1. [3,16]
2. [23,50]
3. [3,16],[23,50]

The mover is now able to place D-cysteine disulfides, beta-3-cysteine disulfides, and mixed D/L/beta-3 disulfides.

NOTES:
- This is a multiple pose mover. If non-multiple-pose-compatible movers are called AFTER this mover, only the first disulfide configuration will be returned.
- <b>By default, glycine and D/L-proline positions are ignored by this mover.</b>  This behaviour can be overridden with the ```mutate_gly=true``` or ```mutate_pro=true``` options (see below).


```xml
<Disulfidize name="(&string)" scorefxn="(&string)" set1="(&selector)" set2="(&selector)" match_rt_limit="(&float 2.0)" score_or_matchrt="(&bool false)" max_disulf_score="(&float 1.5)" min_loop="(&int 8)" use_l_cys="(&bool true)" keep_current_disulfides="(&bool false)" include_current_disulfides="(&bool false)" use_d_cys="(&bool false)" use_beta_cys=(&bool false)  mutate_gly="(&bool false)" mutate_pro="(&bool false)" />
```

- scorefxn:  Name of the scoring function to use for repacking and minimization when rebuilding disulfides.  If not specified, the default scorefunction is used.  Note that a symmetric scorefunction must be provided for symmetric poses.
- set1: Name of a residue selector which identifies a pool of residues which can connect to residues in set2.  (Default: all residues)
- set2: Name of a residue selector which identifies a pool of residues which can connect to residues in set1.  (Default: all residues)
- match_rt_limit: "distance" in 6D-space (rotation/translation) which is allowed from native disulfides.  Lower values increase the stringency of the requirement that disulfides be similar to native disulfides. (Default: 2.0).
- score_or_matchrt: If true, disulfides are accepted if they pass the match_rt (rigid-body transform) criterion OR the full-atom disulfide score criterion.  If false, disulfides must pass BOTH criteria.  False by default (both criteria must pass).
- max_disulf_score: Highest allowable per-disulfide dslf_fa13 score.  Reducing this requires that disulfide geometry be more ideal.  (Default: 1.5 )
- min_loop: Minimum distance between disulfide residues in primary sequence space.  (Default 8).
- min_disulfides: Smallest allowable number of disulfides.
- max_disulfides: Largest allowable number of disulfides.
- keep_current_disulfides:  If true, all current disulfides are preserved.  If false, existing disulfides containing a CYS residue within either set1 or set2 are mutated to alanine. Disulfides with both CYS residues outside of the union of the selected residue sets will not be affected. False by default.
- include_current_disulfides:  If true, current disulfides are included in the possible disulfide combinations to try.  False by default (only new disulfide combinations tried).
- use_l_cys: Should the mover consider placing L-cysteine?  True by default.  (Note that at least one of use_l_cys, use_d_cys, and use_beta_cys must be set to "true".)
- use_d_cys: Should the mover consider placing D-cysteine?  False by default.  (Note that at least one of use_l_cys, use_d_cys, and use_beta_cys must be set to "true".)
- use_beta_cys: Should the user consider placing beta-3-cysteine at beta-3-amino acid positions?  False by default.  (Note that at least one of use_l_cys, use_d_cys, and use_beta_cys must be set to "true".)  If alpha-cysteine is also allowed, then the mover will consider beta-beta disulfides, alpha-alpha disulfides, and alpha-beta disulfides.
- mutate_gly: Should the mover ignore glycine positions (false) or allow mutations to cysteine at these positions (true)?  Default false (ignore gly positions).
- mutate_pro: Should the mover ignore D/L-proline positions (false) or allow mutations to cysteine at these positions (true)?  Default false (ignore pro/dpr positions).

**EXAMPLE**  The following example looks for 1-3 disulfides. All found disulfide configurations are then designed using FastDesign.

```xml
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
As of 29 September 2015, the Disulfidize mover works with symmetric poses, permitting disulfides to be built across symmetric interfaces.  In this case, the min_disulfides and max_disulfides options represent the minimum and maximum number of *unique* disulfide pairs.  Note that this is, at the current time, an experimental feature that may have bugs associated with it.

##See Also

* [[DisulfideMover]]
* [[ForceDisulfidesMover]]
* [[RemodelMover]]
* [[I want to do x]]: Guide to choosing a mover
