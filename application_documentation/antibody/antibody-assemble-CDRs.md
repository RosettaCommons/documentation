#RosettaAntibody3: b). Grafting CDR loops on Antibody Framework

Metadata
========

Authors: 
Jianqing Xu (xubest@gmail.com), Daisuke Kuroda (dkuroda1981@gmail.com), Oana Lungu (olungu@utexas.edu), Jeffrey Gray (jgray@jhu.edu)

Last edited 4/25/2013. Corresponding PI Jeffrey Gray (jgray@jhu.edu).

Code for Reading Constraints
============================

-   Application source code:

    ```
    rosetta/main/source/src/apps/public/antibody/antibody_graft.cc
    ```

-   Main mover source code:

    ```
    rosetta/main/source/src/protocols/antibody/GraftCDRLoopsProtocol.cc
    ```

-   To see demos of some different use cases see integration tests located in

    ```
    rosetta/tests/integrationi/tests/antibody_graft 
    ```

To run Grafting Protocol, type the following in a command line:

```
[path to executable]/antibody_assemble_CDRs.[platform|linux/mac][compile|gcc/ixx]release –database [path to database] @options
```

Note: these demos will only generate one decoy.

References
==========

We recommend the following articles for further studies of RosettaDock methodology and applications:

-   J. Xu, D. Kuroda & J. J. Gray, “RosettaAntibody3: Object-Oriented Designed Protocol and Improved Antibody Homology Modeling.” (2013) in preparation
-   A. Sivasubramanian,\* A. Sircar,\* S. Chaudhury & J. J. Gray, "Toward high-resolution homology modeling of antibody Fv regions and application to antibody-antigen docking," Proteins 74(2), 497-514 (2009)

Application purpose
===========================================

Graft antibody CDR templates on the framework template to create a rough antibody model.

Algorithm
=========

1.  The code superimposes the backbone coordinates of 4 residues at each end of CDRs (each end 4 residues) on the 4 residues on the framework (each end), so the CDRs can be “grafted” on the framework.
2.  After grafting, the backbone coordinates of 2 residues on the superimposition region were replaced by the superimposed 2 residues on the terminus of the CDR
3.  The code also minimizes and repacks the entire CDRs (backbone and side chain) after grafting

Input
=====

FR.pdb (framework template)
 L1.pdb, L2.pdb, L3.pdb (L chain CDR templates)
 H1.pdb, H2.pdb, H3.pdb (H chain CDR templates)

The preparation of these inputs can be found in the [[RosettaAntibody3: Protocol Workflow|antibody-protocol]]

Flags
=====

**Example:**

```
-s FR.pdb
-antibody::graft_l1
-antibody::graft_l2
-antibody::graft_l3
-antibody::graft_h1
-antibody::graft_h2
-antibody::graft_h3
-antibody::h3_no_stem_graft
-antibody::packonly_after_graft
```

**Detailed Description of Flags:**

```
-antibody::graft_l1
-antibody::graft_l2
-antibody::graft_l3
-antibody::graft_h1
-antibody::graft_h2
-antibody::graft_h3
```

-   Description:
     specify which CDRs you want to graft

-   Options:
     true or false

```
-antibody::h3_no_stem_graft
```

-   Description:
     In the grafting code, after superimposition, coordinates of two stem residues are replaced by the extra residues at each end of CDR template PDB files (L1.pdb, H2.pdb etc.). Non-H3 CDRs may be OK, but for H3, it may be bad for the purpose of later loop modeling if the stems are changed. This flag will protect the H3 stems. The superimposition step is exactly the same, the only difference is the stems of H3 will not be replaced by the residues on H3 side. So the stem can be original stem on the framework template.

-   Options: true or false

```
-antibody::packonly_after_graft
```

-   Description:
     The default of the grafting protocol will do minimization (both side chain and backbone) after CDR grafting. Sometimes the minimization can be tricky, as it can change the structure dramatically, if the prepared model is in a bad condition. This flag allows user to turn on/off minimization, but packing still default to be conducted.

-   Options: true or false

Output
===============

One pdb file with 6 CDR grafted.

New things since last release
=============================

This is the first public release in Rosetta3

-   Supports the modern job distributor (jd2).
-   Support for [[constraints|constraint-file]] .

##See Also

* [[General Antibody Options and Tips]]
* [[Antibody Applications]]: Homepage for antibody applications
    * [[Antibody protocol]]: The primary antibody modeling application
    * [[Antibody Python script]]: Setup script for this application
    * [[Modeling CDR H3|antibody-model-CDR-H3]]: Determine antibody structures by combining VL-VH docking and H3 loop modeling.
    - [[Camelid antibody docking|antibody-mode-camelid]]: Dock camelid antibodies to their antigens.
    - [[SnugDock | snugdock]]: Paratope structure optimization during antibody-antigen docking
    * [[Antibody Design Strategy Analysis]]: A PyRosetta-based tool to analyze and/or compare antibody design strategies.

    * [[CDR Cluster Identification]]: An application that matches each CDR of an antibody to North/Dunbrack CDR clusters based on the lowest dihedral distance to each cluster center.

     * [[CDR Cluster Constrained Relax]]: An application to relax CDRs using circular harmonic constraints based on identified CDR clusters.
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
