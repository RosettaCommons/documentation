# FindConsensusSequence
*Back to [[Mover|Movers-RosettaScripts]] page.*
## FindConsensusSequence

###Author
Alex Sevy (alex.sevy@gmail.com); 
PI: Jens Meiler

###Description

Multistate design mover used at the end of the RECON protocol. In the RECON protocol multiple states are designed independently with a sequence constraint to encourage convergence on a single solution. At the end FindConsensusSequence is used to choose a single sequence that is optimal for all states. It does this by, at each position, swapping out all possible amino acids that are present on at least one state, measuring the fitness of each candidate amino acid and choosing the best. For more details on the RECON protocol see [Sevy AM, et al, PLoS Comput. Biol, 2015](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004300)

```xml
<FindConsensusSequence name="(&string)" scorefxn="(talaris2014 &string)" 
resfiles="(&strings\_comma\_separated)" task_operations="(&string)" debug="(false &bool)" />

```

-   scorefxn: Score function to use when evaluating best amino acids at each position
-   resfiles: A list of resfiles to define designable and repackable residues for all states in multistate design. Multiple resfiles can be used for multiple states - in this case the first resfile in the tag will be applied to the first structure, etc. One single resfile used for all states is also supported.
-   task_operations: Specifies behavior of the packer when substituting different amino acids and repacking.
-   debug: Output extra messages during the protocol

##See Also

* [[MSDMover]]: Design mover to be used during RECON multistate design
* [[I want to do x]]: Guide to choosing a mover
