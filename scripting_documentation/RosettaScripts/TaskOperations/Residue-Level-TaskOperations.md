Residue Level TaskOperations
----------------------------

Use these as a subtag for special OperateOnCertainResidues TaskOperation. Only one may be used per OperateOnCertainResidues

### RestrictToRepackingRLT

Turn off design on the positions selected by the accompanying ResFilter.

    <RestrictToRepackingRLT/>

### PreventRepackingRLT

Turn off design and repacking on the positions selected by the accompanying ResFilter.

    <PreventRepackingRLT/>

### RestrictAbsentCanonicalAASRLT

Do not allow design to amino acid identities that are not listed (i.e. permit only those listed) at the positions selected by the accompanying ResFilter.

    <RestrictAbsentCanonicalAASRLT aas=(&string)/>

-   aas - list of one letter codes of permitted amino acids, with no separator. (e.g. aas=HYFW for only aromatic amino acids.)

### AddBehaviorRLT

Add the given "behavior" to the positions selected by the accompanying ResFilter.

    <AddBehaviorRLT behavior=(&string)/>

-   behavior - Behavior string. These are protocol-specific. Consult the protocol documentation for if it responds to behavior strings.

