#cartesian\_ddg application

Metadata
========
The documentation was last updated August 13th, 20125, by Rachel Clune. Questions about this documentation can be asked in the how\_do\_i\_do\_x, documentation, or debugging channels on the Rosetta Commons slack. Alternatively you can create a new [Issue](https://github.com/RosettaCommons/rosetta/issues), create a new [Discussion](https://github.com/RosettaCommons/rosetta/discussions), or reach out to Frank DiMaio: dimaio(@u.washington.edu). The documentation is only for monomeric ddg calculation, while this tool can be used to study protein-protein and small molecule interactions, other tools (e.g. [[InterfaceAnalyzer|Interface Analyzer]]) are better for these purposes. 

_Note:_ [ThermoMPNN](https://github.com/Kuhlman-Lab/ThermoMPNN) is a machine learning method that can be used to calculate the ddG of mutation, for benchmarking information see this [article](https://www.pnas.org/doi/10.1073/pnas.2314853121) by H. Dieckhaus, et al. It may perform better than cartesian ddG in some situations, consider if this is a better tool for your application. 


Reference
==========

The algorithm is developed by Phil Bradley and Yuan Liu. Details about the method and benchmark result on monomeric ddg dataset ([[Kellogg et al. | ddg-monomer]]) was published in:

Hahnbeom Park, Philip Bradley, Per Greisen Jr., Yuan Liu, Vikram Khipple Mulligan, David E Kim, David Baker, and Frank DiMaio (2016) "Simultaneous optimization of biomolecular energy function on features from small molecules and macromolecules", JCTC. [Full text](https://pubs.acs.org/doi/10.1021/acs.jctc.6b00819).

Additional improvements and benchmarking has been described in:

Frenz, Brandon, Steven M. Lewis, Indigo King, Frank DiMaio, Hahnbeom Park, and Yifan Song. 2020. “Prediction of Protein Mutational Free Energy: Benchmark and Sampling Improvements Increase Classification Accuracy.” Frontiers in Bioengineering and Biotechnology 8 (October): 558247. [Full text](https://www.frontiersin.org/journals/bioengineering-and-biotechnology/articles/10.3389/fbioe.2020.558247/full).

Purpose
=======

The purpose of this application is to predict the change in stability (the ddG) of point mutations in a protein structure. The number of replicas needed to produce the predicted ddG values is greatly reduced compared to [[ddg_monomer|ddg monomer]] due to the use of Cartesian-space refinement which allows small local backbone movement during the refinement procedure. The ddG is calculated in [[Rosetta energy units|Units in Rosetta]] by taking the difference between the initial (wild-type) structure and the relaxed, mutated structure. A scaling factor of 2.94 is needed to then convert these values into kcal/mol, see the Supporting Information in the paper by [Park, et al.](https://pmc.ncbi.nlm.nih.gov/articles/PMC5515585/) for more details. 

Command Line Options
====================
First, input pdb should be properly relaxed in cartesian space with unrestrained backbone and sidechain coordinates. 

_Note:_ unrestrainted relax has been found to produce fewer errors in classification. See the Frenz et al. paper for details. This represents a change from previous version.

Please refer to [[here|relax]] for more information; also see an example command line:

```
This is the command line we used for preminimization:

$ROSETTABIN/relax -s $pdb -use_input_sc \
-ignore_unrecognized_res \
-nstruct 20 \
-relax:cartesian-score:weights ref2015_cart \
-relax:min_type lbfgs_armijo_nonmonotone \
-relax:script cart2.script \
-fa_max_dis 9.0 # modify fa_atr and fa_sol behavior, really important for protein stability (default: 6). This flag needs to match what is used in the cartesian ddg options below.

with file "cart2.script":

switch:cartesian
repeat 2
ramp_repack_min 0.02  0.01     1.0  50
ramp_repack_min 0.250 0.01     0.5  50
ramp_repack_min 0.550 0.01     0.0 100
ramp_repack_min 1     0.00001  0.0 200
accept_to_best
endrepeat

```

### Protein stability mode

An example of command line is
```
cartesian_ddg.linuxgccrelease
 -database $ROSETTADB
 -s [inputpdb]
 -ddg:mut_file [mutfile] # same syntax with what being used in ddg-monomer application.
 -ddg:iterations 3 # can be flexible; 3 is fast and reasonable
 -force_iterations false (default True) #If this flag is on the protocol will stop when the results converge on a score
 -ddg::score_cutoff 1.0 #If the lowest energy scores are within this cutoff the protocol will end early.
 -ddg::cartesian
 -ddg::dump_pdbs false # you can save mutants pdb if you want
 -bbnbr 1 # bb dof, suggestion: i-1, i, i+1
 -fa_max_dis 9.0 # modify fa_atr and fa_sol behavior, really important for protein stability (default: 6)  
 -[scorefunction option]: any other options for score function containing cart_bonded term, for example, -beta_cart or 
 -score:weights talaris2014_cart]
 -ddg::legacy false #Using the latest version of the code
```

For ddg:mut_file format, please refer to [[here | ddg-monomer]]. Note that this file contains the mutations you want to introduce at once, which means, specifying more than one mutation in a single file will try to mutate all together at same time. Scanning over separate mutations (e.g. ALA scanning) will therefore require running this app separately using different mut_file as input.


### Interface mode

This application can do PPI and Protein small molecule simulation. **This has not been thoroughly benchmarked.** Other tools, such as [[InterfaceAnalyzer|Interface Analyzer]] are recommended for these types of studies. 

Optional options:
```
-mut_only #skip native structure
-interface_ddg -1 #jump number for interface (-1 means the last jump)
```

Here the application calculates differences in energy by detaching "the part in pose defined by the last jump" from the rest of pose; the easiest way of doing this is to edit the input pdb so that the ligand (either protein or small molecule)
locates at its end. One can check whether it is working properly by running with an optional flag "-ddg:dump_pdbs", which will output *_bj.pdb (before dissociation) and *_aj.pdb (after dissociation). 

Frenz et. al flags and options (cartddg2020)
==========================================

## Prep:

```
ROSETTASCRIPTS>
    <SCOREFXNS>
        <ScoreFunction name="fullatom" weights="ref2015_cart" symmetric="0">
        </ScoreFunction>
	</SCOREFXNS>
	<MOVERS>
        <FastRelax name="fastrelax" scorefxn="fullatom" cartesian="1" repeats="4"/> 
	</MOVERS>
	<PROTOCOLS>
        <Add mover="fastrelax"/>
    </PROTOCOLS>
    <OUTPUT scorefxn="fullatom"/>
</ROSETTASCRIPTS>
```

```
rosetta_scripts.static.release \
    -database $ROSETTA_DATABASE \
    -s /workdir/input.pdb\
    -parser:protocol /workdir/relax.xml\
    -default_max_cycles 200\
    -missing_density_to_jump\
    -ignore_zero_occupancy false\
    -fa_max_dis 9
```

## Run:

```
#!/bin/bash
cartesian_ddg\
    -database $ROSETTA3_DB\
    -s ${input.pdb}\
    -ddg::iterations 5\
    -ddg::score_cutoff 1.0\
    -ddg::dump_pdbs false\
    -ddg::bbnbrs 1\
    -score:weights ref2015_cart\
    -ddg::mut_file ${mutfile.mut}\
    -ddg:frag_nbrs 2\
    -ignore_zero_occupancy false\
    -missing_density_to_jump \
    -ddg:flex_bb false\
    -ddg::force_iterations false\
    -fa_max_dis 9.0\
    -ddg::json true\
    -ddg:legacy false
```

Expected Outputs & post-processing
===============

Running application will produce a file named [pdbfile_prefix]\_[mutationindex].ddg; for example 1ctf\_G44S.ddg.

The file contains lines (monomer mode):
```
COMPLEX: RoundX: [WT or MUT\_XXXX]: [totalscore] fa_atr: [fa\_atr] .....

```

In the paper, the difference in totalscores averaged over 3 rounds for WT and MUT is taken as ddG. Using the lowest scores from each round works equally well as shown in the Frenz 2020 paper, as does running until the scores converge to within 1 REU:

```
ddG = avrg(MUT totalscore) - avrg(WT totalscore)

```

With interface mode, 

```
COMPLEX: RoundX: [WT or MUT\_XXXX]: [totalscore] fa_atr: [fa\_atr] .....
APART: RoundX: [WT or MUT\_XXXX]: [totalscore] fa_atr: [fa\_atr] .....
OPT_APART: RoundX: [WT or MUT\_XXXX]: [totalscore] fa_atr: [fa\_atr] .....


ddG_bind = avrg(COMPLEX MUT totalscore) - avrg(COMPLEX WT totalscore)
ddG_mono = avrg(OPT_APART MUT totalscore) - avrg(OPT_APART WT totalscore)

```

Simple way of estimating ddG of binding is to use ddG_bind alone, after converting from [[Rosetta energy units|Units in Rosetta]] to kcal/mol. One can also combine ddG_mono to consider monomeric stability change as well; how to combine both values hasn't been well benchmarked within cartesian_ddg application.

##See Also

* [[ddg_monomer application| ddg-monomer]]: An application for predicting the ddG of point mutations in monomeric proteins.
* [[Analysis applications | analysis-applications]]: other design applications.
* [[Point mutation scan| pmut-scan-parallel ]]: Parallel detection of stabilizing point mutations using design.
* [[Application Documentation]]: Application documentation home page.
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta.
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs.
* [[Units in Rosetta]]: A description of how Rosetta handles various units.