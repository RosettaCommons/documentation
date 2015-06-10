## VERY INCOMPLETE - just wanted to get a few things down ##

This page is intended to be broadly useful for understanding how Rosetta scores macromolecule conformations.

## Necessary classes ##

### EnergyMethod ###

An energy method is the workhorse of scoring in Rosetta.

One EnergyMethod can map to multiple ScoreTypes.  For example, the [[hydrogen bonding EnergyMethod|hbonds]] maps to several [[score types]] including hbond_sr_bb, hbond_lr_bb, hbond_bb_sc, and hbond_sc.

EnergyMethods Hierchy
-Long range
-Short Range

##See Also

* [[Rosetta overview]]
* [[Score functions and score terms|score-types]]
* [[Additional score terms|score-types-additional]]
* [[Hydrogen bond energy term|hbonds]]
* [[Scorefunctions for noncanonical residues and molecules|NC-scorefunction-info]]
* [[Adding new score terms|new-energy-method]]