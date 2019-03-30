# Auction
*Back to [[Mover|Movers-RosettaScripts]] page.*
## Auction

This is a special mover associated with PlaceSimultaneously, below. It carries out the auctioning of residues on the scaffold to hotspot sets without actually designing the scaffold. If pairing is unsuccessful Auction will report failure.

```xml
<Auction name="( &string)" host_chain="(2 &integer)" max_cb_dist="(3.0 &Real)" cb_force="(0.5 &Real)">
   <StubSets>
     <Add stubfile="(&string)"/>
   </StubSets>
</Auction>
```

Note that none of the options, except for name, needs to be set up by the user if PlaceSimultaneously is notified of it. If PlaceSimultaneously is notified of this Auction mover, PlaceSimultaneously will set all of these options.


##See Also

* [[PlaceSimultaneouslyMover]]
* [[RosettaScriptsPlacement]]
* [[I want to do x]]: Guide to choosing a mover
