<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
This filter counts the number of hydrogen bond acceptors that are receiving hydrogen bonds from more than the allowed number of donors. If the count is greater than a threshold value (default 0), the filter fails. This filter is intended to address a limitation of Rosetta's pairwise-decomposible hydrogen bond score terms: it is not possible for a score term that is examining the interaction between only two residues to know that a third is also interacting with one of the residues, creating artifacts in which too many hydrogen bond donors are all forming hydrogen bonds to the same acceptor.

```xml
<OversaturatedHbondAcceptorFilter name="(&string;)"
        max_allowed_oversaturated="(&non_negative_integer;)"
        hbond_energy_cutoff="(&real;)" consider_mainchain_only="(&bool;)"
        acceptor_selector="(&string;)" donor_selector="(&string;)"
        scorefxn="(&string;)" confidence="(1.0 &real;)" />
```

-   **max_allowed_oversaturated**: How many oversaturated acceptors are allowed before the filter fails? Default 0 (filter fails if any oversaturated acceptors are found).
-   **hbond_energy_cutoff**: A hydrogen bond must have energy less than or equal to this threshold in order to be counted. Default -0.1 Rosetta energy units.
-   **consider_mainchain_only**: If true (the default), only mainchain-mainchain hydrogen bonds are considered. If false, all hydrogen bonds are considered.
-   **acceptor_selector**: Selector that defines the hydrogen bond acceptor. The name of a previously declared residue selector or a logical expression of AND, NOT (!), OR, parentheses, and the names of previously declared residue selectors. Any capitalization of AND, NOT, and OR is accepted. An exclamation mark can be used instead of NOT. Boolean operators have their traditional priorities: NOT then AND then OR. For example, if selectors s1, s2, and s3 have been declared, you could write: 's1 or s2 and not s3' which would select a particular residue if that residue were selected by s1 or if it were selected by s2 but not by s3.
-   **donor_selector**: Selector that defines the hydrogen bond donor. The name of a previously declared residue selector or a logical expression of AND, NOT (!), OR, parentheses, and the names of previously declared residue selectors. Any capitalization of AND, NOT, and OR is accepted. An exclamation mark can be used instead of NOT. Boolean operators have their traditional priorities: NOT then AND then OR. For example, if selectors s1, s2, and s3 have been declared, you could write: 's1 or s2 and not s3' which would select a particular residue if that residue were selected by s1 or if it were selected by s2 but not by s3.
-   **scorefxn**: Name of score function to use
-   **confidence**: Probability that the pose will be filtered out if it does not pass this Filter

---
