# ResidueLipophilicityFilter
*Back to [[Filters|Filters-RosettaScripts]] page.*

documentation written by Jonathan Weinstein jonathan.weinstein@weizmann.ac.il, Nov 2017

## ResidueLipophilicityFilter

based on the MPResidueLipophilicity energy term, this filter calculates the mp_res_lipo score of the pose. this should be equivalent to the value reported by mp_res_lipo in the score file. 
this filter can also print either to stdout or to a file some calculations done by mp_res_solv, mostly for debugging and further understanding the result
```xml
<ResidueLipophilicity name="(& string)" print_splines="(0 &bool)" output_file="(TR &string)" />
```

- print_splines - whether to print the splines found in mp_res_lipo or not
- output_file - where to print the details table to. TR - to tracer. file name - write to file. auto - print to file named JOBNAME_RS.txt. "" (empty string) do not print or save to file. default is TR.

## the table format:
- residue - residue numebr and identity
- Z - z coordinate - membrane depth
- na1 - number of atoms in the 6A radius
- na2 - number of atoms in the 12A readius
- sig1 - sigmoid for the 6A radius
- sig2 - sogmoid for the 12A radius
- sigx - sig1 times sig2
- cen6N - number of atoms in the 6A radius in centroid level
- cen6sig - sigmoid for 6A radius in centroid mode
- cen12N - number of atoms in the 12A radius in centroid level
- cen12sig - sigmoid for 12A radius in centroid mode
- cen10x12 - centroid sigmoids multiplication
- cen_score - centroid level score
- scorex - score times centorid multiplication
- score - score from spline

## See also
* [[MPResidueLipophilicityEnergy]]