# Geometry Filter
*Back to [[Filters|Filters-RosettaScripts]] page.*
## Geometry Filter

```xml
<Geometry name="(&string)"
  omega="(165&Real)"
  cart_bonded="(20 &Real)"
  cstfile="('none' &string)"
  cst_cutoff="(10000.0 &Real)"
  start="(1 &residue number)"
  end="(100000 &residue number)"
  residue_selector="( '' &string )"
  count_bad_residues="( false &bool )" />
```

-   omega: cutoff for omega angle of peptide plane, Cis-proline is also considered. Works for multiple chains
-   cart\_bonded: bond angle and length penalty score
-   cstfile: if specified, the given constraint file will be used to introduce constraints into the pose. Only atom pair constraints will be used. The constraint scores will be checked to see if they are lower than cst_cutoff.  If the constraint score is > cst_cutoff, the pose will fail.
-   cst_cutoff: cutoff for use with cstfile option
-   start: starting residue number to scan
-   end: ending residue number
-   residue_selector: If specified, only residues selected by the user-specified residue selector will be scanned. By default, all residues are selected.  If start and/or end are also set, only residues selected by the residue_selector AND within the range [start, end] will be scanned.
-   count_bad_residues: If true, the number of residues failing the filter will be computed and returned as the filter score by report_sm(). If false, the filter score will be either 1.0 (i.e. all residues pass) or 0.0 (i.e. a residue failed the filter).  Default: false

## See also:

* [[AngleToVectorFilter]]
* [[SecondaryStructureFilter]]
* [[SecondaryStructureHasResidueFilter]]
* [[TorsionFilter]]
