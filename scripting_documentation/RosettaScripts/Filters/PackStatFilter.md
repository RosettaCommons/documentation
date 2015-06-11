# PackStat
*Back to [[Filters|Filters-RosettaScripts]] page.*
## PackStat

Computes packing statistics.

```
<PackStat name=(&string) threshold=(0.58 &Real) chain=(0 &integer) repeats=(1 &integer)/>
```

-   threshold: packstat above which filter passes. Common wisdom says 0.65 is a good number.
-   chain: jump on which to separate the complex before computing packstat. 0 means not to separate the complex.
-   repeats: How many times to repeat the calculation.

