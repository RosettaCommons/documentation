#Matching and enzyme design geometric constraint file format

Author: Florian Richter (floric@u.washington.edu)

Metadata
========

This document was written by Florian Richter (floric@u.washington.edu) in August 2010. The `       enzyme_design      ` and `       match      ` applications are maintained by David Baker's lab. Send questions to dabaker@u.washington.edu

References
==========

Richter F, Leaver-Fay A, Khare SD, Bjelic S, Baker D (2011) De Novo Enzyme Design Using Rosetta3. PLoS ONE 6(5): e19230. doi:10.1371/journal.pone.0019230

Application purpose
===========================================

The match / enzdes geometric constraint file ( from hereon referred to as 'cstfile' ) format is used to specify a desired binding/active site arrangement in Rosetta. Such an arrangement usually consists of

1.  a number of amino acids and a small molecule ligand or substrate and
2.  how these different amino acids and the ligand are spatially/geometrically positioned with respect to each other.
     This information in the cstfile is used by the matcher to try to graft the desired site into a protein structure, and by the enzyme\_design code (from hereon referred to as 'enzdes' ) to constrain active sites to the desired geometry during rotamer packing and minimization. Example cstfiles can be found in the integration tests for the matcher ( `        Rosetta/main/tests/integration/tests/match/inputs/1n9l_CHbN/Est_CHbkupb_d2n_match.cst       ` , `        Rosetta/main/tests/integration/tests/match/inputs/1c2t/1c2t_xtal_BUHis.cst       ` , `        Rosetta/main/tests/integration/tests/match/inputs/6cpa/6cpa_xtal.cst       ` ), enzdes ( `        Rosetta/main/tests/integration/tests/enzdes/inputs/Est_CHba_d2n.cst       ` ), and cstfile\_to\_theozyme\_pdb `        Rosetta/main/tests/integration/tests/cstfile_to_theozyme_pdb/inputs/CTP_RKRE_1acid2acid.cst       `
     While the matcher is only able to find sites that contain one ligand and a number of protein residues interacting with this ligand or with another protein residue, in enzdes a cstfile can be used to also constrain geometries between a protein protein interface, two ligands, or within a single protein. The public app rosetta/rosetta\_source/src/apps/public/enzdes/CstfileToTheozymePDB.cc can create a .pdb model of the theozyme geometry specified in a cstfile. When developing a theozyme it is recommended to run this app to confirm that the desired geometry is correctly encoded by the cstfile. Details about using this app can be found below in Section "Using the CstfileToTheozymePDB executable".

Description of the cstfile format
============

Once the user has decided what the desired interaction should be like, (in terms of the geometric relationship between a catalytic residue and the substrate, or between two catalytic residues), a file consisting of blocks in the following format needs to be written. For each interaction between two residues, there needs to be one block. The example below describes the iteraction between a histinide and a ligand abbreviated with name D2N. In this cstfile, there needs to be a block of the following format for each catalytic interaction:

```
CST::BEGIN
  TEMPLATE::   ATOM_MAP: 1 atom_name: C6 O4 O2
  TEMPLATE::   ATOM_MAP: 1 residue3: D2N

  TEMPLATE::   ATOM_MAP: 2 atom_type: Nhis,
  TEMPLATE::   ATOM_MAP: 2 residue1: H

  CONSTRAINT:: distanceAB:    2.00   0.30 100.00  1        0
  CONSTRAINT::    angle_A:  105.10   6.00 100.00  360.00   1
  CONSTRAINT::    angle_B:  116.90   5.00  50.00  360.00   1
  CONSTRAINT::  torsion_A:  105.00  10.00  50.00  360.00   2
  CONSTRAINT::  torsion_B:  180.00  10.00  25.00  180.00   4
  CONSTRAINT:: torsion_AB:    0.00  45.00   0.00  180.00   5
CST::END
```

The information in this block defines constraints between three atoms on residue 1 and three atoms on residue 2. Up to six parameters can be specified ( one distance, two angles, 3 dihedrals ).

The Records indicate the following:

'CST::BEGIN' and 'CST::END' indicate the beginning and end of the respective definition block for this catalytic interaction.

