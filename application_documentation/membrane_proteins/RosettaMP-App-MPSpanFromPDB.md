# RosettaMP Application: Span From PDB (MPSpanFromPDB)

## Code and Demo
The spanfile from PDB application can be found in `Rosetta/main/source/src/apps/public/mp_span_from_pdb.cc` 

A demo for MPSpanFromPDB can be found in `Rosetta/demos/protocol_captures/mp_span_from_pdb`

Rosetta Revision #58069

## Background
A spanfile is required by most RosettaMP applications. If the structure of the protein is known, the spanfile can be computed from the structure if the structure is transformed into membrane coordinates. The application considers residues between -15 <= z <= 15 to be in the membrane when they are in a secondary structure element, as predicted with Rosetta's DsspMover. Spans must also be at least 3 residues long - sometimes Dssp predicts several short helices for a single span. Also, this means that shorter helices like the pore helices in potassium channels are considered a span. Further, the distance along the z-axis between start and end residue of the span have to be at least 5 Angstrom: otherwise the span is considered amphipathic and will be disregarded. Shorter spans that have up to 3 residues loop in between (such as kinks or short loops) will be connected if the span direction is the same (in/out or out/in topology) for BOTH spans. If the directions of the two spans are antiparallel, the spans will not be connected because these are considered different spans. 

**Note:** While the application is much better than the previous implementation, there are a couple of considerations to take into account. (1) Identification of a span relies on Dssp. This means if Dssp computes incorrect secondary structure (i.e. it predicts a loop where there is a helix), a span might not be correctly identified. While it is very rare that complete spans are not identified at all, it does occur that they are predicted too short in some cases. So please make sure to check your spanfile! (2) Membrane proteins are very diverse and short helices don't necessarily have to completely span the membrane. If in one case there are many short helices in one leaflet of the membrane, the membrane center that Rosetta identifies might be slightly off, since it considers the center of the spans. When running an application, please visualize the membrane and make sure it is correct. 

## Run the application

Please make sure your protein is transformed into the membrane coordinate frame before running this application. You can do so with either PDBTM database, TMDET server, OPM database, or PPM server. Then run 

```
Rosetta/main/source/bin/mp_span_from_pdb.macosclangrelease \
-in:file:s 1AFO_tr.pdb \
```

## Flags / Options

|**Flag**|**Description**|
|:-------|:--------------|
|`-mp::thickness <Real>` | One-half thickness of the membrane used to create spanfiles. Overwrites default thickness of 15A (membrane is 30A thick)|

## Citation
Rosetta Revision #57715

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Tiley DC, Gray JJ (2015). An integrated framework advancing membrane protein modeling and design. PLoS Comput. Biol; 11(9).

Koehler Leman J, Mueller BK, Gray JJ (2017). Expanding the toolkit for membrane protein modeling in Rosetta. Bioinformatics; 33(5).

## Contact

Questions and comments to: 
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Rebecca F. Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

