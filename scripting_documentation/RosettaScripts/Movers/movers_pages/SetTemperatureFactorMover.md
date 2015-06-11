# SetTemperatureFactor
*Back to [[Mover|Movers-RosettaScripts]] page.*
## SetTemperatureFactor

Set the temperature (b-)factor column in the PDB based on a filter's per-residue information. Useful for coloring a protein based on some energy. The filter should be ResId-enabled (reports per-residue values) or else an error occurs.

```
<SetTemperatureFactor name="&string" filter=(&string) scaling=(1.0&Real)/>
```

-   filter: A ResId-compatible filter name
-   scaling: Values reported by the filter will be multiplied by this factor.


