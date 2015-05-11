[[_TOC_]]

### Ligand docking

These movers replace the executable for ligand docking and provide greater flexibility to the user in customizing the docking protocol. An example XML file for ligand docking is found here (link forthcoming). The movers below are listed in the order found in the old executable.

#### StartFrom

```
<StartFrom name="&string" chain="&string" >
   <Coordinates x=(&float) y=(&float) z=(&float)/>
   <File filename=(&string) chain_for_hash=(&string)/>
</StartFrom>
```

Provide a list of XYZ coordinates. One starting coordinate will be chosen at random and the specified chain will be recentered at this location.

Alternately, provide a File tag specifying a JSON formatted file containing hashes of protein chains and associated starting positions. Coordinates and File tags cannot be combined. if a File tag is specified, the Mover will compute the hash of the chain specified with the "chain for hash" flag and use that to look up the appropriate starting position. This is useful if you are docking ligands into a large number of protein structures. The application generate\_ligand\_start\_position\_file will generate these JSON files, which are in the format:

        [
            {
                "input_tag" : "infile.pdb",
                "x" : 0.0020,
                "y" : -0.004,
                "z" : 0.0020,
                "hash" : 14518543732039167129
            }
        ]

At present, Boost hashing of floats is extremely build and platform dependent. You should not consider these hash files to be at all portable. This will be addressed in the near future.

#### Transform

```
<Transform name="&string" chain="&string" box_size="&real" move_distance="&real" angle="&real" cycles="&int" repeats="&int" temperature="&real" initial_perturb="&real" rmsd="&real"/>
```

The Transform mover is designed to replace the Translate, Rotate, and SlideTogether movers, and typically exhibits faster convergence and better scientific performance than these movers. The Transform mover performs a monte carlo search of the ligand binding site using precomputed scoring grids. Currently, this mover only supports docking of a single ligand, and requires that Scoring Grids be specified and computed.

-   chain: The ligand chain, specified as the PDB chain ID
-   box\_size: The maximum translation that can occur from the ligand starting point. the "box" here is actually a sphere with the specified radius. Any move that results in the center of the ligand moving outside of this radius will be rejected
-   move\_distance: The maximum translation performed per step in the monte carlo search. Distance should be specified in angstroms. A random value is selected from a gaussian distribution between 0 and the specified distance.
-   angle: The maximum rotation angle performed per step in the monte carlo search. Angle should be specified in degrees. a random value is selected from a gaussian distribution between 0 and the specified angle in each dimension.
-   cycles: The total number of steps to be performed in the monte carlo simulation. The lowest scoring accepted pose will be output by the mover
-   repeats: The total number of repeats of the monte carlo simulation to be performed. if repeats \> 1, the simulation will be performed the specified number of times from the initial starting position, with the final pose selected.
-   temperature: The boltzmann temperature for the monte carlo simulation. Temperature is held constant through the simulation. The higher the number, the higher the percentage of accepted moves will be. 5.0 is a good starting point. "Temperature" here does not reflect any real world units.
-   initial\_perturb: Make an initial, unscored translation and rotation. Translation will be selected from a random uniform distribution between 0 and the specified value (in angstroms). Additionally, the ligand will be randomly rotated 360 degrees around each of the x, y, and z axes. Large values are useful for benchmarking to scramble the starting position, and small values are useful for docking rod-like ligands in narrow pockets, where the Monte Carlo nature of the protocol may not allow for end-over end ligand flipping.
-   rmsd: The maximum RMSD to be sampled away from the starting position. if this option is specified, any move above the specified RMSD will be rejected.

#### Translate

```
<Translate name="&string" chain="&string" distribution=[uniform|gaussian] angstroms=(&float) cycles=(&int)/>
```

The Translate mover is for performing a course random movement of a small molecule in xyz-space. This movement can be anywhere within a sphere of radius specified by "angstroms". The chain to move should match that found in the PDB file (a 1-letter code). "cycles" specifies the number of attempts to make such a movement without landing on top of another molecule. The first random move that does not produce a positive repulsive score is accepted. The random move can be chosen from a uniform or gaussian distribution. This mover uses an attractive-repulsive grid for lightning fast score lookup.

