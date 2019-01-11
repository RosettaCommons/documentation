#Symmetry User's Guide.

Metadata
========

This document was last edited 7/20/2017. The original authors were Ingemar Andre and Frank DiMaio.

[[_TOC_]]

Introduction
============

Many proteins assemble into structures with internal symmetry. The symmetry code in Rosetta3 was developed to provide a framework to enforce symmetry in the conformation among equivalent subunits in the assembly. In order to maintain symmetry in a Rosetta simulation, three different types of degrees of freedoms needs to be symmetrically coupled: backbone, sidechain and rigid-body. Once a Pose is symmetrical, Rosetta contains all the machinery to maintain symmetry for all types of operations that modifies the conformation. In this document the basic machinery responsible for symmetry is described. A typical user will not directly interact with this basic code, instead the control and description of symmetry in the system is maintained with input symmetry definitions.

Symmetry in proteins
====================

Proteins can adopt a range of different symmetries. The most common one is cyclic symmetry which involves n-fold rotation around a symmetry axis (Cn symmetry). A majority of symmetric proteins are homodimers that have C2 symmetry. Another common group is the Dihedral symmetries that combine one n-fold symmetry axis with perpendicular twofold symmetry axis. For example D2 symmetry involves a dimer of dimers. Yet more complicated symmetries can be found in the cubic group. Of particular interest is the icosahedral symmetries found in virus capsids. Icosahedra has 2-fold, 3-fold and 5-fold symmetries. Moving beyond point group symmetries, proteins can form filaments using helical symmetry which involves both rotational symmetry as well as translational symmetry. Finally, proteins crystalizes with spacegroup symmetries, a type of symmetry not found in biogical proteins.

Rosetta is capable of describing all these types of symmetries. The only restriction is that all repeating units in the system must have a chemically identical environment. The smallest repeating unit with this property is the asymmetric unit of the system. The asymmetric unit is typically identical to a subunit.

Overview: How to run a protocol with symmetry
=============================================

