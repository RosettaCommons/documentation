## Integrating double electron-electron resonance (DEER) spectroscopy data

Documentation written by Diego del Alamo (del.alamo@vanderbilt.edu). Last edited 13 May 2020. If you use this score term, please cite "Rapid Simulation of Unprocessed DEER Decay Data for Protein Fold Prediction" by del Alamo et al, Biophysical Journal (2020).

[[_TOC_]]

The goal of the DEEREnergy scoring term is to integrate experimental DEER measurements with protein structural modeling and prediction. The DEER technique (sometimes called PELDOR) provides distance data from 15 to 80 angstroms between two or more unpaired electrons conjugated to a protein backbone. In most cases, these unpaired electrons are introduced as spin labels that are covalently linked to surface-engineered cysteine residues. Each double-cysteine mutant generated this way provides an orthogonal measurement of the system of interest, and the data are frequently used for modeling. In the literature, these measurements are generally depicted and published as probability distributions. When modeling proteins, however, it is common to use a single distance value, such as the average or peak distance, rather than the entire distribution. Under other circumstances, it may be beneficial to using the raw data, rather than the distance distribution.

## The DEEREnergy scoring term

### Practical considerations

As of writing, the DEEREnergy scoring term can only integrate experimental measurements between methanethiosulfonate spin labels (MTSL/MTSSL, which is the most widely-used label by far). An advantage of MTSSL is that its flexibility allows it to be covalently linked to a protein's backbone without compromising that protein's function. A disadvantage is that MTSSL can adopt many possible rotamers, making its precise position very difficult to predict under most circumstances. As a result, there is generally a deviation of 2 to 4 angstroms between the average values of the experimental and simulated distance distributions. Moreover, there is no correlation between the width of the simulated and experimental distributions. For this reason, when attempting to model protein structures using these data, it is recommended that some wiggle-room be given to accommodate this imprecision, and to avoid overfitting the data.

### General approach

The DEEREnergy method simulates the distance distribution from a protein structural model by introducing a rotamer library of "dummy" spin labels over all spin-labeled residues. Pairwise distances between these rotamer libraries are then used to compute a distance distribution for comparison to the experimental data. The backbone atoms themselves (e.g. alpha carbons and/or beta carbons) are not directly used for comparison. If the steric environment does not allow any of these dummy rotamers to be placed, the van der Waals radius of the spin labels are gradually reduced until at least one can fit.

### Simulating the raw data from distance distributions

To simulate DEER traces from distance data, the distance distribution is multiplied by a dipolar coupling kernel matrix (refer to Fabregas Ibañez and Jeschke 2019 for theoretical details). To save computation time, this kernel matrix is computed once when Rosetta launches and saved. During each scoring round, the distribution is then multiplied by this kernel matrix to simulate the experimental spectroscopic signal. After this step, depending on whether the data were background-corrected, there may be an additional step where the simulated DEER trace is further manipulated for optimal comparison to the experimental data.

## Command line options and file formatting

The score term for DEEREnergy is ```deer_energy_score```. The data will then be read in as a whitespace-separated file passed to the ```-epr_deer:input_files``` command line option, and an error will be thrown if this option is not provided. Note that this option accepts multiple input files.

There are three approaches for integrating experimental DEER data as restraints:
* Passing individual distances or distance ranges. Values can be the peak distance, the average distance plus or minus the standard deviation, the peak plus or minus the width at half-max, etc. The score is the squared deviation of the average simulated distance from this distance range (in angstroms). This is the simplest approach.
* Passing the entire distance distribution. The score is the negative log-likelihood of the experimental distribution given the simulated distribution. This is recommended if the entire distribution can be explained by a single backbone conformation; e.g. if backbone dynamics are not expected to contribute to the distribution. This is not recommended if the distribution's standard deviation is greater than 4 or 5 angstroms.
* Passing the raw DEER trace. The score is the sum of squared residuals between the simulated and experimental traces. This is recommended when the data in the time domain is insufficient for distance data to be confidently determined, and when conformational heterogeneity is expected to be minimal.