#### Rotate

```
<Rotate name="&string" chain="&string" distribution=[uniform|gaussian] degrees=(&int) cycles=(&int)/>
```

The Rotate mover is for performing a course random rotation throughout all rotational degrees of freedom. Usually 360 is chosen for "degrees" and 1000 is chosen for "cycles". Rotate accumulates poses that pass an attractive and repulsive filter, and are different enough from each other (based on an RMSD filter). From this collection of diverse poses, 1 pose is chosen at random. "cycles" represents the maximum \# of attempts to find diverse poses with acceptable attractive and repulsive scores. If a sufficient \# of poses are accumulated early on, less rotations then specified by "cycles" will occur. This mover uses an attractive-repulsive grid for lightning fast score lookup.

#### SlideTogether

```
<SlideTogether name="&string" chain="&string"/>
```

The initial translation and rotation may move the ligand to a spot too far away from the protein for docking. Thus, after an initial low resolution translation and rotation of the ligand it is necessary to move the small molecule and protein into close proximity. If this is not done then high resolution docking will be useless. Simply specify which chain to move. This mover then moves the small molecule toward the protein 2 angstroms at a time until the two clash (evidenced by repulsive score). It then backs up the small molecule. This is repeated with decreasing step sizes, 1A, 0.5A, 0.25A, 0.125A.

#### HighResDocker

```
<HighResDocker name="&string" repack_every_Nth=(&int) scorefxn="string" movemap_builder="&string" />
```

The high res docker performs cycles of rotamer trials or repacking, coupled with small perturbations of the ligand(s). The "movemap\_builder" describes which side-chain and backbone degrees of freedom exist. The Monte Carlo mover is used to decide whether to accept the result of each cycle. Ligand and backbone flexibility as well as which ligands to dock are described by LIGAND\_AREAS provided to INTERFACE\_BUILDERS, which are used to build the movemap according the the XML option.

#### FinalMinimizer

```
<FinalMinimizer name="&string" scorefxn="&string" movemap_builder=&string/>
```

Do a gradient based minimization of the final docked pose. The "movemap\_builder" makes a movemap that will describe which side-chain and backbone degrees of freedom exist.

#### InterfaceScoreCalculator

```
<InterfaceScoreCalculator name=(string) chains=(comma separated chars) scorefxn=(string) native=(string) compute_grid_scores=(bool)/>
```

InterfaceScoreCalculator calculates a myriad of ligand specific scores and appends them to the output file. After scoring the complex the ligand is moved 1000 Å away from the protein. The model is then scored again. An interface score is calculated for each score term by subtracting separated energy from complex energy. If compute\_grid\_scores is true, the scores for each grid will be calculated. This may result in the regeneration of the scoring grids, which can be slow. If a native structure is specified, 4 additional score terms are calculated:

1.  ligand\_centroid\_travel. The distance between the native ligand and the ligand in our docked model.
2.  ligand\_radious\_of\_gyration. An outstretched conformation would have a high radius of gyration. Ligands tend to bind in outstretched conformations.
3.  ligand\_rms\_no\_super. RMSD between the native ligand and the docked ligand.
4.  ligand\_rms\_with\_super. RMSD between the native ligand and the docked ligand after aligning the two in XYZ space. This is useful for evaluating how much ligand flexibility was sampled.

#### ComputeLigandRDF

```
<ComputeLigandRDF name=(string) ligand_chain=(string) mode=(string)>
    <RDF name=(string)/>
</ComputeLigandRDF>
```

