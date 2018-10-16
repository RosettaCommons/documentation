#Remodel Documentation

* See also the [[RosettaRemodel]] documentation
* For XML information see [[RemodelMover]]

A demo for remodel is available in from the Rosetta distribution at `Rosetta/demos/public/design_w_flex_loops_using_RosettaRemodel`

**The remodel mode is a shortcut to the loop modeling tools in Rosetta, tailor-made for design purposes.** The basic components of the tool consists of a building stage (at the centroid level) and a design stage. Generally there is a "partial design" stage to direct simulation to satisfy packing requirements. Instructions are given using an input PDB file, a blueprint description of the task, and if needed, a constraint definition and a PDB containing a segment of a structure to be inserted to the starting PDB.

flags to use:

     -s [starting pdb -- currently require renumbering from residue 1, but can handle other chains like DNA, see BUILD section below]
     -remodel:blueprint [blueprint file]

The length of the run can be controlled by

     -num_trajectory [integer, >= 1]

this flag dictates the number of centroid level sampling desired.

Number of structures to be processed in accumulator/clusters should be specified with:

     -save_top [integer]

should probably include the flags generally used for rosetta runs

     -no_optH false
     -ex1
     -ex2

there are also other flags to be use for special cases: (see other sections in this documentation)

     -enzdes:cstfile [constraint file]
     -insert_segment_from_pdb [pdb containing segment]
     

Currently Remodel protocol is setup to run CCD\_refine, but this can be switched off by -remodel:quick\_and\_dirty

This is useful in early stages of design when one wants to sample different loop length to find appropriate setup.

OUTPUT
------

**CURRENTLY REMODEL HANDLES ITS OWN FILE I/O, and only use job\_distributor to launch the process. Normally job distributor will write out a file at the end of a run, usually in the format of XXX\_0001.pdb; this file is NOT TO BE TRUSTED IF YOU RUN -num\_trajectory GREATER THAN 1!!** Instead, look for the files that are simply 1.pdb, 2.pdb, etc. Due to internal caching of the structures in both clustering and structure accumulation stage, Remodel protocol generates more structures internally than what was expected by job\_distributor (which is apparently, one in, one out.). If one trajectory was used, then the 1.pdb will have the same info as the XXX\_0001.pdb from the job\_distributor. Once Accumulator/Clustering is used, due to sorting done internally, the structure with lowest energy, according to score12, is output as XXX\_0001.

BUILD
-----

in the building stage, one needs to describe the task through assignments in the blueprint file. (discussed below) Remodel allows switching different builders, but is default to use RemodelLoopMover as the builder protocol. It is slightly different from the other builders because it assumes no knowledge of amino acid types at the centroid level. Only "vdw", "rama" and "rg" were used to score centroid level structures.

