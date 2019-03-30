# MakePolyX
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MakePolyX

Convert pose into poly XXX ( XXX can be any amino acid )

    <MakePolyX name="&string" aa="&string" keep_pro="(0 &bool)"  keep_gly="(1 &bool)" keep_disulfide_cys="(0 &bool)" />

Options include:

-   aa ( default "ALA" ) using amino acid type for converting
-   keep\_pro ( default 0 ) Pro is not converted to XXX
-   keep\_gly ( default 1 ) Gly is not converted to XXX
-   keep\_disulfide\_cys ( default 0 ) disulfide CYS is not converted to XXX


##See Also

* [[BuildAlaPoseMover]]
* [[SaveAndRetrieveSidechainsMover]]
* [[PackRotamersMoverPartGreedyMover]]
* [[PredesignPerturbMover]]
* [[EnzRepackMinimizeMover]]
* [[I want to do x]]: Guide to choosing a mover