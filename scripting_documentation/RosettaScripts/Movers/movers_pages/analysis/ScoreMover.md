# ScoreMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ScoreMover

This [[Mover]] applies the [[scorefunction|score-types]] to your [[pose|RosettaEncyclopedia#pose]].  Simple, but sometimes that's what you need!

```xml
<ScoreMover name="&string" scorefxn="(&string)" verbose="(&bool)"/>
```

- scorefxn: What scorefunction to calculate.  Calls ScoreFunctionFactory with an empty string by default, which is either a good default or NULL.
- verbose: boolean controls a bunch of extra output - pose.energies.show() and something called a jd2:ScoreMap

##rmsd
Note this Mover automatically looks for a native pose to RMSD against.  If it finds one, it calculates a bunch of CASP-y stuff via setPoseExtraScore: 

* rms
* allatom_rms
* maxsub
* maxsub2.0
* gdtmm
* gdtmm1_1
* gdtmm2_2
* gdtmm3_3
* gdtmm4_3
* gdtmm7_4

##loops
This mover looks for ```-loops::loopscores```.  It then runs "loops::addScoresForLoopParts" - which is guess is a slice of scores for just the loops?

##exclude_res
This mover looks for ```-evaluation::score_exclude_res``` and then will print the PoseExtraScore "select_score" of what this author assumes is the remaining residues.


##See Also

* [[I want to do x]]: Guide to choosing a mover
