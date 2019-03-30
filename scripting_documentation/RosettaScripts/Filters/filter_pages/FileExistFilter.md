# FileExist
*Back to [[Filters|Filters-RosettaScripts]] page.*
## FileExist

Does a file exist on disk? Useful to see whether we're recovering from a checkpoint

```xml
<FileExist name="(&string)" filename="(&string)" ignore_zero_bytes="(0 &bool)"/>
```

-   filename: what filename to test?
-   ignore\_zero\_bytes: if true, files that are merely place holders (contain nothing) are treated as nonexistant (filter returns false).

## See also

* [[FileRemoveFilter]]
