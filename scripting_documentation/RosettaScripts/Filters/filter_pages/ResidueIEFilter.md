# Residue Interaction Energy
*Back to [[Filters|Filters-RosettaScripts]] page.*
## Residue Interaction Energy

Finds the ineraction energy (IE) for the specified residue over the interface (interface=1) or the entire pose (interface=0). Then applies an interaction penalty if the IE is above the specified cutoff, such that penalty = sum (IE(res)-(cutoff)). e.g. if the residue is a trp with IE -5 and cutoff of -6.5 the penalty is 1.5.

```xml
<ResidueIE name="(&string)" scorefxn="(score12 &string)" score_type="(total_score &string)" energy_cutoff="(0.0 &float)" restype3="(TRP &string; 3 letter code)" interface="(0 &bool)" whole_pose(0 &bool) selector="(&residue_selector)" jump_number="(1 &float)" interface_distance_cutoff="(8.0 &float)" max_penalty="(1000.0 &float)" penalty_factor="(1.0 & float)"/>
```

One way to use this filter is to look at IE over real protein interfaces, see stats below. One would then set the cutoff at mean + SD, e.g. at -6.5 for Trp.

IE statistics have been calculated for aromatics by Alex Ford (ZDOCK, prot/prot set) and Sagar Khare (CSAR, prot/ligand) sets (number of samples in paren):

|Values:    |  mean(CSAR) | SD(CSAR) |  mean(ZDOCK)  |  SD (ZDOCK) |
|-----------|-------------|----------|---------------|-------------|
|W          |  -8.8 (82)  | 2.3      |  -8.6         |   2.0       |
|F          |  -7.3 (128) | 2        |  -7           |   1.9       |
|Y          |  -7.4 (108) | 1.7      |  -6.5         |   2.2       |

## See also

* [[EnergyPerResidueFilter]]
* [[HbondsToResidueFilter]]
* [[ResidueDistanceFilter]]
* [[ResidueBurialFilter]]

