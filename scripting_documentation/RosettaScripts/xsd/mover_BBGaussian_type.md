<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Monte Carlo update for chain molecules: Biased Gaussian steps in torsional space The Journal of Chemical Physics, Vol. 114, No. 18. (2001), pp. 8154-8158. Two steps for perturbing the backbone and keeping the geometry constrain Step 1: Gaussian Biased steps in torsional space: the end atoms of the moving segment should be choosen by user and to keep the geometry constrain(6), the DOF of the moving segment greater than 6 Step 2: pivot update the bb conformation, or followed by a chainclosure method (BBConRot)

```xml
<BBGaussian name="(&string;)" factorA="(1.0 &real;)" factorB="(10.0 &real;)"
        end_atoms="(&string;)" dof="(8 &non_negative_integer;)"
        pivot="(4 &non_negative_integer;)" shrink="(false &bool;)"
        autoA="(false &bool;)" fix_tail="(false &bool;)" />
```

-   **factorA**: XRW TO DO
-   **factorB**: XRW TO DO
-   **end_atoms**: XRW TO DO
-   **dof**: XRW TO DO
-   **pivot**: XRW TO DO
-   **shrink**: XRW TO DO
-   **autoA**: XRW TO DO
-   **fix_tail**: XRW TO DO overwrite option[bbg::fix_short_segment]

---
