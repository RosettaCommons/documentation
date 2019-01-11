# MSDMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MSDMover

###Author
Alex Sevy (alex.sevy@gmail.com); 
PI: Jens Meiler

###Description

Multistate design mover used in the RECON protocol. MSDMover applies linking constraints to a pose based on the sequence of other input poses, then uses a predefined design mover to run design based on these sequence constraints. These constraints are then removed for the next step of the protocol. For more details on the RECON protocol see [Sevy AM, et al, PLoS Comput. Biol, 2015](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004300)

```xml
<MSDMover name="(&string)" design_mover="(&string)" resfiles="(&strings)" 
constraint_weight="(1.0 &real)" debug="(false &bool)" />

```

-   design\_mover: A previously defined mover that will design the input states. Note that since resfiles are applied as a TaskOperation within the MSDMover, there's no need to specify ReadResfile behavior for the design\_mover - however all other desired TaskOperations (InitializeFromCommandLine, etc) should be specified in the design\_mover tag
-   resfiles: A comma-separated list of resfiles to define designable and repackable residues for all states in multistate design. Multiple resfiles can be used for multiple states - in this case the first resfile in the tag will be applied to the first structure, etc. One single resfile used for all states is also supported.
-   constraint_weight: The weight of amino acid linking constraints during the RECON protocol. Generally weights will be ramped from 0.5 to 2.0, to allow searching of more sequence space in early rounds.
-   debug: Output extra messages during the protocol

##See Also

* [[FindConsensusSequence]]: Converge all states in RECON multistate design to a single sequenced. Used at the end of the RECON protocol. 
* [[PackRotamersMover]]: Pack and design side chain rotamers. Useful as the design mover for MSDMover.
* [[I want to do x]]: Guide to choosing a mover
