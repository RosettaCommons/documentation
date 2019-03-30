# PatchdockTransform
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PatchdockTransform

Uses the Patchdock output files to modify the configuration of the pose.

```xml
<PatchdockTransform name="&string" fname="(&string)" from_entry="(&integer)" to_entry="(&integer)" random_entry="(&bool)"/>
```

Since Patchdock reading is also enabled on the commandline, the defaults for each of the parameters can be defined on the commandline. But, setting patchdock commandline options would provoke the JobDistributor to call the PatchDock JobInputter and that might conflict with the mover options defined here.

-   fname: the patchdock file name.
-   from\_entry: from which entry to randomly pick a transformation.
-   to\_entry: to which entry to randomly pick a transformation.
-   random\_entry: randomize the chosen entry?

If you choose from\_entry to\_entry limits that go beyond what's provided in the patchdock file, the upper limit would be automatically adjusted to the limit in the patchdock file.


##See Also

* [[I want to do x]]: Guide to choosing a mover
