<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
XRW TO DO

```xml
<SSBisectddGFilter name="(&string;)" scorefxn="(&string;)"
        threshold="(-999999 &real;)" report_avg="(true &bool;)"
        ignore_terminal_ss="(0 &non_negative_integer;)"
        only_n_term="(false &bool;)" only_c_term="(false &bool;)"
        relax_mover="(&string;)" convert_charged_res_to_ala="(false &bool;)"
        skip_ss_element="(false &bool;)" report_sasa_instead="(false &bool;)"
        confidence="(1.0 &real;)" />
```

-   **scorefxn**: Name of score function to use
-   **threshold**: XRW TO DO
-   **report_avg**: XRW TO DO
-   **ignore_terminal_ss**: XRW TO DO
-   **only_n_term**: XRW TO DO
-   **only_c_term**: XRW TO DO
-   **relax_mover**: Optionally define a mover which will be applied prior to computing the system energy in the unbound state.
-   **convert_charged_res_to_ala**: converts the charged residue to alanine
-   **skip_ss_element**: skips a secondary structure element(sheet,helix) when calculating ddg
-   **report_sasa_instead**: reports sasa instead of ddg
-   **confidence**: Probability that the pose will be filtered out if it does not pass this Filter

---
