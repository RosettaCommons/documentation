## Metadata

Questions and comments to: 
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Rebecca F. Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Updated: 3/17/15

## Algorithm Description
Scoring a membrane protein pose with a defined score function is one of the most basic and much needed functionality. For this, we hijacked the score_jd2 application and made it (at least partly) applicable for membrane proteins. 

## Code and Demo
This application uses Movers from RosettaMP. The score_jd2 application can be found at `public/analysis/score_jd2.cc`. The supplement of the above manuscript also outlines its use. 

## Run the application

There are two modes available for this application: 

**1) Having a fixed membrane and a fixed protein.** This requires the protein structure already be transformed into membrane coordinates (see [[PDB-file]] on how to do this) and currently only works if a spanfile is given, which can be generated from the transformed structure (see XXX). Example flags: 

```
Rosetta/main/source/bin/score_jd2.macosclangrelease \
-database Rosetta/main/database \
-in:file:s 1AFO_tr.pdb \
-in:membrane \
-mp:setup:spanfiles 1AFO__tr.span \
-score:weights mpframework_smooth_fa_2012.wts \
```

**2) Having a fixed membrane a movable protein.** This does not require the protein to be transformed into membrane coordinates and works with a regular cleaned PDB file. However, it requires a spanfile as input. Example flags: 

```
Rosetta/main/source/bin/score_jd2.macosclangrelease \
-database Rosetta/main/database \
-in:file:s 1AFO.pdb \
-in:membrane \
-mp:setup:spanfiles 1AFO__tr.span \
-mp:setup:transform_into_membrane \
-score:weights mpframework_smooth_fa_2012.wts \
```

Both applications only score the protein and don't optimize the membrane position!
Note: Make sure your numbering between PDB file and spanfile match!

## Reference

Alford RF, Koehler Leman J, Weitzner BD, Duran AM, Elazar A, Tilley DC, Gray JJ (2015)
An integrated framework advancing membrane protein modeling and design,
PLoS Computational Biology (under revision) 
