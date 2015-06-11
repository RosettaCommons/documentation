# MultipleOutputWrapper
*Back to [[Mover|Movers-RosettaScripts]] page.*
## MultipleOutputWrapper

This is a simple wrapper that will execute the mover or ROSETTASCRIPTS protocol it contains to generate additional (derived) output poses from the original pose.
This mover is designed to work with the MultiplePoseMover.
"MoverName" is a placeholder for the actual name of the mover to be used.
Use this wrapper if the mover you want to use does cannot provided more than one output pose (yet).

```
<MultipleOutputWrapper name=(&string) max_output_poses=(&integer)>
    <MoverName .../>
</MultipleOutputWrapper>
```

or

<MultipleOutputWrapper name=(&string) max_output_poses=(&integer)>
    <ROSETTASCRIPTS>
        ...
    </ROSETTASCRIPTS>
</MultipleOutputWrapper>

-   max\_output\_poses: Maximum number of output poses this wrapper should generate (i.e. how many times the inner mover is executed).

