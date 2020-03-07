# MinMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MinMover

[[include:mover_MinMover_type]]

## Notes:

-   cartesian: To set up a score function for Cartesian minimization (i.e if you get the `ERROR: Scorefunction not set up for nonideal/Cartesian scoring`) you must set `cart_bonded` to  0.5 and `pro_close` to 0.0. 
-   MoveMap: The movemap can be programmed down to individual degrees of freedom. See [[FastRelax|FastRelaxMover]] for more details.


##See Also

* [Minimization Tutorial](https://www.rosettacommons.org/demos/latest/tutorials/minimization/minimization)
* [[SymMinMover]]: Symmetric version of this mover
* [[Minimization overview]]
* [[I want to do x]]: Guide to choosing a mover