ComputeLigandRDF computes Radial Distribution Functions using pairs of protein-protein or protein-ligand atoms. The conceptual and theoretical basis of Rosettas RDF implementation is described in the [ADRIANA.Code Documentation](http://www.molecular-networks.com/files/docs/adrianacode/adrianacode_manual.pdf) . A 100 bin RDF with a bin spacing of 0.1 Å is calculated.

all RDFs are inserted into the job as a string,string pair. The key is the name of the computed RDF, the value is a space separated list of floats

The outer tag requires the following options:

-   ligand\_chain: The PDB ID of the ligand chain to be used for RDF computation.
-   mode: The type of RDF to compute. valid options are "interface" in which the RDF is computed using all ligand atoms and all protein atoms within 10 Å of the ligand, and "pocket" in which the RDF is computed using all protein atoms within 10 Å of the ligand.

The ComptueLigandRDF mover requires that one or more RDFs be specified as RDF subtags. Descriptions of the currently existing RDFs are below:

##### RDFEtableFunction

RDFEtableFunction computes 3 RDFs using the Analytic Etables used to compute fa\_atr, fa\_rep and fa\_solv energy functions.

RDFEtableFunction requires that a score function be specified using the scorefxn option in its subtag.

##### RDFElecFunction

RDFElecFunction computes 1 RDF based on the fa\_elec electrostatic energy function.

RDFElecFunction requires that a score function be specified using the scorefxn option in its subtag.

##### RDFHbondFunction

RDFHbondFunction computes 1 RDF based on the hydrogen bonding energy function.

##### RDFBinaryHbondFunction

RDFBinaryHbondFunction computes 1 RDF in which an atom pair has a score of 1 if one atom is a donor and the other is an acceptor, and a 0 otherwise, regardless of whether these atoms are engaged in a hydrogen bonding interaction.

### Enzyme design

#### EnzRepackMinimize

EnzRepackMinimize, similar in spirit to RepackMinimize mover, does the design/repack followed by minimization of a protein-ligand (or TS model) interface with enzyme design style constraints (if present, see AddOrRemoveMatchCsts mover) using specified score functions and minimization dofs. Only design/repack or minimization can be done by setting appropriate tags. A shell of residues around the ligand are repacked/designed and/or minimized. If constrained optimization or cst\_opt is specified, ligand neighbors are converted to Ala, minimization performed, and original neighbor sidechains are placed back.

```
<EnzRepackMinimize name="&string" scorefxn_repack=(score12 &string) scorefxn_minimize=(score12 &string) cst_opt=(0 &bool) design=(0 &bool) repack_only=(0 &bool) fix_catalytic=(0 &bool) minimize_rb=(1 &bool) rb_min_jumps=("" &comma-delimited list of jumps) minimize_bb=(0 &bool) minimize_sc=(1 &bool) minimize_lig=(0 & bool) min_in_stages=(0 &bool) backrub=(0 &bool) cycles=(1 &integer) task_operations=(comma separated string list)/>
```

-   scorefxn\_repack: scorefunction to use for repack/design (defined in the SCOREFXNS section, default=score12)
-   scorefxn\_minimize: similarly, scorefunction to use for minimization (default=score12)
-   cst\_opt: perform minimization of enzdes constraints with a reduced scorefunction and in a polyAla background. (default= 0)
-   design: optimize sequence of residues spatially around the ligand (detection of neighbors need to be specified in the flagfile or resfile, default=0)
-   repack\_only: if true, only repack sidechains without changing sequence. (default =0) If both design and repack\_only are false, don't repack at all, only minimize.
-   minimize\_bb: minimize back bone conformation of backbone segments that surround the ligand (contiguous neighbor segments of \>3 residues are automatically chosen, default=0)
-   minimize\_sc: minimize sidechains (default=1)
-   minimize\_rb: minimize rigid body orientation of ligand (default=1)
-   rb\_min\_jumps: specify which jumps to minimize. If this is specified it takes precedence over minimize\_rb above. Useful if you have more than one ligand in the system and you only want to optimize one of the ligands, e.g., rb\_min\_jumps=1,2 would minimize only across jumps 1&2.
-   minimize\_lig: minimize ligand internal torsion degrees of freedom (allowed deviation needs to be specified by flag, default =0)
-   min\_in\_stages: first minimize non-backbone dofs, followed by backbone dofs only, and then everything together (default=0)
-   fix\_catalytic: fix catalytic residues during repack/minimization (default =0)
-   cycles: number of cycles of repack-minimize (default=1 cycle) (Note: In contrast to the enzyme\_design application, all cycles use the provided scorefunction.)
-   backrub:use backrub to minimize (default=0).
-   task\_operations: list of task operations to define the packable/designable residues, as well as the minimizable residues (the minimizable resiudes will the packable residues as well as such surrounding residues as needed to allow for efficient minimization). If explicit task\_operations are given, the design/repack\_only flags will not change them. (So it is possible to have design happen with the repack\_only flag set.) -- If task\_operations are not given, the default (command line controlled) enzyme\_design task will be used. Keep in mind that the default flags are to design everything and not to do interface detection, so being explicit with flags is recommended.

#### AddOrRemoveMatchCsts

Add or remove enzyme-design style pairwise (residue-residue) geometric constraints to/from the pose. A cstfile specifies these geometric constraints, which can be supplied in the flags file (-enzdes:cstfile) or in the mover tag (see below).

The "-run:preserve\_header" option should be supplied on the command line to allow the parser to read constraint specifications in the pdb's REMARK lines. (The "-enzdes:parser\_read\_cloud\_pdb" also needs to be specified for the parser to read the matcher's CloudPDB default output format.)

