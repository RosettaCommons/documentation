#MakeRotLib application

Metadata
========

Author: P. Douglas Renfrew (renfrew@nyu.edu)
Author: Andrew Watkins (amw579@nyu.edu)

The documentation was updated in February 2016, by Andy Watkins.  Notes about how current usage differs from what is documented here were added on 9 November 2018 by Vikram K. Mulligan (vmulligan@flatironinstiutute.org) and on 27 November 2018 by Andy Watkins.  Minor tweaks were made on 13 May 2021 and 17 May 2021 by Vikram K. Mulligan. The PI for this application is Brian Kuhlman (bkuhlman@email.unc.edu).

[[_TOC_]]

Code and Demo
=============

The main mover is located in the application code at `       main/source/src/protocols/make_rot_lib      ` . The application code is located at `       main/source/src/apps/public/ncaa_utilities/MakeRotLib.cc      ` . The integration tests can be found at `       main/tests/integration/tests/make_rot_lib/      ` . The demo can be found at `       demos/public/make_rot_lib/      ` .

References
==========

P. Douglas Renfrew, Eun Jung Choi, Brian Kuhlman, "Using Noncanonical Amino Acids in Computational Protein-Peptide Interface Design" (2011) PLoS One. It is strongly recomended to read the paper as it provided addition details.

A *very* early version of this code was used to generate a bound dye rotamer library for Gulyani A, Vitriol E, Allen R, Wu J, Gremyachinskiy D, Lewis S, Dewar B, Graves LM, Kay BK, Kuhlman B, Elston T, Hahn KM. A biosensor generated via high-throughput screening quantifies cell edge Src dynamics. Nat Chem Biol. 2011 Jun 12;7(7):437-44. doi: 10.1038/nchembio.585. Erratum in: Nat Chem Biol. 2012 Aug;8(8):737. PubMed PMID: 21666688; PubMed Central PMCID: PMC3135387.

Purpose
===========================================

This code creats a Noncanonical Amino Acid (NCAA) rotamer library and is the second of three steps toward being able to use a NCAA in Rosetta.

Algorithm
=========

Rotamer libraries are sets of common side chain conformations that generally correspond to local minima on the side chain conformational energy landscape. Side chain conformations are usually represented as a set of mean angles and a standard deviation to indicate variability. Rotamer libraries are used in for two main purposes in Rosetta: to provide starting points for side chain optimization routines, and the relative frequency is used as a pseudo-energy. Traditionally rotamer libraries are created by collecting statistics from protein structures. Rosetta uses the backbone dependent Drunbrack rotamer libraries. Since there are not enough structures containing NCAAs they must be generated.

Running the MakeRotLib protocol consists of four steps

-   creating and input template and generating the MakeRotLib options files
-   running the MakeRotLib protocol on each option file
-   assembling the individual rotamer libraries in a single file
-   modify the ResidueType parameter file to be aware of our new rotamer library

Limitations
===========

This code was originally designed to make Dunbrack 2002 style rotamer libraries for noncanonical side chains with an alpha-peptide backbone. It is reasonably well extended to handle peptoid backbones and beta+-peptide backbones; moreover, it has the facility to generate the continuous distribution necessary for a Dunbrack 2010-style approach to a non-rotameric chi (such as chi2 of aspartate).

Input Files
===========

Rosetta primarily uses backbone dependent rotamer libraries. Backbone-dependent rotamer libraries list provide side chain conformations sampled from residue positions whose backbone dihedral angles fall in particular bins. In the case of the Drunbrack rotamer libraries used by Rosetta the bins are in 10 degree intervals for for both phi and psi for a total of 1296 (36\*36) phi/psi bins.  (For beta amino acids, for the moment, we employ 30 degree bins, for a total of 1728 (12\*12\*12).) To replicate this for the NCAAs we need to create a set of side chain rotamers for each member of a set of phi/psi bins.

The MakeRotLib protocol takes an option file as input. It requires an options file for each phi/psi bin. The first step in running it is creating these 1296 options files. Continuing from the HowToMakeResidueTypeParamFiles protocol capture we are again using ornithine as an example. Ornithine has 3 sidechain dihedral angles (chi). We want to sample each chi angle from 0 to 360 degrees in 30 degree intervals, and based on the chemistry of the side chain we predict that were will probably be three preferred angles for each chi angle at 60, 180, and 300 degrees for a total of 27 rotamers (3x3x3). We setup our MakeRotLib options file template as shown bellow.

The `       C40_rot_lib_options_XXX_YYY.in      ` file is shown bellow.

