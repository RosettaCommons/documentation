# Targeted Cross-Linking Mass Spectrometry (PyTXMS)

## Metadata
Authors: Hamed Khakzad (hamed.khakzad@uzh.ch), Lars Malmström (lars.malmstroem@uzh.ch)

Last edited March 12, 2019 by Hamed Khakzad (hamed.khakzad@uzh.ch).


## Table of Contents
* Metadata
* Code and Demo
* References
* Application purpose
* Algorithm
* Input Files
* Standard options
* Tips
* Constraints
* Expected Outputs
* Post Processing

 
## Code and Demo
**Note: We provided a singularity container on Zenodo.org ([DOI: 10.5281/zenodo.2593626](https://zenodo.org/record/2593626#.XIp1QS-ZPUI)) which all the required dependencies are installed and tested. The download link to access the container can be granted by having a valid license of Rosetta software. You can request through Zenodo or send us email with your license information.**

**Below the step-by-step documentation is provided if you want to make your own protocol under PyRosetta.**

The code is written in Python 2.7 under PyRosetta- 4. PyRosetta is an interactive Python-based interface to the Rosetta molecular modeling suite to help designing custom algorithms benefitting from Rosetta protocols and energy functions. PyTXMS uses RosettaDock (both low- and high-resolution protocols) to generate docking models, RosettaCM for comparative modeling purpose, and fragment-picker to generate required fragments of a protein sequence. The package is wrapped by applicake which is designed for framework development. You need to install applicake as follow:
* applicake

`pip install applicake`

To analyze mass spectrometry data, following packages need to be installed in python:

* scikit-learn; to implement machine learning algorithms.

`pip install -U scikit-learn`

* pyteomics v 3.5.1; to analyze MS/MS spectra.

`sudo apt-get install python-setuptools python-dev build-essential
sudo easy_install pip
sudo pip install lxml numpy matplotlib pyteomics`


* pdb-tools; to clean PDB files

`pip install pdb-tools`

To convert data between different MS versions (RAW to mzML or mzML to mgf), tools like MSConvert from ProteoWizard or OpenMS fileconverter can be used.

* MSConvert from ProteoWizard

[http://proteowizard.sourceforge.net/download.html](http://proteowizard.sourceforge.net/download.html)

* OpenMS

http://www.openms.de/downloads/
	
* Dinosaur and Taxlink

[https://github.com/fickludd/dinosaur](https://github.com/fickludd/dinosaur)

[https://github.com/fickludd/taxlink](https://github.com/fickludd/taxlink)


Once you installed all the dependencies, you should clone the GitHub repository of PyTXMS and put it under applicake/appliapps/ node. The metanode folder contains cheetah_wf.py which is the main node to run the whole protocol. To run this, you need to provide an input.ini file (see input files and standard options sections below). Then you can run it with the following command:

`apl metanode.cheetah_wf --WORKDIR . --INPUT input.ini --OUTPUT vars.ini`

Please note that the working directory needs to contain all the required files mentioned at input.ini.

## References
We recommend the following article(s) for further studies of PyTXMS methodology and applications:

* Hauri, S., Khakzad, H., Happonen, L., Teleman, J., Malmström, J., & Malmström, L. (2019). Rapid determination of quaternary protein structures in complex biological samples. Nature communications, 10(1), 192. doi:10.1038/s41467-018-07986-1


## Application purpose
* Determination of protein-protein interaction and the binding interface(s) in biological complex samples.
* Modeling protein tertiary structure by using cross-linking mass spectrometry data.
* Mass spectrometry data analysis (hrMS1 and DDA)


## Algorithm
PyTXMS is a modified python version of TX-MS [reference article above] implemented under PyRosetta. The main modification relies on reducing the number of docking models in an intelligent way to reduce computational time and complexity. PyTXMS can analyze one typical protein-protein interaction (according to the Mass Spectrometry Data) per hour.

PyTXMS contains several modes (depends to the data, computational resources and time availability). It starts with two to several sequences and one (or many) mass spectrometry experimental samples. In first version, it supports hrMS1 and DDA samples (in TX-MS main version DIA data are also supported -see the reference article above- which will be added to PyTXMS in the future).

The first stage (pre-processing stage) starts with using hrMS1-based machine learning algorithm. It literally finds potential peptides for the Binding Interfaces (BI) based on hrMS1 data and a large training set which has been provided previously according to the real data from several crystal structures.

In the second stage, few low-resolution docking models are generated and scored based on Rosetta energy function and potential BI-peptides. The best model is selected and all computational XLs are generated to send to the next stage.

In third stage, computational XLs from previous stage are analyzed according to their MS/MS spectra by using DDA data and the model get a general score according to the number of valid XLs and their length (considering a normal distribution function). The algorithm then repeated until it converges to the maximum score (mainly based on the number of valid XLs).

Finally, in last stage, few high-resolution models are generated according to the best selected model and the best one (according to the Rosetta energy function) is reported as the final model.

Note: If no structural information is provided, PyTXMS can model each sequence according to their homologue information and by using cross-linking data as a filter. This step is done before the main algorithm starts and it is possible to run it as a separate protocol as it requires lots of computational power. This step is currently under development which make use of RosettaCM protocol and MS cross-linking constraints.

## Input Files
The list of input files is as follow:
* Protein structural data (PDBs or models).
* Protein sequences (if no structural data is available).
* Mass Spectrometry samples in correct format. (mzML format for both hrMS1 and DDA). See ‘Code and Demo’ section for help on data conversion.

## Standard options

|      Parameter     |  Value (default)  | Description                                                                       |
|:------------------:|:-----------------:|-----------------------------------------------------------------------------------|
|       k-fold       |    5,10,20 (10)   | K-fold cross validation number to test the accuracy of ML over the training data. |
|      ensemble      |     2~100 (2)     | number of classifiers for ensemble learning algorithm.                            |
|        delta       | 0.01 ~ 0.1 (0.01) | delta window to compare monoisotopic mass/z values.                               |
|      intensity     |   1000~5000 (0)   | filtering ion peaks with intensity value below this threshold.                    |
|  number-of-models  |   2 ~ 100K (20)   | number of low-resolution docking models.                                          |
| num-of-top-filters |    2 ~ 10K (5)    | number of top selected models for the second round of analysis with MS2 data.     |
|       cut-off      |     15~40 (32)    | threshold value to consider XLs on the structure.                                 |
Please note that you need to pass also all executable folders of installed required software. According to the address you provide in the input.ini file, those applications will be run and used in the protocol.

## Tips
* PyTXMS contains several protocols. However, they can be categorized in two major groups: 1- protein modeling with cross-linking data, and 2- protein-protein interaction with cross-linking data. Although it is possible to have a single workflow contains both mentioned protocols, we strongly suggest using these two protocols separately and make sure about the input of each step.

* MS/MS analysis in PyTXMS can be done automatically by considering default thresholds (delta = 0.01 and fragment count > 20). It is also possible to have visual inspection over annotated spectra -which are all provided as PNG figures in the output- and discriminate real spectra with noises.

## Constraints
PyTXMS is designed to find cross-linking data which can be used as strong constraints in protein modeling or prediction of binding interface(s) in protein-protein interaction networks.

## Expected Outputs
Here is the list of expected outputs. Clearly, some of them are not produced according to the selected protocol:
* One PDB file – the final model.
* One PyMOL session contains the PDB and all XLs mapped there.
* PNG figures of annotated spectra in MS/MS analysis.
* SQLite table contains all the details about MS2 analysis.
* List of all selected XLs in a .txt file.

## Post Processing
Selected XLs can be validated one more step with DIA analysis approach -provided in the reference TX-MS main protocol- and be used again for modeling purpose. However, it is only necessary if few information is obtained and selected spectra would not be reliable.