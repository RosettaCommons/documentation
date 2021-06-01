## Integrating double electron-electron resonance (DEER) spectroscopy data

### Summary

Electron paramagnetic resonance spectroscopy, EPR for short, is an experimental tool that reports protein dynamics and structural heterogeneity. A widely-used application is double electron-electron resonance (DEER, also called PELDOR), which is used to measure nanometer-scale distances between pairs of spin probes attached to protein backbones by site-directed spin labeling (SDSL). The DEEREnergy energy method, which is a part of the broader RosettaDEER module, allows these data to be integrated with Rosetta for modeling protein structures.

Documentation written by Diego del Alamo (del.alamo@vanderbilt.edu). Last edited 13 May 2020. If you use this score term, please cite "Rapid Simulation of Unprocessed DEER Decay Data for Protein Fold Prediction" by del Alamo et al, Biophysical Journal (2020).

[[_TOC_]]

### The DEEREnergy scoring term

#### General approach

The DEEREnergy scoring method compares experimental data, provided by the user, to data simulated from a protein model. As with all score terms in Rosetta, low scores indicate that the simulated data closely matches the experimental data, whereas higher scores indicate disagreement or discrepancies between the model and the data. Simulation and scoring is carried out in several steps, discussed in greater detail in subsequent sections below.

1. At the start of the program, the user provides data as input.
2. During scoring, dummy spin labels are introduced over the protein to simulate the distance distribution. If the raw time-domain data are provided as input, the simulated distance distribution is further converted into a time trace.
3. A score is calculated by comparing the simulated and experimental data. The precise score term is specified by the user.

### How to provide experimental data using the command line

The score term for DEEREnergy is ```epr_deer_score```. As with all score terms in Rosetta, it may be passed to the program using the command line option ```-score:set_weights epr_deer_score X```, where ```X``` is the desired weight. One or more files containing experimental data may be specified using the command line option ```-epr_deer:input_files file1.txt file2.txt ... fileN.txt```. Formatting these files is discussed below. 

There are four approaches for integrating experimental DEER data as restraints:
* **Passing a specific distance value:** The average distance of the simulated distance distribution (in Ångstroms) will be compared to the provided value, and the square of the difference will be returned.
* **Passing a range of distance values:** The average distance of the simulated distance distribution (in Ångstroms) will be compared to the distance range. The score returned is zero if this value falls within the range. If this values falls outside the range the score is equal to the square of the difference between it and either the lower or upper bound, whichever is closer.
* **Passing an experimental distance distribution:** The simulate distance distribution is directly compared to the experimental distribution using one of several functions (default: negative log-likelihood).
* **Passing an experimental DEER trace:** The simulated distance distribution is transformed to the time domain and, depending on the options specified by the user, is further modified before comparing to the experimental data. The score is equal to the sum-of-squared residuals.

**It is highly recommended that a modeling task stick to one specific scoring approach.** The dynamic ranges of these scoring functions are not similar, and emphasis may be placed on data provided using one approach versus another. However, they can be mixed and matched as needed if necessary.

#### Input file formatting to compare to a specific distance value

This section outlines how to format the data to score using the first option above. Comparison to the average experimental distance continues to be the most widely used approach for integrating DEER distance data into modeling. Here is an example to format the file appropriately:
```
# Simple integration of distance restraints.
# Distance values should be provided in angstroms
# Lines starting with '#' are ignored
PAIR	20	155	30.2
PAIR	20	355	45.0
PAIR	155A	355A	18.6
```

The second and third columns are the residues and the fourth column is the distance of interest. In this case, the score is the squared deviation between this distance value and the average distance of the simulated distance distribution. For example, when scoring the third restraint, an average simulated distance of 21.6 between residues 155 and 355 will return a score of 9.0. Note that the residue numbers can accommodate multiple chains (e.g. by passing 20B to signify residue 20 of chain B).

#### Input file formatting to compare to ranges of distances

There may be circumstances where the default settings are unsuitable for a modeling project of interest. In such cases, more detailed controls can be provided. To do so, the data for the restraint needs to be split up over two lines as follows:

```
# One distance value is provided as a restraint
DESC	1	DEFAULT 20	DEFAULT	155
BOUNDS	1	30.2	30.2	1.0

# A range of distances are possible:
# Lower bound is 43.0, upper bound is 47.0. 
DESC	2	DEFAULT 20	DEFAULT	355
BOUNDS	2	43.0	47.0	1.0

# The deviation is divided by 4.0 before squaring
# The penalty is not as steep
DESC	3	DEFAULT 155A	DEFAULT	355A
BOUNDS	3	16.6	20.6	4.0
```

