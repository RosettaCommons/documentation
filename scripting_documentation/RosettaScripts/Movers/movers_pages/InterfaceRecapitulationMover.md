# InterfaceRecapitulation
*Back to [[Mover|Movers-RosettaScripts]] page.*
## InterfaceRecapitulation

Test a design mover for its recapitulation of the native sequence. Similar to SequenceRecovery filter below, except that this mover encompasses a design mover more specifically.

```xml
<InterfaceRecapitulation name="(&string)" mover_name="(&string)"/>
```

The specified mover needs to be derived from either [[DesignRepackMover]] or [[PackRotamersMover]] base class and to to have the packer task show which residues have been designed. The mover then computes how many residues were allowed to be designed and the number of residues that have changed and produces the sequence recapitulation rate. The pose at parse-time is used for the comparison.


##See Also

* [[ProteinInterfaceMSMover]]: Mover for multistate design of protein interfaces
* [[DnaInterfacePackerMover]]
* [[InterfaceAnalyzerMover]]
* [[InterfaceScoreCalculatorMover]]
* [[I want to do x]]: Guide to choosing a mover
