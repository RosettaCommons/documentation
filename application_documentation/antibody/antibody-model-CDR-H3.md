#RosettaAntibody3: c). Modeling CDR H3 and Optimize VL-VH simultaneously

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
2.  constraint file, optional, but recommended (e.g. cter\_constraint)
     * a). Purpose: provide constraints potential to constraint H3 cterminal

Flags
=====

**Antibody Flags:**

```
-antibody::remodel              perturb_kic
-antibody::snugfit              true
-antibody::refine               refine_kic
-antibody::cter_insert          false
-antibody::flank_residue_min    true
-antibody::bad_nter             false
-antibody::h3_filter            true
-antibody::h3_filter_tolerance  20
-antibody:constrain_cter
-antibody:constrain_vlvh_qq
-constraints:cst_file ./inputs/constraint_file
-nstruct 2000
-s ./inputs/FR02.pdb
-in:file:native ./inputs/LH_renumbered.pdb
-out:file:scorefile score.fasc
-run:multiple_processes_writing_to_one_directory
```

**Packing Flags:**

```
-ex1
-ex2
-extrachi_cutoff 0
```

**Next Generation KIC (NGK) Flags:**

(personal communication with Amelie Stein in Tanja Kortemme’s lab, detailed explanations should be in the NGK documentation ( [[Next-generation kinematic loop modeling and torsion-restricted sampling|next-generation-KIC]] ) for the following flags)

```
-kic_bump_overlap_factor 0.36
-corrections:score:use_bicubic_interpolation false
-loops:legacy_kic false
-loops:kic_min_after_repack true
-loops:kic_omega_sampling
-loops:allow_omega_move true
-loops:ramp_fa_rep
-loops:ramp_rama
-loops:outer_cycles 5
-loops:kic_rama2b (takes 5G memory, one can turn this off if your computer cluster cannot handle such big memory job)
```

**Detailed Description of Flags:**

```
-antibody::remodel 
```

-   Description:
     * Model the H3 loop in centroid mode. It uses the loop\_perturb object in the loop modeling protocol

-   options:
     * perturb\_kic
     * perturb\_ccd (Note CCD has not been well tested)

```
-antibody::snugfit
```

-   Description:
     * Optimize VL-VH orientational via L-H docking

-   options:
     * true or false

```
-antibody::refine 
```

-   Description:
     * High resolution refinement of H3 loop. It uses the loop\_refne objet in the loop modeling protocol

-   options:
     * refine\_kic
     * refine\_ccd (Note CCD has not been well tested)

```
-antibody:cter_insert false
```

-   Description:
     * a). This flag was originally designed to read a file called “H3\_CTERM”, in which you can find many 4 residue fragments from many antibody H3 c\_terminal backbone coordinates. The idea is that: if you can use bioinformatics rules to predict Kink/Extend, you can insert a Kink/Extend fragment from “H3\_CTERM” file to the target H3 sequence structure. This is expected to reduce sampling assuming the bioinformatics is reliable. Please realize that this “cter\_insert” only happens in low resolution loop building. My previous tests showed, this step may help CCD (legacy CCD), but not very useful in KIC. CCD\_refine randomly chose residues to do small/shear moves, but KIC\_refine do the entire loop backbone movement collectively because it solves polynomials and get the whole set of backbone angles.
     * b). Because it is not very useful for KIC, we can turn it off. However, you may find it is weird that the code still asks “H3\_CTERM” file. This is a small bug I should fix, but this bug does not affect anything. Just copy the “H3\_CTERM” file, the code will read this file, but do nothing, as you set “-antibody:cter\_insert false”. The reason for asking this file is because I put the function of reading “H3\_CTERM” in the constructor of one class, so the default is to read the file and decide what to do based on the flag of “-antibody:cter\_insert”.
     * c). By the way, there is only one “H3\_CTERM” file for all cases, you can copy paste to any antibody target.. The questions is what about if I already use “-antibody:cter\_insert true” in my KIC? My previous test showed this has no effects to the final results.

