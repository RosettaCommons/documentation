#Score Function Options

Here is a list of Score Function options

```
-score:weights              Name of weights file (without extension .wts)
                            Default="standard". [String]
-score:patch                Name of patch file (without extension)
                            Default="". [String]
-score:empty                Make an empty score - i.e. NO scoring. [Boolean]
-score:fa_max_dis           How far does the FA pair potential go out to.
                            Default = '6.0'. [Real]
-score:fa_Hatr              Turn on Lennard Jones attractive term for hydrogen 
                            atoms. [Boolean]
-score:no_smooth_etables    Revert to old style etables. [Boolean]
-score:etable_lr            Lowers energy well at 6.5A. [Real]
-score:input_etables        Read etables from files with given prefix. [String]
-score:output_etables       Write out etables to files with given prefix. [String]
-score:rms_target           Target of RMS optimization for RMS_Energy EnergyMethod' 
                            Default='0.0' [Real]
-score:ramaneighbors        Uses neighbor-dependent ramachandran maps
                            Default='false' [Boolean]
-score:optH_weights         Name of weights file (without extension .wts) to use 
                            during optH. [String]
-score:optH_patch           Name of weights file (without extension .wts) to use 
                            during optH. [String]
```
