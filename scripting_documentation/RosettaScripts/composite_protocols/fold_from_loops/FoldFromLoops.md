The **FoldFromLoops (FFL)** protocol is a variant of the _grafting protocol_.  
The protocol is aimed towards the insertion of structural motifs with a high RMSD distance to the insertion region in the target scaffold.

> This documentation refers to the **FFL2.0** protocol, integrated as part of _RosettaScripts_. To learn about the first version of the protocol (**FFL1.0** or **FFL_legacy**) as described in [Correia _et al._, 2014](http://doi.org/10.1038/nature12966) see [apps/fold_from_loops]()

# Overview:

**FFL** requires two input structures: one containing the **motif** or structural segment that we want to keep/transfer into a new protein and the **template** or the scaffold that will define the structure that will support the motif.  
Broadly, the steps that the protocol follows are (**M**-Mandatory, **R**-Recommended):  

1.  Extract constraints from the **template** (_R_).
2.  Generate structure-based fragments from the **template** (_M_).
3.  Unfold the **template** and attach it to the **motif** region (_M_).
4.  Perform _ab initio_ allowing movement in all the **template** regions but keeping the **motif** regions fixed (_M_).
5.  Design/Relax the final structure without allowing movement in the **motif** (_R_).

## Highlights
### Automatic fragment generation
Thanks to the use of the [[StructFragmentMover]], **FFL** is capable to generate fragments _on the fly_ to guide the _ab initio_ folding. This fragments use mostly structural information (secondary structure and phi/psi angles) in order to guarantee that the conformation of the final designs will be similar to that of the **template** but also allowing the system to explore conformational variations to better fit the **motif**.

### Multi-segment motif
In **FFL**, a **motif** can be composed of _one_ continuous or _multiple_ discontinuous segments, as long as the number of insertion points in the **template** is the same as the number of expected segments. The different segments will be kept in spatial correlation of each other exactly as they are found in the original **motif** structure input. This is achieved through the **FoldTree** definition and breaks in the sequence. Thus, this scenario requires for a loop closure protocol to be applied in order to close the final design. Although any loop closure protocol in Rosetta will do, the [[NubInitioLoopClosureMover]] is provided by the protocol. This particular mover is aware of the constraints imposed by **FFL** and will automatically avoid non-allowed changes in the **motif** segments.

### Order independent
In multi-segment **motif**s, the individual segments do not need to be inserted into the **template** in the same sequence order as they are found in the **motif** source structure. As a matter of fact, as long as they come from the same structural source, they don't even need to belong to the same protein.

### Length independent
The **motif** segments don't need to be of the same sequence length as their insertion points. **FFL** will fix constraints and fragments in order to adapt to the possible length change between the designs and the **template**.

### Folding with the binder
For binding **motif**s, the binder can be added to the _ab initio_ process, forcing the conformation of the designs not only to adapt to the **motif** but also to the binder, thus ensuring that there are no structural segments that can block the **motif**'s function.

### Label guided design
Due to the possibility of size change and to help guide the design/relax steps, **FFL** uses a residue-label system similar to that of **[[MotifGraftMover]]** (plus some others):

|label|Function|Expected behaviour|
|-----|--------|------------------|
|**MOTIF**|Highlight the **motif** regions|None in itself|
|**TEMPLATE**|Marks the residues that come from the **template**|This residues are allowed _bb/chi_ movement and design|
|**HOTSPOT**|Residues in the **motif** that are considered _key_|This residues can **not** move or be design|
|**COLDSPOT**|Residues in the **motif** that are not _key_|This residues have _chi_ movement and can be designed|
|**FLEXIBLE**|Residues in the edges of the **motif** that are allowed to move|This residues have _bb/chi_ movement but are **not** allowed to design|
|**CONTEXT**|Residues belonging to the target binder (if any)|This residues are **not** allowed to move or design|

The behaviour attached to each of this labels is **fixed** during the _folding process_ (performed by [[NubInitioMover]]) and the _loop closure_ (done by [[NubInitioLoopClosureMover]]), but it can be tweaked in any other part of the process by the user.

### Extra informative silent files
The **FFL** protocol adds several remarks to the silent file output in order to facilitate the reload of the data in new scripts while keeping the protocol's conditions. Amongst them:

* **REMARK LABELS:** All residue label assignation are saved to file. They can be reloaded with **[[DisplayPoseLabelsMover]]**.
* **REMARK WORKING_FOLDTREE:** The working _FoldTree_ necessary to keep the **motif** segments in place is also saved. It can be loaded back with **[[AtomTreeMover]]**'s _from_remark_ option.
* **REMARK POST_NUBINITIO_SEQ:** As there is the possibility to run cycles of design on the sequence just after folding, the sequence at that state is saved, allowing an easier trackback of the design/relax process.

# Known caveats

1.  It is imperative to make sure that the **template** Pose is a **single chain** structure. Neither the generation of fragments, nor the _ab initio_ process allow for multiple movable chains.
2.  Due to the use of labels, the easiest way to guide control the protocol after folding is through the use of the  [[ResiduePDBInfoHasLabel|ResidueSelectors#residueselectors_conformation-dependent-residue-selectors_residuepdbinfohaslabel]] residue selector. To guide the MoveMap, one can then use **MoveMapFactory** to generate [[ResidueSelectors]]-based Movemaps. Right now, not all Movers that can work with MoveMaps can work with the MoveMapFactory. For those that can work with named MoveMaps, the [[MoveMapFactoryToNamedMoveMapMover]] can help.

# Main Components

* **[[]]:**
