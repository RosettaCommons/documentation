# Quantum mechanical energy calculations in Rosetta

Back to [[Rosetta basics|Rosetta-Basics]].
Page created 16 November 2021 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).
Fleshed out 1 May 2024 by Noora Azadvari, University of Oregon (eazadvar@uoregon.edu).

[[_TOC_]]

## Citation
GAMESS needs to be cited when using RosettaQM:

[Barca, G. M. J. et al. The Journal of Chemical Physics 152, 154102 (2020)](https://doi.org/10.1063/5.0005188)


## Summary

Traditionally, Rosetta has used a quasi-Newtonian force field for energy calculations.  This has allowed Rosetta protocols to score a large macromolecular structure rapidly (typically in milliseconds) and repeatedly, permitting large-scale sampling of conformation and/or sequence space.  The downside, however, has been that force fields are of finite accuracy.  In late 2021, we added support for carrying out quantum mechanical energy and geometry optimization calculations in the context of a Rosetta protocol, by calling out to a third-party quantum chemistry software package.  This page summarizes how to set up and use this functionality.

The protocols in RosettaQM use **Single point energy calculation** , **Geometry optimization** or a combination of them. 

## Important considerations

### Molecular system size, level of theory, and computation time

GAMESS can only process 2000 atoms at time. Therefore, for systems with larger than 2000 atoms, the molecule needs to be fragmented through FMO. This limit can be increased, but it is not recommended. 

### Computer memory

TODO

### CPU usage (especially in multi-threaded or multi-process contexts)

TODO

### Disk usage

TODO

## Supported third-party quantum chemistry software packages

All Rosetta QM calculations are performed through calls to third-party quantum chemistry software packages.  These must be downloaded and installed separately, and users must have appropriate licences and privilegse to use these.  Supported packages include:

### The General Atomic and Molecular Electronic Structure System (GAMESS)

[GAMESS](https://www.msg.chem.iastate.edu/index.html) is a versatile quantum chemistry package written in FORTRAN, and developed by the [Gordon group at Iowa State University](https://www.msg.chem.iastate.edu/group/members.html).  Users may agree to the licence agreement and obtain the software from [the GAMESS download page](https://www.msg.chem.iastate.edu/gamess/download.html).

#### Installation and setup

Here we give an example of installing *GAMESS version September 30, 2023 R2 for 64 bit x86_64 under Linux using GNU compilers*. After submitting the request to download, it takes around a day or less to receive an email with the link. After downloading the *.tar.gz file, transfer it 
to the desired node if needed. Unzip the file with following command:

`tar -xzvf <file-name>`

It will create a directory named `gamess` with files and subfolders inside it. Change the directory to this folder with `cd gamess`. The instructions for installation are provided in `README.md` file. 

Run executable `config` file with `./config`. It will ask you questions about your system. You need to open a new terminal window, to search the answers for those questions. Here are the questions:

| Question | Recommended answer |
| ------- | -------------------- |
|What is the type of your machine?|type `uname -a` in the new window. Here we use Linux, so the answer is `linux64`. All possible options are provided as a list on the left column. |
|Where is the GAMESS software located on your system?| Press enter for default |
|GAMESS build directory?|This can be the same as where gamess is located. So we provide the same path again.|
|Please provide a version number for the GAMESS executable.|Press enter for default|
|Are you building for a specific HPC system?|Press enter for none (unless you use a specific one)|
|Please enter your choice of FORTRAN:|gfortran|
|Please enter only the first decimal place, such as 8.2 or 11.2:|type `gfortran -v` in the new window. the last line shows version as `gcc version xx.x.x `, enter the version with first decimal place as an answer.|
|Enter your math library choice from one of the options below:|These libraries might be installed through modules, so it would be advised to search for them through `module spider <library-name>` and choose the best available one. The path to root can also be found through `module show <library-name>`|
|communication library|We recommend using `sockets`.|
|Optional: Build LibXC interface?|If your gcc version was higher that 5.5, then answer `yes`.|
|Do you want to use LIBCCHEM 2.0?|`no`|
|other questions|Based on your liking and system. None of them are required though.|

YAY! Now you have all configurations set, and it can be found in `gamess/install.info`. Some options can still be edited, as mentioned above. 

#### Compiling GAMESS

Use `make` or `make -j(number_of_processors)`. You can find the number of processors in your linux system by typing `nproc` in command line. 

#### Using GAMESS with Rosetta

You need to set `gamess_executable_version` and `gamess_path` tags in xml file. `gamess_path` 
is the directory that contains gamess executable. In this directory you will find a file with format `gamess.$$.x` where `$$` is the executable version. 

An example of using these tags in code (note that this is not a real case, and you need to use other tags to set the basis set and other configurations.)
```
<ROSETTASCRIPTS>
    <SCOREFXNS>
        <ScoreFunction name="gamess_energy" weights="empty" >
            <Reweight scoretype="gamess_qm_energy" weight="1.0" />
            <Set 
                gamess_path="<path-to-gamess-directory>"
                gamess_executable_version="<version>"
            />
        </ScoreFunction>
    </SCOREFXNS>
    <PROTOCOLS>
        <Add metrics="gamess_energy" />
    </PROTOCOLS>
</ROSETTASCRIPTS>
```


##### Point energy calculations with GAMESS within a Rosetta protocol

A single point energy (SPE) calculation with GAMESS can be run through Rosetta directly from the command line. Depending on the user preference, the user can either use an XML script or run directly from the command-line interface. Here are two tutorials to demonstrate how this can be done:

[[Tutorial #1|GAMESSPointEnergyTutorial1]]
[[Tutorial #2|GAMESSPointEnergyTutorial2]]

###### Dealing with the influence of solvent

When modelling biological macromolecules, the effect of solvent cannot be discounted.  Indeed, the hydrohobic effect is the dominant effect that causes proteins to fold.  Solvent affects computed energies in two ways.  First, there is the enthalpy of interaction of a biomolecule with the surrounding solvent.  Second, the shape and interacting groups presented by a molecule infuence solvent entropy.  The hydrohobic effect is largely an entropic effect: hydrophobic groups that are unable to form hydrogen bonds with water force an ordering of water molecules when they are solvated, since the accessible low-enthalpy states, in which water molecules satisfy their hydrogen bonds by bonding to one another, are fewer when some water conformations are effectively prohibited by the presence of a non-hydrogen bonding group.

GAMESS can model solvent effects in three ways:

1.  By ignoring them completely.  This is equivalent to modelling the macromolecule in vacuum, and can be achieved by setting `-quantum_mechanics:GAMESS:default_solvent GAS` on the commandline, or `gamess_solvent="GAS"` in the scoring function setup.  In most circumstances, this is not advised: one would not expect a protein to fold, for instance, if water is not present.

2.  By modelling only electrostatic interactions with the solvent, and electrostatic screening effects.  The default PCM (polarizable continuum) model, with solvent set to the default value of `WATER`, will do this.  This is roughly equivalent to explicitly modelling water molecules and carrying out a vacuum calculation, up to the limits of accuracy of any continuum (implicit solvent) model.  This does _not_ capture the effects of the macromolecule's conformation on solvent entropy.  Again, this is not advised in most circumstances.  However, since the `gamess_qm_energy` is a scoring _term_ and not an independent scoring _function_, one can use a sum of QM and molecular mechanics terms to capture solvent enthalpy and entropy.  For instance:

```xml
<ScoreFunction name="qm_with_rosetta_solvation" weights="empty.wts" >
            <!-- Use GAMESS for enthalpic interactions including solvent electrostatics: -->
            <Reweight scoretype="gamess_qm_energy" weight="1.0" />
            <!-- Use Rosetta's ref2015 energy function for solvent entropy effects: -->
            <Reweight scoretype="fa_sol" weight="1.0" />
            <Reweight scoretype="fa_intra_sol_xover4" weight="1.0" />
            <Reweight scoretype="lk_ball_wtd" weight="1.0" />
            <Set ... QM setup here ... />
</ScoreFunction>
```

3.  By modelling electrostatic interactions with the water, plus _c_avitation, _d_ispersion, and local solvent _s_tructure effects (CSD model) using an empirically-fitted SMD (solvation model density) model.  The CSD part of the SMD model approximates the entropic effects, though this has not been widely tested for biological macromolecules, particuarly to simulate solvent entropy-mediated effects like protein folding.  In theory, this model should be more general than Rosetta's solvation model, though, and should support a wider range of solvents (including many organic solvents).  To enable the SMD solvation model, set `quantum_mechanics:GAMESS:default_use_smd_solvent true` on the commandline, or `gamess_use_smd_solvent="true"` in the scorefunction settings.

##### Geometry optimization with GAMESS within a Rosetta protocol

TODO

##### Transition state identification with GAMESS within a Rosetta protocol

TODO

#### Rosetta-GAMESS bridge code organization

TODO

### Psi4

TODO

### Orca

TODO

### NWChem

TODO

## Common issues

||Problem | Reason| Solution |
|--|----|-----|----|
|1|Errors about charge and multiplicity with FMO | open termini | The -ignore_zero_occupancy false flag is often needed. |
|2|Errors with the `-auto_setup_metals` flag (see the [[Metals]] page) or the [[SetupMetalsMover]], especially with histidine.|Incorrect tautomerization of histidines that coordinate metals can result in the proton being removed from neutral histidine, yielding an improbable negatively-charged histidine and an incorrect electronic configuration of the system.|Use the [[MutateResidueMover]] to manually mutate histidine residues to either "HIS" (protonated on the epsilon nitrogen) or "HIS_D" (protonated on the delta nitrogen) tautomer, to ensure that the proton is on the nitrogen that is _not_ coordinating the metal.  Do this _prior_ to using the [[SetupMetalsMover]]|
