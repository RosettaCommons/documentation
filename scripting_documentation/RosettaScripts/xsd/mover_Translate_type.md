<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Performs a coarse random movement of a small molecule in xyz-space.

```xml
<Translate name="(&string;)" chain="(&string;)"
        distribution="(&distribution_string;)" force="(&string;)"
        tag_along_chains="(&string;)" angstroms="(&real;)"
        cycles="(&non_negative_integer;)" grid_set="(default &string;)" />
```

-   **chain**: (REQUIRED) Chain ID of chain to be translated.
-   **distribution**: (REQUIRED) The random move can be chosen from a "uniform" or "gaussian" distribution.
-   **force**: XRW TO DO
-   **tag_along_chains**: XRW TO DO . Comma separated list of chain IDs to be moved together with "chain".
-   **angstroms**: (REQUIRED) Movement can be anywhere within a sphere of radius specified by "angstroms".
-   **cycles**: (REQUIRED) Number of attempts to make such a movement without landing on top of another molecule.
-   **grid_set**: The ScoringGrid set to use for scoring the translation. If no scoring grids (at all) are present in the XML, use a default classic grid.

---
