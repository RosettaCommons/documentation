#Match application

Metadata
========

Authors: Florian Richter, Andrew Leaver-Fay

This document was written by Florian Richter and Andrew Leaver-Fay in August 2010. The section about generating ligand grids was written by Lucas Nivon. The `       match      ` application is maintained by David Baker's lab. Send questions to (dabaker@u.washington.edu)

Code and Demo
=============

The matcher executable is compiled from rosetta/main/source/src/apps/public/match/match.cc. The classes that constitute the matcher live in the directory (and subdirectories of) rosetta/main/source/src/protocols/match/ and rosetta/main/source/src/protocols/toolbox/match\_enzdes\_util/. The details for many of the classes are described in greater detail within the doxygen tags, and are recommended as a source for more details than can be given in this document. Demos for the matcher are given in rosetta/main/tests/integration/tests/match/.

References
==========

The matcher algorithm was published in:

Alexandre Zanghellini, Lin Jiang, Andrew M. Wollacott, Gong Cheng, Jens Meiler, Eric A. Althoff, Daniela Rothlisberger, and David Baker. (2006) "New algorithms and an in silico benchmark for computational enzyme design" Protein Science. 15. 2785–2794.

As noted in Matcher.cc this protocol was ported to Rosetta 3.x by Andrew Leaver-Fay and Florian Richter. Some of the additional features available in the Rosetta 3.x version are described in:
 Richter F, Leaver-Fay A, Khare SD, Bjelic S, Baker D (2011) De Novo Enzyme Design Using Rosetta3. PLoS ONE 6(5): e19230. doi:10.1371/journal.pone.0019230

Application purpose
===========================================

In brief:

The matcher application can search through a protein backbone ("scaffold") to find positions where a binding site for a desired small molecule (or biomolecule, in the more general case) target can be introduced. The target consists of a molecule and a set of desired side-chain interactions with that molecule. For example, the target might have an amino group to which the user wants to form a hydrogen bond from a sidechain carboxyl group. That interaction is specified via a constraint (\*.cst) file; this file can be used both for matching, and later, for enzyme design. The output from the matcher will be a set of poses of the target in the scaffold, with the desired sidechains placed as specified by the constraint file; if the matcher finds no matches there will be no outputs. The matcher can be used on a large set of protein backbone scaffolds as a series of independent jobs, but each job will only examine a single scaffold.

In detail:

The matcher algorithm was originally concieved of within the domain of enzyme design. The transition state for the desired reqction is contacted by several amino acids each with a particular geometry. The goal of the matcher is to find a set of backbone positions on a given protein-backbone scaffold where those amino acids could be grafted such that they would contact the transition state in the desired geometry.

Consider a case where the transition state is contacted by an asparagine, an aspartate and a histidine. The user designing an enzyme for this transition state knows the geometry that describes the orientation of the transition state with respect to each of these side chains; what they do not know is into what protein and at what positions they should introduce these amino acids. The user will give the matcher a description of the geometry between the amind acids and the transition state, the "external geometry". This geometry is in the form of 6 parameters: 3 diherals, 2 angles, and 1 distance (more on these later). Given the coordinates of a particular side chain and the geometry describing the transition state relative to the side chain, the coordinates of the transition state may be computed. In a sense, the transition state may be grown off of the end of a side chain in the desired geoemtry.

(Usually, the user will specify many different possible values for each of the 6 parameters, and the matcher will then consider all combinations of those values. E.g. the ideal distance might be 2.0 A, but the user might ask the matcher to consider the values 1.95 and 2.05 A additionally. Each assignment of values to these 6 parameters fully specifies the coordinates of the transition state.)

