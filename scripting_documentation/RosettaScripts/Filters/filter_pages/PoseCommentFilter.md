# PoseComment
*Back to [[Filters|Filters-RosettaScripts]] page.*
## PoseComment

Test for the existence or the value of a comment in the pose. This is useful for controlling execution flow: if the pose comments have been modified you do one thing or another.

```xml
<PoseComment name="(&string)" comment_name="(&string, '' )" comment_value="(&string, '')" comment_exists="(&bool, false )"/>
```
- comment_name: the key value of the comment
- comment_value: the comment's value
- comment_exists: check only whether the comment exists or not, regardless of its content.

If you run with comment_name="" then all the pose comments are checked to find the requested value.

## See also:

* [[LoadPDBMover]]
* [[PoseInfoFilter]]
