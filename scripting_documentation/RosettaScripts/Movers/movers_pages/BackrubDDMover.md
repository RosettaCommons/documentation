# BackrubDD
*Back to [[Mover|Movers-RosettaScripts]] page.*
## BackrubDD

Do backrub-style backbone and sidechain sampling.

```xml
<BackrubDD name="(backrub &string)" partner1="(0 &bool)" partner2="(1 &bool)" interface_distance_cutoff="(8.0 &Real)" moves="(1000 &integer)" sc_move_probability="(0.25 &float)" scorefxn="(score12 &string)" small_move_probability="(0.0 &float)" bbg_move_probability="(0.25 &float)" temperature="(0.6 &float)" task_operations="('' &string)">
        <residue pdb_num/res_num="(&string)"/>
        <span begin="pdb or rosetta-indexed number, eg 10 or 12B &string" end="pdb or rosetta-indexed number, e.g., 20 or 30B &string"/>
</BackrubDD>
```

With the values defined above, backrub will only happen on residues 31B, serial 212, and the serial span 10-20. If no residues and spans are defined then all of the interface residues on the defined partner will be backrubbed by default. Note that setting partner1=1 makes all of partner1 flexible. Adding segments has the effect of adding these spans to the default interface definition Temperature controls the monte-carlo accept temperature. A setting of 0.1 allows only very small moves, where as 0.6 (the default) allows more exploration. Note that small moves and bbg\_moves introduce motions that, unlike backrub, are not confined to the region that is being manipulated and can cause downstream structural elements to move as well. This might cause large lever motions if the epitope that is being manipulated is a hinge. To prevent lever effects, all residues in a chain that is allowed to backrub will be subject to small moves. Set small\_move\_probability=0 and bbg\_move\_probability=0 to eliminate such motions.

bbg\_moves are backbone-Gaussian moves. See The J. Chem. Phys., Vol. 114, pp. 8154-8158.

Note: As of June 29, 2011, this mover was renamed from "Backrub" to "BackrubDD". Scripts run with versions of Rosetta after that date must be updated accordingly.

-   pdb\_num/res\_num: see the [[RosettaScripts Documentation|RosettaScripts#rosettascripts-conventions_specifying-residues]] for more.
-   task\_operations: see [RepackMinimize](#RepackMinimize)


##See Also

* [[BackrubMover]]: Backrub-style backbone movements
* [[Backrub]]: The backrub application
* [[Backrub Server (external link)|https://kortemmelab.ucsf.edu/backrub/cgi-bin/rosettaweb.py?query=index]]: Web-based server that provides backrub ensembles for academic users
* [[I want to do x]]: Guide to choosing a mover
