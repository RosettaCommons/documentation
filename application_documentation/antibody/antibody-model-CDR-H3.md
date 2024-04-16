#RosettaAntibody3: Modeling CDR H3 and Optimize VL-VH simultaneously

Metadata
========

Authors: 
Jianqing Xu (xubest@gmail.com), Daisuke Kuroda (dkuroda1981@gmail.com), Oana Lungu (olungu@utexas.edu), Jeffrey Gray (jgray@jhu.edu)

Last edited 4/25/2013. Corresponding PI Jeffrey Gray (jgray@jhu.edu).

Code for Reading Constraints
============================

-   Application source code:

    ```
    rosetta/rosetta_source/src/apps/pilot/jianqing/antibody_model_CDR_H3.cc
    ```

-   Main mover source code:

    ```
    rosetta/rosetta_source/src/protocols/antibody2/AntibodyModelerProtocol.cc.cc
    ```

-   To see demos of some different use cases see integration tests located in

    ```
    rosetta/rosetta_tests/integration/antibody_protocol_* (antibody_protocol_using_KIC_loop_mover, antibody_protocol_using_CCD_loop_mover).
    ```

To run Rosetta3Antibody, type the following in a command line:

```
[path to executable]/antibody_model_CDR_H3.[platform|linux/mac][compile|gcc/ixx]release –database [path to database] @options
```

Note: these demos will only generate one decoy. To generate a large number of decoys you will need to add –nstruct N (where N is the number of decoys to build) to the list of flags.

References
==========

We recommend the following articles for further studies of RosettaDock methodology and applications:

- B. D. Weitnzer\*, J. R. Jeliazkov\*, S. Lyskov\*, N. Marze, D. Kuroda, R. Frick, J. Adolf-Bryfogle, N. Biswas, R. L. Dubrack Jr, & J. J. Gray, "Modeling and docking of antibody structures with Rosetta," Nature Protocols 12, 401–216 (2017)
 
-   J. Xu, D. Kuroda & J. J. Gray, “RosettaAntibody3: Object-Oriented Designed Protocol and Improved Antibody Homology Modeling.” (2013) in preparation
-   A. Sivasubramanian,\* A. Sircar,\* S. Chaudhury & J. J. Gray, "Toward high-resolution homology modeling of antibody Fv regions and application to antibody-antigen docking," Proteins 74(2), 497-514 (2009)

Application purpose
===========================================

Determine the structure of antibody homology models by combining VL-VH docking (using docking protocol) and H3 loop modeling (loop modeling protocol ).

Input
=====

1.  starting structure, mandatory (e.g. input.pdb)
     * a). The input antibody file needs to be Chothia numbered.
     * b). It can be an crystal structure
     * c). or homology model (check Work Flow and Graft Protocol)

Flags
=====

Sample command line (as of May 17th, 2020): `antibody_H3.macosclangrelease @flags`.

flags:
```
# input grafted model
-s grafting/model-0.relaxed.pdb

# recommended number of structs
-nstruct 1000 

# constraints are enabled by default, so flags are shown just to indicate that they can be turned off
# recommended as kink is present in 90% of Abs and as VH-VL Q-Q is present in 808%
-antibody:h3_loop_csts_lr true
-antibody:h3_loop_csts_hr true
-antibody:auto_generate_h3_kink_constraint true
-antibody:constrain_vlvh_qq true
-constraints:cst_weight 1.0

# standard settings, for packages used by antibody_H3
-ex1
-ex2
-extrachi_cutoff 0

# necessary if running multiple procs w/o MPI
-multiple_processes_writing_to_one_directory 

# specify output file
-out:file:scorefile H3_modeling_scores.fasc 

# specify output folder
-out:path:pdb H3_modeling 
```

**Detailed Description of Flags (may not have been included above):**

```
-antibody::snugfit
```

-   Description:
     * Optimize VL-VH orientational via L-H docking

-   options:
     * true (default) or false

```
-antibody:h3_loop_csts_lr true
-antibody:h3_loop_csts_hr true
-antibody:auto_generate_h3_kink_constraint true
-antibody:constrain_vlvh_qq true
```

-   Note all these flags are true by default as they implements constraints to known antibody motifs. The kink is observed in ~90% of antibody CDR H3 loops and the VL-VH QQ h-bond is observed in ~80% of structures.
-   Description:
     * a). "-antibody:h3\_loop\_csts\_lr" enables constraints in the low-resolution stage. Can be manually specified constraints or automatically generated ones.
     * b). "-antibody:h3\_loop\_csts\_hr" enables constraints in the **high**-resolution stage. Can be manually specified constraints or automatically generated ones.
     * c). "-antibody:auto\_generate\_h3\_kink\_constraint" sets up the correct weights and constraints to emulate the kink observed in 90\% of all antibodies (see Weitzner and Gray, J. Immunol. 2016 paper).
     * d). “-antibody:constrain\_vlvh\_qq” the VH--VL Q--Q hydrogen bond(s) that occur(s) in \~0\% off all antibodies.
     * e). "-constraints:cst_file ./constraint_file" specifies constraints. Q-Q bond constraints used to be manually specified as (for example):
     ```
     AtomPair CD 38L CD 39H LINEAR\_PENALTY 4.1 0 0.4 400
     ```

-   Options:
     * true or false
     * local of the constraint file

**Additional Description of constraint file:**

AtomPair CD 38L CD 39H LINEAR\_PENALTY 4.1 0 0.4 400 
     1. To constrain two GLN, one is on L chain, the other is on H chain, they form Hydrogen bond at the L-H interface 
     2. “CD” is the the carbon on GLN bonding to Nitrogen and Oxygen
     3. 38L means L chain 38, and 39H means H chain 39. They are GLN forming hydrogen bond.
     4. LINEAR\_PENALTY potential, see details in constraint file
     5. distance\_constraint=4.1, well\_depth=0, width=0.4, slope=400, see the details in constraint file.

FoldTree output
===============

One antibody PDB structure with modeled H3 loop and optimized VL-VH orientation.

New things since last release
=============================

This is the first public release in Rosetta3

-   Supports the modern job distributor (jd2).
-   Support for [[constraints|constraint-file]] .

##See Also

* [[General Antibody Options and Tips]]
* [[Antibody Applications]]: Homepage for antibody applications
    * [[Antibody protocol]]: Main antibody modeling application
    * [[Antibody Python script]]: Setup script for this application
    * [[Grafting CDR loops|antibody-assemble-cdrs]]: Graft antibody CDR templates on the framework template to create a rough antibody model.  
    - [[Camelid antibody docking|antibody-mode-camelid]]: Dock camelid antibodies to their antigens.
    - [[SnugDock | snugdock]]: Paratope structure optimization during antibody-antigen docking
    * [[Antibody Design Strategy Analysis]]: A PyRosetta-based tool to analyze and/or compare antibody design strategies.

    * [[CDR Cluster Identification]]: An application that matches each CDR of an antibody to North/Dunbrack CDR clusters based on the lowest dihedral distance to each cluster center.

     * [[CDR Cluster Constrained Relax]]: An application to relax CDRs using circular harmonic constraints based on identified CDR clusters.
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs