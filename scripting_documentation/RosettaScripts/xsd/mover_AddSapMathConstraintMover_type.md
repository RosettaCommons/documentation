<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
A mover that adds the SapMathConstraint to the pose. The SapMathConstraint allows you to create math expressions from previously added SapConstraints. These SapConstraints are added with the AddSapConstraintMover. The sap_constraint scoreterm must be enabled. Additionally, the SapConstraints this relies on do not need to actually incur a penalty. Setting their penalty_per_sap=0 is what to do if you only want SapMathConstraints to affect the score. See this paper for more info on sap: Developability index: a rapid in silico tool for the screening of antibody aggregation propensity.  Lauer, et. al. J Pharm Sci 2012

```xml
<AddSapMathConstraintMover name="(&string;)" penalty_per_unit="(1 &real;)"
        lower_bound="(&string;)" upper_bound="(&string;)" >
    <Add name="(&string;)" multiplier="(&real;)" />
</AddSapMathConstraintMover>
```

-   **penalty_per_unit**: If the math expression is outside lower_bound or upper_bound, apply this penalty for each unit past the bounds.
-   **lower_bound**: The lowest value of the math expression that will not incur a penalty. Leaving this blank or not including it will have no lower_bound.
-   **upper_bound**: The highest value of the math expression that will not incur a penalty. Leaving this blank or not including it will have no upper_bound.


Subtag **Add**:   

-   **multiplier**: Multiply the SapScore by this before adding to the sum.

---
