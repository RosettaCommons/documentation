# Bond geometry and omga angle
*Back to [[Filters|Filters-RosettaScripts]] page.*
## Bond geometry and omga angle

```
<Geometry name=(&string) omega=(165&Real) cart_bonded=(20 &Real) start=(1 &residue number) end=("100000" &residue number) />
```

-   omega: cutoff for omega angle of peptide plane, Cis-proline is also considered. Works for multiple chains
-   cart\_bonded: bond angle and length penalty score
-   start: starting residue number to scan
-   end: ending residue number


