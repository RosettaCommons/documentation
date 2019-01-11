# PSSM2Bfactor
*Back to [[Mover|Movers-RosettaScripts]] page.*
## PSSM2Bfactor

Set the temperature (b-)factor column in the PDB based on filter's per-residue PSSM score. Sets by default PSSM scores less than -1 to 50, and larger than 5 to 0 in the B-factor column. Between -1 and 5 there is a linear gradient.

```xml
<PSSM2Bfactor name="&string" Value_for_blue="(&Real)" Value_for_red="(&Real)"/>
```

-   Value\_for\_blue: All PSSM scoring with value and lower will be converted to 0 in the Bfactor column. default 5.
-   Value\_for\_red: All PSSM scoring with value and higher will be converted to 50 in the Bfactor column. Default 0.


##See Also

* [[SetTemperatureFactorMover]]
* [[FavorSequenceProfileMover]]
* [[ConsensusDesignMover]]
* [[I want to do x]]: Guide to choosing a mover