The matcher examines each geometric constraint one at a time. It builds rotamers for one or more amino acids capable of satisfying a desired geometry (e.g. both ASP and GLU if an acid group is needed) at each of several active-site positions, and for each rotamer, it grows the transition state. The matcher does a quick collision check between the atoms of the transition state and the backbone of the protein, rejecting transition-state conformations that collide. If the conformation is collision-free, then the matcher measures the coordinates of the transition state as a point in a 6-dimensional space. (It is no coincidence that there are 6 geometric parameters and that there are 6 dimensions in the space describing the transition state's coordinates). With this 6-dimensional coordinate, the matcher can recover the coordinates for the transition state – the 6-D coordinate and the full euclidean coordinates of the transition state are interconvertable. The matcher can also bin the coordinate. If two coordinates in 6-D are close, they will be assigned to the same bin. This is the fundamental insight of the matching algorithm: the matcher will grow the transition state from different catalytic residues, and when the 6-d coordinates from different catalytic residues are assigned to the same bin, then the matcher has found a set of conformations of the transition state that are compatible with more than one catalytic geometry.

Each collision-free placement of the transition state is called a "hit". If there are N geometric-constrains that the matcher is asked to satisfy, then a set of N hits, one per constraint, that fall into the same bin are called a "match".

In the general case, the Matcher builds hits for each of several geometric constraints. The protein scaffold in the enzyme-design example generalizes to any macro-molecular polymer scaffold. The protein rotamers in the enzyme-design example generalizes to a set of conformations for the "upstream" partner. The transition state in the enzyme-design example generalizes to a "downstream" partner, which itself may have multiple conformations. "Upstream" and "Downstream" refer to the order in which the coordinates of the two partners are computed. The upstream coordinates are built first, the downstream coordinates second. Changes to the coordinates of the upstream partner propagate to the coordinates of the downstream partner. The downstream partner could in theory also be an entire protein – and may have it's own set of rotameric states. E.G. one might want to match a hydrogen-bond donor on the scaffold to a serine side-chain on the target (downstream) protein. The downstream partner should then be able to examine many serine rotamers for each conformation of the upstream rotamer. However, the matcher is not setup yet to handle entire proteins as downstream partners.

A hit is represented in two parts: a discrete part and a continuous part. The discrete portion consists of four integers: 1. the build-point index on the scaffold, 2. the rotamer index on the upstream partner, 3.  the external-geometry index, and 4. the rotamer index on the downstream partner. The continuous portion consists of 6 double-precision values representing the coordinate of the downstream partner in 6D. The first three values are the x,y and z coordinates of a particular atom in the downstream partner. The second three values are the phi, psi, and theta values describing the coordinate frame at this atom. These three "Euler angle" parameters describe three rotations: Z(psi) \* X(theta) \* Z(phi) \* I. They are described in greater detail in rosetta/main/source/src/numeric/HomogeneousTransform.hh, and the hit class is in rosetta/main/source/src/protocols/match/Hit.hh "Phi" and "psi" here have nothing to do with the protein-backbone angles. When a hit is binned, there are two sets of parameters that describe how wide the bins in each dimension should be: the Euclidean bin widths are for the xyz coordinates, and the Euler bin widths are for the Euler angles. The Euclidean bin widths are in Angstroms and the Euler bin widths are in degrees.

Algorithm
=========

In brief:

A matching run takes a non-ligand-containing scaffold pdb, a specification for the target (params file and set of possible conformers in pdb format), and a description of the desired constraints (aka the external geometry) between the scaffold sidechains and the target. A constraint file will have multiple specific constraints, for example constraint 1 from a Glu carboxyl group to a ligand amide and constraint 2 from a Tyr OH to a ligand C=O group (we'll use these example constraints in the paragraphs below). In the general case the scaffold is "upstream" and the target molecule (a small molecule or biomolecule) is "downstream".

Matching takes place in two major steps, hit generation from each constraint and then match enumeration to find compatible hits from each constraint. Two hits "match" if they both describe the ligand as being in the same bin in 6D (more on this below).

In hit generation each constraint is examined in series. The desired sidechain is built out from each allowed active site position (specified in the pos file), testing all rotamers and all allowed sidechain-ligand geometries from the constraint file. Whenever a positioning of the ligand is found that does not clash with the backbone, the matcher records a "hit". The hit – that is an object with 3 spatial dimensions and 3 rotational angle dimensions that describes a positioning of the ligand – is placed into a bin in 6D and that bin is used as a key into a hash table. If two hits are in the same 6D bin, that means they are at very nearly the same spot in space and have very nearly the same orientation. If the grid spacings are large then the allowed deviation within a hash bin is correspondingly large. That positioning could lead to a match from that position, e.g. it has the correct geometry from Glu 50 carboxyl to the ligand amide NH for constraint 1. However to make a match that hit must lie in the same 6D bin as with another hit from each of the other constraints. If a given constraint generates no hits the matcher stops – there needs to be a hit from each constraint in order to get a match, so if one constraint generates no hits, then no matches are possible.

If every constraint generates a least one hit, the matcher proceeds to match enumeration. The hash map in which all hits are placed is examined to find bins with hits from every constraint. A bin that contains at least one hit from each geometric constraint yeilds matches; a match is a combination of hits which all lie in the same bin in 6D; it is possible for one bin to contain many hits, and many many matches.

In detail:

There are two stages of matching: 1) hit generation, where the geometrically-compatible placements of the downstream partner are computed, and 2) match enumeration where the combinations of hits that fall into the same bins in 6D are enumerated and output.

1.1 Hit generation with the classic match algorithm as developed by Zanghellini et al.

This section sketches the algorithm for the "classic matching" routine. The loops described below are a little different for the "secondary matching" routines.

The outer loop in the hit generation stage is across all geometric constraints. In the case of matching in parallel with OpenMP, it's worth noting that each geometric constraint is processed completely before the next geometric constraint is begun.

