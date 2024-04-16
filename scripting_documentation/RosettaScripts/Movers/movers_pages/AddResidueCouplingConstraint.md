# AddResidueCouplingConstraint
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AddResidueCouplingConstraint

```xml
<AddResidueCouplingConstraint name="(&string)" tensorfile ="(&string)" indexfile="(&string)" strength="(1 &Real)" alphabet="(ARNDCQEGHILKMFPSTWYV- &string)"/>
```
* **tensorfile**: Location of the tensor storing co-evo. data.
* **indexfile**: Location of the index file defining the tensor format.
* **strength**: Defines the strength of co-evo. constraints (default=1).
* **alphabet**: Defines the alphabet used in creating the co-evo. tensor (default=Gremlin order).

## Description

This mover is intended for leveraging co-evolutionary information for protein design to favor sequences which recapitulate correlated mutations as observed in nature. The co-evo. information is derived from a multiple sequence alignment of homologous sequences which is analyzed by a mutual information/direct-coupling method, e.g. Gremlin.

In short, the mover takes a correlation matrix as input and then adds it as new term to the scoring function.

The matrices get input as tensor of the shape [N, A, N, A] where N is the length of the protein and A is the length of the alphabet (typically 21 amino acids + 1 for gaps). The order of the alphabet used can be defined by the user. To access the measure of co-evolution between, e.g., residue 1 (ALA) and residue 2 (ARG) the tensor lookup would be "[1, 0, 2, 1]" (using the GREMLIN alphabet order). The co-evolution strength is multiplied by a user defined strength factor (default=1) and then added as new term to the scoring function.

For more information see:
> Rosetta Design with Co-Evolutionary Information Retains Protein Function   
> S. Schmitz, M. Ertelt, R. Merkl, J. Meiler (Plos comp. biol. 2021)

## Tensor generation
The mover was designed to take co-evo. tensors from Gremlin as input, however, if the tensor is formatted into the right Rosetta tensor format the choice of method should not matter.

A python script to generate a tensor from a multiple sequence alignment (MSA) with Gremlin and then format it into something Rosetta can read, can be found in `tools/GREMLIN/Gremlin2RosettaTensor.py`. The script takes an MSA and the wanted name of the output files as input and will output `tensor.bin`, `indexFile.index` and `tensor.json`. 

## Caveats
The Rosetta tensor format expects the `tensor.json` file to be in the same directory as the `tensor.bin` file.

## Usage example
Example xml for protein design:

```xml
<ROSETTASCRIPTS>
    <SCOREFXNS>
        <ScoreFunction name="scorefxn_cst" weights="ref2015.wts">
                <Reweight scoretype="res_type_linking_constraint" weight="1.0"/>
        </ScoreFunction>
        <ScoreFunction name="scorefxn" weights="ref2015.wts"/>
    </SCOREFXNS>
    <TASKOPERATIONS>
        <InitializeFromCommandline name="ifcl"/>
            <ReadResfile name="rrf" filename="./design.resfile"/>
    </TASKOPERATIONS>
    <MOVERS>
        <AddResidueCouplingConstraint name="favor" tensor_file="./tensor.bin" index_file="./indexList" strength="1.0" alphabet="ARNDCQEGHILKMFPSTWYV-"/>
        <PackRotamersMover name="design" scorefxn="scorefxn_cst" task_operations="ifcl,rrf" />
    </MOVERS>
    <FILTERS>
    </FILTERS>
    <APPLY_TO_POSE>
    </APPLY_TO_POSE>
    <PROTOCOLS>
        <Add mover="favor" />
        <Add mover="design" />
    </PROTOCOLS>
    <OUTPUT scorefxn="scorefxn" />
</ROSETTASCRIPTS>
```

##See Also

* [[FavorSequenceProfileMover]]
* [[FavorSymmetricSequenceMover]]
* [[ResidueTypeConstraintMover]]
* [[I want to do x]]: Guide to choosing a mover