# RollMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## RollMover

Rotate pose over a given axis.

```
        <RollMover name=(&string) start_res=(&int) stop_res=(&int) min_angle=(&Real) max_angle=(&Real) > 
               <axis x=(&Real) y=(&Real) z=(&Real) /> 
               <translate x=(&Real) y=(&Real) z=(&Real) /> 

        </RollMover>
```

-   start\_res: first residue id of object to roll
-   stop\_res: last residue id of object to roll
-   min\_angle: minimum angle to roll about axis
-   max\_angle: maximum angle to roll about axis
-   axis: vector to rotate about
-   translate: point to translate axis to


