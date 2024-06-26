<!-- THIS IS AN AUTOGENERATED FILE: Don't edit it directly, instead change the schema definition in the code itself. -->

_Autogenerated Tag Syntax Documentation:_

---
The RestrictInteractionGraphThreadsOperation limits the number of threads allowed for interaction graph pre-computation.  By default, all available threads are used.  Note that this only has an effect in the multi-threaded build of Rosetta (built with the "extras=cxx11thread" option).
This TaskOperation was written on Saturday, 19 October 2019 by Vikram K. Mulligan, Flatiron Institute (vmulligan@flatironinstitute.org).

```xml
<RestrictInteractionGraphThreadsOperation name="(&string;)"
        thread_limit="(0 &non_negative_integer;)" />
```

-   **thread_limit**: The maximum number of threads allowed for interaction graph precomputation.  Setting this to 0 imposes no limit.  Note that this task operation will only lower the number of allowed threads.  That is, if other flags or task operations limit the allowed threads to fewer than this task operation allows, the minimum value will be used.

---