Inside the loop over all geometric constraints is a loop over all "build positions." That is, the user must specify which residues on the scaffold protein are worth considering. The user may specify different build positions for each of the geometric constraints, or she may use one list of build positions for all geometric constraints.

Inside the loop over all build points is a loop over all amino acids that can be built for the given geometric constraint. Inside this loop is a loop over all the rotamers that can be build for each amino acid. Inside this loop is a loop over all the possible ways to grow the the ligand from a rotamer (e.g. when growing a ligand from an ASP, both OD1 and OD2 can be used and so this loop will iterate across both of these atoms). Consider at this point that we have a particular amino acid at a particular build point, that we have chosen a particular rotamer of this amino acid, and that, from this rotamer we have selected an atom – actually three atoms (e.g. in the case of building from an ASP, either the three atoms ( CG, CD, OD1 ) OR the three atoms ( CG, CD, OD2 )) from which to build.

The next loop is over all combinations of parameters describing the "external geometry" that connects the protein to the ligand. There are 6 parameters that describe this geometry: 3 dihedrals, 2 angles, and 1 distance. For each of the combinations of the external geometry, the matcher builds the coordinates for three atoms of the transition state. From here, the matcher will consider all the possible ligand conformations, building the remaining atoms of the ligand using the coordinates of three atoms that were built as part of the previous external-geometry building step. Each one of the ligand conformations at this point could turn into a hit. There are five criteria that are used to determine if a hit should not be saved for further consideration:

a) Some atom on the ligand collides with the backbone. This check is performed using a class BumpGrid: a set of 3D grids (each represented by an instance of class Bool3DGrid), one for each the different atom radii for the ligand, where each grid reflects the Minkowski sum of the ligand atom (the probe) and the backbone atoms. A voxel within the grid for atom-type i with radius ri will hold "true" if all points inside the voxel are within ( ri + rj ) of some atom j with radius rj, and "false" otherwise. To do a collision check for a particular ligand atom with a particular radius, the matcher first selects the corresponding grid. It then computes the 3D voxel that contains the center of the ligand atom. If that voxel's value in the 3D grid is "true", then the atom is in collision with the backbone; if it's "false", then the atom is not in collision with the backbone. This is a very rapid check. Collision tolerance is built in to this grid at its construction time, so that, with a tolerance of t, and prove atom i with radius ri, all points inside a voxel must be within ( ri + rj - t ) distance of some atom j with radius rj. The flag -bump\_check \<tolerance\> controls how much collision tolerance is allowed.

b) Some atom on the ligand collides with some atom on the upstream residue. The collision tolerance for this check is controlled with the flag -updown\_collision\_tolerance \<tolerance\>, or, if this flag is not used, then by the value specified with the -bump\_check \<tolerance\> flag.

c) This is not the first geometric constraint to be examined and the 6D coordinate of the ligand (the 6D coordiante consists of 3 Euclidean coordiantes and 3 Eulerian coordinates) falls in a region of 6D that cannot lead to a productive match. If it cannot lead to a productive match, then there is no reason to store it. How does this work? The matcher keeps track of all the 6D voxels that could be productive. As the matcher is examining geometric constraint i, then voxel v could be productive iff each geometric constraint 1..(i-1) produced a hit which landed in v. Note that in round 1, all hits pass this test. The data structure which is responsible for holding these voxels is the OccupiedSpaceHash that lives in src/protocols/match/OccupiedSpaceHash.hh.

d) The Euclidean 3D coordinate of the hit lies outside of the 3D bounding box for the OccupiedSpaceHash. This bounding box must be specified up front (see the description for the -grid\_boundary \<fname\> option)

e) One or more critical ligand atoms lie outside the active site for the scaffold (aka the "ligand grid"). The critical ligand atoms are listed in the input file controlled by the -required\_active\_site\_atom\_names \<fname\> flag. There are two ways to define the active site; through the use of a Rosetta++ style ligand grid, or by listing the active site residues for the structure.

If all the hit passes all five filters, then it will be appended a list of hits. This contents of this list will eventually reach the outer-most for loop.

When the loop over all build positions has completed, then the Matcher will update the OccupiedSpaceHash with all the hits from the focused geometric constraint. If this is the first geometric constraint, then all the hits are added to the OccupiedSpaceHash; if it's not the first geometric constraint, then each voxel in the OccupiedSpaceHash which was not filled by a hit from this round is marked as being unproductive. Then, all hits from previous rounds (rounds 1..(i-1)) whose voxels in 6D have been marked as unproductive are deleted.

The hits from each round are saved for the match enumeration stage.

1.2 Hit Generation with Secondary Matching

