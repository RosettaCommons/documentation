#Torsional Potential Corrections

Metadata
========

Author: Patrick Conway and Frank DiMaio

Code
====

The torsional potential correction application lives in Rosetta/main/source/src/apps/public/weight\_optimization/torsional_potential_correction.cc.

References
==========

PT Conway, F DiMaio (2016). Improving hybrid statistical and physical forcefields through local structure enumeration.  _Protein Science._

Purpose
=======

The tool is intended to make corrections to the Rosetta sidechain torsional potential [[fa_dun | score-types]], canceling out portions of the distribution accounted for by other terms.  This tool was used to generate corrections for [[talaris2014 | score-types]], described below.

Using the corrected talaris2014 terms
=====================================

Corrections have been included in the most recent Rosetta versions, and are accessed by providing the flags:
```
-dun10_dir rotamer/corrections_conway2016 
-score::weights corrections_conway2016.wts
```

Or in RosettaScripts:
```
<SCOREFXNS>
    <fa weights=corrections_conway2016\>
</SCOREFXNS>
```

Applying corrections to a custom scorefunction
==============================================

The corrections proceed in a three-step process: 1) build a fragment library from a large library of structures; 2) score each of these fragments using a target scorefunction (for which corrections are desired); 3) apply these corrections, writing a new sidechain torsional library.  All three steps are carried out by the app, using the **-mode** flag to specify which step is desired.

### 1) build a fragment library from a large library of structures

The following command carries out this step:
```
$ROSHOME/source/bin/torsional_potential_corrections.default.linuxgccrelease \
    -mode makefrags \
    -fragfile fragments.out \
    -l infilelist \
    -cluster_radius 0.1 \
    -ignore_unrecognized_res
```

Inputs:

**-l infilelist**

A list of PDB files from which to grab fragments.  For the talaris2014 corrections, the Richardson 8000 set was used.

**-cluster_radius 0.1**

The cluster radius for fragment clustering.

Outputs:

**-fragfile fragments.out**

A silent file containing the individual fragments (to be used as input for subsequent steps).

### 2) scoring these fragments with the target scorefunction

```
$ROSHOME/source/bin/torsional_potential_corrections.default.linuxgccrelease \
   -mode calcscores \
   -fragfile fragments.out \
   -scorefile scores.out \
   -rotmin true \
   -score::weights talaris2014.wts
```

Inputs:

**-fragfile fragments.out**

The output of step 1

**-rotmin true**

A flag determining whether or not minimization of each rotamer should be applied.  Slower but more accurate.

Outputs:

**-scorefile scores.out**

A text file containing the individual fragment scores (to be used as input for the final step).

**Note:** This step is very time consuming; it is recommended to run this on many processors, by generating multiple fragment libraries in step one and running this step in parallel on the libraries.  The resulting score files may then be concatenated together.


### 3) apply the corrections and write a new torsional library
```
$ROSHOME/source/bin/torsional_potential_corrections.default.linuxgccrelease  \
    -mode correctdun \
    -scorefile scores.out \
    -smoothing 10 \
    -cap 3.0 \
    -scale 0.65
```

Inputs:

**-scorefile scores.out**

The scorefile from the previous step.

**-smoothing 10**

How much to smooth the corrections (degrees)

**-cap 3.0**

The energy magnitude cap of the corrections.

**-scale 0.65**

Scale the resulting corrections by 1/(this value).

Outputs:

A set of rotamer libraries following the corrections.  These may be placed in a folder in the database and be specified with the flag -dun10_dir (the non-bb dependent libraries will need to be copied from database/rotamer/ExtendedOpt1-5).

**Note:** The values for -smoothing, -cap, and -scale are very specific to the particular scorefunction undergoing correction.  The values shown were used in correcting talaris2014, and they are probably a good starting point for other optimizations.  Still, it is important to explore these parameters somewhat when applying this to a new energy function.
 
## See Also

* [[Utility applications | utilities-applications]]: other utility applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.