The 'TEMPLATE:: ATOM\_MAP:' records:
 These indicate what atoms are constrained and what type of residue they are in. The number in column 3 of these records indicates which catalytic residue the record relates to. It has to be either 1 or 2.
 The 'atom\_name' tag specifies exactly which 3 atoms of the residue are to be constrained. It has to be followed by the names of three atoms that are part of the catalytic residue. In the above example, for catalytic residue 1, atom 1 is C6, atom 2 is O4, and atom3 is O2. The 'atom\_type' tag is an alternative to the 'atom\_name' tag. It allows more flexible definition of the constrained atoms. It has to be followed by the [[Rosetta atom type|Rosetta AtomTypes]] of the first constrained atom of the residue. In case this tag is used, Rosetta will set the 2nd constrained atom as the base atom of the first constrained atom and the third constrained atom as the base atom of the 2nd constrained atom. ( Note: the base atoms for each atom are defined in the ICOOR records of the .params file for that residue type ). There are two advantages to using the 'atom\_type' tag: first, it allows constraining different residue types with the same file. For example if a catalytic hydrogen bond is to be constrained, but the user doesn't care if it's mediated by a SER-OH or a THR-OH. Second, if a catalytic residue contains more than one atom of the same type (as in the case of ASP or GLU ), but it doesn't matter which of these atoms mediates the constrained interaction, using this tag will cause Rosetta to evaluate the constraint for all of these atoms separately and pick the one with lowest score, i.e. the ambiguity of the constraint will automatically be resolved.

The 'residue1' or 'residue3' tag specifies what type of residue is constrained. 'residue3' needs to be followed by the name of the residue in 3 letter abbreviation. 'residue1' needs to be followed by the name of the residue in 1 letter abbreviation. As a convenience, if several similar residue types can fulfill the constraint (i.e. ASP or GLU ), the 'residue1' tag can be followed by a string of 1-letter codes of the allowed residues ( i.e. ED for ASP/GLU, or ST for SER/THR ).

The 'CONSTRAINT::' records:
 These records specify the actual value and strength of the constraint applied between the two residues specified in the block. Each of these records is followed by one string and 4 numbers. The string can have the following allowed values: 'distanceAB' means the distance Res1:Atom1 = Res2:Atom1, i.e. the distance between atom1 of residue 1 and atom1 of residue 2. 'angle\_A' is the angle Res1:Atom2 - Res1:Atom1 - Res2:Atom1 'angle\_B' is the angle Res1:Atom1 - Res2:Atom1 - Res2:Atom2 'torsion\_A' is the dihedral Res1:Atom3 - Res1:Atom2 - Res1:Atom1 - Res2:Atom1 'torsion\_AB' is the dihedral Res1:Atom2 - Res1:Atom1 - Res2:Atom1 - Res2:Atom2 'torsion\_B' is the dihedral Res1:Atom1 - Res2:Atom1 - Res2:Atom2 - Res2:Atom3. Figure 1 below depicts in a graphical form how the parameters distance, angle and torsion are obtained.

