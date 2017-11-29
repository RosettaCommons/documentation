# MPSpanAngleEnergy
documentation written by Jonathan Weinstein jonathan.weinstein@weizmann.ac.il, Nov 2017

## MPSpanAngleEnergy
An energy term that penalizes the pose for TM spans whose angle with the membrane normal is very different from the distribution of angles in natural membrane proteins.
this improves sampling in fold & dock simulations considerably, preventing the sampling of TMs at irrelevant angles.
this energy term is used by the membrane energy function ref2015_memb and the centroid level energy fucntions score*_memb

## See also
* [[MPHelicalityEnergy]]
* [[MPResidueLipophilicityEnergy]]