New to this implementation of the matching algorithm is the option to avoid generating new hits by instead reusing the hits generated in a prior round of hit generation. That is, if a geometric constraint can be specified in fewer than 6 degrees of freedom (i.e. it doesn't matter which value is assigned to one or more of the 6 DOFs describing the geometric constraint between the protein and a ligand) or if a geometric constraint is specified between parts of the protein (i.e. the ASP contacting the ligand in geometric constraint 1 needs to recieve a hydrogen bond from a HIS in geometric constraint 2), there is now the option to use existing hits from some preceeding geometric constraint as the hit source for this later geometric constraint.

The secondary matching algorithm may be activated by including extra information inside the (optional) ALGORITHM\_INFO block in the ref match\_cstfile\_format "geometric constraint input file."

When secondary matching is performed for a particular round, the hits that were generated in some prior round, or all prior rounds are gathered. Then the matcher begins its standard interation across all build positions, and for each build position, across all rotamers. After building a rotamer at a given build position, then the geometry between this rotamer and all earlier hits is measured and the hits which are within range on all the specified geometric parameters are considered hits for this round. Also availabe is a version of secondary matching where the desired interaction between the new rotamer and the geometry provided in the earlier hit (either a location of the downstream partner, or a the rotamer for a residue in a prior round) can be specified as requiring some certain energy cutoff; the weights for each of the terms you wish to consider and the total energy threshold for the pair interaction should be specified in the ALGORITHM\_INFO block of the geometric-constraint file.

2\.  Match enumeration

There are three things to describe in this section: a) why this stage is referred to as an enumeration, b) why we have to search for matches 64 times instead of just once, and c) how matches are output.

a) Enumeration:

A match consists of N hits, one from each of the N geometric constraints. Matches are found by using a hash table: the 6D coordinate for the ligand is binned and the bin is turned into an integer (a 64-bit integer). The integer is used as a key in the hash table; this hash table maps between bin-indices and an N-dimension [[utility::vector1|vector1]] \< std::list\< Hit \> \> so that a Hit generated in round i is inserted into the list in the i'th position of the vector1. Then, all the 6D voxels that contain matches can be found by iterating across all the elements of the hash table.

Now, each element in this hash map contains a list of Hits. If there are three geometric constraints, and a particular voxel contains 2 Hits from each of the three geometric constraints, then there are 2 \* 2 \* 2 = 8 matches that can result from these 6 Hits. If there are 3 Hits from each geometric constraint, there are 27 matches that can result. Generally, if geometric constraint i contains n\_i(v) hits for voxel v, then the total number of matches from voxel v is product(i=1, i\<=N; n\_i(v)). All possible matches are considered in an enumeration of all combinations of hits. That is why this phase is called "match enumeration."

b) Hashing 64 times:

One problem with hashing hits into bins is that two hits can be very near each other in 6D, but on the other side of an arbitrarily defined bin boundary. In 1D, imagine the bins defined with a width of 1 and an origin at 0. In such a case, one hit with coordinate 1.125 and another hit with the coordinate 1.35 would fall into the same bin – the bin from 1 to 2 – and the two hits would be considered together as part of a match. However, a hit with the coordinate of 0.95 does not fall into the same bin as the hit with coordinate 1.125 and therefore they would not be grouped together, even though they are very close to eachother. The solution in 1-D is obvious: hash twice. Hash once with an origin of 0.0 (and bins 0-1, 1-2, 2-3, etc.), and a second time with an origin of 0.5 (and bins 0.5-1.5, 1.5-2.5, 2.5-3.5, etc.). The 0.95 hit and the 1.125 hit would be binned together in the second hashing. The choice of the origin for the 2nd binning is a step of 1/2 of the bin width.

This approach in 1D produces 2\^1 = 2 hashings; the solution in 6D produces 2\^6 = 64 hashings. There are 6 dimensions along which the origin may be shifted by half a bin width, and there are 2\^6 combinations of shiftings, all of which must be considered. This is why we have 64 hash maps we must consider and why the number 64 shows up in so much of the code.

One thing to note about this approach is that some hits will be binned together multiple times: the 1.125 hit and the 1.35 hit are binned together with the origin at 0 and with the origin at 0.5. This means that, in order to avoid outputting a match multiple times, we must keep track of what matches have already been output; class MatchOutputTracker is responsible for doing just that.

c) Outputting Matches:

The outputting of matches is divided into two parts: the Matcher itself is responsible for iterating across all 64 origin-definitions, hashing hits in this origin definition, enumerating matches for it, and ensuring that each match is only considered once. The Matcher then hands the match to a MatchProcessor, and the MatchProcessor is responsible for the rest of the steps in making sure a match is, or is not output.

