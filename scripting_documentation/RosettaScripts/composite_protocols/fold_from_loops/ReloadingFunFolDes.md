# Reloading FunFolDes

# The Problem
Let's assume that one has run **FunFolDes** and obtained _25 candidate decoys_ that deserve further attention. To proper proceed with the optimisation of those designs one can either choose to treat them as normal decoys and move forward or one might want to _keep the conditions and restrictions_ of **FunFolDes**. This would mean fixing the residue type of the `HOTSPOTS` as well as the correlative position between the different segments of a **motif**.  
In order to do that, there are two main content that we need to reload into the follow up _rosettascript_:

1.  **LABELS:** In order to keep the same level of control as before, we need to reload the residue labels as they were before.
2.  **WORKING FOLDTREE:** This is specific for multi-segment **motif**s. In single-segment **motif**s, the `FOLDTREE` loaded from the silent file is already the functional one, but in multi-segment **motif**s, [[NubInitioLoopClosureMover]] should have taken care of closing the breaks of the structure and setting up the correct `FOLDTREE` for a fully closed structure. Thus, the original `WORKING_FOLDTREE` needs to be reloaded in order to make sure that the different segments of the **motif** are kept in place.

# Necessary Movers
To reload the **LABELS** into the pose, one simply needs to use [[LabelPoseFromResidueSelectorMover]] with the special attribute `from_remark`:

```xml
<LabelPoseFromResidueSelectorMover name="relabel" from_remark="1" />
```

To reload the **WORKING_FOLDTREE**, one will use the [[AtomTreeMover]] such as:

```xml
<AtomTree name="retree" update_residue_variants="1" from_remark="WORKING_FOLDTREE" />
```

Just adding these two movers at the beginning of your `PROTOCOLS` should be enough to reload all the necessary data to keep the required conditions of a classic **FunFolDes** run.