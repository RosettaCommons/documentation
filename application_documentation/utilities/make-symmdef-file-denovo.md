#Denovo Symmetry Definiton file creation script.

*Author: Ingemar André*

*Last edited Aug 20 2010 by Ingemar André. Code by Ingemar Andre.*

Code and Demo
=============

All the code is contained in the Python script main/source/src/apps/public/symmetry/make_symmdef_file_denovo.py.

Purpose
===========================================

This script automatically creates symmetry definition files corresponding to the specified symmetry. It currently covers cyclical and dihedral symmetry.

Limitations
===========

This routine does not create symmetry definition files for all types of symmetries. These have to be made by hand, see [[the symmetry definition guide|symmetry]], or from a template by application of [[make_symmdef_file|make-symmdef-file]] to a known protein complex.

Options
=======

Running the script without options give the possible range of options.

```
usage: make_symmdef_file_denovo.py [options]

example: make_symmdef_file_denovo.py -symm_type cn -nsub 2
example: make_symmdef_file_denovo.py -symm_type dn -nsub 4
example: make_symmdef_file_denovo.py -symm_type dn -nsub 4 -slide_type RANDOM -slide_criteria_type CEN_DOCK_SCORE
example: make_symmdef_file_denovo.py -symm_type cn -nsub 24 -subsystem

common options:
    -symm_type (cn|dn)                                          : The type of symmetry. Currently cyclic or dihedral symmetry
    -nsub <integer>                                             : number of subunits
    -subsystem                                                  : Simulate a smallers subsystem. For cn 3 consecutive subunits are represented.
                                                                  For dn 6 subunits are represented 3 in the upper ring and 3 in the lower ring
    -slide_type (RANDOM|SEQUENTIAL|ORDERED_SEQUENTIAL)          : Defines how a multidimensional slide should be performed.
                                                                  For dn symmetry there are two sliding directions. A slide
                                                                  can be done by randomly selecting a slide direction for each
                                                                  slide step (RANDOM), randomly deciding on which direction should
                                                                  be slided first but always sequentially go through both (SEQUENTIAL),
                                                                  or define the order yourself (ORDERED_SEQUENTIAL). RANDOM default
    -slide_criteria_type (CEN_DOCK_SCORE|FA_REP_SCORE|CONTACTS) : Defines what the criteria is for abandaning a slide. Either
                                                                  the CEN_DOCK_SCORE, FA_REP_SCORE or the number of contacts. CEN_DOCK_SCORE deafult
    -slide_criteria_val <string|float>                          : Sets the actual value when a slide move is abandoned given the criteria type. By default
                                                                  set to AUTOMATIC, which means that ROSETTA figures it out by itself. Really
                                                                  only useful for the CONTACTS type
```

Expected Outputs
================

A sample command line to generate a trimer. The same command was used to create the symmetry definition for the symmetric docking integration test (rosetta/main/tests/integration/tests/symmetric\_docking):

```
make_symmdef_file_denovo.py -symm_type cn -nsub 3
```

This gives rise to the following symmetry definition:

```
symmetry_name c3
subunits 3
recenter
number_of_interfaces  1
E = 3*VRT0001 + 3*(VRT0001:VRT0002)
anchor_residue COM
virtual_transforms_start
start -1,0,0 0,1,0 0,0,0
rot Rz 3
virtual_transforms_stop
connect_virtual JUMP1 VRT0001 VRT0002
connect_virtual JUMP2 VRT0002 VRT0003
set_dof BASEJUMP x(50) angle_x(0:360) angle_y(0:360) angle_z(0:360)
```

The actual format of the symmetry definition file is described in the [[Symmetry User's Guide.|symmetry]]


## See Also

* [[Types of input files | file-types-list]] used in Rosetta.
* [[Symmetry]]: on symmetry mode
* [[Utility applications | utilities-applications]]: other utility applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
