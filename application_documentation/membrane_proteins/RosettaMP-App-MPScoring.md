# RosettaMP Applications: Score JD2 Extension

## Code and Demo
This application uses Movers from RosettaMP. The score_jd2 application can be found at `public/analysis/score_jd2.cc`. The supplement of the manuscript below also outlines its use. 

## Algorithm Description
Scoring a membrane protein with a defined score function is one of the most basic and much needed functionality. For this, we hijacked the score_jd2 application and made it (at least partly) applicable for membrane proteins. 

Rosetta Revision #58096

## Run the application

There are two modes available for this application: 

**1) Having a fixed membrane and a fixed protein.** This scores the protein as is and requires that the protein is already transformed into membrane coordinates (see [[PDB-file]] on how to do this) and currently only works if a spanfile is given, which can be generated from the transformed structure (see the MPSpanfileFromPDB application). Example flags: 

```
Rosetta/main/source/bin/score_jd2.macosclangrelease \
-database Rosetta/main/database \
-in:file:s 1AFO_tr.pdb \
-in:membrane \
-mp:setup:spanfiles 1AFO__tr.span \
-score:weights mpframework_smooth_fa_2012.wts \
```

**2) Having a fixed membrane a movable protein.** This transforms the protein into membrane coordinates first before it is scored. It does not require the protein to be transformed into membrane coordinates and works with a regular cleaned PDB file. However, it requires a spanfile as input. Example flags: 

```
Rosetta/main/source/bin/score_jd2.macosclangrelease \
-database Rosetta/main/database \
-in:file:s 1AFO.pdb \
-in:membrane \
-mp:setup:spanfiles 1AFO__tr.span \
-mp:setup:transform_into_membrane \
-score:weights mpframework_smooth_fa_2012.wts \
```

Both applications only score the protein and don't optimize the membrane position with the scorefunction! Use the flags in the next section to change settings. 
Note: Make sure your numbering between PDB file and spanfile match!

## Flags / Options

|**Flag**|**Description**|
|:-------|:--------------|
|`-mp::setup::transform_into_membrane <bool>` | Required to score membrane proteins. Add this option to transform the protein pose into the membrane.|
|`-mp::transform::optimize_embedding <bool>` | Use the scorefunction to optimize the embedding after an initial coarse grained setting.|

## Citation
Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol; 11(9).

Koehler Leman J, Mueller BK, Gray JJ (2017). Expanding the toolkit for membrane protein modeling in Rosetta. Bioinformatics; 33(5).

## Contact

Questions and comments to: 
 - Rebecca F. Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))


