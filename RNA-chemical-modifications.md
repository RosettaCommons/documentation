# RNA chemical modifications

Many nucleotides in natural RNAs bear chemical modifications, either as an obligatory modifications (see in particular tRNAs and rRNAs) or as transient base edits. Synthetic RNA molecules may be edited to confer additional chemical stability (see the frequent use of sulfur modifications to the phosphate backbone and 2'OMe on the sugar in siRNA or pseudouridine in mRNA therapeutics). Natural processes may lead to additional base modifications 

### Rosetta parameters

Rosetta parameters may be available already for your nucleotide of choice. If it is found in `database/chemical/residue_type_sets/fa_standard/residue_types/nucleic/rna_nonnatural/` already, you don't need to do anything further. If a PDB structure has already been solved that includes this nucleotide, you may not need to do much either: the Chemical Components Dictionary may include it and correctly annotate it as a "polymeric" residue. Functionality may be slightly more limited, but you will be able to energy-minimize a structure containing it and see no catastrophic behavior.

If no structure has been solved with this nucleotide, or if you want to do more extensive modeling (for example: fragment assembly), you will need explicit parameter file support, which you may need to incorporate by hand. Check (here)[RNA fasta file] for a list of the already-supported nucleotides.

### Making new parameters

Practically speaking, you can edit Rosetta parameter files by hand, just by copying a base residue type (if you are interested in modeling 8-oxo-guanosine, consider starting from guanosine) and then making modifications to it. (To wit: you'll have to add an oxygen atom and remove a hydrogen; you'll have to add a bond between the correct carbon in the nucleobase and the new oxygen; you will have to set up internal coordinate kinematics for the oxygen.) Your initial guess for these parameters may be imperfect, but if it isn't good enough, you can re-optimize the internal geometry in QM or semiempirically as desired.