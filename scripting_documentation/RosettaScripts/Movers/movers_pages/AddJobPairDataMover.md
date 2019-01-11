# AddJobPairData
*Back to [[Mover|Movers-RosettaScripts]] page.*

## AddJobPairData

Add an arbitrary piece of data to the current Job, which will be output in the silent file, database, etc. This is useful for adding metadata to keep track of data generated using multiple experimental conditions.

The data appended to the Job consists of a key and a value. The key is a string, and the value can be either a real or string. The mover is used like this:

```xml
<AddJobPairData name="(&string)" value_type="(&string)" key="(&string)" value="(&string, 'real' or 'string')" value_from_ligand_chain="(%string)"/>
```

The contents of "value\_type" must be either "string" or "real". "value" will be interpreted as either a string or real depending on the contents of "value\_type. If "value\_from\_ligand\_chain" and a ligand pdb chain is specified, the string or real value will be extracted from data cached in the ResidueType with the given key. Data can be added to a residuetype by appending lines to the ligand params file in the following format:

```
STRING_PROPERTY key value
NUMERIC_PROPERTY key 1.5
```


##See Also

* [[JD2]]: Information on the job distributor
* [[ResourceManager]]: Another tool for storing information
* [[I want to do x]]: Guide to choosing a mover