-   options:
     * true or false

```
-antibody:flank_residue_min true
```

-   Description:
     * Set the H3 stems (default 2 residue each side on framework) on the framework to be adjustable of H3 into the movemap of minimization step in H3 loop modeling.

-   options:
     * true or false

```
-antibody:bad_nter false
```

-   Description:
     * a). This is Rosetta2 style (Aroop did) to make up for the bad grafting of H3, because bad H3 grafting can change the coordinates of H3 stems. If you already used the flag “-antibody::h3\_no\_stem\_graft” in grafting (pay attention, grafting) H3, then stem of H3 does not get changed. You can set “–antibody:bad\_nter false”.
     * b). So the question may be … do we have “-antibody:bad\_cter” ? The answer is no, as we have so many ways to deal with and always do something to the c\_terminal, so it is ok even the grafting change the cterminal. Simple answer: set it to “false” if you H3 stems are good.

-   options:
     * true or false

```
-antibody:h3_filter true
-antibody:h3_filter_tolerance 20
```

-   Description:
     * a). Sometimes you are very confident about the h3 Kink/Extend prediction made by bioinformatics rules, as the rules has \~90% probability to be correct. So you want the loop modeling (CCD or KIC) to give you predicted Kink or Extend conformation, otherwise filter it and do the loop modeling again. There is possibility that you may never get what you predicted, and the loop modeling just try again and again and takes forever, that’s why we have the “-antibody:h3\_filter\_tolerance 20” to restrict the maximum tries to be 20. You can change the value to smaller if you want.
     * b). If you think it is inappropriate to trust the bioinformatics rules, you can set “-antibody:h3\_filter false”. The “-antibody:h3\_filter\_tolerance” flag will be invalid automatically.

-   options:
     * true of false
     * a number

```
-antibody:constrain_cter
-antibody:constrain_vlvh_qq
-constraints:cst_file ./constraint_file
```

-   Description:
     * a). What it is doing is still constraining the c\_terminus of H3. Meaning that: “antibody:h3\_filter” is too slow, “-antibody:cter\_insert” is useless for KIC. Let me just constrained the H3 c\_terminus to be Kink/Extend.
     * b). “-antibody:constrain\_cter” or “-antibody:constrain\_vlvh\_qq” must be specified in order to use the the prepared constraint file.
     * c). “-antibody:constrain\_cter” and “-antibody:constrain\_vlvh\_qq” can be both specified
     * d) Example of constraint file (one line or two lines like below)
     ```
     Dihedral CA 220 CA 221 CA 222 CA 223 SQUARE\_WELL2 0.5233 0.6978 200
     AtomPair CD 38L CD 39H LINEAR\_PENALTY 4.1 0 0.4 400
     ```

-   Options:
     * true or false
     * local of the constraint file

**Additional Description of constraint file:**

1.  Dihedral CA 220 CA 221 CA 222 CA 223 SQUARE\_WELL2 0.5233 0.6978 200
     1. To constrain the c-terminal of H3 to be Kink/Extend
     2. -220, 221, 222, 223 are all pose number of the H3 cterminus residues. In PDB numbering (Chothia), they are supposed to be H100X, H101,H102, H103. For different antibody, pose number may/should be changed.
     3. SQUARE\_WELL2 is the square well potential
     4. Middle=30 degree (0.5233), Range=40 degree (0.6978), Well depth=200. So we are constraining the c\_terminal region to -10\<angle\<70 , this is the old definition of KINK. This can be changed.
     5. For cases predicted to be extended, it is not clear which degree to use to constrain, as Extend H3 is much more diversified. One can try 125-185 degree, or just do not use constrain, and do not use H3\_filter, and run much more decoys.

2.  AtomPair CD 38L CD 39H LINEAR\_PENALTY 4.1 0 0.4 400 
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