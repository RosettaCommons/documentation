# RECON multistate design

## Metadata

The RECON algorithm was developed by Alex Sevy in Jens Meiler lab. Please contact jens@meilerlab.org or alex.sevy@gmail.com with any questions.

## Code and Demo

Application source code is located at src/apps/public/recon\_design/recon.cc. The individual movers that control behavior of the RECON algorithm are found at src/protocols/recon\_design/. Protocol captures for published material using the method can be found at https://github.com/sevya/msd_analysis_scripts and https://github.com/sevya/parallelized_RECON_protocol_capture.

## References

For more information on the purpose and scope of the RECON algorithm, please consult the following publications:

* Sevy AM, Jacobs TM, Crowe JE, Meiler J. Design of Protein Multi-specificity Using an Independent Sequence Search Reduces the Barrier to Low Energy Sequences. PLoS Comput Biol. 2015;11(7):e1004300.
* Sevy AM, Wu NC, Gilchuk IM, et al. Multistate design of influenza antibodies improves affinity and breadth against seasonal viruses. Proc Natl Acad Sci USA. 2019;116(5):1597-1602.

## Application purpose
The RECON algorithm performs multi-specificity design on a set of protein states. It can be used to improve binding affinity to a variety of targets, or estimate sequence space available to different conformations. Other multistate design methods can be slow and limited in terms of the number of designed residues or number of input states. RECON uses a heuristic to cut down the amount of sequence space needed to find an optimal multistate solution. This means that you can incorporate other movements, such as backbone movements, during design. RECON can run in parallel on multiple processors using MPI to allow large number of states in multistate design simulations.

## Algorithm 
The algorithm works by allowing each protein state to sample sequence space independently, then encouraging them to converge on a single sequence through the use of sequence constraints. In this way the large sequence space of a design problem can be minimized, by limiting the search space to that which is feasible in the context of any individual state. It is most useful for multi-specificity design, for example designing an antibody against a panel of desired targets to increase its affinity and/or breadth.

## RECON-specific Movers and Filters
The RECON application is very similar to the [[RosettaScripts]] application. It takes in an XML script that defines the movers, filters, score functions, etc. to be used during the protocol. Any regular mover can be used in the RECON application. There are also two Movers and one Filter that are RECON-specific and can't be used in an XML through RosettaScripts. These Movers/Filters are described below:

### MSDMover

Multistate design mover used in the RECON protocol. MSDMover applies linking constraints to a pose based on the sequence of other input poses, then uses a predefined design mover to run design based on these sequence constraints. These constraints are then removed for the next step of the protocol.

```xml
<MSDMover name="(&string)" design_mover="(&string)" post_mover="(&string)" resfiles="(&strings)" 
constraint_weight="(1.0 &real)" debug="(false &bool)" />

```

-   design\_mover: A previously defined mover that will design the input states. Note that since resfiles are applied as a TaskOperation within the MSDMover, there's no need to specify ReadResfile behavior for the design\_mover - however all other desired TaskOperations (InitializeFromCommandLine, etc) should be specified in the design\_mover tag
-   post\_mover: A previously defined mover that will act on the input states after the design step.
-   resfiles: A comma-separated list of resfiles to define designable and repackable residues for all states in multistate design. Multiple resfiles can be used for multiple states - in this case the first resfile in the tag will be applied to the first structure, etc. One single resfile used for all states is also supported.
-   constraint\_weight: The weight of amino acid linking constraints during the RECON protocol. Generally weights will be ramped from 0.5 to 2.0, to allow searching of more sequence space in early rounds.
-   debug: Output extra messages during the protocol

### FindConsensusSequence
Multistate design mover used at the end of the RECON protocol. In the RECON protocol multiple states are designed independently with a sequence constraint to encourage convergence on a single solution. At the end FindConsensusSequence is used to choose a single sequence that is optimal for all states. It does this by, at each position, swapping out all possible amino acids that are present on at least one state, measuring the fitness of each candidate amino acid and choosing the best. 

```xml
<FindConsensusSequence name="(&string)" scorefxn="(talaris2014 &string)" 
resfiles="(&strings_comma_separated)" task_operations="(&string)" debug="(false &bool)" />

```

-   scorefxn: Score function to use when evaluating best amino acids at each position
-   resfiles: A list of resfiles to define designable and repackable residues for all states in multistate design. Multiple resfiles can be used for multiple states - in this case the first resfile in the tag will be applied to the first structure, etc. One single resfile used for all states is also supported. Comma-separated list of resfiles (i.e. resfiles=one.resfile,two.resfile,three.resfile).
-   task\_operations: Specifies behavior of the packer when substituting different amino acids and repacking.
-   debug: Output extra messages during the protocol

### FitnessFilter
Filter designed for use in RECON protocol. It measures the fitness of all input states, where fitness is defined as the sum of energy of all states. Fitness can then be used in a Monte Carlo cycle using the GenericMonteCarloMover or simply output to a scorefile.

```xml
<FitnessFilter name="(&string)" scorefxn="(talaris2014 &string)" output_to_scorefile="(false &bool)" threshold="(&real)" />
```

-   scorefxn: Score function to use when evaluating fitness
-   output\_to\_scorefile: Output the fitness to score file?
-   threshold: Threshold to pass or fail structure based on fitness


## Example Command Line
#### Non-MPI 
`recon.default.linuxgccrelease -database Rosetta/main/database/ -use_input_sc -ex1 -parser:protocol msd_brub.xml -nstruct 100 -out:suffix _msd_rlx -s state_A.pdb state_B.pdb state_C.pdb state_D.pdb state_E.pdb`

#### MPI
`mpiexec -n 5 recon.mpi.linuxgccrelease -database Rosetta/main/database/ -use_input_sc -ex1 -parser:protocol msd_brub.xml -nstruct 100 -out:suffix _msd_rlx -s state_A.pdb state_B.pdb state_C.pdb state_D.pdb state_E.pdb`

## Tips
* We recommend generating at least 100 design models to get good convergence
* To run RECON with MPI you must have exactly as many processes as states. So if you want to run 5 states you need to run over 5 processes.
* You can have each state use a different resfile during RECON - this makes the protocol a lot more flexible! However you have to make sure that the states and resfiles are matched up correctly. Each state is assigned a resfile element-wise (i.e. when you define resfiles in the MSDMover tag `resfiles`, make sure they're in the same order as the states as passed in on the command line). 
* If you use multiple resfiles, and you see an error message `"Error: all states must have the same number of designable residues"`, this means the resfiles are defining a different number of designable residues between the states. All input states must have exactly the same number of designable residues, or else you wouldn't be able to correspond between different states. Even if the number of `ALLAA` is the same in all your resfiles, you can get different number of designable residues if you're trying to design a disulfide-bonded cysteine, or a residue that doesn't exist. Double check that your resfiles are in the same order as your input PDBs.

## Limitations
RECON is unable to perform negative design, i.e. designing a sequence that will maximize energy on a given conformation.

## See also
* [[mpi-msd]]: Alternate protocol for performing multistate design over MPI. 
* [[PackRotamersMover]]: Pack and design side chain rotamers. Useful as the design mover for MSDMover.
* [[RosettaScripts]]: Reference for how XML and Movers/Filters work in Rosetta
* [[I want to do x]]: Guide to choosing a mover