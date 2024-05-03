# Geometry Optimization using RosettaQM

## Summary
In this tutorial, we are going to give an example of geometry optimization for a protein.

## Tutorial
In this case, we have part of a zinc-finger protein. We want to optimize the geometry of protein:
* in proximity of zinc, with quantum mechanics,
* its neighbourhood with a lower level of theory quantum mechanics,
* and the rest of protein with Rosetta's energy field.

<figure align="center">
<img src="../../../images/GeometryOptimizationRosettaQM_image1.png" alt="drawing" width="200"/>
<figcaption>Figure 1.</figcaption>
</figure>

Therefore, the protein will be seperated into three regions, which will be called reg1, reg2 and reg3, respectively. Then, different movers and scorings will be applied for each reigon.

Residue selectors ae used to specify each region.`reg1` is selected by residue numbers, and `reg2` is selected by `Neighborhood` selector. This selector compares the distance between beta carbons of selection (in this case, `reg1`) with beta carbons of other residues. If the distance i
s less than or equal to the threshold (in this case, 4A) it selects that residue. The `include_focus_in_subset="false"` tag means `reg2` excludes `reg1`. Figure 2. highights `reg1` with dark blue, and `reg2` with light blue. `reg3` is selected as anything not in `reg1` or `reg2` regions.

```
<RESIDUE_SELECTORS>
    <Index name="reg1" resnums="8,11,24,28,29"/>
    <Neighborhood name="reg2" selector="reg1" distance="4.0" include_focus_in_subset="false" />
    <Not name="reg3" selector="reg1,reg2">
</RESIDUE_SELECTORS>
```
<figure align="center">
<img src="../../../images/GeometryOptimizationRosettaQM_image2.png" alt="drawing" width="200"/>
<figcaption>Figure 2.</figcaption>
</figure>

For each region, a different score function needs to be used. The following table gives a summary of that.

| Region's name | Score function |
|-------------|----------------|
| reg1 | |
| reg2 | 
| reg3 | Rosetta ref2015 |


```

```
