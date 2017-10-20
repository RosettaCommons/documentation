# iFAQ
## InFrequently Asked Questions

This is a list of some of the less commonly asked questions about Rosetta.

In truth this is a grab-bag for short bits of documentation which have not (yet) found a home elsewhere.

See Also:
* [[FAQ]] - Frequently Asked Questions 
* [[Glossary]] - short definitions of Rosetta-related terms.
* [[RosettaEncyclopedia]] - longer form explanations of Rosetta-related concepts. 

[[_TOC_]]

#### What is RosettaDesign?

RosettaDesign identifies low energy sequences for specified protein backbones, and has been used previously to stabilize proteins and create new protein structures. Please visit our RosettaDesign server: http://rosettadesign.med.unc.edu

#### What is RosettaDock?

RosettaDock predicts the structure of a protein-protein complex from the individual structures of the monomer components. See <http://rosie.rosettacommons.org/docking/> for the current server.

#### What is RosettaNMR?

RosettaNMR combines the Rosetta de novo structure prediction method with limited experimental data from NMR for rapid prediction of protein structure. NMR constraints of RDC and NOE have been used successfully in RosettaNMR to determine global folds.

#### What is RosettaLigand?

RosettaLigand employs the full atom modes of Rosetta to predict the interactions of protein-small molecule interactions.

#### Where can I find createTemplate.pl?

You can find an optional package named BioTools in the software download page. The createTemplate.pl is in this package.

#### What is the value of temperature which is used in Rosetta simulations?

Rosetta uses "REUs" for its energy unit. (See [[Units in Rosetta]].) As such, the temerature is also in arbitrary units.  

#### I could not find the file named "pNNMAKE.gnu" which is used when I run make_fragments.pl to create fragments.

pNNMAKE.gnu is not a pre-existed file. You need generate it after you download the rosetta_fragments package. After entering the rosetta_fragment/nnmake directory, type "make" to compile and the pNNMAKE file will be generated.

#### How can I get coordinates for the fragments in my fragment libraries?

Coordinates for all fragments are precalculated in the vall_cst_coord.dat.* file. The fields in this file are:

1 frag source pdb name 2 frag source chain 3 frag source residue 5-7 HN coords (x,y,z) 8-10 HA coords 11-21 coefficients for evaluating RDC restraints 22-24 N coords 25-27 CA coords 28-30 CB coords 31-33 C coords 34-36 O coords

All fragments in fragment libraries are identified by the frag source pdb name, chain and residues, allowing relevant coordinates to be extracted from the vall_coord_cst.dat.* data file.


#### Which interaction graph should I use?

For speed, the Packer uses an "Interaction Graph" to cache the residue interaction energies. (See [[packing-options]] for command line options to control the packer.) Depending on the protocol you're using, maintaining this interaction graph can account for a considerable amount of time and memory. As such, different interaction graphs (IG) are available.

* The default interaction graph (the Pairwise Decomposable Interaction Graph) is good for general repacking applications.
* For design, the Linear Memory Interaction Graph (`-linmem_ig`) reduces both the memory and runtime over the default interaction graph
* The Lazy Interaction Graph (`-lazy_ig`) is in all cases faster than the Linear Memory Interaction Graph, but at the cost of more memory usage.
* The Double Lazy Interaction Graph (`-double_lazy_ig`) is only useful for multistate design.

#### The Multicool annealer gives lower scores, so it must be better for relax, right?

No. The FastRelax algorithm relies on the stochastic behavior of the packer to get adequate sampling of the conformational space. The Multicool annealer (the `-multi_cool_annealer` option) is too convergent, and does not give enough variability in results for a good relax results.