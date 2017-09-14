#SequenceDistanceFilter

Documentation by Christoffer Norn (ch.norn@gmail.com).  Page created 14 August 2017.

*Back to [[Filters|Filters-RosettaScripts]] page.*

##SequenceDistanceFilter

This filter computes the hamming distance between the current pose sequence and a sequence stored in pose comments (sequence_comment_id) OR to a sequence specified directly in the XML script (target_seq). To write a previous pose sequence to pose comments use SaveSequenceToPoseMover.

## Options and Usage

```xml
< SequenceDistance name=(string)
     sequence_comment_id=(string,"true")
     target_sequence=(string,"true")
     threshold=(int,"8000") 
     confidence=(real,"1.0")
/>
```

**name** -- A unique string by which a particular instance of the filter will be referred in a RosettaScripts XML file.

**sequence_comment_id** -- Comment id from which the sequence should be loaded from pose. Usually SaveSequenceToComments are used for getting a sequence earlier in the protocol into comments.

**target_sequence** -- Amino acid sequence to compare pose sequence to.

**threshold** -- The maximum hamming distance.  Default 8000.

**confidence** -- Probability that the pose will be filtered out if it does not pass this Filter

## See also

* [[SaveSequenceToComments| SaveSequenceToCommentsMover]] mover.