There are two flavors of matches that should be mentioned, that differ in how two matches are construed as the same match. In the first definition, a match is defined as the unique combination of N hits from the N geometric constraints. In this definition, match m and match m' can describe the same rotamers for all N geometric constraints, but differ in one location of the downstream partner. If the downstream partner's geometry is sampled agressively, then many matches will seem identical. The second definition is that a match is defined as the unique combination of the upstream portion of N hits, and the unique location of the downstream partner as defined by a particular geometric constraint. In this case, multiple groupings of hits that are enumerated can map to the same match. This second definition, in the code referred to as a "match\_dspos1" since the down-stream (ds) position is defined by a single geometric constraint, reduces the number of matches that need to be considered for output considerably; this makes matching faster and avoids the problem of producing thousands of nearly-identical output files which frustrate post-processing. Since often many matches are similar to each other (depending on the fineness and quantity of geometric samples ), by default the matcher uses so called CloudPDB output. See the CloudPDB paragraph in the Expected Outputs section. Briefly, matches will be grouped by the MatchGrouper, and all matches that fall in the same group will be output in a special file format that includes all ligand positions and protein rotamers as additinonal models.

Depending on the command line flags, the Matcher either enumerates matches using the regular match definition or the match\_dspos1 definition. It then hands the match (or the match\_dspos1) to the MatchProcessor using the MatchProcessors interface method "process\_match."

There are two MatchProcessor classes: the MatchOutputter and the MatchConsolidator. The MatchOutputter class flushes a match to disk as soon as it is encountered; the MatchConsolidator holds on to the matches it's asked to process, groups them, and then, once the Matcher has enumerated all of the matches, outputs the best X matches in each group, where "best" is interpretted as having the lowest score according the MatchEvaluator. X is set by the user with the flag -output\_matches\_per\_group \<X\>.

Both the MatchOutputter and the MatchConsolidator rely on MatchFilters and OutputWriters to filter matches and to actually write matches out in a particular format.

Available match filters include:
* UpstreamCollisionFilter – purge matches where the upstream portions of the match collide with each other
* UpstreamDownstreamCollisionFilter – purge matches where the upstream and downstream portions collide
* LimitHitsPerRotamerFilter – purge matches if a particular rotamer has been output already too often FLORIAN VERIFY PLEASE

Available output writers include: (described in greater detail below)
* PDBWriter
* CloudPDBWriter
* WriteKinemageOutputter

The MatchOutputter and the MatchConsolidator, when given a match in the process\_match function invocation, both verify that the match passes all filters. The MatchConsolidator does more work at this stage, but in the end, both the MatchOutputter and the MatchConsolidator hand a match which is slated for output to the OutputWriter.

In between ensuring that a match passes all the filters, and when readying a match for output, the MatchConsolidator groups matches based on properties of those matches. It scores each match in a given group according to some criterion. There are two classes responsible for the grouping and for scoring: the MatchGrouper and the MatchEvaluator.

Available MatchGroupers include:
* SameSequenceGrouper – two matches belong in the same group if their hits come from the same amino acds at the same scaffold build positions.
* SameRotamerGrouper – two matches belong in the same group if their hits come from the same rotamers of the same amino acids at the same scaffold build positions
* SameChiBinComboGrouper – two matches belong in the same group if their hits come from the same rotamer wells (as defined by the Dunbrack library) of the same amino acids at the same scaffold build positions.

Available MatchEvaluators include:
* DownstreamRMSEvaluator – report the score for a match as sum of square distances between all atoms in all downstream conformations; only available for the standard match definition; incompatible with the match\_dspos1 definition. The closer the hits are to each other, the lower the score.

Limitations
===========

The Matcher is not guaranteed to find matches. The more geometric constraints that you attempt to match, the harder it is to produce matches.

The running time gets slower and slower the more samples are included; the number of possible ligand conformations that the matcher will consider is the product of the number of build positions, the number of rotamers per build position, the number of launch-atoms per rotamer, the number of external geometries per build atom, and the number of ligand rotamers. This can become very expensive, both in running time (since most if not all of these conformations need to be enumerated) and in memory use (since the memory use for storing Hits is usually the limiting factor.) That said, insufficient sampling can miss valuable hits.

Input Files
===========

The following files are required for a matching run, and examples for a each of these can be found in the matcher integration test:

1.  a pdb of the scaffold
2.  a match\_cstfile that specifies the desired site. Please refer to the [[match cstfile format documentation|match-cstfile-format]] for more information.
3.  a .params file and optionally a conformer file for the ligand of interest. Please refer to the [[ligand docking documentation|ligand-dock]] for more information.
4.  a positions file that lists all the scaffold residue positions that will be considered in matching. Automatic generation of a pos file is described in the section below, "Generating ligand grid and pos files". Alternatively, the format for a pos file is simple enough that a user can generate the file by hand – format required for this file is described in the details section of MatcherTask::initialize\_scaffold\_active\_site\_from\_command\_line() in src/protocols/match/MatcherTask.cc

