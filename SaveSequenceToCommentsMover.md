#SaveSequenceToComments

Documentation by Christoffer Norn (ch.norn@gmail.com).  Page created 14 August 2017.

*Back to [[Movers|Movers-RosettaScripts]] page.*

##SaveSequenceToComments

This mover stores the current pose sequence in pose comments.

## Options and Usage

```xml
<SaveSequenceToComments name=(string)
     save_seq_name=(string,"true")
/>
```

**name** -- A unique string by which a particular instance of the mover will be referred in a RosettaScripts XML file.

**save_seq_name** -- Name of comment that the pose sequence will be saved to.

## See also

* [[SequenceDistance|SequenceDistanceFilter]] filter.