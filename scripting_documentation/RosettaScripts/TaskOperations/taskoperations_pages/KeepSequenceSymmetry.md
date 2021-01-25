# KeepSequenceSymmetry
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page. Page last updated 25 January 2021.*
## KeepSequenceSymmetry

This feature was created to perform the same purpose of link residues, but hopefully in a more user-friendly way. 
It must be paired with a corresponding [[SetupForSequenceSymmetryMover]] to have any affect.

When used, the packer will enforce identical sequences for all linked regions defined in a corresponding **SetupForSequenceSymmetryMover**.

**NOTE**: if there are no common residue types amongst linked residues the annealer will exit as it cannot assign any valid residue types to these positions.

### Syntax

```xml
<KeepSequenceSymmetry name="(&string)" setting="true(&bool)"/>
```
* **setting**: If true, Rosetta will activate the SequenceSymmetricAnnealer. Use this when you want to design identical regions but do not want/cannot enforce physical symmetry.

### Residue Linking Logic

The linking logic for the task operation relies on predefined ResidueSelectors, specified in SequenceSymmetry subtags in an associated [[SetupForSequenceSymmetryMover]].
More specifically, it uses a lists, ordered by Rosetta residue IDs, of the residues defined by each selector and links each corresponding entry.
Therefore, all ResidueSelectors defined in a subtag must define the same number of residues.
Moreover, if any residues are defined in multiple subtags then the union of all defined links will be used, see below for an example.
Any residues not defined by a SequenceSymmetry tag will be treated normally.

### Example

Consider the scenario described by the following XML:

```xml
<RESIDUE_SELECTORS>
  <Index name="index1" resnums="1,2,3,4,5" />
  <Index name="index2" resnums="11,15,14,12,13" />

  <Index name="index3" resnums="3-8" />
  <Index name="index4" resnums="20-25" />
</RESIDUE_SELECTORS>
<TASKOPERATIONS>
  <KeepSequenceSymmetry name="keep_seq_sym" setting="true" />
</TASKOPERATIONS>
<MOVERS>
  <SetupForSequenceSymmetryMover name="setup_seq_sym" sequence_symmetry_behaviour="keep_seq_sym" >
    <SequenceSymmetry residue_selectors="index1,index2" />
    <SequenceSymmetry residue_selectors="index3,index4" />
  </SetupForSequenceSymmetryMover>
</MOVERS>
```

Going through each SequenceSymmetry definition in sequence, the residues 1-5 and 11-15 are linked.
Specifically, residue 1 will be linked to 11, residue 2 to 12, ... and residue 5-15 as the order specified in the Index ResidueSelector is ignored and the Rosetta numbering takes precedence.
Next, the residues 3-8 and 20-25 are linked.
However, as residues 3-5 are also defined in the previous subtag, so the union of all links is used.

Therefore, the final links are as follows (where <-> denotes a linkage):
- 1 <-> 10
- 2 <-> 11
- 3 <-> 12 <-> 20
- 4 <-> 13 <-> 21
- 5 <-> 14 <-> 22
- 6 <-> 23
- 7 <-> 24
- 7 <-> 25

### Developer Info

Enabling this task operation will construct the SequenceSymmetricAnnealer.
Introduced in PR 4260, updated in PR 5168. 

##See Also

* [[RosettaScripts|RosettaScripts]]: Using RosettaScripts
* [[Task Operations | TaskOperations-RosettaScripts]]: Other TaskOperations in RosettaScripts
* [[Conventions in RosettaScripts|RosettaScripts-Conventions]]
* [[I want to do x]]: Guide for making specific structural pertubations using RosettaScripts
* [[Scripting Interfaces|scripting_documentation/Scripting-Documentation]]: Other ways to interact with Rosetta in customizable ways
* [[Running Rosetta with options]]: Instructions for running Rosetta executables.
* [[Analyzing Results]]: Tips for analyzing results generated using Rosetta
* [[Rosetta on different scales]]: Guidelines for how to scale your Rosetta runs
* [[Preparing structures]]: How to prepare structures for use in Rosetta