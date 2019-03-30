# Generalized Kinematic Closure (GeneralizedKIC)
*Back to [[Mover|Movers-RosettaScripts]] page.*

Documentation created by Vikram K. Mulligan, Baker laboratory.  For questions, e-mail vmullig@uw.edu.  Last updated 24 October 2015.

## Generalized Kinematic Closure (GeneralizedKIC)

Kinematic closure is a computationally-inexpensive, analytical algorithm for loop closure.  Given a loop with defined start- and endpoints, with N degrees of freedom, it is possible to sample N-6 of these degrees of freedom and to solve for the remaining 6.  GeneralizedKIC is a generalization of the classic KIC algorithm that permits closure and conformational sampling of any covalently-connected chain of atoms.  Chains to be closed can include backbone segments, covalently-linked side-chains (_e.g._ disulfide bonds), ligands, noncanonical residues, _etc._  GeneralizedKIC is invoked in RosettaScripts as follows:
```xml
<GeneralizedKIC name="(string)" closure_attempts="(2000,int)" stop_if_no_solution="(0,int)" stop_when_n_solutions_found="(0,int)" selector="(string)" selector_scorefunction="(string)" selector_kbt="(1.0,Real)" contingent_filter="(string)" correct_polymer_dependent_atoms="(false,bool)">
     #Define loop residues in order:
     <AddResidue res_index="(int)"/>
     <AddResidue res_index="(int)"/>
     <AddResidue res_index="(int)"/>
     ...
     #List tail residues in any order (see documentation for details):
     <AddTailResidue res_index="(int)"/>
     <AddTailResidue res_index="(int)"/>
     <AddTailResidue res_index="(int)"/>
     ...
     #Pivot atoms are flanked by dihedrals that the KIC algorithm will solve for in order to enforce closure:
     <SetPivots res1="(int)" atom1="(string)" res2="(int)" atom2="(string)" res3="(int)" atom3="(string)" />
     #One or more perturbers may be specified to sample loop conformations:
     <AddPerturber effect="(string)">
          ...
     </AddPerturber>
     ...
     #One or more filters may be specified to discard unwanted or bad closure solutions:
     <AddFilter type="(string)">
          ...
     </AddFilter>
     ...
</GeneralizedKIC>
```
See the [[GeneralizedKIC documentation|GeneralizedKIC]] for details about [[GeneralizedKIC options|GeneralizedKIC]], and about GeneralizedKIC [[perturbers|GeneralizedKICperturber]], [[filters|GeneralizedKICfilter]], and [[selectors|GeneralizedKICselector]], as well as for usage examples.  _**Note:** GeneralizedKIC should currently be considered a "beta" feature.  Some details of the implementation are likely to change._


##See Also

* [[KicMover]]: Limited to protein backbones
* [[RosettaScriptsLoopModeling]]
* [[Loops file]]: File format for specifying loops for loop modeling
* [[Loop modeling algorithms|loopmodel-algorithms]]
* [[Structure prediction applications]]: A list of command line applications to be used for structure prediction, including loop modeling
* [[I want to do x]]: Guide to choosing a mover