In this format, the DESC line contains the spin-labeled residues (columns 3 and 5), the rotamer library for the spin labels being used (```DEFAULT```, discussed below; columns 4 and 6), and the index of the restraint (column 2). The BOUNDS line signifies the lower (column 3) and upper (column 4) bounds of the restraint, as well as the steepness of the penalty function (column 5). Note that the index of the restraint also needs to be provided (column 2) to match the restraint to the residue information.

#### Input file formatting to compare entire distance distributions

Individual distance values can be provided as follows:
```
# Case where an entire distribution is passed as a restraint.
DESC	4	DEFAULT 20	DEFAULT	233
DIST	4	15.0	0.01
DIST	4	15.5	0.05
DIST	4	16.0	0.11
DIST	4	16.5	0.18
DIST	4	17.0	0.27
# etc
```

Here the DESC line is the same as described above (see "Adding options"), and specifies both the spin-labeled residues involved in the restraint as well as the rotamer library being used to model the spin label itself. The DIST line contains information on the distance (column 3) and the amplitude (column 4) of the distance distribution. As with the BOUNDS line mentioned above, the index of the restraint must also be provided. When reading these data, the total amplitude of the distribution will automatically be normalized to 1.0. By default, DEEREnergy uses two bins per angstrom, and all input values will be rounded accordingly. To modify this value, please see section "Detailed controls" below.

#### Input file formatting to compare DEER traces

To simulate DEER traces from distance data, the distance distribution is multiplied by a dipolar coupling kernel matrix (refer to Fabregas Ibañez and Jeschke 2019 for an excellent primer on theoretical details of this step). To save computation time, this kernel matrix is computed once when Rosetta launches and stored in memory. During each scoring round, the distribution is then multiplied by this kernel matrix to simulate the experimental spectroscopic signal. After this step, depending on whether the data were background-corrected, there may be an additional step where the simulated DEER trace is further manipulated for optimal comparison to the experimental data.

Experimental DEER traces may be passed as follows:
```
# Experimental DEER trace between residues 53 and 95
DESC 7 DEFAULT 53 DEFAULT 95
DECAY 7 0	1
DECAY 7 0.00528221	1.00086
DECAY 7 0.0132822	0.997666
DECAY 7 0.0212822	0.995706
DECAY 7 0.0292822	0.991671
DECAY 7 0.0372822	0.988712
DECAY 7 0.0452822	0.98526
# etc
```

In this case, column 3 is the time (in microseconds) and column 4 is the normalized dipolar coupling decay signal. **Note that a time point of zero with a normalized signal of 1.0 is always added as a reference by Rosetta**. The signal will not be normalized, phase-corrected, or adjusted in the time domain in any way; what is introduced to the program is directly used for modeling. By default, the data are _not_ assumed to be background-corrected, and the background signal is assumed to be homogeneous in three dimensions.

When using DEER decay data for refinement problems, rather than _de novo_ structure prediction, we recommend treating the standard deviation of the distance distribution as a fitting parameters. By default this is turned off, as it increases the computation time significantly and does not provide any improvement when the models are far from the target conformation. However, when the models are relatively close to the conformation of interest, this approach allows native-like models to be identified more effectively. This is discussed below (see "Additional options").

#### Choosing spin labels

The examples above using the spin label ```DEFAULT```. The other option, ```DEFAULT_FAST```, is approximately four times faster to compute but comes at a slight accuracy cost. It is therefore recommended to use ```DEFAULT_FAST``` exclusively for _de novo_ folding problems. **Both libraries are parametrized from methanethiosulfonate spin label rotamer libraries.** It is therefore not recommended that this method be used to restrain proteins with data collected between other labels, such as IDSL/V1, bifunctional labels, or paramagnetic noncanonical amino acids.

#### More than two residues per restraint

If more than two residues are spin labeled for a given restraint, they may also be listed in the ```DESC``` line for a given restraint. This may be relevant to cases such as doubly-labeled homooligomers:
```
DESC 8 DEFAULT 20A DEFAULT 55A DEFAULT 20B DEFAULT 55B
```

In this case, the distance distribution between the four residues of interest (residues 20 and 55 for both monomers) would be the sum of each of the six pairwise distributions. There are several caveats to doing this. First, it implies that every residue is 100% labeled, which may not always be the case. Second, simulated DEER traces will not have the artificial short-distance "ghost peaks" that are expected when three or more spins are in close proximity (see von Hagens et al PCCP 2013 for theoretical details).

### Detailed controls

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
```
