<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
Implements replica exchange in the MetropolisHastingsMover framework.  Note that this mover requires compilation with extras=mpi (a Message Passing Interface build) to work.

```xml
<HamiltonianExchange name="(&string;)" temp_file="(&string;)"
        temp_low="(0.6 &real;)" temp_high="(3.0 &real;)"
        temp_levels="(10 &non_negative_integer;)"
        temp_interpolation="(linear &interpolation_type;)"
        temp_stride="(100 &non_negative_integer;)"
        io_stride="(10000 &non_negative_integer;)"
        trust_current_temp="(true &bool;)" stats_line_output="(false &bool;)"
        stats_silent_output="(false &bool;)"
        stats_file="(tempering.stats &string;)" exchange_schedule="(&string;)" />
```

-   **temp_file**: XRW_TODO
-   **temp_low**: XRW_TODO
-   **temp_high**: XRW TO DO
-   **temp_levels**: XRW TO DO
-   **temp_interpolation**: XRW TO DO
-   **temp_stride**: XRW TO DO
-   **io_stride**: XRW TO DO
-   **trust_current_temp**: XRW TO DO
-   **stats_line_output**: XRW TO DO
-   **stats_silent_output**: XRW TO DO
-   **stats_file**: XRW TO DO
-   **exchange_schedule**: File specifying exchange schedule

---
