<!--- BEGIN_INTERNAL -->
<!--- Membrane Chemical Profiles Project --> 
# RosettaMP Membrane Chemical Profiles Project: Movers

[[_TOC_]]

## Benchmark Movers

### SampleTiltAngleMover

**About**
The `SampleTiltAngleMover` was designed to sample and score possible tilt angles of trans-membrane spanning helical peptides. With a good scoring function, this mover should sample tilt angles within a reasonable range of the experimentally determined tilt angle. Currently, the mover uses a combination of rigid body moves and membrane fast relax for sampling. The `mpframework_fa_2007` scoring function is currently the default. 

**Rosetta Scripts Interface**
The SampleTiltAngleMover can be used either with a default setup or custom setup using the interface below: 
```
<SampleTiltAngleMover weights="my_sfxn_weights">
```

**Where to find**
This mover is grouped with the membrane chemical profiles project benchmarking movers in `protocols/membrane/benchmark`

### 



## Contact
This project is currently not released and not ready for use by the general community. For questions, please contact: 
 - Rebecca Alford [rfalford12@gmail.com](rfalford12@gmail.com)
 - Corresponding PI: Jeff Gray [jgray@jhu.edu](jgray@jhu.edu)

<!--- Membrane Chemical Profiles Project --> 
<!--- END_INTERNAL -->