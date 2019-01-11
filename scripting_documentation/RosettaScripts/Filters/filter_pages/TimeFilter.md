# Time
*Back to [[Filters|Filters-RosettaScripts]] page.*
## Time

Simple filter for reporting the time a sequence of movers/filters takes.

```xml
<Time name="(&string)"/>
```

Within the protocol, you need to call time at least twice, once, when you want to start the timer, and then, when you want to stop. The reported time is that between the first and last calls.

## See also

* [[ExpiryFilter]]