The following files are optional for a matching run:

1.  a so called ligand grid or gridlig file. This file specifies the region of the scaffold protein in which the ligand is desired to end up, usually a cavity or crevice on the surface. The residue positions specified in the positions file should lie in the same region as the ligand grid. Automatic generation of a pos file from a scaffold pdb structure is described in the section below, "Generating ligand grid and pos files". The residue positions specified in the positions file should lie in the same region as the ligand grid. In general a gridlig file is difficult to manipulate by hand without the aid of a script or graphical interface. The file format for the ligand grid is described in MatcherTask::initialize\_active\_site\_definition\_from\_command\_line().
2.  a file specifying which ligand atoms have to lie on the grid. This file simply lists the names of all the ligand atoms that should lie on the ligand grid.

Options
=======

-   Matcher required options
    * -s \<scaffold pdb=""\> structure of the scaffold
    * -match:lig\_name \<name of="" ligand=""\> the name of the ligand to be matched
    * either -match:scaffold\_active\_site\_residues\_for\_geomcsts \< per geomcst posfile \> or -match:scaffold\_active\_site\_residues \< posfile \>
    * -match:geometric\_constraint\_file \<cstfile\>
    * -extra\_res\_fa \<ligand .params file\>
    * and if gridlig files are used:
        * -match:grid\_boundary \<gridlig file\>=""\> the ligand grid file
        * -match:active\_site\_definition\_by\_gridlig \<gridlig file\>=""\> -required\_active\_site\_atom\_names \<atom name="" file\>=""\>

-   The following options are relevant to the matcher but the default settings should work for most projects:
    * -match:output\_format \< format in which matches are output \>
    * -match\_grouper \< by what criterion matches are clustered by the CloudPDB writer or the consolidator \>
    * -output\_matchres\_only \<true/false\> determines if the whole pose is written for each match or only the matched site -enumerate\_ligand\_rotamers \<true/false\> determines whether the matcher tries all ligand conformers separately
    * -only\_enumerate\_non\_match\_redundant\_ligand\_rotamers \<true/false \> in case the matcher is enumerating ligand rotamers, this option will cause it to only enumerate those ligand rotamers where the ligand atoms that are involved in matching interactions are in different positions, i.e. depending on the system there will be a considerable speedup while the same number of unique matches should be found.

-   Recommended general Rosetta options:
    * For matcher production runs, all the usual rosettta packing options should be used, i.e. ex1, ex2, use\_input\_sc. Further, in case there are many ligand conformers, the protocols.idealize tracer channel should be muted ( -mute protocols.idealize ).

Generating ligand grid and pos files
====================================

The ligand grid (\*.gridlig) file specifies where the target (ligand) can lie in the active site. The pos file specifies the active site residues from which each constraint is permitted to originate – e.g. if the pos file only lists 50,60 then all constraints must originate from either residue 50 or residue 60.
 These files can be generated from a pdb with a ligand (gen\_lig\_grids; the files are generated around the space the wild-type ligand already occupies) or from a pdb without a ligand (gen\_apo\_grids; rosetta identifies large pockets of empty space and generates the gridlig and posfile around those pockets).

1) gen\_lig\_grids  < a name="gen-lig-grids" />

A full working example can be found in the associated integration test:
 rosetta/main/tests/integration/tests/gen\_lig\_grids/

Starting from a scaffold pdb (1a53.pdb), first split out one scaffold chain and its associated ligand. The scaffold (without any HETATM lines) should be a single chain with no other lines, only the ATOM lines of that chain, scaffold.pdb (1a53\_nohet\_1.pdb). The ligand should be the ligand from that chain, with only the HETATM lines and no other lines, ligand.pdb (1a53\_ligand\_1.pdb).

The gen\_lig\_grids app will generate a set of grids around the ligand binding pocket, scaffold.pdb\_0.gridlig. This is to be used as the ligand grid in the matcher (with the match::grid\_boundary flag). It will also generate a list of residue positions which are at the ligand binding site, called a "pos file", e.g. scaffold.pdb\_0.pos. This is also used as input to the matcher (with the match::scaffold\_active\_site\_residues flag).

A generic command line:
 gen\_lig\_grids -s scaffold.pdb ligand.pdb -database [database\_path] @flags

A real example command line used for the rosetta/main/tests/integration/tests/gen\_lig\_grids example:
 /path/to/rosetta/main/source/bin/gen\_lig\_grids.linuxiccrelease -s 1a53\_nohet\_1.pdb 1a53\_ligand\_1.pdb @flags

