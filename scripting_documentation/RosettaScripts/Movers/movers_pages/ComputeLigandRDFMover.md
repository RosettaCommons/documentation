# ComputeLigandRDF
*Back to [[Mover|Movers-RosettaScripts]] page.*
## ComputeLigandRDF

```xml
<ComputeLigandRDF name="(string)" ligand_chain="(string)" mode="(string)">
    <(string)/>
</ComputeLigandRDF>
```

ComputeLigandRDF computes Radial Distribution Functions using pairs of protein-protein or protein-ligand atoms. The conceptual and theoretical basis of Rosettas RDF implementation is described in the [ADRIANA.Code Documentation](http://www.molecular-networks.com/files/docs/adrianacode/adrianacode_manual.pdf) . A 100 bin RDF with a bin spacing of 0.1 Å is calculated.

all RDFs are inserted into the job as a string,string pair. The key is the name of the computed RDF, the value is a space separated list of floats

The outer tag requires the following options:

-   ligand\_chain: The PDB ID of the ligand chain to be used for RDF computation.
-   mode: The type of RDF to compute. valid options are "interface" in which the RDF is computed using all ligand atoms and all protein atoms within 10 Å of the ligand, and "pocket" in which the RDF is computed using all protein atoms within 10 Å of the ligand.

The ComptueLigandRDF mover requires that one or more RDFs be specified as RDF subtags. Descriptions of the currently existing RDFs are below:

### RDFEtableFunction

RDFEtableFunction computes 3 RDFs using the Analytic Etables used to compute fa\_atr, fa\_rep and fa\_solv energy functions.

RDFEtableFunction requires that a score function be specified using the scorefxn option in its subtag.

### RDFElecFunction

RDFElecFunction computes 1 RDF based on the fa\_elec electrostatic energy function.

RDFElecFunction requires that a score function be specified using the scorefxn option in its subtag.

### RDFHbondFunction

RDFHbondFunction computes 1 RDF based on the hydrogen bonding energy function.

### RDFBinaryHbondFunction

RDFBinaryHbondFunction computes 1 RDF in which an atom pair has a score of 1 if one atom is a donor and the other is an acceptor, and a 0 otherwise, regardless of whether these atoms are engaged in a hydrogen bonding interaction.

##See Also

* [[Preparing ligands]]: Preparing ligands for use in Rosetta
* [[Non-protein residues]]: Homepage for working with non-protein molecules in Rosetta
* [[InterfaceScoreCalculatorMover]]
* [[HighResDockerMover]]
* [[GrowLigandMover]]
* [[WriteLigandMolFileMover]]
* [[I want to do x]]: Guide to choosing a mover