![Matcher Constraint logic visualization](https://new.rosettacommons.org/docs/wiki/rosetta_basics/images/matcher_cst_visual.png)
**Figure 1.** Defining interaction geometry between Atom **1** from **Residue 1** and Atom **1'** from **Residue 2**.

Each of these strings is followed by 4 (optionally 5 ) columns of numbers: x0, xtol, k, covalent/periodicity, and number of samples. The 1st column, x0, specifies the optimum distance x0 for the respective value. The 2nd, xtol, column specifies the allowed tolerance xtol of the value. The 3rd column specifies the force constant k, or the strength of this particular parameter. If x is the value of the constrained parameter, the score penalty applied will be: 0 if |x - x0| \< xtol and k \* ( |x - x0| - xtol ) otherwise
 This 3rd column is only relevant for enzdes, and the number in it is not used by the matcher.

The 4th column has a special meaning in case of the distanceAB parameter. It specifies whether the constrained interaction is covalent or not. 1 means covalent, 0 means non-covalent. If the constraint is specified as covalent, Rosetta will not evaluate the vdW term between Res1:Atom1 and Res2:Atom1 and their [1,3] neighbors.
 For the other 5 parameters, the 4th column specifies the periodicity per of the constraint. For example, if x0 is 120 and per is 360, the constraint function will have a its minimum at 120 degrees. If x0 is 120 and per is 180, the constraint function will have two minima, one at 120 degrees and one at 300 degrees. If x0 is 120 and per is 120, the constraint function will have 3 minima, at 120, 240, and 360 degrees.
 The 5th column is optional and specifies how many samples the matcher, if using the classic matching algorithm ( see the matcher documentation ), will place between the x0 and x0 +- tol value. The numbers in this column are not used by enzdes. The matcher interprets the value in this column as the number of sampling points between x0 + xtol and x0 - xtol. I.e. in the above example, for angleA, the matcher will sample values 99.10, 105.10, and 111.10 degress. For torsionA, it will sample 95, 100, 105, 110, and 115 degress. Generally, if the value in this column is n, the matcher will sample 2n+1 points for the respective parameter. Note that the number of samples is also influenced by the periodicity, since the matcher will sample around every x0. For example, for torsion\_AB in the block above, there will be 2\*5+1 = 11 samples for every minimu, and since there are two minima ( 0 and 180 degrees ), there will be a total of 22 samples for this parameter, at the following values: 0, 9, 18, 27, 36, 45, 135, 144, 153, 162, 171, 180, 189, 198, 207, 216, 225, 315, 324, 333, 342, 351.
 When determing how many different values to sample for each parameter, it is important to remember that the number of different ligand placements attempted for every protein rotamer built is equal to the product of the samples for each of the 6 parameters. For example, in the above block there is one sample for distanceAB, 3 samples for angle\_A, 3 samples for angle\_B, 5 samples for torsion\_A, 18 samples for torsion\_B, and 22 samples for torsion\_AB, meaning that for every protein rotamer, the matcher will attempt to place the ligand in a total of 1\*3\*3\*5\*18\*22 = 17820 different conformations.

Matcher specific instructions in the cstfile
====================================

Several other features of a matcher run can be dictated through blocks in the cstfile.

1.  Matching algorithm to be used for a given block
     The matcher knows to algorithms by which to find the desired active site: classic matching and secondary matching. Please refer to the matcher documentation for a description and comparison of these two algorithms. By default, the matcher carries out classic matching to the ligand. To induce secondary matching for a given constraint/interaction, the following lines need to be added to the cstfile block for that constraint:

    ```
      ALGORITHM_INFO:: match
        SECONDARY_MATCH: DOWNSTREAM
      ALGORITHM_INFO::END
    ```

     This will induce secondary matching to the ligand for this constraint. To induce secondary matching to a protein residue that was matched in another constraint block, the SECONDARY\_MATCH tag has to be changed to

    ```
      ALGORITHM_INFO:: match
        SECONDARY_MATCH: UPSTREAM_CST 2
      ALGORITHM_INFO::END
    ```

     The number in the last column of the 'SECONDARY\_MATCH: UPSTREAM\_CST 2' line defines which cstfile block the target upstream/protein residue is in. Naturally, upstream secondary matching can only happen to a residue in a previous cstfile block.

2.  Sampling level of the protein rotamers
     Generally the protein rotamer sampling level of in the matcher is determined by the values for the -packing:ex1 etc command line options. It is however possible to override these for individual constraint blocks by adding the following lines to a constraint block:

    ```
      ALGORITHM_INFO:: match
        CHI_STRATEGY:: CHI 1 EX_FOUR_HALF_STEP_STDDEVS
        CHI_STRATEGY:: CHI 2 EX_ONE_STDDEV
            IGNORE_UPSTREAM_PROTON_CHI
      ALGORITHM_INFO::END
    ```

     Detailed documentation about how to specify rotamer sampling for individual match residues can be found in the detailed comments in rosetta/rosetta\_source/src/protocols/match/Matcher.cc, preceding function 'initialize\_from\_file'. The 'IGNORE\_UPSTREAM\_PROTON\_CHI' instruction can be very helpful when matching a SER, THR, CYS, or TYR sidechain, if the interaction is defined through the O/S heavyatom and not the proton. It should be noted that the matcher can sample rotameric conformations not available in the standard Rosetta rotamer libraries. When using this feature, one should be aware that the catalytic rotamers might then not be available in the post-processing stages when matches are designed.

3.  Modifying match positions according to structural features.
     It is possible to modify the scaffold positions that are considered for an upstream residue through instructions in the cstfile block of this residue. This can come in very handy when matching against a large number of scaffolds.
     The properties that can be used to discriminate against certain match positions at the moment are secondary structure, bfactors, and number of 10A neighbors.

examples: adding the following to a block to a cstfile

```
  ALGORITHM_INFO:: match_positions
    bfactor absolute <value>
  ALGORITHM_INFO::END
```

will mean that only those positions in the posfile where the calpha has a bfactor of less than value will be matched, for the constraint in which's block in the cstfile this information is.

The following other options are possible at the moment:

```
bfactor relative
```

only positions with a relative bfactor of

are allowed (value has to be 0 \< value \< 1 ) , where relative means ca-bfactor divided by the biggest ca-bfactor observed in the pdb

```
ss ss_char H 
```

only positions that are in a helix are allowd (to get sheet/loop, replace H by E/L )
ss ss\_motif helix\_nterm only positions at the n terminus of a helix will be matched

```
num_neighbors min_neighbors <minval> max_neighbors <maxval> 
```

only positions that have between minval and maxval neighbors will be matched
 num\_neighbors max\_neighbors \<val\> only positions that have less than val neighbors will be matched
 num\_neighbors min\_neighbors \<val\> should be obvious

all these options can be combined, i.e. if you add the following to a block in your cstfile

```
  ALGORITHM_INFO:: match_positions
    ss ss_motif helix_nterm
    bfactor relative 0.4
    num_neighbors min_neighbors 7 max_neighbors 20
  ALGORITHM_INFO::END
```

Only positions in the posfile that are at the n terminus of a helix, are relatively rigid, are not too exposed but also not too buried will be matched. The code for these exclusions resides in `       Rosetta/main/source/src/protocols/match/MatchPositionModifiers.hh/cc      `

Using the CstfileToTheozymePDB executable
===================================

This executable takes a cstfile and builds a pdb model of the residues and geometry specified in it. For every desired interaction (every block in the cstfile), a set of rotamers of the desired residue will be constructed and placed according to the specified geometry. The usage is simply:

```
CstfileToTheozymePDB.<extension> -extra_res_fa <.params file of ligand> -match:geometric_constraint_file <cstfile> -database <rosetta database>
```

See the cstfile\_to\_theozyme\_pdb integration test for an example.

WARNING: Four things need to be considered when using this app, most importantly that the sampling parameters in cstfiles used with this application should be set as small as possible.

1.  The number of sampling steps for all degrees of freedom (5th column of CONSTRAINT records) should always be set to 0. The reason is that during the 3D-model construction, one set of rotamers gets build for every combination of sampling steps. In the above presented example, 17820 distinct conformations of a HIS rotamer set would be built and written to disk. The resulting pdb model would thus be very cluttered, and in case the sampling parameters were even higher, could quickly fill up disk.
2.  Cstfiles used for this application must have all six degrees of freedom specified for every constraint block. The reason is that for every interaction, the rotamer set gets placed using the ligand or a previous rotamer as reference. This means that if there are blocks in the cstfile that have some undefined degrees of freedom and that are to be secondary matched, parameters will have to be added for the undefined dofs for this app.
3.  No energy calculations are done by this app. This could mean that the models produced might have clashes, based on the theozyme geometry, the ligand rotamers, and where the side chain rotamer backbones end up. This does not necessearily mean that a theozyme cannot yield non-clashing matches.
4.  Positions of side chains will be calculated against the first ligand rotamer. Positions of side chains interacting with other side chains (upstream upstream interactions ) will also be calculated against the first side chain rotamer.

In summary, this application should be used to make sure that Rosetta understands the geometry in a cstfile in the way that the user envisions it. When using cstfiles developed with the help of this app in matching or enzdes, one shouldn't forget to adjust the cstfile for sampling parameters and/or secondary matching with some undefined degrees of freedom.

##See Also

* [[File types list]]: List of file types used in Rosetta
* [[Rosetta Basics]]: The Rosetta Basics home page
* [[Match]]: Documentation for the match application
* [[Constraints files|constraint-file]]: Rosetta constraints file format (not for the match application)
* [[Options overview]]: Overview of Rosetta command line options
* [[Glossary]]: Brief definitions of Rosetta terms
* [[RosettaEncyclopedia]]: Detailed descriptions of additional concepts in Rosetta.
* [[Rosetta overview]]: Overview of major concepts in Rosetta
* [[Application Documentation]]: Links to documentation for a variety of Rosetta applications