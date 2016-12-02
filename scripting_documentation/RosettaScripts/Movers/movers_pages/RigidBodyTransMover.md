# RigidBodyTransMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## RigidBodyTransMover

Translate chains.

     <RigidBodyTransMover name="(&string)" jump="(1 &int)" distance="(1.0 &Real)" x="(0.0 &Real)" y="(0.0 &Real)" z="(0.0 &Real)" />

-   jump: The chain downstream of the specified jump will be translated.
-   distance: The distance to translate along the axis
-   x,y,z: Specify the axis along which to translate. The vector will be normalized to unit length before use. All zeros (the default) results in automatic apply-time setting of the direction on the axis between the approximate centers of the two components being separated.


##See Also

* [[TransformMover]]
* [[TranslateMover]]
* [[I want to do x]]: Guide to choosing a mover