```
AA_NAME C40
OMG_RANGE 180 180 1
PHI_RANGE XXX XXX 1
PSI_RANGE YYY YYY 1
EPS_RANGE 180 180 1
NUM_CHI 3
NUM_BB 2
CHI_RANGE 1 0  330  30
CHI_RANGE 2 0  330  30
CHI_RANGE 3 0  330  30
CENTROID 300 1 300 1 300 1
CENTROID 300 1 300 1 180 2
CENTROID 300 1 300 1  60 3
CENTROID 300 1 180 2 300 1
CENTROID 300 1 180 2 180 2
CENTROID 300 1 180 2  60 3
CENTROID 300 1  60 3 300 1
CENTROID 300 1  60 3 180 2
CENTROID 300 1  60 3  60 3
CENTROID 180 2 300 1 300 1
CENTROID 180 2 300 1 180 2
CENTROID 180 2 300 1  60 3
CENTROID 180 2 180 2 300 1
CENTROID 180 2 180 2 180 2
CENTROID 180 2 180 2  60 3
CENTROID 180 2  60 3 300 1
CENTROID 180 2  60 3 180 2
CENTROID 180 2  60 3  60 3
CENTROID  60 3 300 1 300 1
CENTROID  60 3 300 1 180 2
CENTROID  60 3 300 1  60 3
CENTROID  60 3 180 2 300 1
CENTROID  60 3 180 2 180 2
CENTROID  60 3 180 2  60 3
CENTROID  60 3  60 3 300 1
CENTROID  60 3  60 3 180 2
CENTROID  60 3  60 3  60 3
TEMPERATURE 1
```

-   AA\_NAME | three letter code for the amno acid
-   OMG\_RANGE | omega range for the peptide bond _preceding_ the residue, expressed as STARTVAL ENDVAL INCREMENT
-   PHI\_RANGE | phi value for this bin phi value for this bin, expressed as STARTVAL ENDVAL INCREMENT
-   PSI\_RANGE | psi value for this bin psi value for this bin, expressed as STARTVAL ENDVAL INCREMENT 
-   EPS\_RANGE | omega range (referred to as "epsilon") for the peptide bond _following_ the residue, expressed as STARTVAL ENDVAL INCREMENT
-   BB_\_RANGE | optionally used to add additional backbone dihedrals. *Note that NUM_BB must reflect the number of backbone dihedrals not including omega and epsilon.*  Backbone dihedral indices are based on the order specified, and PHI\_RANGE, PSI\_RANGE, and BB\_RANGE all have the same effect, under the hood, of setting the range for the next backbone dihedral index. All are expressed as STARTVAL ENDVAL INCREMENT.
-   NUM\_BB | number of backbone dihedrals _not including_ omega (the preceding inter-residue bond) or epsilon (the following inter-residue bond)
-   NUM\_CHI | number side chain dihedral angles : This should be the same as in the parameter file.
-   CHI\_RANGE | The number of CHI\_RANGE fields needs to equal the values specified for NUM\_CHI.  The range is expressed as CHINUMBER STARTVAL ENDVAL INCREMENT, where CHINUMBER specifies the specific chi angle in the side chain, the first is closest to the  alpha carbon. 
-   CENTROID | Rotamer number for chi 1 | starting value { rotamer number for chi 2 | starting value }{etc.} : CENTROIDS specify the starting points for the K-means clustering described in the related publication. A CENTROID field is needs for each potential rotamer. The number of CENTROID fields defines the number of rotamers listed in the resulting rotamer library.
-   TEMPERATURE | Boltzmann distribution style temperature to translate from the energies generated by the protocol into probabilities.

-   CENTROID input is laborious, especially for residues with four chis and multiple nonrotameric chi angles (for example, tryptophan has twelve bins for chi2 in its Dun10 representation); manually specifying a four-chi residue with two such chis would require almost 1500 centroids. Consequently, we have developed an alternative syntax:
-   ROTWELLS lines allow the user to generate the Cartesian product of certain rotamer wells, so the above file would replace its CENTROID lines with

```
ROTWELLS 1 3  60 180 300 
ROTWELLS 2 3  60 180 300 
ROTWELLS 3 3  60 180 300 
```
-   Proline-like rotamer libraries, where there are two legal rotamers due to other constraints, make 'all possible combinations' undesirable, so the CENTROID format still has a niche.

To generate the 1296 input files we use a provided script that simply replace the XXX and YYY with the phi and psi values. The script is run as shown bellow.  (**Note: As of 9 Nov 2018, it is not necessary to generate thousands of input files.  Ranges can be specified in a single input file.**)

```
$ cd inputs
$ ../scripts/make_inputs C40_rot_lib_options_XXX_YYY.in
```

