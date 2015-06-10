#Metalloprotein ab initio / relax documentation

Metadata
========

Author: Chu Wang; transcribed by Steven Lewis (smlewi@gmail.com)

The transcription into the doc folder was performed 6/18/12 by Steven Lewis. It is known that this documentation is not yet "up to spec".

Protocols for the metalloprotein abrelax application are based on standard protein folding and loop modeling protocols (see documentation for the [[abinitio-relax]] application) with additional constraint files.

In addition to the input files required for [[abinitio relax]], the following input files are required to run this application:

1.  [[fasta file]] – This file contains the protein sequence to be modeled. The sequence required for this application must be more annotated than the standard one with [CYZ] or [HIS] to mark the residues that chelate the zinc, and Z[ZN] at the end for extra "zinc" residue.

2.  residue\_pair\_jump\_cst – explanation after \#\#

    ```
    BEGIN  ## starting marker
    jump_def: 3 60 59 59
    ## a rigid-body jump from the residue 3(first zinc-chelating residue) to 60(zinc) with a cut point starting at 59 and ending at 59 (last protein residue) This is to define how the fold tree is generated.
    aa: CYS ZN
    ## the residues on both sides of the jump
    cst_atoms: SG CB CA ZN V1 V2
    ## how distance, angular and dihedral parameters are defined
    jump_atoms: C CA N ZN V1 V2
    ## how the jump is defined between in the atom tree
    disAB: 2.20
    angleA: 68.0
    angleB: 70.5
    dihedralA: -150.0 -120.0 -90.0 -60.0 -30.0 0.0 30.0 60.0 90.0 120.0 150.0 180.0
    dihedralAB: -150.0 -120.0 -90.0 -60.0 -30.0 0.0 30.0 60.0 90.0 120.0 150.0 180.0
    dihedralB: 120.0
    ## all the degrees of freedom as defined in Figure 1 and Table 1 to generate various jump transformations between CYS and ZN
    END ## ending marker
    ```

    each blocks as above can define one zinc binding site and if you have more than one zinc, append more blocks like this.

3.  cen\_cst or fa\_cst files: These files are used to define constraints to keep chelating geometry optimal between zinc and other three chelating residues. The files are in standard Rosetta distance and angular constraints format (see the [[constraint file]] documentation).


For examples of metalloprotein-abrelax input files, please check the integration test input. [[Integration tests]] for the `metalloprotein_abrelax` application are located in the following directory:

`main/test/integration/tests/metalloprotein_abrelax/`

All necessary input files for these integration tests can be found in:

`main/test/integration/tests/metalloprotein_abrelax/input/`

##See Also

* [[Metals]]: More information on working with metals in Rosetta
* [[Constraint file]]: Constraint file format
* [[Fasta file]]: Fasta file format
* [[Fragment file]]: Fragment file format (required for abinitio structure prediction)
* [[Structure prediction applications]]: A list of other applications to be used for structure prediction
  * [[Abinitio-relax]]: Application for predicting protein structures using only sequence information
    * [[Further details on the abinitio-relax application|abinitio]]
  * [[Membrane abinitio]]: Ab initio for membrane proteins.  
  - [[Comparative modeling|minirosetta-comparative-modeling]]: Build structural models of proteins using one or more known structures as templates for modeling (uses the minirosetta application).
    * [[Minirosetta]]: More information on the minirosetta application.
  * [[Metalloprotein ab initio|metalloprotein-abrelax]]: Ab inito modeling of metalloproteins.  
  - [[Backrub]]: Create backbone ensembles using small, local backbone changes.  
  - [[Floppy tail]]: Predict structures of long, flexible N-terminal or C-terminal regions.
  - [[Fold-and-dock]]: Predict 3-dimensional structures of symmetric homooligomers.  
  - [[Molecular replacement protocols|mr-protocols]]: Use Rosetta to build models for use in X-ray crystallography molecular replacement.  
    * [[Prepare template for MR]]: Setup script for molecular replacement protocols.  
  - [[Relax]]: "Locally" optimize structures, including assigning sidechain positions.
* [[Application Documentation]]: List of Rosetta applications
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Comparing structures]]: Essay on comparing structures
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Solving a Biological Problem]]: Guide to approaching biological problems using Rosetta
* [[Commands collection]]: A list of example command lines for running Rosetta executable files