# RollMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## RollMover

Rotate pose over a given axis.

```xml
        <RollMover name="(&string)" start_res="(&int)" stop_res="(&int)" min_angle="(&Real)" max_angle="(&Real)"> 
               <axis x="(&Real)" y="(&Real)" z="(&Real)" /> 
               <translate x="(&Real)" y="(&Real)" z="(&Real)" /> 

        </RollMover>
```

-   start\_res: first residue id of object to roll
-   stop\_res: last residue id of object to roll
-   min\_angle: minimum angle to roll about axis
-   max\_angle: maximum angle to roll about axis
-   axis: vector to rotate about
-   translate: point to translate axis to



Rotate and/or translate pose over random axis/random direction

```xml
<RollMover name="(&string)" chain="(&int)" random_roll="(&Bool)" random_roll_angle_mag="(&Real)" random_roll_trans_mag="(&Real)" /> 
```
-   random_roll_angle_mag: the sigma for a gaussian magnitude rotation around a random axis
-   random_roll_trans_mag: the sigma for a 3D gaussian random translation


##See Also

* [[TransformMover]]
* [[RotateMover]]
* [[I want to do x]]: Guide to choosing a mover
