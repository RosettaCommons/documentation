### To do
#### FARNA
* **Important** Proper RNA_SecStructInfo objects, including noncanonical pairings and setup of base pair steps inside Rosetta
* change default FARNA setup to stepwise setup (incl. -in:file:silent stored in FullModelInfo or FullModelParameters?) 
*A good time to do this might be when Kalli generalizes FARNA to include RNA-protein lo-res potential. Rebuilding an RNA pair within the MS2 test case is a good example.*
* native RMSD screen in FARNA (to more stringently test idea that stepwise -lores can offer better sampling than classic FARNA) *Again, Kalli's work on RNP lores modeling offers good test case.*
* test on more complex cases (e.g., tectoRNA, riboswitches) *Will test when Clarence/Caleb have MOHCA-seq benchmark set up.*
* Fix bulge BPS databases, which now require filtering for wrong fold-tree entries.
* setup ‘long-distance’ BPS (>3 intervening nts)

#### Stepwise-lores  *(low priority since not seeing many wins compared to FARNA)*
* Make sure base-pair-step setup decides on the number of intervening residues based on PDBinfo or full_model_info (if defined).
* 'focus' fragments near site of stepwise addition/deletion (low priority)
* setup move to add triples and resample based on a triplet database.
* autorecognition of long stretches of sequence identity (e.g., >5 nts) — hold NR2015 as silent files in the database.
