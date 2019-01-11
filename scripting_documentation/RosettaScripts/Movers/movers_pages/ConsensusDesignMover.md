# ConsensusDesignMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ConsensusDesignMover

This mover will mutate residues to the most-frequently occuring residues in a multiple sequence alignment, while making sure that the new residue scores well in rosetta. It takes a position specific scoring matrix (pssm) as input to determine the most frequently occuring residues at each position. The user defines a packer task of the residues which will be designed. At each of these positions only residues which appear as often or more often (same pssm score or higher) will be allowed in subsequent design. Design is then carried out with the desired score function, optionally adding a residues identity constraint proportional to the pssm score (more frequent residues get a better energy).

```xml
<ConsensusDesignMover name="&string" scorefxn="(&string)" invert_task="(&bool)" sasa_cutoff="(&float)" use_seqprof_constraints="(&bool)" task_operations="(&string)"/>
```

-   scorefxn: Set the desired score function (defined in a the \<SCOREFXNS\> block)
-   taskoperations: Hand in a task operation defining the residues you want to design (or their inverse). Without a task\_operation and with invert\_task=0 everything will be designed.
-   use\_seqprof\_constraints: Only residues which appear more often in the pssm than the wild-type residue at position i are allowed in the packer task as position i. If use\_seqprof\_constraints = 0 all of those are allowed with equal probability -- that is, no extra constraint energy is added. If use\_seqprof\_constraints = 1 the more frequent residues are added to the packer task at residue i and each is granted a sequence constraint roughly proportional to the pssm score. In effect the more-frequent residues are included in proportion to their frequency of occurence in the pssm.
-   sasa\_cutoff: Buried residues (with sasa \< sasa\_cutoff) will not be designed. Surface residues (with sasa \> sasa\_cutoff) will be designed. To carry out consensus design on all residues in the task simply don't enter a sasa\_cutoff or set it to 0.
-   invert\_task: A common usage case is to take an interface/ligand packer task and then do consensus design for everything outside of that design (which is presumably optimized by rosetta for binding). That use requires a task that is the opposite of the original task. This flag turns on that inverted task.


##See Also

* [[FavorSequenceProfileMover]]
* [[PSSM2BfactorMover]]
* [[I want to do x]]: Guide to choosing a mover
