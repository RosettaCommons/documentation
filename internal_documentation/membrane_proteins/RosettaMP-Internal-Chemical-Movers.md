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



## Contact
This project is currently not released and not ready for use by the general community. For questions, please contact: 
 - Rebecca Alford [rfalford12@gmail.com](rfalford12@gmail.com)
 - Corresponding PI: Jeff Gray [jgray@jhu.edu](jgray@jhu.edu)

<!--- Membrane Chemical Profiles Project --> 
<!--- END_INTERNAL -->