The number of chi angles and the CHI\_RANGE sampling interval are the primary determinants of the run time as they determine the number of rotamers that will be tested for each phi/psi bin. It is recommended to have at least 500 samples per chi. In the ornithine example we sample in 30 degree intervals for each of the 3 chi angles giving us a total of 1728 (12x12x12) conformations tested for each phi/psi bin. For a residue with a single chi 1 degree bins will suffice.

Running the MakeRotLib Protocol
===============================

The next step is to run the MakeRotLib protocol on each of the input files we created in step one. This is the most time consuming portion of the process and should probably be done on a cluster. As cluster setups vary, an example for a single MakeRotLib options file is provided. The other 1295 should be run identically.  (**Note: As of 9 Nov 2018, it is not necessary to generate thousands of input files.  Ranges can be specified in a single input file.**)

```
$ cd outputs
$ PATH/TO/ROSETTA/bin/MakeRotLib.default.macosclangrelease -database PATH/TO/rosetta/main/database -options_file ../inputs/C40_rot_lib_options_-60_-40.in >C40_rot_lib_options_-60_-40.log &
```

**Note:** The extension on your executable may be different.

The only options passed to the executable are the path to the database and the MakeRotLib options file. After the run completes a file called `       C40_-60_-40_bbdep.rotlib      ` should be in the output directory. This is the backbone dependent rotamer library for a phi of -60 and a psi of -40.

The log file from the rosetta run in includes quite a bit of useful output.

There are three main sections to the log output, `       ROTAMERS      ` , `       CENTROIDS      ` and `       FINAL ROTAMERS      ` sections. Each one shows the following data: phi, psi, omega and epsilon backbone dihedral angles, probability, total energy, torsion energy, intra-residue repulsive, intra-residue attractive, the number of chi angles, the assigned cluster number, the set of input chi angles, the set of minimized chi angles, the standard deviation, and the distance from that point to each of the cluster centroids.

The log file also displays the number of conformations per cluster, the average distance between the cluster center and the members of that cluster. Lack of conformations in a cluster and a large (\>30) average cluster centroid distance suggests that that cluster is higher in energy.

Options
-------

Mandatory input flags:

-   make\_rot\_lib:options\_file: the path to the rotlib options file we made above.

Optional input flags:

-   make\_rot\_lib:output\_logging: If true (the default), then logfiles are written out for every rotamer file generated.  The logfiles can be quite a bit larger than the rotamer files, though, and can easily fill up available space.  Setting this explicitly to false reduces output size considerably.  (The "-mute all" flag is also useful for this.)

Expected Outputs
================

You should have 1296 rotamer libraries, one for each phi/psi bin.

Assembilng the Individual Rotamer Libraries in to a Single File
===============================================================

After the MakeRotLib protocol has been run on all of the MakeRotLib options files the individual rotamer libraries for each phi psi bin need to be assembled in to a single file. This is accomplished with a provided script as shown bellow.

```
$ cd outputs
$ ../scripts/make_final_from_phi_psi.pl C40
```

The single file rotamer library should be called `       C40.rotlib      ` . The file should be placed in the ncaa\_rotlibs directory in the database.

```
$ cp C40.rotlibs PATH/TO/DATABASE/rosetta/main/database/ncaa_rotlibs/
```

Modifying the ResidueType Parameter File
========================================

The last step is modifying the residue type parameter file to use the new rotamer library. To do this we need to add the name of the rotamer library, the number chi angles it describes, and how many bins there are for each chi angle to the Residue type parameter file. The ornithine rotamer library is called C40.rotlib and the rotamer library describes 3 chi angles and each of those 3 chi angle has 3 rotamer numbers. So we would use the following commands to add that information to the file we created in HowToMakeResidueTypeParamFiles.

```
$ echo "NCAA_ROTLIB_PATH C40.rotlib" >> PATH/TO/rosetta/main/database/chemical/residue_type_sets/fa_standard/residue_types/l-ncaa/ornithine.params
$ echo "NCAA_ROTLIB_NUM_ROTAMER_BINS 3 3 3 3" >> PATH/TO/rosetta/main/database/chemical/residue_type_sets/fa_standard/residue_types/l-ncaa/ornithine.params
```

New things since last release
=============================

This application is new for the Rosetta 3.4 release.

## See Also

## See Also

* [[Utility applications | utilities-applications]]: other utility applications
* [[Unfolded State Energy calculator | unfolded-state-energy-calculator]]: for creating "reference energies" for using NCAAs in design
* [[Noncanonical Amino Acids]]: How to work with noncanonical amino acids
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