Assuming the protocol you are using has been adopted to symmetry (if not see [How to adopt your protocol to use symmetry](#how-to-adopt-your-protocol-to-use-symmetry), this section describes the steps to use symmetry in Rosetta.

1. Generate a symmetry definition file.
2. If necessary modify symmetry definition file. This typically involves changing the set\_dof lines.
3. Add symmetry related flags.
4. Make sure you use the binary silent files format if you output silent files.

How to generate symmetry definitions <a name="generate" />
------------------------------------

To aid in creating a symmetry definition file from a symmetric (or near-symmetric) PDB, an application – **make\_symmdef\_file.pl** – has been included in src/apps/public/symmetry. Running this application without arguments gives an overview of usage; see [[make_symmdef_file|make-symmdef-file]] for more details. Also, a tutorial is present [here](https://www.rosettacommons.org/demos/latest/tutorials/Symmetry/Symmetry).

To aid in creation of symmetry definition files from scratch, typically for denovo prediction, – **make\_symmdef\_file\_denovo.py** – has been included in src/apps/public/symmetry. Running this application without arguments gives an overview of usage; see [[make_symmdef_file_denovo|make-symmdef-file-denovo]] for more details.

How to generate crystal symmetry _without_ making a symmdef file
----------------------------------------------------------------

If you wish to model a structure in its crystal lattice, a symmetry definition file is not needed.  Rather, one can use the flag **-symmetry_definition CRYST1**.  If this option is used, there are two other relevant flags:

**-interaction_shell ##** specifies the distance (in Angstrom) away from the input structure to generate symmetric partners.

**-refinable_lattice** enables refinement of lattice parameters

Alternately, the same control is given through RosettaScripts.  To create systems with 3D lattice symmetries:

```
<MakeLatticeMover name=make_lattice contact_dist=24/>
```
Make a lattice from the input PDB and CRYST1 line.  Include all subunits within 'contact_dist'.

There is also a mover aimed at handling 2D lattice symmetries:
```
<MakeLayerMover name=make_layer contact_dist=24/>
```
Make a 2D lattice from the input PDB and CRYST1 line.  The CRYST1 line must correspond to one of the 17 layer groups.

There are two movers aimed at manipulating these lattice symmetries (both work with 2D & 3D):
```
<DockLatticeMover name=crystdock fullatom=1 trans_step=1 rot_step=2 ncycles=100 scorefxn=talaris2013 />
```
Docking within a crystal lattice.  If fullatom=1 it does fullatom docking with repacks and min steps; if fullatom=0 you need to provide a centroid energy function (e.g. score4_smooth) and it will also add lattice slide moves.  _trans_step_ and _rot_step_ give the magnitude of perturbation; _ncycles_ is # of steps to run.

```
<UpdateCrystInfo name=updatecrystinfo/>
```
Convert back to an asymm pose with a valid CRYST1 line


General options for using symmetry in protocols
-----------------------------------------------

**-symmetry:symmetry\_definition my\_symdef\_file**

Read in my\_symdef\_file symmetry definition file.  If my\_symdef\_file is the special tag **CRYST1**, use the CRYST1 line of the input PDB file instead to generate lattice symmetry.

**-symmetry:initialize\_rigid\_body\_dofs**

If you want to initialize the rigid body placement according to the symmmetry definition file.

**-symmetry:perturb\_rigid\_body\_dofs ANGSTROMS DEGREES**

If you want to apply a rigid body perturbation to the initial rigid body conformation. The values overrrides the SymDof data?

Protocols aware of symmetry
===========================

This section provides a list of protocols that have been ported to use symmetry. If the protocol you are interested in using is found here you can just follow the instructions in [How to run with symmetry](#How-to-run-with-symmetry). This list will surely not bee properly updated at times, so you might end up having to look into the code. Please add new protocols here as you port them.

* **Score app: src/apps/pilot/score.cc**
* **Symmetric Docking: see src/apps/pilot/andre/SymDock.cc**
* **Fold and dock: see src/protocols/topology\_broker/FoldandDockClaimer.cc**
* **Relax protocols: see src/protocols/relax.cc**

Implementation of symmetry
==========================

The following section describes how symmetry is maintained while perturbing the degrees of freedom in the system and while scoring and minimizing a conformation.  Symmetry is implemented as REAL residues with extra VIRTUAL residues to help.  This means that if you include symmetry, they will be output, included in distance measurements, etc. 

Rigid body symmetry
-------------------

The rigid body relations between asymmetric units in a symmetrical assembly is determined by the symmetry operations of the symmetry group. For example, in a homodimer the subunits are related by a 2-fold rotation around a symmetry axis. Knowledge of the rotation axis and a center of rotation is enough to create the symmetrical system from a single subunit. In this description the two subunits are described in the same coordinate frame and the symmetry is encoded in symmetry operations that are applied to a single subunit to generate the other copies. This framework leads to difficulties in describing complex symmetries and performing energy based minimization. Instead in rosetta, each subunit has their own coordinate frame, with each subunit adopting the exact same coordinates in their respective coordinate frame. Instead of having the coordinates of the subunits related by symmetry operations, the coordinate frames of the subunits are related by symmetry. In the case of the homodimer there are two coordinate frames that are related by a twofold rotation and each subunit has the same coordinates in their respective coordinate system. Now, if we set up the coordinate frames symmetrically then any conformational change that is applied in one coordinate frame will maintanin the overall symmetry if the same operation is applied in the other coordinate frames. Thus if we apply a rigid body jump for the first subunit for the dimer and then applied the same jump to the second subunit, then the dimer is still symmetrical after this operation.

Rosetta uses virtual residues (VRTs) to encode the subunit coordinate frames. VRT residues have an origin, X and Y coordinate. Each subunit is connected through a rigid body jump to such virtuals. For a dimer the simplest setup involves having two VRT residues, where the coordinates of one VRT residue is related by a twofold rotation to another. For more complex symmetries it is common to have additional layers of virtual residues that are sometimes connected by jumps to other virtual residues where each virtual residue encodes a coordinate frame. The setup is generally a tree structure of virtual residues and at the top of the is rooting residue that specifies the coordinate of the whole symmetrical assembly in the cartesian coordinate frame. This root coordinate system allows you to for exampe to fit the assembly into an electron density or a membrane.

Some of the VRT residues have special status: they are masters. The masters control their slave virtuals. If a jump from a master is applied, the same jump gets applied to its slaves. Only jumps from masters can be applied. This work is done by the set\_jump functions in the SymmetricConformation class which replicate jumps from masters to slaves.

The coordinates of the virtual residues is specified in a symmetry definition file. The parsing of symmetry definitions is done by the SymmData class. The information in the SymmData class is then used to insert VRT residues into the symmetrical conformation when a symmetrical pose is constructed. The SymmData object is also used to initialize the SymmetryInfo class that is stored in the SymmetricConformation class. SymmetryInfo stores all the information about symmetry that a pose carries around.

Backbone symmetry
-----------------

Maintaining backbone symmetry is trivial once the subunit coordinate frames have been set up. When a torsion angle is changed in the master subunit the same torsion is set for the slave subunits. This is done by the set\_torsion function in the SymmetricConformation class.

Sidechain symmetry
------------------

Siechain symmetry is maintained in the same manner as backbone symmetry. Sidechain conformations are typically changed through pack\_rotamers or rotamer\_trials. There are symmetrical versions of these functions: symmetric\_pack\_rotamers and symmetric\_rotamer\_trials.

Symmetric scoring
-----------------

In a symmetric system every asymmetric unit is chemically identical and therefore has the same energy. We only need to evaluate the energy of a single asymmetric unit and multiply it by the number of asymmetric units in order to find the energy of the full system. This type of smarter scoring generate a very large performance boost but makes scoring a bit more complicated than it is in the asymmetric system. In order for the scoring to be correctly calculated we need to tell rosetta how to score it. First, rosetta has to know which asymmetric unit to score. This usually does not matter and for convenience we typically score the first asymmetric unit in the system. But sometimes it matters: If we represent the symmetrical system with only a subset of the units in the full system we need to think about edge effects. For example, in a fibre the subunits at the termini is not in the same environment as the subunits in the center of the fiber. Here we should choose to score the a centrally located subunit to represent the total energy. Secondly, we need to tell how the scoring subunit interacts with other subunits. In a trimer, with subunits A, B and C, if A is the scoring subunit is the scoring subunit A interacts with both B and C. However, A interact with B and C in an identical manner so we only need to calculate the interaction A:B and multiply it with 3 to get the total subunit-subunit interaction. The total energy in this system is E = 3\*A + 3\*A:B (3\*A + 3\*A:C would be the same). This is the information you feed into rosetta through the symmetry definition file.

Even if you only need a smaller number of subunits to score the complex you may have to explicitly represent a larger number of asymmetric units for minimization and packing. The rule is this: The scoring subunit has to have all its interacting neighbors present. This is the smallest system that can be explicitly modeled.

Symmetric minimization
----------------------

All asymmetric units have the same environment in assembly. Also the rigid body movements are coupled. In a dimer the derivate of energy with distance along a line between centers of mass can be calculated as the derivate of a single subunit with r time two because the two move in the same manner towards each other. This is generally true for any symmetrical system that have the same coordinates in the same their reference frames. When we minimize the energy we allow only the master jumps and master subunits torsions to optimize and the derivate of the the total system can be calculated as this derivate times the number of asymmetric units in the system. This represent a huge speed-up. Another speed-up is coming from the fact that in a symmetrical system only some degrees of freedom are meaningful to change. For a asymmetric dimer you need six degrees of freedom to describe the relative orientation of the two subunits. In the symmetrical dimer only 4 degrees of freedom are necessary to describe the relative rigid body relation: 3 rotation degrees of freedom for a single subunit and one distance along a vector between the centers of mass of the subunits. When minimizing we only need to optimize the symmetrical degrees of freedom in the system. What these degrees of freedom are depends on the symmetry of the system and this information has to be given to rosetta through the symmetry definition file.

Symmetry definitions <a name="Symmetry-definition" />
====================

* In addition to the detailed explanation below, there is also a hands-on tutorial that might help understanding symmetry definitions. It can be found in `demos/tutorials/Symmetry/Symmetry.md` - or click [[here|https://www.rosettacommons.org/demos/latest/tutorials/Symmetry/Symmetry]].

Everything that rosetta needs to know about the symmetry of the system is encoded in the symmetry definition file. Its tells rosetta how to score a structure, how to maintain symmetry in rigid body perturbations, what degrees of freedom are allowed to move, how to initially setup the system and how to perturb the system. A correctly specified symmetry definition file will allow you to preserve the symmetry and absolute coordinate frame of your input protein assembly. You can also setup the symmetry for a denovo predictionwhen only the symmetry group is known. The symmetry definition files are typically generated by scripts and very little tinkering of these files are needed in the typical case. Generated these files by hand is very complicated for complex symmetries. Below is a description of he fields in symmetry denfinition files:

```
symmetry_name my_pdb_P_1_21_1
```

a string describing the symmetry of the system. This can be anything.

```
E = 2*VRT_0_0_0_0_base + 1*(VRT_0_0_0_0_base:VRT_0_0_0_1_base) + 3*(VRT_0_0_0_0_base:VRT_0_n1_0_0_base) + 4*(VRT_0_0_0_0_base:VRT_1_0_0_0_base)
```

E line: This is how to tell rosetta how to score the structure. In this example, the subunit that is connected to the virtual residue VRT\_0\_0\_0\_0\_base is the scoring subunit and internal energies in this subunit is multiplied with 2 to get the total energy. The add intermolecular energies from the VRT\_0\_0\_0\_0\_base connected subunit to subunits connected to VRT\_0\_0\_0\_1\_base, VRT\_0\_n1\_0\_0\_base and VRT\_1\_0\_0\_0\_base with factors of 1,3 and 4, respectively.

```
anchor_residue 29
```

The subunit jump is anchored at residue 29.

```
 virtual_coordinates_start
 xyz VRT_0_0_0_0 1.000,0.000,0.000 0.000,1.000,0.000 -1.363,24.921,7.618
 xyz VRT_0_0_0_0_base 1.000,0.000,0.000 0.000,1.000,0.000 -2.363,23.921,6.618
 xyz VRT_0_0_0_1 1.000,0.000,0.000 0.000,1.000,0.000 -12.385,24.921,43.670
 xyz VRT_0_0_0_1_base 1.000,0.000,0.000 0.000,1.000,0.000 -13.385,23.921,42.670
 xyz VRT_0_0_0_n1 1.000,0.000,0.000 0.000,1.000,0.000 9.660,24.921,-28.435
 xyz VRT_0_0_0_n1_base 1.000,0.000,0.000 0.000,1.000,0.000 8.660,23.921,-29.435
 xyz VRT_0_n1_0_0 1.000,0.000,0.000 0.000,1.000,0.000 -32.063,24.921,7.618
 xyz VRT_0_n1_0_0_base 1.000,0.000,0.000 0.000,1.000,0.000 -33.063,23.921,6.618
 xyz VRT_0_1_0_0 1.000,0.000,0.000 0.000,1.000,0.000 29.337,24.921,7.618
 xyz VRT_0_1_0_0_base 1.000,0.000,0.000 0.000,1.000,0.000 28.337,23.921,6.618
 xyz VRT_1_0_0_0 -1.000,0.000,0.000 0.000,1.000,0.000 1.363,42.471,-7.618
 xyz VRT_1_0_0_0_base -1.000,0.000,0.000 0.000,1.000,0.000 2.363,41.471,-6.618
 xyz VRT_1_0_n1_0 -1.000,0.000,0.000 0.000,1.000,0.000 1.363,7.371,-7.618
 xyz VRT_1_0_n1_0_base -1.000,0.000,0.000 0.000,1.000,0.000 2.363,6.371,-6.618
 xyz VRT_1_0_0_1 -1.000,0.000,0.000 0.000,1.000,0.000 -9.660,42.471,28.435
 xyz VRT_1_0_0_1_base -1.000,0.000,0.000 0.000,1.000,0.000 -8.660,41.471,29.435
 xyz VRT_1_0_n1_1 -1.000,0.000,0.000 0.000,1.000,0.000 -9.660,7.371,28.435
 xyz VRT_1_0_n1_1_base -1.000,0.000,0.000 0.000,1.000,0.000 -8.660,6.371,29.435
 virtual_coordinates_stop
```

Define the coordinates of the virtual residues. There are three triples ( X, Y and ORIGIN ) that each have three coordinates describing units vectors( for X and Y ) and a center ( ORIGIN ). You can use ane unique name for theses virtuals.

```
 connect_virtual JUMP_0_0_0_0_to_subunit VRT_0_0_0_0_base SUBUNIT
 connect_virtual JUMP_0_0_0_1_to_subunit VRT_0_0_0_1_base SUBUNIT
 connect_virtual JUMP_0_0_0_n1_to_subunit VRT_0_0_0_n1_base SUBUNIT
 connect_virtual JUMP_0_n1_0_0_to_subunit VRT_0_n1_0_0_base SUBUNIT
 connect_virtual JUMP_0_1_0_0_to_subunit VRT_0_1_0_0_base SUBUNIT
 connect_virtual JUMP_1_0_0_0_to_subunit VRT_1_0_0_0_base SUBUNIT
 connect_virtual JUMP_1_0_n1_0_to_subunit VRT_1_0_n1_0_base SUBUNIT
 connect_virtual JUMP_1_0_0_1_to_subunit VRT_1_0_0_1_base SUBUNIT
 connect_virtual JUMP_1_0_n1_1_to_subunit VRT_1_0_n1_1_base SUBUNIT
 connect_virtual JUMP_0_0_0_0_to_com VRT_0_0_0_0 VRT_0_0_0_0_base
 connect_virtual JUMP_0_0_0_1_to_com VRT_0_0_0_1 VRT_0_0_0_1_base
 connect_virtual JUMP_0_0_0_n1_to_com VRT_0_0_0_n1 VRT_0_0_0_n1_base
 connect_virtual JUMP_0_n1_0_0_to_com VRT_0_n1_0_0 VRT_0_n1_0_0_base
```

connect\_virtual statements encode the jumps in the system. For example,

```
connect_virtual JUMP_0_0_0_0_to_com VRT_0_0_0_0 VRT_0_0_0_0_base
```

means that virtuals JUMP\_0\_0\_0\_0\_to\_com and VRT\_0\_0\_0\_0\_base should be connected by a jump. We name this jump JUMP\_0\_0\_0\_0\_to\_com. Any string can be chosen for this name. If the second jump is SUBUNIT then it means that a jump from a virtual to a subunit is specified.

```
set_dof JUMP_0_0_0_0_to_com x z
set_dof JUMP_0_0_0_0_to_subunit angle_x angle_y angle_z
```

set\_dof statements specify which degrees of freedom are allowed for a particular jump. They are x,y,z for translations and angle\_x, angle\_y, angle\_z for rotations. The set\_dof should only be set for the master jump. If a jump does not have a set\_dof statement associated with it then by default the jump is unmovable. Observe that the movers that perturb jumps must be sensitive to dof SymDof data, is stored in SymmetryInfo, in order for these dof restrictions to be used. You can still manually set dofs of jumps that should not move in order to maintain symmetry if you set jumps manually!

You can also encode the initial placement of subunits by modifying this line. For example:

```
set_dof JUMP_0_0_0_0_to_com x(20) z(10:20)
```

means that x should be set to 20 angstrom and z should be randomly chosen in the range 10-20. For angles:

```
set_dof JUMP_0_0_0_0_to_subunit angle_x(360) angle_y(360) angle_z(360)
```

means that the rotation should be completely randomized. You can also encode rigid body perturbation sizes:

```
set_dof JUMP_0_0_0_0_to_com x(20:5) z(10:20)
```

Here, that that perturbations along the x-direction should be gaussian with size 5. In order for this to be used in rosetta the protocol that you are using must be using SymDof objects in their movers. Below the section on how to run with symmetry explains how to make this happen.

```
set_jump_group JUMPGROUP1 JUMP_0_0_0_0_to_subunit JUMP_0_0_0_1_to_subunit JUMP_0_0_0_n1_to_subunit JUMP_0_n1_0_0_to_subunit JUMP_0_1_0_0_to_subunit JUMP_1_0_0_0_to_subunit JUMP_1_0_n1_0_to_subunit JUMP_1_0_0_1_to_subunit JUMP_1_0_n1_1_to_subunit
```

These statements tell rosetta which jumps are involved in master/slave relationships. The first jump in the jumpgroup is the master. The name of the jump group can be chosen freely.

If you run a denovo case where you don't have an input symmetrical structure you might want to generate a symmetry definition by hand. There is an additional format that can be used to build virtual residues through the specification of rotation and translation operations. For example:

```
 symmetry_name c3
 subunits 3
 recenter
 number_of_interfaces 1
 E = 3*VRT1 + 3*(VRT1:VRT2)
 anchor_residue 17
 virtual_transforms_start
 start -1,0,0 0,1,0 0,0,0
 rot Rz 3
 virtual_transforms_stop
 connect_virtual JUMP1 VRT1 VRT2
 connect_virtual JUMP2 VRT2 VRT3
 set_dof BASEJUMP x(50) angle_x angle_y angle_z
```

Observe that we don't give the names of VRT residues they are automatically assigned to VRT1, VRT2,...etc. Jumpgroups are automatically calculated as well. There is automatically jumps added between virtuals.

```
recenter
```

Tells rosetta to recenter the input subunit so that the CA of the anchor residue is at the origin (0,0,0).

```
virtual_transforms_start
```

Virtual residues will be specified through rotation and translation operations instead of hard coded coordinates.

```
virtual_transforms_start consecutive
```

the consecutive keywords signals that for every virtual that is placed all the transformations between **virtual\_transforms\_start** and **virtual\_transforms\_stop** will be applied. The default is that

```
start -1,0,0 0,1,0 0,0,0
```

is the position of the first virtual residue in the system (unit vectors of X, Y and coordinate of ORGIN). The first transform(s) will be applied to this virtual to generate the second.

```
rot Rz 3
```

apply 3 fold rotation around the absolute z-axis. ( you can use Rx, Ry and Rz ). You can also say:

```
rot Rz_angle 120
```

which means that a 120 degree rotation should be applied.

```
trans 4,5,2
```

encodes a translation operation, the three numbers specifies a translation vector.

Symmetries with mirror operations
--------------------------

Rosetta offers support for symmetries with mirror operations as well.  Mirror symmetry is specified in  through the use of an "inverse virtual" residue which defines a left-handed local coordinate system. These inverse virtuals may be used to define mirror symmetries as follows:

```
symmetry_name Cs
E = 2*VRT0 + 1*(VRT0:VRT1)
anchor_residue 1
virtual_coordinates_start
xyz  VRT0  1.0,0.0,0.0  0.0,1.0,0.0  0.0,0.0,0.0
xyzM VRT1  1.0,0.0,0.0  0.0,1.0,0.0  0.0,0.0,0.0
virtual_coordinates_stop
connect_virtual JUMP0 VRT0 SUBUNIT
connect_virtual JUMP1 VRT1 SUBUNIT
connect_virtual JUMP01 VRT0 VRT1
set_dof JUMP0 x y z angle_x angle_y angle_z
set_jump_group JUMPGROUP2 JUMP0 JUMP1
```

Above, xyzM declares an inverse virtual residue. Connecting this inverse virtual to a subunit makes the connected subunit inverted. The above snippet declares a _Cs_ symmetric system with a mirror plane in XY.

Crystal symmetries with mirror operations are automatically handled with **-symmetry_definition CRYST1** (see above).


Slide-into-contact options
--------------------------

```
slide_type (RANDOM|SEQUENTIAL|ORDERED_SEQUENTIAL)
```

Controls how multidimensional slide-into-contact moves are made. For example, for dn symmetry there are two sliding directions. A slide can be done by randomly selecting a slide direction for each slide step (RANDOM), randomly deciding on which direction should be slided first but always sequentially go through both (SEQUENTIAL), or define the order yourself (ORDERED\_SEQUENTIAL). RANDOM default.

```
slide_criteria_type (CEN_DOCK_SCORE|FA_REP_SCORE|CONTACTS)
```

Defines what the criteria is for abandaning a slide. Either the CEN\_DOCK\_SCORE, FA\_REP\_SCORE or the number of contacts. CEN\_DOCK\_SCORE default.

```
slide_criteria_val (value|AUTOMATIC)
```

Sets the actual value when a slide move is abandoned given the criteria type. By default set to AUTOMATIC, which means that ROSETTA figures it out by itself. Really only useful for the CONTACTS type.

```
slide_order jump name
```

If you are using ORDERED\_SEQUENTIAL slide type you can give the order by which the jumps corresponding to the allowed translations are visited. Uses the jump names defined in the symmetry definition file.

How to adopt your protocol to use symmetry
==========================================

There are a few required steps to make your protocol smoothly work with symmetric structures. The main guiding principle is that any operation that changes the conformation of a pose may have to be modified.

**Setting up a symmetric pose** Call SetupForSymmetryMover (src/protocols/moves/symmetry/SetupForSymmetryMover.cc) at the beginning of the protocol before any conformational changes occur to the pose. This takes a monomeric input pose and make a symmetric oligomer base on the symmetry\_definition file.

**Scoring** Use ScoreFunctionOP or ScoreFunctionCOP instead of ScoreFunction because the symmetrical scorefunction (SymmetricScoreFunction) is derived out of ScoreFunction. This will be automatic if using the ScoreFunctionFactory. ScoreFunctionFactory checks if a symmetry definition file has been defined as an option and makes a SymmetricScoreFunction in that case.

**Packing and RotamerTrials** If the pose is symmetric then use symmetric versions of the PackRotamersMover and RotamerTrialsMover (src/protocols/moves/SymPackRotamerMover.cc and src/protocols/moves/SymRotamerTrialsMover)

**Minimizing** If the pose is symmetric then use symmetric versions of the MinimizeMover (src/protocols/moves/SymMinimizeMover.cc)

**FoldTree manipulation** If you modify the foldtree in the protocol make sure that the symmetric structure is properly updated. Simplest idea is to work on a monomer and then call SetupForSymmetryMover to regenerate the symmetrical oligomer.

**Degrees of freedom** Only the degrees of freedom of one asymmetric unit should be allowed to move. This will by automatic in most symmetry-aware movers but it is safest to explicitly only setup the dofs for the master subunit. You can find out from the SymmetryInfo what the master residues/jumps are.

**Perturbing rigid body** What dofs are allowed to move and how much are controlled by the set\_dof statements in the input symmetry defintion. A SymmDof object is stored in SymmetryInfo. You can grab what jumps are allowed to move from the SymmDof object. However, there are a range of RigidBodyMovers sensitive to Symdof data. These are found in src/protocols/moves/RigidBodyMover.cc. The safest is to use those, or if they do not solve your problem, add others in the same mold at the same location. Beware that there is nothing preventing you to move a jump that destroys the symmetry, so make sure to use the information SymmetryInfo and SymmDof when you make a jump move that is not internal to a monomer.

**Calculating rms** Having many eqivavelent chains leads to problems in calculating rms of more than two chains because the order of chains in the output structure is arbitrary. This is mostly a problem for denovo predicitions. In other cases, the chain order is probably not changed during the simulation. To get a proper rms one has to test all different chain orderings and calculate rms for all of them. CA\_rmsd\_symmetric does this trick for you (src/core/scoring/rms\_util.cc). There is also a PoseEvaluator for it. Beware that there is a combinatorial explosion lurking behind this command so don't use this for very large number of chains!

**Useful code**

In src/core/conformation/symmetry/util.cc there are a number of convinence functions for working with symmetrical poses. A typical operation when working with symmetry is to find out whether it is symmetrical the function core::conformation::symmetry::is\_symmetric( pose ) will answer this question. You can ask a Conformation, Scorefunction and Energies object the same questions.

Another common operation is to grab a pointer to a SymmetricConformation and SymmetryInfo:

```
SymmetricConformation const & SymmConf ( dynamic_cast<SymmetricConformation const &>( pose.conformation()) );
SymmetryInfo const & symm_info( SymmConf.Symmetry_Info() );
```

SymmetryInfo contains everything you need to know about the symmetry of the conformation: master/slave relationships (chi\_clones, bb\_clones and jump\_clones etc), Movable Dofs (SymmDofs) etc.

##See Also

* [Symmetry Turtorial](https://www.rosettacommons.org/demos/latest/tutorials/Symmetry/Symmetry)
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Full options list]]: Includes options for using symmetry in Rosetta
* [[RosettaScripts]]: RosettaScripts home page