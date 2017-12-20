#HBNet Unsats

*Back to [[HBNet|HBNetMover]] page.  Back to [[Mover|Movers-RosettaScripts]] page.  Back to [[RosettaScripts|RosettaScripts]] page.*<br>

###How HBNet treats buried unsatisfied polar atoms
HBNet has its own internal method for evaluating and counting buried unsatisfied polar atoms.  Each network requires all buried heavy-atom donors and acceptors to participate in h-bonds.  Any network that does not meet and requires that does not meet this requirement is automatically thrown out.

###See also:
[[Filters|BuriedUnsatHbondsFilter]]