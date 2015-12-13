### To do
* **Important** Proper RNA_SecStructInfo objects, including noncanonical pairings and setup of base pair steps inside Rosetta
* change default FARNA setup to stepwise setup (incl. -in:file:silent stored in FullModelInfo or FullModelParameters?) 
* native RMSD screen in FARNA (to more stringently test idea that stepwise -lores can offer better sampling than classic FARNA) 
* test on more complex cases (e.g., tectoRNA, riboswitches) 
* 'focus' fragments near site of addition/deletion (low priority)
* Fix bulge BPS databases, which now require filtering for wrong fold-tree entries.
* setup ‘long-distance’ BPS (>3 intervening nts)
* setup move to add triples and resample based on database.
* autorecognition of long stretches of sequence identity (e.g., >5 nts) — hold NR2015 as silent files in the database.