A detailed flags example (@flags):
```
-ignore_unrecognized_res # ignore any ligands already present in the scaffold.pdb
-grid_delta 0.5 # grid spacing, Angstroms
-grid_lig_cutoff 4.0 # cutoff from ligand, the grid will extend this far away from the ligand
-grid_bb_cutoff 2.25 # cutoff from backbone, the grid will be pruned back this distance from the backbone
-grid_active_res_cutoff 5.0 # distance cutoff for active site residues to be included in the pos file; any amino acid within this distance from a ligand atom will be included in the pos file
```
2) gen\_apo\_grids <a name="gen-apo-grids" />

A full working example can be found in the associated integration test:
 rosetta/main/tests/integration/tests/gen\_apo\_grids/

With gen\_apo\_grids the scaffold pdb should not have a ligand. In gen\_apo\_grids Rosetta will identify the most likely locations for a ligand binding site and create corresponding gridlig/pos files, using the RosettaHoles algorithm. If there is a ligand the user should, in general, use gen\_lig\_grids unless the crystal structure ligand binding site is undesirable/untrustworthy. Starting from a scaffold pdb (1a53.pdb) first split out one scaffold chain, which presumably does not contain a ligand. The scaffold (without any HETATM lines) should be a single chain with no other lines, only the ATOM lines of that chain, scaffold.pdb (1a53\_nohet\_1.pdb).

The gen\_apo\_grids app will generate a set of gridlig/pos files around the largest buried void in the scaffold (scaffold.pdb\_1.gridlig, \_1.pos), the second largest void (scaffold.pdb\_2.gridlig, \_2.pos), etc. These are to be used as the ligand grid in the matcher (with the match::grid\_boundary flag) and the posfile for the matcher (with the match::scaffold\_active\_site\_residues flag). In a subsequent matcher run the user can choose which of these gridlig/posfile combinations to use for the matcher, or simply run the matcher separately on every gridlig/posfile (in separate matcher runs), or select just a subset of gridlig/posfiles. In common usage one might start with only the largest gridlig (\_1.gridlig, \_1.pos) over a set of scaffold pdbs and then expand to include more gridlig/posfiles if the number of matches is not satisfactory.

A generic command line:
```
 gen_apo_grids -s scaffold.pdb -database [database_path] @flags
```
A real example command line used for rosetta/main/tests/integration/tests/gen\_apo\_grids example:
```
 /path/to/rosetta/main/source/bin/gen_apo_grids.linuxiccrelease -s 1a53_nohet_1.pdb @flags
```
A detailed flags example (@flags):
```
  -mute all
  -unmute apps.pilot.wendao.gen_apo_grids
  -chname off
  -constant_seed
  -ignore_unrecognized_res
  -packstat:surface_accessibility
  -packstat:cavity_burial_probe_radius 3.0 # if the cavity ball can be touched by probe r>3, then it's not in a pocket
  -packstat:cluster_min_volume 30 # minimum size of a pocket, smaller voids will not be considered
  -packstat:min_cluster_overlap 1.0 # cavity balls must overlap by this much to be clustered
  -packstat:min_cav_ball\radius 1.0 # radius of smallest void-ball to consider
  -packstat:min_surface_accessibility 1.4 # voids-balls must be at least this exposed
```

Troubleshooting: These apps should be in rosetta/main/source/bin. If it is not make sure that src/pilot\_apps.src.settings.all has the pilot app turned on under user wendao.

Manual generation of pos files
------------------------------

Although automatic generation above will create pos files, they can also be created manually.

Two different formats for the pos files are recognized, one with a single list of positions to be used for all constraints (specified with -match:scaffold\_active\_site\_residues), and one which lists positions on a per-constraint basis (specified with -match:scaffold\_active\_site\_residues\_for\_geomcsts). Both take residue numbers in pose numbering format. Pose numbering consists of a sequentially incremented value for each residue, starting at 1. For example, if the first residue in the input PDB is chain A residue 26, then chain A residue 33 would have a residue number of 8 in pose numbering format. (It is generally recommended that input pdb files to the matcher be renumbered to start at chain A residue 1).

1) Single list of positions. The file consists of a whitespace-separated list of numbers in pose numbering format.

Example:

```
104 106 108 109 117 118 137 139 143 144 36 6 85 87 88 89 91 92 97
```

2) Per constraint list of positions. The first line of the file begins with N\_CST, followed by the number of geometric constraints. This must match the number of geometric constraints in the .cst file. On each subsequent line, the geometric constraint ID is given, followed by a colon and then followed by all of the residue ID's (in pose numbering format) that should be considered for that geometric constraint. Each geometric constraint must appear on one line in the file, though they may be listed in any order. It is also possible to specify that all positions in the scaffold can be used for a certain constraint by using the keyword "all".

Example:

```
N_CST 4
1: 9
3: 12
2: 6 7 9 11 12 14 15 17 18 21 22 23 25 26 38 40 43 46 47 49 53 54 57 60 61
4: all
```

Expected Outputs
================