Since the identity of the amino acid is not known until the backbone is built. As a placeholder for sidechain volume, VALINE centroids are used as the generic amino acid type. One can change this assignment by "-generic\_aa A" \<=this changes the generic amino acid to ALANINE. [only one letter code allowed, Dec 19, '11]

For different types of building tasks (such as building helices, sheets), one will want to also turn on the secondary structure relevant flags to turn on their scoring in the centroid level.

For helices:

     -hb_srbb 1.0  <= the number is the weight for this scoretype

For sheets:

     -hb_lrbb 1.0
     -rsigma 1.0
     -ss_pair 1.0

the value for the weights can be adjusted freely. But needs a number greater than 0 to turn the score on.

**CHAIN (DNA) -- thanks, Fabio (This section will change in near future. The plan is currently to have chain specific blueprints)**

In a starting PDB that has multiple chains, Remodel works on the first chain. Leave the chain field empty for this region or use the flag "-chain " followed by chain name (eg. A) to indicate the target chain. The other parts can still carry their chain designator, and they will not be touched by the protocol -- but will stay present throughout the simulation. If DNA is present it will be considered for scoring but will not move during the run. Also if you have anything other than protein, clustering on CA atom will not work, so clustering should be turned off by "-use\_clusters false."

**MOCK\_PREDICTION {not available yet}**

Although it does not have all the bells and whistles for running a thorough prediction run when a sequence is known, the Remodel protocol can be used to run a "mock prediction" where the amino acid sequences are given and one just wanted to predict its final structure using sequence biased fragments (still generic/or hand assigned and has no secondary structure prediction from multiple sequence alignment) and relying largely on full-atom refinement to get a structure for a known sequence. In this case, one would switch on "-mock\_prediction" and this swaps out the design scorefunction with the one (score4L) used for general loop prediction tasks. "-remodel:use\_blueprint\_sequence" should also be used, so fragments chosen from vall database will bias towards sequences known. But when doing so, be sure to assign the \*SECOND\* column of the blueprint file amino acids of your target sequence, and use PIKAA to manually force the final amino acids used in refinement to match the sequence needed a predicted structure.

BLUEPRINT
---------

blueprint file can be generated by running getBluePrintFromCoords.pl script (in Rosetta/demos/public/design\_w\_flex\_loops\_using\_RosettaRemodel/scripts)
```
getBluePrintFromCoords.pl -pdbfile [starting pdb] \> [blueprint name]
```
Blueprint file consists of three columns:
```
1 N .
```
(residue number in the original PDB, residue single letter code, and building instruction) By replacing the "." to "E", "L", "H", or "D" one can build ss type extended strand, loop, helix, or any random SS, respectively. This notation controls the secondary structure used in harvesting fragments from vall.

e.g.

     1 N .
     2 K H
     3 G H
     4 W H
     5 K .

This assignment will rebuild residue 2-4 using helical fragments.

Simply removing a line while giving build assignments to the positions before and after the deletion will shrink the PDB and reconnect (if possible, given the slack in the structure) the rest of the structure. one might need to include more positions in the rebuild assignment to ensure enough elements can move to reconnect the junction.

EXTENSIONS:
-----------

if a section of the PDB is to be extended, an "extension" code can be used:

     1 N .
     2 K H
     0 x H
     0 x H
     3 G H
     4 W .
     5 K .

This way, 2 residues will be inserted between the original residue 2 and 3. Although the blueprint file supports commenting lines, it's simpler if you don't add extra lines. This way if you use vi, you can show line number and the numbering will correspond to the new residue numbers. **NOTE: you need to have assignments in the third column for residues flanking the extension. In our example, position 2 and 3 has to be assigned.**

BUILD with CONSTRAINTS
----------------------

Remodel uses the [constraint setup]( https://www.rosettacommons.org/docs/latest/rosetta_basics/file_types/match-cstfile-format) in the EnzDes protocol, because it separates the definition of residue positions and the constraints to be applied to them. This setup allows blueprint to double as a constraint position definition file and allow all extensions and deletions to be handled elegantly. Note that the build constraint defined here will only be used in the centroid stage.

To setup build constraints, a constraint definition text file has to be created first, following the enzdes format:** (NOTE that backbone atoms need extra manual declaration of "is\_backbone" otherwise they won't get applied in the build stage. And the atom\_types are Rosetta atom\_types.)**

     CST::BEGIN
       TEMPLATE::   ATOM_MAP: 1 atom_type: Nbb
       TEMPLATE::   ATOM_MAP: 1 is_backbone
       TEMPLATE::   ATOM_MAP: 1 residue3: ALA CYS ASP GLU PHE GLY HIS ILE LYS LEU MET ASN PRO GLN ARG SER THR VAL TRP TYR
     
       TEMPLATE::   ATOM_MAP: 2 atom_type: OCbb
       TEMPLATE::   ATOM_MAP: 2 is_backbone
       TEMPLATE::   ATOM_MAP: 2 residue3: ALA CYS ASP GLU PHE GLY HIS ILE LYS LEU MET ASN PRO GLN ARG SER THR VAL TRP TYR
     
       CONSTRAINT:: distanceAB:    2.80   0.20 100.00  0
     CST::END

this block describes a constraint setup between two backbone Nitrogen and backbone Oxygen atoms to fall within a hydrogen bonding distance (2.8 Å) The residue3 tag lists all the amino acid types so when the constraint is applied, it simply ignores the amino acid identity. it can be a single letter code if "residue1" is used.

Notes on cst file: "atom\_type" designation requires only one name, and the connectivity will be automatically looked up in params file. But if use "atom\_name", one would have to explicitly specify three atoms so the torsions and angles can be set correctly. For example: ATOM\_MAP: 1 atom\_name N CA C and ATOM\_MAP: 2 atom\_type Obb, given a TORSION\_A constraint, it will restraint torsion between O-N-CA-C.

The terms can be used are: distanceAB: torsion\_A: torsion\_B: torsion\_AB: angle\_A: angle\_B:

atom\_map residue1 (or residue3) assignment should match the kind of atoms they define. In the example above, a backbone constraint can be applied to all amino acid types, so we list all 20 AA's. But if a sidechain designation is required, be sure to use only the residue that can satisfy those descriptions. (e.g. NE2 exists in GLN, but not in ALA)

Secondly, the positions corresponding to the residues defined in the constraint file should be tagged in blueprint:

     10 K .
     11 T .
     12 L . CST1A
     13 K .
     14 G H
     15 E H
     16 T H
     17 T H CST1B
     18 T H

In this example, the Nbb atom on position 12 will have a H-bond constraint setup with the OCbb atom on position 17. **The residue tagged as "A" corresponds to "Atom Map: 1" in the constraint definition block, "B" corresponds to "Atom Map: 2" (unfortunately, this conversion between A, B and 1, 2 is needed so the number of constraints is not limited to 26, A...Z.** If you have more than one constraint to setup for each position, just continue with the definition (but be sure to duplicate the CST entry in the constraint file, each block correspond to CST1A/B, CST2A/B, ..., etc):

     10 K .
     11 T .
     12 L . CST1A CST2B
     13 K .
     14 G H
     15 E H CST2A
     16 T H
     17 T H CST1B
     18 T H

In this second case, the Nbb and OCbb on position 12 is constraint with the OCbb on position 15 and Nbb on position 17, respectively.

Once the constraint and the blueprint files are tagged correctly, to use them, one simply issue "-enzdes:cstfile [constraint file name]" to use them.

Non-enzdes style constraints may also be used ( e.g. -cst_file atompair_angle_dihedrals.cst ) however if these are used in both centroid and fullatom mode and thus will crash if non-backbone atoms are used

 CONSTRAINT FILTER

When running a build with constraint definition, Remodel automatically uses a constraint filter and only generates decoys that satisfies your constraints, within 10 energy units. This value can be changed with a flag (e.g. -cstfilter 100)

The stringency of individual constraints can also be adjusted by changing the weights on the constraint term, for example, in the cstfile defined above:

       CONSTRAINT:: distanceAB:    2.80   0.30 100.00  0

a constraint weight of 100.00 was defined. Effectively any violation of this distance constraint will be greater than the 10 energy unit allowed. To soften this filter, one can simply change the line:

       CONSTRAINT:: distanceAB:    2.80   0.30   1.00  0

the change in the constraint weight effectively gives 1/100th the penalty. After each round of building, the log will indicate what the atom\_pair violation is and the user can tweak the weight based on this.


DESIGN
------

There are different stages of designing a newly built structure. In a accumulation stage (the "partial structure"), Remodel counts neighbors to identify what residues are buried, and only uses the buried positions in this stage.

There are 6 different design modes.

the decision for the switches are controlled by whether there's a 4th column added to the blueprint and 2 extra flags:

If there's no resfile command assignment in the 4th column (except CST assignments), uses automatic design. (auto design will pick core positions automatically and use only hydrophobic amino acids) To control whether neighboring residues are included, repacked or redesigned:

-find\_neighbors alone will repack all the neighbors, in either auto or manual mode, otherwise only the rebuilt positions described in the blueprint file will be redesigned. -find\_neighbors -design\_neighbors will redesign all the neighbors.

For manual design, Blueprint file also handles designing positions using resfile commands, so one can specify:

     1 N .
     2 K H PIKAA K
     0 x H ALLAA
     0 x H APOLAR
     3 G H ALLAA
     4 W .
     5 K .

If you are using manual mode, **it is recommended that you assign all the positions included in the rebuilding segment (but not necessarily elsewhere)** , otherwise they will be turned into Valines. (the default building residue at centroid level) This assignment, however, is not limited to the residues to be rebuilt. It works just like a resfile, you can turn any residue on the fly.

additionally, the normal design flags such as -ex1 -ex2 should also be included to control this design behavior.

so up to this point, with the information given, one can already build a simple structure with the following commandline:

```
remodel.linuxiccrelease -s input.pdb -remodel:blueprint test.blueprint -ex1 -ex2 -correct -num\_trajectory 10
```

KIC CONFIRMATION
----------------

[this feature is to be tested] After building the structure using CCD\_refinement, one still does not know what would be the best sequence to produce experimentally. A new feature is to check those sections with an orthogonal method, and if the results converge, there is a higher chance that the loop is plausible. Currently we use CCD to build, and use KIC for the refinement step. if "-run\_confirmation" was issued, structures generated by CCD will be tested in a KIC refinement step using the sequences designed from the CCD step. The build region will be expanded by 2 residues (to reduce bias) on both sides, and the entire segment will be rebuilt by KIC\_refine protocol. The confirmation stage is currently setup as an evaluation check instead of a filter, so structures failed the test will still be produced. RMSD for the loop CA atoms to the CCD refined structure will be reported in both the log file and the REMARKs section (if turning on "-preserve\_header true" ). One can post-filter the structures based on this info.

 As of May 1, 2010, one can also swap the methods to build with KIC and refine with CCD by "-swap\_refine\_confirm\_protocols" .

More advanced setup:
====================

CLUSTERNG
---------

In specifying -num\_trajectory, Remodel can make decisions on the refinement step by going after only the unique structures that score well coming out of the partial design stage. It collects all the structures and cluster them, and only use the lowest energy (presumably having the best contacts in the core) models to carry out full-atom refinement.

To control the clustering behavior, the default behavior is "false"

       -use_clusters false <=this will ask the program to refine all the structures generated at centroid level.

One can turn this feature on with

       -use_clusters true

But be sure to set a trajectory number greater than one. Single structure can't form a cluster and Remodel will generate no output.

and if using the clustering strategy, one can use -cluster\_radius [real number]

to set how different the clusters should look.

CHECKPOINTING
-------------

Remodel has its own checkpointing scheme, in which structures were written out to disk and could be re-introduced to the program when the process is rebooted -- as in the case of being pre-emped from a cluster but inserted later on.

checkpointing is switch on by issuing the flag: -checkpoint

and it is related to the -save\_top [number] command, as checkpointing recovers the same number of structures written out by the -save\_top command. (if your first pass of the protocol didn't generate the number of structures specified in -save\_top, only the ones generated will be recovered). This scheme is only used to make sure that the best structures from a simulation is not lost when a process is terminated. It will also generate a text file to mark the number of trajectories already finished, therefore picking up from where num\_trajectories were left off, so to speak.

**WARNING: for SYD, you may want to keep save\_top to about 10 files only. It might bring down the filesystem.**

Domain Insertion
----------------

the usage is simply 1) create a fragment of the PDB you want to put into the other structure, and 2) make a blueprint definition of it (by calling it "I" instead of H, E, or L) along with the assignments for how you want to connect the loops, and 3) use the flag "-insert\_segment\_from\_pdb [name of the pdb file]"

Special pair linker setup scheme
--------------------------------

I have recently been asked to provide a setup where multiple linkers can be built on two different chains simultaneously. More specifically for a domain assembly type setup where a dimer interface is held constant while two extra domains are linked to each of the binding partners. This special case requires Remodel to recognize the input pose consists of two chains and allows fragment insertion without holding a jump across the segment.

use two flags to achieve this: Starting PDB already contain all the domains, now just build linkers to assemble them in a plausible configuration.

     -remodel:two_chain_tree [start of the second chain]  
     -remodel:no_jumps

Tethered docking
----------------

[recommend to use only for rebuilding a single segment]

-remodel:RemodelLoopMover:bypass\_closure

-remodel:RemodelLoopMover:force\_cutting\_N

a segment of the structure can be rebuild, but without restricting it to closure criteria. This is useful for things like docking a helix onto a backbone, and one can build a new connection once the helix is in place. normally only the "bypass\_closure" is needed, and a cut will be introduced to the C-term of the blueprint assignment range, but it can be switched to N-term shall the helix, or any structure needs building backwards.

Disulfide design
----------------

-remodel:build\_disulf 

-remodel:disulf\_landing\_range [start] [end] 

-remodel:match\_rt\_limit [float]

Remodel will try centroid build and scan for all possible disulfides between the build region and the landing range (but not within the build region). The build region is assigned in the blueprint file to define the starting residues, which will then be paired with residues specified within the "-disulf\_landing\_range".

It's recommended that you use pose relax refinement scheme for disulfide refinement. Sometimes it's desirable to just scan for possible disulfide positions in the native structure (instead of rebuilding a segment to make it), this can be done in combination with "bypass-fragment" flag. The structure will still be minimized when the disulfide is introduced, but the sites possible were all from native conformation.

sample commandline: \~/src/mini/xcode/build/Release/remodel -s scaffonly\_renum.pdb -remodel:blueprint test.blueprint -bypass\_fragments -database \~/minirosetta\_database/ -remodel:use\_clusters false -remodel:build\_disulf -no\_optH false -correct -remodel:match\_rt\_limit 5.0 -remodel:disulf\_landing\_range 1 53 -remodel:num\_trajectory 1 -remodel:save\_top 5 -overwrite -remodel:use\_pose\_relax true

NOTE: in this case num\_trajectory is 1, but requested outputting 5 structures. This is because there are more than one possible disulfide in this one structure, and Remodel makes them all. (if only 4 are possible, only 4 will be generated)

One can also tighten the match\_rt\_limit setting to make only "better" disulfides, but runs the risk of not able to build any. in Rob's disulfide potential, it's a RMSD measure from your backbone to a real disulfide in the database. The disulfides in the database are harvested with idealized structures, so the precision isn't sub-angstrom. around 1 Å is pretty good.

in the log, you will find lines like:

protocols.forge.remodel.RemodelDesignMover: DISULF possible 22.8416

protocols.forge.remodel.RemodelDesignMover: DISULF 30x5

protocols.forge.remodel.RemodelDesignMover: match\_rt 1.04513

This tells you the quality of the disulfide it finds. The first one is a CA distance squared, it only evaluates them if within 5 Å. the second tells you it's between residues 30 and 5 the third line is how different this pair is from the closest disulfide in the database.

it will show lines like:

protocols.forge.remodel.RemodelDesignMover: central residues: 35,36,37,38,

protocols.forge.remodel.RemodelDesignMover: neighbor residues: 52,53,54,56,

If you don't see residue numbers listed in the central and neighbor residues, then your blueprint is probably assigned wrongly.

**WARNING: currently, the disulfide building scheme has a death trap built into it. It works very well if you give it positions that are plausible, but if it can not find a disulfide to build, it will try in an infinite loop. Building perfect disulfides can be very difficult, thus this setup was used. This is especially bad for scanning fixed backbones. Since they aren't moved, failure in the first try will guarantee failure the second time, too. So be sure to catch it and kill it by hand.**

FAQ (WHY DID MY RUN CRASH?)
===========================

Some common mistakes are:

1) if you get a seg fault right after reading the blueprint, it might be because you have an empty line at the end of the file. the blueprint file should just end at the last definition and no empty blank lines.

2) if you see errors complaining about some residue doesn't exist or some kind of ResfileReader generated problems. It's very likely that you have chain definition in your PDB and you are running manual design modes. The easiest solution is to delete the chain from your starting PDB and checkpointed PDB's if you are using them. The checkpointed PDB's carry over whatever chain the starting PDB has, so sometimes they also have to be corrected to remedy this problem.

3) It can also be that you forgot to assign secondary structures around an extension.

4) Why some of my positions get turned into ALA? It can be because you assigned some positions to build manually, but forgot to assign all rebuilding positions. Currently, once you are in manual mode, everything is controlled manually (except neighboring residues that can be picked automatically).

5) a bug. this... you'll have to debug yourself or ask Possu.