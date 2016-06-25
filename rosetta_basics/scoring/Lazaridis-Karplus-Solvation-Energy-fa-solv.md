The Lazaridis-Karplus solvation energy (fa_sol) scores the energy of a molecule in implicit solvent using a Gaussian-exclusion solvent model. The term was originally described in [[this paper | http://onlinelibrary.wiley.com/doi/10.1002/(SICI)1097-0134(19990501)35:2%3C133::AID-PROT1%3E3.0.CO;2-N/abstract]]. Rosetta uses this model with a few adjustments: 

1. The desolvation energy function has the exponential form described in Equations
5–7 only for a certain range of interatomic distances. For other distances Rosetta
uses approximating forms (see "Etable::analytic_lk_evaluation()").

2. By default the contributions of some atom pairs are ignored (e.g., the intra-residue
contributions and the contributions ignored via the count-pair mechanism).

3. The DELTA_G_REF constant energy offsets are ignored. This value is conceptually folded into the grab-bag of residue-type-constant energies that is the reference energy.

The unweighted solvation energies are expressed in kcal/mol. 