Since it is not certain that the desired input geometry can be matched into any given scaffold, the matcher might finish without outputting any matches. In any case, there will be a logfile. For every matcher run that finished orderly, the last line of the logfile should read: 'Matcher ran for x seconds'. If this line doesn't get written, something went wrong during the calculation.
 In case matches were found, the matcher can output them in three different formats: Pdb, CloudPdb, and kinemage, with CloudPdb being the recommended default. Which output format is used is determined by option -match:output\_format.
 When reading this section, one should remember that a match is a simply a set of hits, i.e. pairs of protein rotamers and a corresponding ligand placement (or, in the case of upstream matching, pairs of two protein rotamers). Depending on the sampling density for both protein rotamers and ligand placements specified in the cstfile, it is possible that several dozen or hundreds of ligand placements fall into the same hash bin, and enumerating all possible hit combinations can often lead to millions of highly similar matches.

**CloudPdb output format:**
 In this output format, the matcher will first cluster all matches. Clustering will happen according to the value specified for option -match:match\_grouper, which is described below. After all matches have been enumerated and clustered, for each cluster center one multimodel pdb file will be written that contains all unique protein rotamers and ligand placements for that cluster. For cluster centers that happen to have more then 100 unique ligand placements, one file will be written for each 100 unique ligand placements. The CloudPdb output format is the recommended output format.

**Pdb output format:**
 In this format, every match will be output as a separate pdb file. As mentioned above, in cases where the combinatorics of match enumeration lead to millions of matches, this output format can quickly fill up whole harddrives. To prevent this from happening, two options should be set to true when using this output format.
 -match:output\_matchres\_only will cause the output pdb files to only contain the matched residues and the ligand, but not the rest of the scaffold. Eventually a script can be used to insert the matches into the whole scaffold again.
 -match:consolidate\_matches will cause only a subset of matches to be output. Matches will be clustered according to the value for option -match:match\_grouper, and then for each cluster centear a number of matches (the number being determined by option -match:output\_matches\_per\_group ) will be randomly selected for output.

For both CloudPdb and Pdb output formats the option -match:grouper is very important. This option can have the following values, and matches can be grouped/clustered accordingly:

* SameSequenceGrouper matches that have the same sequence (i.e. the residues are matched at identical positions ) will be grouped together
* SameSequenceAndDSPositionGrouper matches that have the same sequence and where the ligand placements are not further than -match:grouper\_downstream\_rmsd angstroms away will be clustered together. This is the default.
* SameChiBinComboGrouper matches where the protein rotamers are in the same chi bin will be grouped together
* SameRotamerComboGrouper matches that have the same protein rotamers will be grouped together.

**Kinemage output format**
 andrew

Post Processing
===============

Usually matches are designed with the enzyme\_design protocol: [[Documentation for the enzyme design application.|enzyme-design]]
 For this, they either have to be in either CloudPdb or Pdb format. In case they're in CloudPdb format, the enzyme\_design application will read in the additional ligand placements and consider them all simultaneously during the design protocol.

Tips
====

Two aspects that should be considered for every matching project are: 1) in what order to specify the blocks in the cstfile and 2) whether to use the ClassicMatching or SecondaryMatching algorithm for a given match residue.

**1) On the order of the different match residues / cstfile blocks**

As a rule of thumb, the geometric constraints should be arranged in order of increasing sampling diversity, i.e. the constraint that is most clearly defined should go first in the cstfile. The reason is that the less sampling there is for a constraint, the less hits there will be, and this means there are less active voxels in the occupied space hash, which in turn leads to faster hit generation in the following rounds of hit generation ( see criterion c) in the discussion of the classic match algorithm above.)

**2) On using Classic matching vs Secondary Matching.**

 Each of these algorithms has advantages and disadvantages. The advantage of Classic Matching is that every hit generation stage is independent, i.e. constraint \#2 can generate hits without having to examine every hit from constraint 1. However, all 6 degress of freedom must be specified for Classic Matching. In cases where the desired chemical interaction is less well defined (i.e. a hydrogen bond, where only the distance, two angles, and maybe one dihedral are important), a large number of values will have to be sampled for non-important degrees of freedom, to ensure that all possible matches are found.
 The Secondary Matching algorithm does not have this disadvantage: the non-important degrees of freedom can simply be left unspecified, which means that any value will be accepted. On the other hand, the Secondary Matching algorithm does have the disadvantage that, for each upstream rotamer, it needs to examinate every hit from the previous matching rounds, which could take a long time depending on the number of previously generated hits.

New things since last release
=============================

This is the first time that the Matcher has been released publically. It was never available in its initial implementation as part of Rosetta++.

##See Also

* [[Design applications | design-applications]]: other design applications
* [[Application Documentation]]: Application documentation home page
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta
