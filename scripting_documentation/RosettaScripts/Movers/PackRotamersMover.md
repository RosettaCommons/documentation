# PackRotamersMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PackRotamersMover

Repacks sidechains with user-supplied options, including TaskOperations

```
<PackRotamersMover name="&string" scorefxn=(score12 &string) task_operations=(&string,&string,&string)/>
```

-   scorefxn: scorefunction to use for repacking (NOTE: the error "Scorefunction not set up for nonideal/Cartesian scoring" can be fixed by adding 'Reweight scoretype="pro_close" weight="0.0"' under the talaris2013_cart scorefxn in the SCOREFXNS section)
-   taskoperations: comma-separated list of task operations. These must have been previously defined in the TaskOperations section.


