# GeneralizedKIC Selectors

## Overview
GeneralizedKIC selectors (class protocols::GeneralizedKIC::GeneralizedKICselector) choose a single solution, based on some criterion, from the many solutions produced by GeneralizedKIC.  A single attempt at closure with GeneralizedKIC can produce 0 to 16 solutions, and one typically attempts many closures, so it is necessary to specify a method of choosing a single solution.

## Use within RosettaScripts
Each [[GeneralizedKIC mover|GeneralizedKIC]] has one and only one GeneralizedKIC selector assigned to it.  In RosettaScripts, this must be specified in the **\<GeneralizedKIC\>** block as follows:

```
<MOVERS>
...
     <GeneralizedKIC ... selector="&string" selector_scorefunction="&string" selector_kbt=(1.0 &real)>
          ...
     </GeneralizedKIC>
...
</MOVERS>
```

The **selector_scorefunction** and **selector_kbt** tags are optional, and are only used by certain selectors.

## Types of selectors
1.  Random (**selector="random_selector"**)
     As the name implies, this selector randomly chooses a solution from those found.  No options are considered.

2.  Lowest energy (**selector="lowest_energy_selector"**)
     This selector chooses the lowest-energy solution found.  It should be provided with a scorefunction (**selector_scorefunction** tag).  Since no repack is performed before scoring, it is recommended to use a scorefunction that only considers backbone geometry (see below).  An example would be a scorefunction consisting of some combination of the **hbond_lr_bb**, **hbond_sr_bb**, **rama**, **omega**, and **p_aa_pp** terms.  The **selector_scorefunction** tag is the only option considered by this selector.

3.  Boltzmann-weighted random (**selector="boltzmann_energy_selector"**)
     This selector chooses a solution randomly, but weighted by a factor of exp(-E/kbt).  This means that it must score the energy of each solution, so as with the lowest energy selector, this selector must be provided with a (preferably backbone-only) scorefunction with the **selector_scorefunction** tag.  It must also be provided with a Boltzmann temperature, in Rosetta energy units, with the **selector_kbt** tag.  The **selector_scorefunction** and **selector_kbt** tags are the only options considered by this selector.

4.  Lowest RMSD (**selector="lowest_rmsd_selector"**)
     This selector chooses the solution with the lowest RMSD to the input loop conformation.  It is therefore best used on structures that already have a closed loop conformation that you would like to perturb subtly (_e.g._ with the **[[perturb_dihedral|GeneralizedKICperturber]]** [[GeneralizedKIC perturber|GeneralizedKICperturber]]).

## Recommended scorefunctions for energy-based selectors

Energy-based selectors, such as the lowest energy and Boltzmann-weighted random selectors, must score candidate solutions with some scorefunction.  The full-atom talaris2013 scorefunction would generally be a poor choice for this, because no repacking or energy-minimization is carried out before scoring to eliminate side-chain clashes.  For this reason, a scorefunction that either considers only backbone geometry, or one that considers backbone and side-chain geometry but not long-range side-chain interactions, is recommended.  Two examples are given below.

```
<bb_hbond_tors weights="empty.wts" symmetric=0>
#A backbone-only scorefunction that only includes the backbone hydrogen-bonding, omega, rama,
#and p_aa_pp terms from the talaris2013 scorefunction.
	<Reweight scoretype=hbond_sr_bb weight=1.17 />
	<Reweight scoretype=hbond_lr_bb weight=1.17 />
	<Reweight scoretype=omega weight=0.5 />
	<Reweight scoretype=rama weight=0.2 />
	<Reweight scoretype=p_aa_pp weight=0.32 />
</bb_hbond_tors>
```

```
<bb_hbond_tors_fadun_cst weights="empty.wts" symmetric=0>
#A scorefunction that only includes the backbone hydrogen-bonding, omega, rama,
#and p_aa_pp terms from the talaris2013 scorefunction, as well as the side-chain
#fa_dun term and constraint weights.  Note that side-chains are not repacked, so
#the fa_dun term will be identical for all side-chains EXCEPT those that are part
#of the loop to be closed (e.g. the side-chains of the cysteines of a disulfide).
	<Reweight scoretype=hbond_sr_bb weight=1.17 />
	<Reweight scoretype=hbond_lr_bb weight=1.17 />
	<Reweight scoretype=omega weight=0.5 />
	<Reweight scoretype=rama weight=0.2 />
	<Reweight scoretype=p_aa_pp weight=0.32 />
	<Reweight scoretype=fa_dun weight=0.56 />
	<Reweight scoretype=atom_pair_constraint weight=1.0 />
	<Reweight scoretype=angle_constraint weight=1.0 />
	<Reweight scoretype=dihedral_constraint weight=1.0 />
</bb_hbond_tors_fadun_cst>
```
