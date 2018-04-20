# AtomTree
*Back to [[Mover|Movers-RosettaScripts]] page.*
## AtomTree

Sets up an atom tree for use with subsequent movers. Connects pdb\_num on host\_chain to the nearest residue on the neighboring chain. Connection is made through connect\_to on host\_chain pdb\_num residue

```xml
<AtomTree name="(&string)" docking_ft="(0 &bool)" pdb_num/resnum="(&string)" connect_to="(see below for defaults &string)" anchor_res="(pdb numbering)" connect_from="(see below)" host_chain="(2 &integer)" simple_ft="(0&bool)" two_parts_chain1="(0&bool)" fold_tree_file="(&string)"/>
```

-   fold_tree_file: if this is set to a file name the mover will read a foldtree from a file and then impose it. Nothing more. Here's an example for a fold-tree definition:

    ```
    FOLD_TREE EDGE 1 18 -1 EDGE 18 32 1 EDGE 18 21 -1 EDGE 32 22 -1 EDGE 32 50 -1 EDGE 50 79 -1 EDGE 50 163 2 EDGE 163 98 -1 EDGE 98 82 3 EDGE 98 96 -1 EDGE 82 95 -1 EDGE 82 80 -1 EDGE 163 208 -1
    ```

    Note that foldtree files cannot contain comments or anything other than the `FOLD_TREE` and `EDGE` directives shown above.

* ab_fold_tree: boolean (dflt 0). If set to true then sets up a fold tree for scFv, the cysteine disulfides are the nodes. If there is a ligand (chain 2) then also creates a jump edge between the ligand center of mass and the cysteine that is the closest to the center of mass of the scFv (chain 1). 
-   docking\_ft: set up a docking foldtree? if this is set all other options are ignored.
-   simple\_ft: set a simple ft going from 1-\>chain1\_end; 1-\>chain2\_begin; chain2\_begin-\>chain2\_end; etc.
-   two\_parts\_chain1: If chain1 is composed of two interlocking parts and you want to allow movements between these two parts, set to true. The mover will find the centers of mass of the first part of chain1, connect to the second part, and also connect the center of mass of the entire chain to the center of mass of chain2.
     Detailed settings for a foldtree:
     These options specify the actual jump atoms. anchor\_res (this is the residue) and connect\_from (the actual atom) are a pair and are used for the first chain, whereas pdb\_num (residue) and connect\_to (atom) are a pair on chain 2 (the one that typically moves)
-   connect\_to: Only can use if defining pdb\_num! Defaults to using the farthest carbon atom from the mainchain for each residue, e.g., CB, Cdelta for Gln etc.
-   connect\_from: user can specify which atom the jump should start from. Currently only the pdb naming works. If not specified, the "optimal" atomic connection for anchor residue is chosen (that is to their functional groups).
-   pdb\_num/resnum: see the main [[RosettaScripts Documentation|RosettaScripts#rosettascripts-conventions_specifying-residues]] for more


##See Also

* [[AtomTree overview]]
* [[FoldTree overview]]
