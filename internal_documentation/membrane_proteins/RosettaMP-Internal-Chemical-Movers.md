<!--- BEGIN_INTERNAL -->
<!--- Membrane Chemical Profiles Project --> 
# RosettaMP Membrane Chemical Profiles Project: Movers

[[_TOC_]]

## Benchmark Movers

All of these movers were intended for membrane energy function benchmarking and can be found in `protocols/membrane/benchmark.` Please be wary that many of these were intended for small peptides and not large membrane proteins. If you would like to use, its probably best to contact Rebecca first ;)

### SampleTiltAngleMover

**About**

The `SampleTiltAngleMover` was designed to sample and score possible tilt angles of trans-membrane spanning helical peptides. With a good scoring function, this mover should sample tilt angles within a reasonable range of the experimentally determined tilt angle. Currently, the mover uses a combination of rigid body moves and membrane fast relax for sampling. The `mpframework_fa_2007` scoring function is currently the default. 

**Rosetta Scripts Interface**

The SampleTiltAngleMover can be used either with a default setup or custom setup using the interface below: 
```
<SampleTiltAngleMover name="sample_tilt" weights="my_sfxn_weights">
```

### MakePeptideMover

**About**

The make peptide mover takes a pose (typically created using `pose_from_sequence` outside the mover) and creates an ideal helix by setting all phi angles to -47˚, all psi angles to -57˚ and all omega angles to -175˚. This mover is intended to predict helix coordinates for designed peptides without a structure. This mover is called in the `build_helical_peptide.cc` app. 

**RosettaScripts Interface**

The MakePeptideMover can currently be setup by default or with custom phi, psi and omega settings. An example RosettaScripts interface with all tags is shown here: 

```
<MakePeptideMover name="make_peptide" phi=47, psi-57, omega=175 >
```

### RefinePeptideMover

**About**

The RefinePeptideMover aims to sample a broad range of conformations for peptides with unknown structure. The mover performs small and shear moves at high kT to perturb the structure out of an ideal helical conformation (helicity defined as ideal angles phi = 47˚, psi =57˚). This mover has only been tested on small peptides so contact Rebecca before using on other systems. The default scoring function is currently `mpframework_fa_2007`

**RosettaScripts Interface**

The RefinePeptideMover can be setup as default or with a custom score function. An example XML line is shown below: 

```
<RefinePeptideMover name="refine_peptide" weights="mpframework_fa_2007" >
```

### HelixInsertionEnergyMover

**About**

The `HelixInsertionEnergyMover` calculates the ∆∆G of insertion: the Rosetta energy required to transfer a peptide from solution into the bilayer. The peptide is refined in solution state, scored, inserted into the bilayer using OptimizeMembranePositionMover, and scored again. The transfer free energy is calculated as the difference between energy in bilayer and solution. 

**RosettaScripts Interface**

The HelixInsertionEnergyMover can be setup as default or with a custom score function. An example XML line is shown below: 
```
<HelixInsertionEnergyMover name="helix_insertion" weights="mpframework_fa_2007" >
```

### AddPeptideMetricsMover

**About**

The `AddPeptideMetricsMover` adds metrics including helicity and tilt angle to the score file for each decoy. These metrics are currently not general to more than one helix!

**RosettaScripts Interface**
Currently, the AddPeptideMetricsMover can only be setup via RosettaScripts with a default interface

```
<AddPeptideMetricsMover name="add_peptide">
```

## Contact
This project is currently not released and not ready for use by the general community. For questions, please contact: 
 - Rebecca Alford [rfalford12@gmail.com](rfalford12@gmail.com)
 - Corresponding PI: Jeff Gray [jgray@jhu.edu](jgray@jhu.edu)

<!--- Membrane Chemical Profiles Project --> 
<!--- END_INTERNAL -->