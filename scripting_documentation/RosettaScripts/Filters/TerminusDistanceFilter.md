# TerminusDistance
## TerminusDistance

True if all residues in the interface are more than \<distance\> residues from the N or C terminus. If fails, reports how far failing residue was from the terminus. If passes, returns "1000"

```
<TerminusDistance name=(&string) jump_number=(1 &integer) distance=(5 &integer)/>
```

-   jump\_number: Which jump to use for calculating the interface?
-   distance: how many residues must each interface residue be from a terminus? (sequence distance)

