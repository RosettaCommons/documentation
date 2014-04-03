# This page is under construction!!!

## MetaData
* Original authors: Christophe Schmitz, Robert Vernon
* Additional info: Christophe Schmitz was a grad student in the labs of Thomas Huber and Gottfried Otting (Australian National University) and developed that code as part of a few months visit to the Bakerlab. Thomas Huber might still be using this code. Christophe developed several software tools involving Pseudo-Contact-Shifts and paramagnetic NMR as part of his PhD: [http://www.nmr.chem.uu.nl/~christophe/](http://www.nmr.chem.uu.nl/~christophe/)
* Documentation: Julia Koehler Leman (julia.koehler1982@gmail.com) 

## Summary
The purpose of this application is to fold proteins with the help of Pseudo-Contact-Shift (PCS) NMR restraints only (additional use of restraints has not been tested (at least not by me - JKL)). Since PCSs are a paramagnetic effect, they are measured as chemical shift perturbations of a paramagnetically labelled protein with respect to a diamagnetic reference protein. For correct aquisition of the diamagnetic chemical shifts, the protein in the sample should still be labelled, but with a diamagnetic reference. Also, MTSL spin labels (that are typically used in EPR and NMR), even though paramagnetic, will not lead to PCS, since their magnetic susceptibility is isotropic. PCSs are typically small and difficult to measure, challenges are sample preparation (protein + tag + para/diamagnetic metal ions) and sometimes aquisition of the restraints due to the flexibility of the tag. More information about the background on PCSs and paramagnetic NMR in (Koehler, 2011, ProgNMRSpec).

## References
* [Schmitz, 2012, JMolBio: Protein Structure Determination from Pseudocontact Shifts Using ROSETTA](http://www.sciencedirect.com/science/article/pii/S0022283611013945)
* Background info: [Koehler, 2011, ProgNMRSpec: Expanding the utility of NMR restraints with paramagnetic compounds: background and practical aspects.](http://www.sciencedirect.com/science/article/pii/S0079656511000410)

## Documentation


## Input files


## Running the application


## Output files


## Data analysis