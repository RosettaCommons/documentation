# SetupNCS
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SetupNCS

Establishes a non crystallographic symmetry (NCS) between residues. The mover sets dihedral constraints on backbone and side chains to force residues to maintain the same conformation. The amino acid type can be enforced too. This mover does not perform any minimization, so it is usually followed by MinMover or RelaxMover.

```xml
  <SetupNCS name="(&string)" bb="(1 &bool)" chi="(1 &bool)" symmetric_sequence="(0 &bool)"/> 
       <NCSgroup source="38A-55A" target="2A-19A"/>
       <NCSgroup source="38A-55A" target="20A-37A"/>
       ...
       <NCSend source="55A" target="1A"/>
       <NCSend source="54A" target="108A"/>
       ...
  </SetupNCS>
```

-   bb: sets dihedral constraints for backbone
-   chi: sets dihedral constraints for side chains
-   symmetric\_sequence: forces the sequence from the source into the target (see below)
-   NCSgroup: defines two set of residues for which the constraints are generated. Source and target groups need to contain the same number of residues. The constraints are defined to minimize the different between dihedral angles, instead of forcing the target conformation into the source conformation. Backbone dihedral angles cannot be set for residues at the beginning or at the end of a chain.
-   source: reference residues, express as single residue or interval. Source and target need the same number of residues.
-   target: target residues, express as single residue or interval. Source and target need the same number of residues.
-   NCSend: forces sequence and conformation from source to target but does not set up any constraint. This tag applies only if symmetric\_sequence=1.


##See Also

* [[Symmetry]]: Using symmetry in Rosetta
* [[SetupForSymmetryMover]]
* [[DetectSymmetryMover]]
* [[ExtractAsymmetricUnitMover]]
* [[ExtractAsymmetricPoseMover]]
* [[SymDofMover]]
* [[SymMinMover]]
* [[SymPackRotamersMover]]
* [[MakeBundleMover]]
* [[SymmetryAndRosettaScripts]]
