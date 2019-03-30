# MPHelicalityEnergy
documentation written by Jonathan Weinstein jonathan.weinstein@weizmann.ac.il, Nov 2017

## MPHelicalityEnergy
an energy term that penalizes the score of a pose for every residue in the membrane whose phi-psi duo is far from the optimal values for alpha-helices. 
the penalty is very severe, and so this is mostly useful for single-spanning proteins. in multi-spanning proteins, there are residues with non helical phi-psi duos, and so will be very severely penalised.

* [[MPResidueLipophilicityEnergy]]