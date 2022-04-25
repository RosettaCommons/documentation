#SID ERMS prediction

Metadata
========
Method, code, and documentation by Justin Seffernick (seffernick.9@osu.edu).
The PI was Steffen Lindert (lindert.1@osu.edu).
Last updated May 2022 by Justin Seffernick. 

Code
=============
Application resides at `       Rosetta/main/source/src/apps/public/analysis/SID_ERMS_prediction.cc      `.
A tutorial for using the application can be found in the reference below.

References
==========
Seffernick, J.T.; Turzo, S.M.B.A.; Harvey, S.R.; Kim, Y.; Marciano, S.; Wysocki, V.H.; and Lindert, S. Simulation of energy-resolved mass spectrometry distributions from surface-induced dissociation. *In preparation*. 2022.


Purpose
==========
Application to predict surface-induced dissociation (SID) mass spectrometry (MS) data from structure of protein complex. In SID, complexes are broken into subunits via surface collision at various lab-frame energies. From these experiments, energy-resolved mass spectrometry (ERMS) data are predicted. ERMS plots show the relative intensity of each subcomplex as a function of the SID acceleration energy. This application can be used to predict the data needed to create such plots.

Algorithm
==========
The algorithm works by assigning a probability of breaking for each interface in the protein complex, which depends on the acceleration energy and interface strength (input directly using B_vals flag or from pdb structure). Based on these probabilities, breakages are simulated 1000 times (then averaged) for each acceleration energy (ranges can be input directly or determined automatically based on interface strength). The resulting subcomplexes are counted and normalized to determine relative intensities for each, and data for the ERMS prediction are output. If experimental ERMS data are known, root-mean-square error (RMSE) comparison can also be calculated for the prediction. Complex type (i.e., the interfaces in the complex) must be input using the `       -complex_type      ` flag. Further details can be found below.

Input files
==========
-   Complex type file. This file is mandatory and tells the application the oligomeric state, connectivity, and possible symmetry for the complex of interest. The first line of the file contains the chain IDs in the complex, separated by whitespace. Each of the subsequent lines contain interface definitions. Each line represents an interface type (all entries within a line are symmetric, also separated by whitespace). Each interface is defined as first chain + underscore + second chain. For example, an interface between chains A and B would be indicated as A_B. 
Below shows an example of a C5 pentamer:
```
A B C D E
A_B B_C C_D D_E E_A
```
Below shows an example of a D2 tetramer:
```
A B C D
A_B C_D
A_D B_C
A_C B_D 
```
-   PDB or `       -B_vals      ` file (one of the two must be given). To calculate the probability curves used in the simulation, the algorithm needs probability midpoint values (B values). This can be done using a direct input (using the `       -B_vals      ` flag to input a file) or from a PDB file. When using the `       -B_vals      ` flag to input, the file should contain one B value per line, corresponding to each interface type from the complex type file, above.
-   Experimental ERMS or acceleration energy values file (optional). To simulate the ERMS, acceleration energies (x values on ERMS plots) are needed. The application can determine these automatically, or they can be input in a file using the `       -ERMS      ` flag. Additionally, RMSE (comparison to experiment) can be calculated based on full ERMS input using the same file. To input a file (whitespace separated), the first column contains the acceleration energies. If the `       -RMSE      ` flag is given, you can provide the experimental relative intensities for each subcomplex type (full ERMS data) in the remaining portion of the file. The second column is the precursor (the full complex), third is precursor-1 (full complex minus a monomer), and so on until the last column is the monomer.

Options
==========
-   `       -complex_type      ` (file): File used to specify oligomeric states, connectivity, and symmetry (see Input Files section for full detail).
-   `       -RMSE      ` (bool): Calculate RMSE to experimental ERMS? Default = false. Note that RMSE value is printed to the screen if calculated.
-   `       -ERMS      ` (file): File to input acceleration energies or full ERMS (for RMSE comparison) (see Input Files section for full detail).
-   `       -B_vals      ` (file): File to manually input B values for each interface type. (If not provided, use `       -in:file:s      ` to input PDB structure) (see Input Files section for full detail).
-   `       -steepness      ` (real): Option to manually input steepness of probability curve. It is highly recommended to use the default values (and not use this flag), but these can be overridden using this flag.
-   `       -breakage_cutoff      ` (real): Option to determine the SID acceleration energy (unit: eV) where breakage is allowed to occur (0 eV by default).
-   `       -out:file:o      ` (string): File name to output predicted ERMS. If not provided, defaults to `       ERMS_prediction.tsv      ` (same format as ERMS input).

Tips
==========
If simulating ERMS from structure, make sure the input PDB matches the complex definition file. If interfaces are defined as symmetric, the simulation will calculate B for the first interface in that definition only. However, the application performs a size check, and if interfaces defined as symmetric vary in size by more than 10%, a warning is printed. To overcome this (or to purposefully calculate B separately for each interface), simply alter the complex_type file by defining interfaces on different lines.  
For example. Removing the symmetry for the first interface type for the D2 symmetry definition (above, previously defining A_B and C_D as symmetric), change the file to the following:
```
A B C D
A_B 
C_D
A_D B_C
A_C B_D 
```

Expected outputs
==========
The application will output useful information to the screen (for example: B values for each interface). Pay attention to the symmetry warning (see above tip to remove defined symmetry). If RMSE is calculated, that value prints to the screen. A file containing the predicted ERMS is created for each simulation (see `       -out:file:o      ` in options above).

New things since last release
==========
This is the first release.