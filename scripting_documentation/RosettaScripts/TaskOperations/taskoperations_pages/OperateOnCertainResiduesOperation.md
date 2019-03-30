# OperateOnCertainResidues
*Back to [[TaskOperations|TaskOperations-RosettaScripts]] page.*
## OperateOnCertainResidues Operation

**This TaskOperation is deprecated. Use [[ResidueSelectors]] and [[OperateOnResidueSubset|OperateOnResidueSubsetOperation]] instead.**

Allows specification of [[Residue Level TaskOperations]] based on residue properties specified with [ResFilters](#ResFilters) .

Example:

    <OperateOnCertainResidues name="PROTEINnopack">
      <ResidueHasProperty property="PROTEIN"/> //Only one ResFilter per OperateOnCertainResidues block. The ResFilter comes first
      <PreventRepackingRLT/>  //Only one Residue level task operation per OperateOnCertainResidues block. The RLTO comes second
    </OperateOnCertainResidues>

[[include:Residue-Level-TaskOperations]]
<!--Why does this work in preview but not on the actual page?!?!?! -->
ResFilters
----------

Use these as a subtag for special OperateOnCertainResidues TaskOperation. Only one may be used per OperateOnCertainResidues, however a compound filter (Any/All/None) may be used to combine multiple filters in a single operation.

### CompoundFilters

AnyResFilter, AllResFilter, NoResFilter combine the results of specified subfilters with the given boolean operation. Any number of subfilters may be declared.

e.g.

      <AnyResFilter>
        <ChainIs chain="A"/>
        <ChainIs chain="B"/>
      </AnyResFilter>

As task operations produce restriction masks, and therefor only prevent targets from repacking/designing, the most effective way to specify a set of residues for design or repack is the use of a double-negative task operation:

     <OperateOnCertainResidues name="aromatic_apolar">
       <NoResFilter>
         <ResidueType aromatic="1" apolar="1"/>
       </NoResFilter>
       <PreventRepackingRLT/>
     </OperateOnCertainResidues>

Restricts repacking to aromatic and apolar residues.

### ResidueType

Convenience filter selects residues by type.

     <ResidueType aromatic="(0 &bool)" apolar="(0 &bool)" polar="(0 &bool)" charged="(0 &bool)"/>

### ResidueHasProperty

### ResidueLacksProperty

Selects or excludes residues based on the given residue property.

-   property: Residue property, as specified in the residue resfile. (e.g. DNA, PROTEIN, POLAR, CHARGED) One only.

<!-- -->

     e.g. <ResidueHasProperty property=POLAR/>

### ChainIs

### ChainIsnt

set of residues based on their chain letter in the original PDB.

-   chain: defaults to "A"

<!-- -->

     e.g. <ChainIs chain=A/>

### ResidueName3Is

### ResidueName3Isnt

-   name3: Any number of residue type specifiers, comma separated.

<!-- -->

     e.g. <ResidueName3Is name3=ARG,LYS,GUA/>

### ResidueIndexIs

### ResidueIndexIsnt

-   indices: comma-separated list of rosetta residue indices (1 to nres)

<!-- -->

     e.g. <ResidueIndexIs indices=1,2,3,4,33/>

### ResiduePDBIndexIs

### ResiduePDBIndexIsnt

-   indices: comma-separated list of chain.pos identifiers e.g. indices=

<!-- -->

     e.g. <ResiduePDBIndexIs indices=A.2,C.100,D.-10/>

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