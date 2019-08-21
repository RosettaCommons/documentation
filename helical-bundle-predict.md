# Helical Bundle Structure Prediction (helical_bundle_predict) Application

Back to [[Application Documentation]].

Created 21 August 2019 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).<br/><br/>
<b><i>This application is currently unpublished!  If you use this application, please include the developer in the list of authors for your paper.</i><br/>

[[_TOC_]]

## Description

## See also

Rosetta's most widely-used structure prediction application, [[Rosetta ab initio|abinitio-relax]], relies on fragments of proteins of known structure to guide the search of the conformation space, and to limit the conformational search to the very small subset of the space that resembles known protein structures.  This works reasonably well for natural proteins, but prevents the prediction of structures built from non-natural building blocks.  In 2015, we introduced the [[simple_cycpep_predict]] application to allow the prediction of structures of small heteropolymers built from any mixture of chemical building-blocks, without any known template sequences.  The [[simple_cycpep_predict]] application uses the [[generalized kinematic closure|GeneralizedKIC]] algorithm to confine the search to closed conformations of a macrocycle, effectively limiting the search space without relying on databases of known structures.  Unfortunately, this only works for relatively small molecules (less than approx. 15 residues), molecules with regions of known secondary structure (less than approx. 10 residues of loop), or molecules with internal symmetry (less than approx. 8 residues in the repeating unit), and absolutely requires covalent linkage between the ends of the molecule.  A prediction strategy for larger, linear heteropolymers built from non-natural building-blocks is needed.