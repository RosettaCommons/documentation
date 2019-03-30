# FileRemove
*Back to [[Filters|Filters-RosettaScripts]] page.*
## FileRemove

Remove a file from disk. Useful to clean up at the end of a trajectory, if we saved any intermediate files. But you need to know in advance the names of all files you want to delete. It doesn't support wildcards.

```xml
<FileRemove name="(&string)" filenames="(comma delimited list, &string)" delete_contents_only="(0 &bool)"/>
```

-   filenames: list of file names separated by comma, e.g., 3r2x\_0001.pdb,3r2x\_0002.pdb
-   delete\_contents\_only: if true, only eliminates the contents of the file but leaves a placeholder file of size 0bytes.

## See also

* [[FileExistFilter]]
