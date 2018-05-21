# RosettaMP Application: Transform into membrane coordinates (mp_transform)

## Code and Demo
The application can be found in `Rosetta/main/source/src/apps/public/membrane/mp_transform.cc` 

An integration test can be found in `Rosetta/main/tests/integration/tests/mp_transform`

Rosetta Revision #58069

## Background

For applications based on RosettaMP to work properly, the protein needs to be transformed into the membrane coordinate frame, i.e. we need to tell Rosetta where around your protein the membrane is located. This is done by attaching a membrane residue to the protein with a center point and normal vector defining the membrane center and normal. The mp_transform application uses the information provided in the spanfile to compute a protein embedding in the membrane. This is done by computing the center and normal vectors for each span from the start and end CA coodinates of the span and then averaging over them. The protein is transformed (i.e. moved) into a fixed membrane with the membrane center at (0, 0, 0) and the membrane normal at (0, 0, 1). In this application, the protein embedding in the membrane is NOT optimized using the scorefunction.

## Run the application

This application requires a spanfile as input and can be run with the following commandline: 

```
Rosetta/main/source/bin/mp_transform.macosclangrelease \
-in:file:s 1AFO.pdb \
-mp:setup:spanfiles 1AFO.span \
```

## Flags / Options

|**Flag**|**Description**|
|:-------|:--------------|
|`-mp::transform::optimize_embedding <bool>` | Use the scorefunction to optimize the embedding after an initial coarse grained setting.|

## Citation
Rosetta Revision #57715

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol; 11(9).

Koehler Leman J, Mueller BK, Gray JJ (2017). Expanding the toolkit for membrane protein modeling in Rosetta. Bioinformatics; 33(5).

## Contact

Questions and comments to: 
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Rebecca F. Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))