Although these different approaches can be combined in a single modeling project as the user sees fit, the score values are not optimized to scale with respect to each other.

### Simple integration of distance restraints

Restraining a structural model using the average or peak value of a distribution continues to be the most widely used approach for integrating DEER distance data into modeling. Here is an example for how to do this using the DEEREnergy score term:
```
# Simple integration of distance restraints.
# Distance values should be provided in angstroms
# Lines starting with '#' are ignored
PAIR	20	155	30.2
PAIR	20	355	45.0
PAIR	155A	355A	18.6
```

The second and third columns are the residues and the fourth column is the distance of interest. In this case, the score is the squared deviation between this distance value and the average distance of the simulated distance distribution. For example, when scoring the third restraint, an average simulated distance of 21.6 between residues 155 and 355 will return a score of 9.0. Note that the residue numbers can accommodate multiple chains (e.g. by passing 20B to signify residue 20 of chain B).

There may be circumstances where the default settings are unsuitable for a modeling project of interest. In such cases, more detailed controls can be provided. To do so, the data for the restraint needs to be split up over two lines as follows:

```
# One distance value is provided as a restraint
DESC	1	20	DEFAULT	155	DEFAULT
BOUNDS	1	30.2	30.2	1.0

# A range of distances are possible:
# Lower bound is 43.0, upper bound is 47.0. 
DESC	2	20	DEFAULT	355	DEFAULT
BOUNDS	2	43.0	47.0	1.0

# The deviation is divided by 4.0 before squaring
# The penalty is not as steep
DESC	3	155A	DEFAULT	355A	DEFAULT
BOUNDS	3	16.6	20.6	4.0
```

In this format, the DESC line contains the spin-labeled residues (columns 3 and 5), the rotamer library for the spin labels being used (```DEFAULT```, discussed below; columns 4 and 6), and the index of the restraint (column 2). The BOUNDS line signifies the lower (column 3) and upper (column 4) bounds of the restraint, as well as the steepness of the penalty function (column 5). Note that the index of the restraint also needs to be provided (column 2) to match the restraint to the residue information.

### Distance distributions as restraints

Two options are available when passing entire distributions as restraints:
* Individual distance values can be provided
* Gaussian functions can be provided

Individual distance values can be provided as follows:
```
# Case where an entire distribution is passed as a restraint.
DESC	4	20	DEFAULT	233	DEFAULT
DIST	4	15.0	0.01
DIST	4	15.5	0.05
DIST	4	16.0	0.11
DIST	4	16.5	0.18
DIST	4	17.0	0.27
# etc
```

Here the DESC line is the same as described above (see "Adding options"), and specifies both the spin-labeled residues involved in the restraint as well as the rotamer library being used to model the spin label itself. The DIST line contains information on the distance (column 3) and the amplitude (column 4) of the distance distribution. As with the BOUNDS line mentioned above, the index of the restraint must also be provided. When reading these data, the total amplitude of the distribution will automatically be normalized to 1.0. By default, DEEREnergy uses two bins per angstrom, and all input values will be rounded accordingly. To modify this value, please see section "Detailed controls" below.

The second option is to define the restraint as a sum of gaussian distributions. This can be achieved as follows:

```
# Single-gauss distribution
DESC	5	20	DEFAULT	350	DEFAULT
GAUSS	5	35.0	2.5	1.0
# Multi-gauss distribution
DESC	6	233	DEFAULT 350 DEFAULT
GAUSS 	6	33.0	2.2	0.6
GAUSS 	6	37.0	0.5	0.4
```

In this case, the distribution will first be constructed using the average values (column 3), the standard deviations (column 4), and the amplitudes (column 5). Note that the total amplitude of the distribution will be normalized to 1.0.

