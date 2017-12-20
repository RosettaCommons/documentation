#HBNet Unsats

*Back to [[HBNet|HBNetMover]] page.  Back to [[Mover|Movers-RosettaScripts]] page.  Back to [[RosettaScripts|RosettaScripts]] page.*<br>

###How HBNet treats buried unsatisfied polar atoms
HBNet has its own internal method for evaluating and counting buried unsatisfied polar atoms.  Each network requires all buried heavy-atom donors and acceptors to participate in h-bonds.  Any network that does not meet and requires that does not meet this requirement is automatically thrown out.  Networks are first ranked and sorted based on the number of Hpol unsats, and users can specify ```max_unsat_Hpol```.  The reasoning is that buried polar heavy atoms incur a large energetic penalty (~5-6kcal/mol) if they do not form compensating hydrogen bonds, whereas for example, an NH2 of Asn or Gln that donates one Hpol but not the other is more tolerated.

###How burial is determined
A challenge of HBNet is determining burial during network search, when no other residues have been packed/designed around the network.  The original implementation used SASA with an increased probe radius to account for this problem.  Now, the default is to use Gabe Rocklin's sidechain neighbors ([[LayerSelector|ResidueSelectors#residueselectors_conformation-dependent-residue-selectors_layerselector]]), which gives two advantages: 1) it's precomputed, binning residues as buried or solvent exposed at the beginning, which is much faster than SASA; 2) it is sidechain-independent (only uses CA-CB vector), so the binning is consistent for each backbone, regardless of aa sequence or rotamers.

Users can also custom-define which residues they want HBNet to consider as buried for the unsat calculations by passing any residue selector to ```core_selector```.

###See also:
* [[BuriedUnsatHbondsFilter]]
* [[LayerSelector|ResidueSelectors#residueselectors_conformation-dependent-residue-selectors_layerselector]]