```
<AddOrRemoveMatchCsts name="&string" cst_instruction=( "void", "&string") cstfile="&string" keep_covalent=(0 &bool) accept_blocks_missing_header=(0 &bool) fail_on_constraints_missing=(1 &bool)/>
```

-   cst\_instruction: 1 of 3 choices - "add\_new" (read from file), "remove", or "add\_pregenerated" (i.e. if enz csts existed at any point previosuly in the protocol add them back)
-   cstfile: name of file to get csts from (can be specified here if one wants to change the constraints, e.g. tighten or relax them, as the pose progresses down a protocol.)
-   keep\_covalent: during removal, keep constraints corresponding to covalent bonds between protein and ligand intact (default=0).
-   accept\_blocks\_missing\_header: allow more blocks in the cstfile than specified in header REMARKs (see enzdes documentation for details, default=0)
-   fail\_on\_constraints\_missing: When removing constraints, raise an error if the constraint blocks do not exist in the pose (default=1).

#### PredesignPerturbMover

PredesignPerturbMover randomly perturbs a ligand in a protein active site. The input protein will be transformed to a polyalanine context for residues surrounding the ligand. A number of random rotation+translation moves are made and then accepted/rejected based on the Boltzmann criteria with a modified (no attractive) score function (enzdes\_polyA\_min.wts).

PredesignPerturbMover currently will perturb only the last ligand in the pose (the last jump).

    <PredesignPerturbMover name=(&string) trans_magnitude=(0.1 &real) rot_magnitude=(2.0 &real) dock_trials=(100 &integer) task_operations=(&string,&string)/>

-   dock\_trials - the number of Monte Carlo steps to attempt
-   trans\_magnitude - how large (stdev of a gaussian) a random translation step to take in each of x, y, and z (angstrom)
-   rot\_magnitude - how large (stdev of a gaussian) a random rotational step to take in each of the Euler angles (degrees)
-   task\_operations - comma separated list of task operations to specify which residues (specified as designable in the resulting task) are converted to polyAla

### Ligand design

These movers work in conjunction with ligand docking movers. An example XML file for ligand design is found here (link forthcoming). These movers presuppose the user has created or acquired a fragment library. Fragments have incomplete connections as specified in their params files. Combinatorial chemistry is the degenerate case in which a core fragment has several connection points and all library fragments have only one connection point.

#### GrowLigand

```
<GrowLigand name="&string" chain="&string"/>
```

Randomly connects a fragment from the library to the growing ligand. The connection point for connector atom1 must specify that it connects to atoms of connector atom2's type, and visa versa.

#### AddHydrogens

```
<AddHydrogens name="&string" chain="&string"/>
```

Saturates the incomplete connections with H. Currently the length of these created H-bonds is incorrect. H-bonds will be the same length as the length of a bond between connector atoms 1 and 2 should be.