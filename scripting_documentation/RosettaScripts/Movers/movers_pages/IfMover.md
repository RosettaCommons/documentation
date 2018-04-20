# IfMover
*Back to [[Mover|Movers-RosettaScripts]] page.*
## IfMover

Implements a simple IF (filter(pose)) THEN true\_mover(pose) ELSE false\_mover(pose). *true\_mover* is required, *false\_mover* is not.

```xml
<If name="( &string)" filter_name="(&string)" true_mover_name="(&string)" false_mover_name="(null &string)"/>
```

##See Also

* [[ContingentAcceptMover]]
* [[ParsedProtocolMover]]
* [[Home page for RosettaScripts filters|Filters-RosettaScripts]]
* [[I want to do x]]: Guide for choosing a mover
