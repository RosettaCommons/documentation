#Score Function Options

Here is a list of Score Function options

```
-score:weights                             Name of weights file (without extension .wts)
                                           Default="talaris2013". [String]
-score:patch                               Name of patch file (without extension)
                                           Default="". [String]
-score:set_weights                         Modification to weights via the command line. 
                                           List of paired strings: -score::set_weights <score_type1> <setting1>         
                                           <score_type2> <setting2> ...
-score:empty                               Make an empty score - i.e. NO scoring. [Boolean]
-score:fa_max_dis                          How far does the FA pair potential go out to.
                                           Default = '6.0'. [Real]
-score:fa_Hatr                             Turn on Lennard Jones attractive term for hydrogen 
                                           atoms. [Boolean]
-score:no_smooth_etables                   Revert to old style etables. [Boolean]
-score:etable_lr                           Lowers energy well at 6.5A. [Real]
-score:input_etables                       Read etables from files with given prefix. [String]
-score:output_etables                      Write out etables to files with given prefix. [String]
-score:rms_target                          Target of RMS optimization for RMS_Energy EnergyMethod' 
                                           Default='0.0' [Real]
-score:ramaneighbors                       Uses neighbor-dependent ramachandran maps
                                           Default='false' [Boolean]
-score:symmetric_gly_tables                Use a symmetric version of the Ramachandran and p_aa_pp tables for glycine
                                           when sampling or scoring.  Useful for sampling or scoring glycine in the
                                           context of a mixed D/L amino acid peptide.  As of 23 February 2016, this
                                           flag also symmetrizes the RamaPrePro tables for glycine.  Default='false'
                                           [Boolean]
-score:optH_weights                        Name of weights file (without extension .wts) to use 
                                           during optH. [String]
-score:optH_patch                          Name of weights file (without extension .wts) to use 
                                           during optH. [String]
-score:hbond_bb_per_residue_energy         In score tables, separate backbone hydrogens bond energies per residue. 
                                           (By default, bb hbonds are included in the total energy, but not per residue                    
                                           energies. Note that this may lead to a slowdown in packing) [Boolean]
```

##See Also

* [Scoring Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/scoring/scoring)
* [[Options overview]]: Description of options in Rosetta
* [[Full options list]]
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Scoring explained]]
* [[Units in Rosetta]]: Gives a description of Rosetta energy units
* [[Additional score terms|score-types-additional]]
* [[Score functions and score terms|score-types]]
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications