# Generalized Kinematic Closure

[[Return to RosettaScripts|RosettaScripts]]

By Vikram K. Mulligan, Baker laboratory.  Documentation written 4 April 2014, and last updated on 11 March 2016.

[[_TOC_]]

## Short summary
GeneralizedKIC (short for *G*eneralized *Ki*nematic *C*losure) is a generalization of the existing kinematic closure machinery.  The generalized version works with arbitrary backbones, and with loops that go through side-chains, ligands, etc.  It has also been implemented with full RosettaScripts support, making it easy to incorporate into more complicated protocols.  The RosettaScripts interface gives full control over the inner workings of the algorithm, making it quite a powerful and versatile tool.

## Usage cases
Generalized KIC is useful for the following situations:
* Given an arbitrary unbranched, covalently-connected part of a structure, with well-defined, fixed starting and ending points, one wishes to sample alternative conformations that preserve ideal geometry.  An example would be a case in which the N- and C-termini of a protein were linked by a disulfide bond, and one wished to sample alternative conformations for a short stretch of the N-terminal backbone, the disulfide bond, and a short stretch of the C-terminal backbone, subject to the condition that the disulfide remains closed.
* Given a part of a structure that is open but which _ought_ to be covalently connected, with well-defined, fixed starting and ending points, one wishes to sample conformations that close the segment.  For example, given unjoined antiparallel beta strands forming a two-strand sheet, one might wish to sample hairpin conformations for a loop connecting the strands.  This closure can be through side-chains or ligands, too: given two segments containing metal-binding residues, one might want to sample conformations that allow a metal to be bound with ideal geometry.
* Given a covalent linkage between distant parts of a FoldTree and a structural perturbation that pulls the atoms involved in the covalent linkage apart, one wishes to find compensatory structural perturbations that maintain the closed covalent geometry while minimally altering the structure.

The above scenarios tend to be sub-problems of more complicated problems, particularly involving heavily cross-linked molecules for which one might wish to sample many conformations.

## Input and output
GeneralizedKIC takes as input a pose that contains a covalently-connected chain of residues (a "loop", where the loop need not be connected solely by conventional backbone connections) to which the algorithm will be applied.  The chain of residues need not start out in a sensible conformation, nor need it consist of canonical alpha-amino acids.

GeneralizedKIC will return a pose in which the loop in question has been put in a new, closed conformation (subject to user-specified sampling methods).  Only the loop residues (and any "tail" residues specified) will be moved by this mover; all other residues will remain in their starting positions.  The FoldTree is disregarded by the GeneralizedKIC mover, and will not be altered by it.  (Note: if a pre-selection mover is defined as described in the [[GeneralizedKIC selector|GeneralizedKICselector]] documentation, this mover can alter geometry outside of the loop to be closed, or could alter the FoldTree.)

If no closed solution could be found, GeneralizedKIC will return the original input pose.  If a ContingentFilter has been supplied, its value will be set to "false" in this case (and "true" otherwise).  By default, GeneralizedKIC will set the mover status to failure if no solution is found, but the user can override this with **dont_fail_if_no_solution_found=true**.

## General workflow
In general, one must:

1.  Build or import a structure, which must include the loop residues to be closed (though these need not be in a closed conformation to start).
2.  Ensure that covalent linkages have been declared with the **[[DeclareBond]]** mover.
3.  Set the GeneralizedKIC options.
4.  Define the loop to be closed, and set pivots.
5.  Set up one or more GeneralizedKIC perturbers, which determine how loop conformations will be sampled.
6.  Define one or more GeneralizedKIC filters.
7.  Set the GeneralizedKIC selector used to choose a solution from among those found (and an optional pre-selection mover).

These steps are discussed in detail in the next section.

## Detailed workflow

1. Build or import a structure.  GeneralizedKIC cannot add residues or geometry.  If one wants to build a new loop, for example, one must add the new loop residues before calling GeneralizedKIC.  (In RosettaScripts, the [[PeptideStubMover]] is useful for building geometry from scratch or for adding residues to existing geometry.)

2. Ensure that covalent linkages have been declared.  GeneralizedKIC will move atoms about to ensure ideal geometry, but cannot declare new chemical bonds.  (In RosettaScripts, the **DeclareBond** mover lets Rosetta know that certain residues are covalently attached to one another.)

