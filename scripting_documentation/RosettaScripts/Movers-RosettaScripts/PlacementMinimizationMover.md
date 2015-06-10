# PlacementMinimization
## PlacementMinimization

This is a special mover associated with PlaceSimultaneously, below. It carries out the rigid-body minimization towards all of the stubsets.

```
<PlacementMinimization name=( &string) minimize_rb=(1 &bool) host_chain=(2 &integer) optimize_foldtree=(0 &bool) cb_force=(0.5 &Real)>
  <StubSets>
    <Add stubfile=(&string)/>
  </StubSets>
</PlacementMinimization>
```


