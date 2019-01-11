# Expiry
*Back to [[Filters|Filters-RosettaScripts]] page.*
## Expiry

Has a predetermined number of seconds elapsed since the start of the trajectory? If so, return false (to stop the trajectory), else return true. Yes, I realize now that this is upside down... This is useful on computer systems that want the program to exit gracefully after a predetermined set of time. After defining this filter, sprinkle calls to it throughout your PROTOCOLS section, where you want it to be evaluated.

```xml
<Expiry name="(&string)" seconds="(&integer)"/>
```

-   seconds: how many seconds until this triggers failure?

## See also

* [[TimeFilter]]