### DEER traces as restraints

Experimental DEER traces may be passed as follows:
```
# Experimental DEER trace between residues 53 and 95
DESC 7 53 DEFAULT 95 DEFAULT
DECAY 7 0	1
DECAY 7 0.00528221	1.00086
DECAY 7 0.0132822	0.997666
DECAY 7 0.0212822	0.995706
DECAY 7 0.0292822	0.991671
DECAY 7 0.0372822	0.988712
DECAY 7 0.0452822	0.98526
# etc
```

In this case, column 3 is the time (in microseconds) and column 4 is the normalized decay. A time point of zero with a normalized signal of 1.0 is always added as a reference. Note the the signal will not be normalized, phase-corrected, or adjusted in the time domain in any way; what is introduced to the program is directly used for modeling. By default, the data are not assumed to be background-corrected, and the background signal is assumed to be homogeneous in three dimensions.

When using DEER decay data for refinement problems, rather than de novo structure prediction, we recommend treating the standard deviation of the distance distribution as a fitting parameters. By default this is turned off, as it increases the computation time significantly and does not provide any improvement when the models are far from the target conformation. However, when the models are relatively close to the conformation of interest, this approach allows native-like models to be identified more effectively. This is discussed below (see "Additional options").

## Detailed controls

### More than two residues per restraint

If more than two residues are spin labeled for a given restraint, they may also be listed in the ```DESC``` line for a given restraint. This may be relevant to cases such as doubly-labeled homooligomers:
```
DESC 8 20A DEFAULT 55A DEFAULT 20B DEFAULT 55B DEFAULT
```

In this case, the distance distribution between the four residues of interest (residues 20 and 55 for both monomers) would be the sum of each of the six pairwise distributions. There are several caveats to doing this. First, it implies that every residue is 100% labeled, which may not always be the case. Second, simulated DEER traces will not have the artificial short-distance "ghost peaks" that are expected when three or more spins are in close proximity (see von Hagens et al PCCP 2013 for theoretical details).

### Alternative rotamer libraries

In all the examples provided in this documentation, we used the ```DEFAULT``` rotamer library, which prioritizes accuracy over speed. For folding problems, it may be desirable to use the ```DEFAULT_FAST``` rotamer library, which is up to four times faster at the cost of being slightly less accurate, particularly in cases where the spin label is not as solvent-exposed.

### Additional options

Additional modifications may be passed through the DEER data file, with the intention applying them only to specific restraints or datasets. Some options are specific to decay traces, whereas others are independent of how the data are provided. This is achieved by writing a line that starts with ```INFO```,  followed by the index of the dataset:
```
# General options for all types of data:
# Adjust the bins per angstrom computed for the distribution
# Set to 2 by default
INFO 1 BINS_PER_ANGSTROM 10

# Multiplies the score returned for this dataset by this value
# Set to 1.0 by default
INFO 2 RELATIVE_WEIGHT 0.5

# Options specific to decay traces:
# Use background-corrected data
INFO 7 BACKGROUND NONE

# Background is not evenly distributed in three dimensions
# This can happen with membrane proteins
INFO 8 BACKGROUND NON_3D

# Treat standard deviation of the distribution as a fitting parameter
# Default: false
INFO 9 FIT_STDEV TRUE

# Passes the standard deviation of the experimental noise.
# Normalizes the residuals when DEER traces have different noise levels
# Default: 1.0
INFO 10 NOISE 0.05

# Set upper or lower bounds to the modulation depth when fitting the background
# Useful when the data was collected using an arbitrary waveform generator
# Default: 0.02 - 0.50
INFO 11 MOD_DEPTH_MAX 0.60
INFO 11 MOD_DEPTH_MIN 0.05

# Note that multiple options may be written per line:
INFO 12 MOD_DEPTH_MIN 0.05 MOD_DEPTH_MAX 0.60 BINS_PER_ANGSTROM 5
```
