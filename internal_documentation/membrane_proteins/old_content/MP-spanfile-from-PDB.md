## Metadata

Questions and comments to: 
 - Julia Koehler Leman ([julia.koehler1982@gmail.com](julia.koehler1982@gmail.com))
 - Rebecca F. Alford ([rfalford12@gmail.com](rfalford12@gmail.com))
 - Corresponding PI: Jeffrey J. Gray ([jgray@jhu.edu](jgray@jhu.edu))

Last Updated: 3/20/15

## Citation
Rosetta Revision #57715

Alford RF, Koehler Leman J, Weitzner BD, Duran A, Elazar A, Tilley DC, Gray JJ (2015)
An integrated framework advancing membrane protein modeling and design
PLoS Computational Biology (under revision) 

## Algorithm Description
A spanfile is required by most RosettaMP applications. If the structure of the protein is known, the spanfile can be computed from the structure if the structure is transformed into membrane coordinates (see [[PDB-file]]). The application considers residues between -15 <= z <= 15 to be in the membrane when they are in a secondary structure element, as predicted with Rosetta's DsspMover. Spans must also be at least 3 residues long - sometimes Dssp predicts several short helices for a single span. Also, this means that shorter helices like the pore helices in potassium channels are considered a span. Further, the distance along the z-axis between start and end residue of the span have to be at least 5 Angstrom: otherwise the span is considered amphipathic and will be thrown out. Shorter spans that have up to 3 residues loop in between (such as kinks or short loops) will be connected if the span direction is the same (in/out or out/in topology) for BOTH spans. If the directions of the two spans are antiparallel, the spans will not be connected because these are considered different spans. 

**Note:** While the application is much better than the previous implementation, there are a couple of considerations to take into account. (1) Identification of a span relies on Dssp. This means if Dssp is wrong (i.e. it predicts a loop where there is a helix), a span might not be identified. While it is very rare that complete spans are not identified, it does occur that they are predicted too short in some cases. So please make sure to check your spanfile! (2) Membrane proteins are very diverse and short helices don't necessarily have to completely span the membrane. If in one case there are many short helices in one leaflet of the membrane, the membrane center that Rosetta identifies might be slightly off, since it considers the center of the spans. When running an application, please visualize the membrane and make sure it is correct. 

## Code and Demo
This application uses functions from RosettaMP. The spanfile_from_pdb application can be found at `Rosetta/main/source/src/apps/pilot/jkleman/spanfile_from_pdb.cc`. The supplement of the above manuscript also outlines its use. 

## Run the application

Please make sure your protein is transformed into the membrane coordinate frame before running this application. You can do so with either PDBTM database, TMDET server, OPM database, or PPM server. Then run 

```
Rosetta/main/source/bin/spanfile_from_pdb.macosclangrelease \
-in:file:s 1AFO_tr.pdb \
```
