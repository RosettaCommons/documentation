<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Test for the existence or the value of a comment in the pose. This is useful for controlling execution flow: if the pose comments have been modified you do one thing or another

```xml
<PoseComment name="(&string;)" comment_name="(&string;)"
        comment_value="(&string;)" comment_exists="(false &bool;)"
        confidence="(1.0 &real;)" />
```

-   **comment_name**: the key value of the comment
-   **comment_value**: the comment's value
-   **comment_exists**: check only whether the comment exists or not, regardless of its content
-   **confidence**: Probability that the pose will be filtered out if it does not pass this Filter

---