3. Set the GeneralizedKIC options (number of closure attempts, whether the algorithm should accept the first successful closure or choose from all successful closure attempts, _etc._).  In RosettaScripts, this is handled inside the <MOVERS> block as follows:
```xml
<MOVERS>
...
     <GeneralizedKIC name="&string" low_memory_mode="(false &bool)" closure_attempts="(100 &int)" stop_if_no_solution="(0 &int)" stop_when_n_solutions_found="(0 &int)" selector="&string" selector_scorefunction="&string" selector_kbt="(1.0 &Real)" contingent_filter="&string" dont_fail_if_no_solution_found="(false &bool)" correct_polymer_dependent_atoms="(false &bool)">
          ...
     </GeneralizedKIC>
...
</MOVERS>
```
The **low_memory_mode** option can be used to limit the amount of information about each solution found that is stored, in order to reduce memory consumption.  See the note below for more details about the advantages and risks of this non-default mode.  The **closure_attempts** parameter sets the number of times the algorithm will try to close the loop.  A setting of **0** means that it will keep trying indefinitely.  The **stop_when_n_solutions_found** option allows the algorithm to stop after finding at least N successful solutions, or, if this is set to 0, to keep going until it has done as many attempts as specified by **closure_attempts**; in either case a solution is then chosen by the selector.  (Note that, because a single attempt returns up to 16 closure solutions, the selector will be applied _even_ if **stop_when_n_solutions_found** is set to 1, since more than one solution might have been found in the first successful attempt).  The **selector** flag is mandatory, and specifies the way in which a solution is chosen from among the successful solutions.  The **selector_scorefunction** flag allows a separate scorefunction to be used by those selectors that select based on energy or score; this is recommended since score terms based on side-chain packing may produce poor results, since the GeneralizedKIC algorithm does not call the packer.  Some selectors also take a temperature value, set by the **selector_kbt** option.  See the [[GeneralizedKIC selector|GeneralizedKICselector]] documentation for more details.<br>In some cases, the GeneralizedKIC mover will find no solution.  This could be because no solution exists (_e.g._ if the loop is too short for the endpoint separation, or if there is geometry blocking any path between the endpoints), because the sampling method used was too restrictive, or because too few attempts were made.  If this happens, the pose is left unaltered.  If the loop geometry is open, it is useful to have a means of aborting the trajectory in this case.  By default, the mover returns failure status, aborting the trajectory.  This can be overridden by setting **dont_fail_if_no_solution_found=true**.  A [[ContingentFilter|Filters-RosettaScripts#ContingentFilter]] can also be used to record whether the mover failed.  The ContingentFilter is a specialized filter that has its value set by a mover.  GeneralizedKIC can set the value of a ContingentFilter, specified using the **contingent_filter** flag, to true or false depending on whether the closure was successful or unsuccessful.  Subsequent application of the filter, possibly at a later point, can then abort trajectories involving unsuccessful loop closure.  As a final note, GeneralizedKIC can correct positions of atoms that depend on polymer bonds (such as amide protons, carbonyl oxygens, or N-methyl groups in N-methylated amino acids) to ideal positions if the **correct_polymer_dependent_atoms** option is set to "true".

4. Define a series of residues for the GeneralizedKIC closure problem.  This must be an unbranched chain of residues with continuous covalent linkages, listed in order from one end of the chain to the other.  When the GeneralizedKIC::apply() function is called, a continuous chain of atoms running through the selected residues is automatically chosen.  Residues are specified with **AddResidue** tags within a **GeneralizedKIC** block.  Pivot points must also be indicated explicitly, using the **SetPivots** tag.  Pivots are atoms in the chain of atoms to be closed that are flanked by bonds whose dihedral values will be solved for analytically by the closure algorithm in order to close the loop.  Currently, due to hard-coded assumptions in the kinematic closure numerical library, the first pivot must be the second atom in the chain to be closed, and the last pivot must be the second-to-last atom in the chain to be closed.  This restriction will be eliminated in a future version of GeneralizedKIC.<br>Optionally, additional "tail" residues can also be listed.  These are residues that are either connected directly to the loop to be closed, or connected indirectly to this loop through other tail residues, and which move with the loop to be closed.  The **AddTailResidue** tag can be used to specify these.  Order is not important for the **AddTailResidue** flag.
```xml
<MOVERS>
...
     <GeneralizedKIC ...>
          <AddResidue res_index="(&int)" />
          <AddResidue res_index="(&int)" />
          <AddResidue res_index="(&int)" />
          ...
          <AddTailResidue res_index="(&int)" />
          <AddTailResidue res_index="(&int)" />
          <AddTailResidue res_index="(&int)" />
          ...
          <SetPivots res1="(&int)" atom1="&string" res2="(&int)" atom2="&string" res3="(&int)" atom3="&string" />
          ...
     </GeneralizedKIC>
...
</MOVERS>
```
For example, if one were closing a loop consisting of residues ALA44, CYS45, LYS46, CYS47, CYS23, ASP22, and PHE21, where CYS47 and CYS23 were linked by a disulfide bond, and where CYS45 were linked to CYS12 by another disulfide such that CYS12 was expected to move with CYS45, one would write:
```xml
<MOVERS>
...
     <GeneralizedKIC ...>
          <AddResidue res_index="4" />
          <AddResidue res_index="45" />
          <AddResidue res_index="46" />
          <AddResidue res_index="47" />
          <AddResidue res_index="23" />
          <AddResidue res_index="22" />
          <AddResidue res_index="21" />
          <AddTailResidue res_index="12" />
          <SetPivots res1="4" atom1="CA" res2="23" atom2="SG" res3="21" atom3="CA" />
          ...
     </GeneralizedKIC>
...
</MOVERS>
```
From the above example, we can see that loop segments may run backwards or forwards, or may involve residues that are far apart in linear sequence provided they are covalently linked.  Note that while the sequence of residues matter, the overall direction of the loop does not: we could just as happily have added residues in the reverse order (21->22->23->47->46->45->44).  In this example, we have arbitrarily chosen CYS23's SG atom as the middle pivot point, though any atom in the chain that is flanked by bonds that can rotate freely could have been chosen.

5. Define one or more GeneralizedKIC perturbers.  Each perturber samples conformation space for each closure attempt.  See [[GeneralizedKIC perturbers|GeneralizedKICperturber]] for details.

6. Define one or more GeneralizedKIC filters.  Filters are applied after each closure attempt, and eliminate solutions that don't meet some criterion.  See [[GeneralizedKIC filters|GeneralizedKICfilter]] for details.

7. Set the GeneralizedKICselector.  The selector chooses a single solution from the set of solutions found that pass all of the filters.  See the [[documentation on GeneralizedKIC selectors|GeneralizedKICselector]] for details, including details on the optional pre-selection mover (a mover applied to all solutions passing filters prior to application of the selector).

That's it!  You should be happily closing loops, now.

## Algorithm details

The kinematic closure algorithm is described in detail in [Coutsias _et al_. (2004). _J. Comput. Chem._ 25(4):510-28.](http://www.ncbi.nlm.nih.gov/pubmed/14735570) and in [Mandell _et al_. (2009). _Nat. Methods._ 6(8)551-2.](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2847683/).  Briefly, given a rigid-body transform describing the position and orientation of the residue immediately following a loop relative to a residue immediately preceding a loop, a loop with N degrees of freedom now has N-6 effective degrees of freedom, the remaining 6 degrees of freedom being determined by the condition that the loop be closed.  This means that all but 6 degrees of freedom of the loop (_e.g._ all but 6 chain dihedral angles) may be sampled, perturbed, or set as one sees fit, and the remaining 6 degrees of freedom may be solved for analytically to impose the closure condition.  The GeneralizedKIC algorithm does just this, allowing the user to sample all but 6 degrees of freedom of the loop, then solve analytically for the remainining 6 (the dihedral angles flanking 3 pivot atoms) to ensure that the loop is closed.  For any given set of values for the other N-6 degrees of freedom, there may be anywhere from 0 to 16 solutions to the system of equations solved by the kinematic closure algorithm.

## Low-memory mode

By default, all solutions found by GenKIC are stored as full poses until one is selected by the selector.  Unfortunately, this means that if instructed to store many solutions, GenKIC can exhaust available memory.  As of 13 March 2016, a low-memory mode has been added (<b>"low_memory_mode=true"</b>).  In this mode, only loop degree-of-freedom values are stored prior to selection.  The drawback, however, is it can be risk to use low-memory mode with a preselection mover.  Any changes to the pose made by the preselection mover will not be stored, so the preselection mover will have to be re-applied to the selected pose after selection.  This costs additional time.  In addition, if the preselection mover has any stochastic component to its behaviour, then the second application may not produce identical results to the first.  This means that what might have been the lowest-energy pose when the preselection mover was first applied could now be a relatively high-energy pose, for example.  For this reason, be judicious in the use of low-memory mode.  The preferred course is to stop GenKIC when N solutions have been found to limit memory usage.

## Example RosettaScripts

This example creates a 10-residue cyclic peptide with a disulfide bond between the N- and C-termini.  It then defines a loop starting at residue 3, going _backwards_ to residue 1, through the disulfide to residue 10, and back to residue 5.  This loop is closed by kinematic closure, with loop conformations sampled.  A bump check filter is applied (AddFilter type="loop_bump_check"), and a solution chosen randomly (selector="random_selector") from the solutions found.
```xml
<ROSETTASCRIPTS>
    <TASKOPERATIONS>
    </TASKOPERATIONS>
    <SCOREFXNS>
        <ScoreFunction name="tala" weights="talaris2013" symmetric="0" />
    </SCOREFXNS>
    <FILTERS>
    </FILTERS>
    <MOVERS>
        <PeptideStubMover name="pep_stub" reset="1">
            <Append resname="CYD" />
            <Append resname="ALA" />
            <Append resname="ALA" />
            <Append resname="ALA" />
            <Append resname="ALA" />
            <Append resname="ALA" />
            <Append resname="ALA" />
            <Append resname="ALA" />
            <Append resname="ALA" />
            <Append resname="CYD" />
        </PeptideStubMover>
        
        <SetTorsion name="tor1">
            <Torsion residue="ALL" torsion_name="phi" angle="-64.7"/>
            <Torsion residue="ALL" torsion_name="psi" angle="-41.0"/>
            <Torsion residue="ALL" torsion_name="omega" angle="180"/>
        </SetTorsion>

	<SetTorsion name="tor2">
            <Torsion residue="pick_atoms" angle="random">
                <Atom1 residue="1" atom="N"/>
                <Atom2 residue="1" atom="CA"/>
                <Atom3 residue="1" atom="CB"/>
                <Atom4 residue="1" atom="SG"/>
            </Torsion>
            <Torsion residue="pick_atoms" angle="random">
                <Atom1 residue="10" atom="N"/>
                <Atom2 residue="10" atom="CA"/>
                <Atom3 residue="10" atom="CB"/>
                <Atom4 residue="10" atom="SG"/>
            </Torsion>
	</SetTorsion>
        
        <DeclareBond name="bond" res1="1" atom1="SG" res2="10" atom2="SG"/>

	<GeneralizedKIC name="genkic" closure_attempts="200" stop_when_n_solutions_found="0" selector="random_selector">
		<AddResidue res_index="3" />
                <AddResidue res_index="2" />
                <AddResidue res_index="1" />
                <AddResidue res_index="10" />
                <AddResidue res_index="9" />
                <AddResidue res_index="8" />
                <AddResidue res_index="7" />
                <AddResidue res_index="6" />
                <AddResidue res_index="5" />
		<SetPivots res1="3" atom1="CA" res2="1" atom2="SG" res3="5" atom3="CA" />
		<CloseBond prioratom_res="10" prioratom="CB" res1="10" atom1="SG" res2="1" atom2="SG" followingatom_res="1" followingatom="CB" bondlength="2.05" angle1="103" angle2="103" randomize_flanking_torsions="true" />
		<AddPerturber effect="randomize_alpha_backbone_by_rama">
			<AddResidue index="3" />
			<AddResidue index="2" />
			<AddResidue index="1" />
			<AddResidue index="10" />
			<AddResidue index="9" />
                        <AddResidue index="8" />
                        <AddResidue index="7" />
                        <AddResidue index="6" />
                        <AddResidue index="5" />
		</AddPerturber>
		<AddFilter type="loop_bump_check" />
	</GeneralizedKIC>
        
    </MOVERS>
    <APPLY_TO_POSE>
    </APPLY_TO_POSE>
    <PROTOCOLS>
        <Add mover="pep_stub"/>
        <Add mover="tor1"/>
        <Add mover="tor2"/>
        <Add mover="bond"/>
        <Add mover="genkic"/>
    </PROTOCOLS>
</ROSETTASCRIPTS>
```

## Failure cases
GeneralizedKIC cannot handle the following cases:
* Multiple covalent connections between a single pair of residues in the chain of residues to be closed.  (This is something that, in general, Rosetta handles poorly).
* Loops involving salt bridges, cation-pi interactions, hydrogen bonds, or other noncovalent interactions.  (The GeneralizedKIC framework has been written with this in mind as a possible future extension, however.)  Note that coordinate covalent bonds between metal-binding residues and metal ions are considered "covalent" in Rosetta, and _are_ handled properly by GeneralizedKIC.

## Full options list

[[include:mover_GeneralizedKIC_type]]
